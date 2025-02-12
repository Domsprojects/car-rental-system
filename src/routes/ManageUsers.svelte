<script>
    async function sprawdzFunkcje() {
        const URL = "./backend/whoIsLogged.php";
        let res = await fetch(URL);
        res = await res.json();
        console.log(res);
        return res;
    }
    let funkcjaUżytkownika = sprawdzFunkcje();

    async function pokazUzytkownikow() {
        const URL = "./backend/getUsers.php";
        let res = await fetch(URL);
        res = await res.json();
        return res;
    }

    let uzytkownicy = pokazUzytkownikow();

    let id, email, funkcja, status, info;
    async function zmienDane(
        wybrane_id,
        wybrany_email,
        wybrana_funckcja,
        wybrany_status
    ) {
        id = wybrane_id;
        email = wybrany_email;
        funkcja = wybrana_funckcja;
        status = wybrany_status;
    }

    async function aktualizuj() {
        if (id && email) {
            let data = new FormData();
            data.append("id", id);
            data.append("email", email);
            data.append("funkcja", document.getElementById("funkcja").value);
            data.append("status", document.getElementById("status").value);

            let URL = "./backend/editUser.php";
            let res = await fetch(URL, {
                method: "POST",
                body: data,
            });
            res = await res.json();

            if (res == true) {
                document.getElementById("info").style.visibility = "visible";
                info = "Rekord został zaktualizowany";
                setTimeout(() => {
                    window.location.reload(true);
                }, 1000);
            } else {
                document.getElementById("info").style.visibility = "visible";
                info = "Nie udało się zaktualizować rekordu";
            }
        } else {
            document.getElementById("info").style.visibility = "visible";
            info = "Nie wybrano użytkownika";
        }
    }
</script>

<section class="text-gray-600 body-font">
    {#await funkcjaUżytkownika}
        <p>Loading</p>
    {:then res}
        {#if res.funkcja == "administrator"}
            <div class="container px-5 py-24 mx-auto">
                <div class="lg:w-2/3 w-full mx-auto overflow-auto">
                    <table
                        class="table-auto w-full text-left whitespace-no-wrap"
                    >
                        <thead>
                            <tr>
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100 rounded-tl rounded-bl"
                                    >Id</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Email</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Funkcja</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Status konta</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Edycja danych</th
                                >
                            </tr>
                        </thead>
                        <tbody>
                            {#await uzytkownicy}
                                <p>Loading</p>
                            {:then res}
                                {#each res as uzytkownik}
                                    <tr>
                                        <td class="text-center px-4 py-3"
                                            >{uzytkownik.id_uzytkownika}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{uzytkownik.email}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{uzytkownik.funkcja}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{uzytkownik.status}</td
                                        >
                                        <td
                                            class="text-center px-4 py-3"
                                            style="display: flex; justify-content: center; align-items: center;"
                                            ><button
                                                class="flex ml-auto text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                                                on:click={() => {
                                                    zmienDane(
                                                        uzytkownik.id_uzytkownika,
                                                        uzytkownik.email,
                                                        uzytkownik.funkcja,
                                                        uzytkownik.status
                                                    );
                                                }}>Edytuj</button
                                            ></td
                                        >
                                    </tr>
                                {/each}
                            {/await}
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="lg:w-2/3 w-full mx-auto overflow-auto flex">
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
            </div>

            <div
                id="info"
                style="visibility: hidden; margin-top: 20px "
                class="flex flex-col text-center w-full mb-12"
            >
                {info}
            </div>
        {:else}
            <div id="info" class="flex flex-col text-center w-full mb-12">
                Brak uprawnień do wyświetlenia strony
            </div>
        {/if}
    {/await}
</section>
