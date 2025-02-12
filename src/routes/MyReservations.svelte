<script>
    async function logowanie() {
        const URL = "./backend/isUserLogged.php";
        let res = await fetch(URL);
        res = await res.json();
        return res;
    }
    let zalogowano = logowanie();

    let uzytkownik = {};
    let rezerwacje = [];
    async function sprawdzFunkcje() {
        const URL = "./backend/whoIsLogged.php";
        let res = await fetch(URL);
        res = await res.json();
        uzytkownik = res;

        let rezerwacje_uzytkownika = wczytajRezerwacje();
    }
    let funkcjaUżytkownika = sprawdzFunkcje();

    let info = "";
    async function wczytajRezerwacje() {
        let data = new FormData();
        data.append("id_uzytkownika", uzytkownik.id_uzytkownika);

        let URL = "./backend/getUserReservations.php";
        let res = await fetch(URL, {
            method: "POST",
            body: data,
        });

        res = await res.json();
        let tab = [];
        res.forEach((element) => {
            tab.push(element);
            if (element.koniec < new Date().toISOString().slice(0, 10)) {
                info =
                    "Przetrzymujesz samochód! Zostaną naliczone dodatkowe koszty";
            }
        });

        rezerwacje = tab;
    }

    async function anulujRezerwacje(
        marka,
        model,
        poczatek,
        koniec,
        id_rezerwacji
    ) {
        let data = new FormData();
        data.append("id_rezerwacji", id_rezerwacji);
        data.append("marka", marka);
        data.append("model", model);
        data.append("poczatek", poczatek);
        data.append("koniec", koniec);

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

    let pokazKodWartosc = false;

    async function pokazKod(mssg) {
        mssg = String(mssg.model);
        pokazKodWartosc = !pokazKodWartosc;
        if (pokazKodWartosc == true) {
            document.getElementById("qrcode").innerHTML = "";

            new QRCode(document.getElementById("qrcode"), mssg);

            document.getElementById("qrcode_container").style.visibility =
                "visible";
            document.getElementById("qrcode").style.height = "300px";
            document.getElementById("qrcode").style.width = "300px";
        } else {
            document.getElementById("qrcode_container").style.visibility =
                "hidden";
            document.getElementById("qrcode").style.height = "0px";
            document.getElementById("qrcode").style.width = "0px";
        }
    }

    async function zwrocAuto(id_rezerwacji, id_samochodu, poczatek, koniec) {
        console.log(id_samochodu, poczatek, koniec);
        let data = new FormData();
        data.append("id_rezerwacji", id_rezerwacji);
        data.append("id_uzytkownika", uzytkownik.id_uzytkownika);
        data.append("id_samochodu", id_samochodu);
        data.append("poczatek", poczatek);
        data.append("koniec", koniec);

        let URL = "./backend/handBackCar.php";
        let res = await fetch(URL, {
            method: "POST",
            body: data,
        });

        res = await res.json();

        if (res) {
            window.location.reload(true);
        }
    }
</script>

<section class="text-gray-600 body-font">
    {#await zalogowano}
        <p>Loading</p>
    {:then res}
        {#if res == true}
            <div class="container px-5 py-24 mx-auto">
                <div class="lg:w-2/3 w-full mx-auto overflow-auto">
                    <table
                        class="table-auto w-full text-left whitespace-no-wrap"
                    >
                        <thead>
                            <tr>
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100 rounded-tl rounded-bl"
                                    >Marka</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Model</th
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
                                    >Status</th
                                >

                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                />
                            </tr>
                        </thead>
                        <tbody>
                            {#await funkcjaUżytkownika}
                                <p>Loading</p>
                            {:then res}
                                {#each rezerwacje as data}
                                    <tr>
                                        <td class="text-center px-4 py-3"
                                            >{data.marka}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{data.model}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{data.poczatek}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{data.koniec}</td
                                        >
                                        <td class="text-center px-4 py-3">
                                            {#if data.status == "zaakcaptowane"}
                                                zaakceptowane
                                            {:else}
                                                {data.status}
                                            {/if}
                                        </td>
                                        <td
                                            class="text-center px-4 py-3"
                                            style="display: flex; justify-content: center; align-items: center;"
                                            >{#if data.status == "oczekujace"}
                                                <button
                                                    class=" text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                                                    on:click={(data) => {
                                                        anulujRezerwacje(
                                                            data.marka,
                                                            data.model,
                                                            data.poczatek,
                                                            data.koniec,
                                                            data.id_rezerwacji
                                                        );
                                                    }}>Anuluj</button
                                                >
                                            {:else if data.status == "zaakceptowane"}
                                                <button
                                                    class="flex ml-auto text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                                                    on:click={() => {
                                                        pokazKod(data);
                                                    }}>Pobierz kod QR</button
                                                >
                                                <button
                                                    class="flex ml-auto text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                                                    on:click={() => {
                                                        zwrocAuto(
                                                            data.id_rezerwacji,
                                                            data.id_samochodu,
                                                            data.poczatek,
                                                            data.koniec
                                                        );
                                                    }}>Zwróć auto</button
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
            <div
                id="info"
                class="flex flex-col text-center w-full mb-12"
                style="color: red"
            >
                {info}
            </div>

            <div
                id="qrcode_container"
                style="display: flex; flex-direction: column; justify-content: center; align-items: center; visibility: hidden;"
            >
                <div id="qrcode" />
                <button
                    class=" text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                    on:click={() => {
                        pokazKod("");
                    }}>Powrót do rezerwacji</button
                >
            </div>
        {:else}
            <div id="info" class="flex flex-col text-center w-full mb-12">
                Brak uprawnień do wyświetlenia strony
            </div>
        {/if}
    {/await}
</section>
