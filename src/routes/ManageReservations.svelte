<script>
    async function sprawdzFunkcje() {
        const URL = "./backend/whoIsLogged.php";
        let res = await fetch(URL);
        res = await res.json();
        console.log(res);
        return res;
    }
    let funkcjaUżytkownika = sprawdzFunkcje();

    let kopia_rezerwacje;
    async function pokazRezerwacje() {
        const URL = "./backend/getModeratorReservations.php";
        let res = await fetch(URL);
        res = await res.json();
        kopia_rezerwacje = res;
        return res;
    }
    let rezerwacje = pokazRezerwacje();

    async function zatwierdzRezerwacje(
        id_rezerwacji,
        poczatek,
        koniec,
        id_samochodu
    ) {
        if (id_rezerwacji && poczatek && koniec && id_samochodu) {
            let data = new FormData();
            data.append("id_rezerwacji", id_rezerwacji);
            data.append("poczatek", poczatek);
            data.append("koniec", koniec);
            data.append("id_samochodu", id_samochodu);

            let URL = "./backend/editReservation.php";
            let res = await fetch(URL, {
                method: "POST",
                body: data,
            });
            res = await res.json();

            if (res == true) {
                alert("Rekord został zaktualizowany");
                setTimeout(() => {
                    window.location.reload(true);
                }, 1000);
            } else {
                alert("Nie udało się zaktualizować rekordu");
            }
        }
    }

    async function zaktualizujRezerwacje(id_rezerwacji, poczatek, koniec) {
        if (id_rezerwacji && poczatek && koniec) {
            let data = new FormData();
            data.append("id_rezerwacji", id_rezerwacji);
            data.append("poczatek", poczatek);
            data.append("koniec", koniec);

            let URL = "./backend/updateReservation.php";
            let res = await fetch(URL, {
                method: "POST",
                body: data,
            });
            res = await res.json();

            if (res == true) {
                alert("Rekord został zaktualizowany");
                setTimeout(() => {
                    window.location.reload(true);
                }, 1000);
            } else {
                alert("Nie udało się zaktualizować rekordu");
            }
        }
    }

    async function anulujRezerwacje(id_rezerwacji) {
        let data = new FormData();
        data.append("id_rezerwacji", id_rezerwacji);

        let URL = "./backend/deleteReservation.php";
        let res = await fetch(URL, {
            method: "POST",
            body: data,
        });

        res = await res.json();

        if (res) {
            window.location.reload(true);
        }
    }

    function sortowanie(kategoria) {
        if (kategoria == "model") {
            kopia_rezerwacje.sort((a, b) => a.model.localeCompare(b.model));
            rezerwacje = kopia_rezerwacje;
        } else if (kategoria == "marka") {
            kopia_rezerwacje.sort((a, b) => a.marka.localeCompare(b.marka));
            rezerwacje = kopia_rezerwacje;
        } else if (kategoria == "uzytkownik") {
            kopia_rezerwacje.sort((a, b) => a.email.localeCompare(b.email));
            rezerwacje = kopia_rezerwacje;
        } else if (kategoria == "status") {
            kopia_rezerwacje.sort((a, b) => a.status.localeCompare(b.status));
            rezerwacje = kopia_rezerwacje;
        }
    }
</script>

<section class="text-gray-600 body-font">
    {#await funkcjaUżytkownika}
        <p>Loading</p>
    {:then res}
        {#if res.funkcja == "moderator"}
            <div class="container px-5 py-24 mx-auto">
                <div class="lg:w-2/3 w-full mx-auto overflow-auto">
                    <table
                        class="table-auto w-full text-left whitespace-no-wrap"
                    >
                        <thead>
                            <tr>
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100 rounded-tl rounded-bl"
                                    >Id rezerwacji</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    on:click={() => {
                                        sortowanie("uzytkownik");
                                    }}>Użytkownik</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    on:click={() => {
                                        sortowanie("marka");
                                    }}>Marka</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    on:click={() => {
                                        sortowanie("model");
                                    }}>Model</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Data odbioru</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Data zwrotu</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    on:click={() => {
                                        sortowanie("status");
                                    }}>Status</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                />
                            </tr>
                        </thead>
                        <tbody>
                            {#await rezerwacje}
                                <p>Loading</p>
                            {:then res}
                                {#each res as rezerwacja}
                                    <tr>
                                        <td class="text-center px-4 py-3"
                                            >{rezerwacja.id_rezerwacji}</td
                                        >
                                        <td>
                                            {rezerwacja.email}
                                        </td>
                                        <td class="text-center px-4 py-3"
                                            >{rezerwacja.marka}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{rezerwacja.model}</td
                                        >
                                        <td class="text-center px-4 py-3">
                                            <input
                                                type="date"
                                                bind:value={rezerwacja.poczatek}
                                            />
                                        </td>
                                        <td class="text-center px-4 py-3">
                                            <input
                                                type="date"
                                                bind:value={rezerwacja.koniec}
                                                min={rezerwacja.poczatek}
                                            />
                                        </td>
                                        <td class="text-center px-4 py-3"
                                            >{rezerwacja.status}</td
                                        >
                                        <td
                                            class="text-center px-4 py-3"
                                            style="display: flex; justify-content: center; align-items: center;"
                                        >
                                            {#if rezerwacja.status == "oczekujace"}
                                                <button
                                                    class=" text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                                                    style="margin-right: 5px;"
                                                    on:click={() => {
                                                        zatwierdzRezerwacje(
                                                            rezerwacja.id_rezerwacji,
                                                            rezerwacja.poczatek,
                                                            rezerwacja.koniec,
                                                            rezerwacja.id_samochodu
                                                        );
                                                    }}>Zatwierdź</button
                                                >
                                                <button
                                                    class=" text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                                                    on:click={() => {
                                                        anulujRezerwacje(
                                                            rezerwacja.id_rezerwacji
                                                        );
                                                    }}>Anuluj</button
                                                >
                                            {:else if rezerwacja.status == "zaakceptowane"}
                                                <button
                                                    class=" text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                                                    on:click={() => {
                                                        zaktualizujRezerwacje(
                                                            rezerwacja.id_rezerwacji,
                                                            rezerwacja.poczatek,
                                                            rezerwacja.koniec
                                                        );
                                                    }}>Zaktualizuj</button
                                                >
                                            {/if}
                                        </td>
                                    </tr>
                                {/each}
                            {/await}
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- <div class="lg:w-2/3 w-full mx-auto overflow-auto flex">
                <div class="flex lg:w-5/7 w-full" id="inputy">
                    <input
                        class="w-1/5 m-1"
                        type="text"
                        bind:value={id}
                        disabled
                    />
                    <input
                        class="w-1/5 m-1"
                        type="text"
                        bind:value={email}
                        disabled
                    />
                    <select name="funkcja" id="funkcja">
                        <option value="uzytkownik">uzytkownik</option>
                        <option value="moderator">moderator</option>
                    </select>
                    <select name="status" id="status">
                        <option value="aktywny">aktywny</option>
                        <option value="nieaktywny">nieaktywny</option>
                    </select>
                </div>
                <div clas="flex lg:w-2/7 w-full">
                    <button
                        class="flex ml-auto text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                        on:click={aktualizuj}>Aktualizuj</button
                    >
                </div>
            </div> -->
        {:else}
            <div id="info" class="flex flex-col text-center w-full mb-12">
                Brak uprawnień do wyświetlenia strony
            </div>
        {/if}
    {/await}
</section>
