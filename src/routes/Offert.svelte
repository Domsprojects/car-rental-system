<script>
    export let params;
    let wybrane_auto = {};
    let gotowy = false;

    let isLogged = true;
    async function logowanie() {
        const URL = "./backend/isUserLogged.php";
        let res = await fetch(URL);
        res = await res.json();
        if (res == true) {
            isLogged = true;
        } else {
            isLogged = false;
        }
    }
    let zalogowano = logowanie();

    let uzytkownik = {};
    async function sprawdzFunkcje() {
        const URL = "./backend/whoIsLogged.php";
        let res = await fetch(URL);
        res = await res.json();
        uzytkownik = res;

        getReservations();
    }
    let funkcjaUżytkownika = sprawdzFunkcje();

    let today = new Date();
    let startDay, endDay;
    let dateStartMin = today.toISOString().split("T")[0];
    async function getOffert() {
        let data = new FormData();
        data.append("id_samochodu", params.id);

        let URL = "./backend/getOffert.php";
        let res = await fetch(URL, {
            method: "POST",
            body: data,
        });

        res = await res.json();
        wybrane_auto = res;
        gotowy = true;
    }
    let car = getOffert();

    let status_rezerwacji;
    let pobranoRezerwacje = false;
    let w_kolejce = 0;
    async function getReservations() {
        let data = new FormData();
        data.append("id_samochodu", params.id);

        let URL = "./backend/getReservations.php";
        let res = await fetch(URL, {
            method: "POST",
            body: data,
        });

        res = await res.json();
        let tab = [];
        res.forEach((element) => {
            tab.push(element);
        });

        if (tab.length > 1) {
            status_rezerwacji = "oczekujące";
            for (var a = 0; a < tab.length; a++) {
                console.log(uzytkownik);
                if (tab[a].id_uzytkownika == uzytkownik.id_uzytkownika) {
                    status_rezerwacji = "niedostępne";
                }
            }
            w_kolejce = tab.length;
        } else {
            if (tab.length == 1 && res[0].status == "zaakceptowane") {
                status_rezerwacji = "niedostępne";
            } else if (tab.length == 0) {
                status_rezerwacji = "dostępne";
            } else if (tab.length == 1 && res[0].status == "oczekujace") {
                status_rezerwacji = "oczekujące";
                w_kolejce = tab.length;
            }
        }
        console.log(status_rezerwacji);
        pobranoRezerwacje = true;
    }
    // let rezerwacja = getReservations();

    let calkowita_cena = "Proszę zanaczyć poprawne daty odbioru oraz zwrotu";
    function policzCene() {
        if (startDay != undefined && endDay != undefined) {
            const dzien = 24 * 60 * 60 * 1000;
            let poczatek = new Date(startDay);
            let koniec = new Date(endDay);
            let liczba_dni = Math.round(Math.abs((poczatek - koniec) / dzien));

            if (liczba_dni <= 0 || liczba_dni == NaN) {
                calkowita_cena =
                    "Proszę zanaczyć poprawne daty odbioru oraz zwrotu";
            } else {
                calkowita_cena = liczba_dni * wybrane_auto[0].cena;
                calkowita_cena = calkowita_cena + "zł";
            }
        }
    }

    async function zarezerwuj() {
        if (startDay != undefined && endDay != undefined && endDay > startDay) {
            let data = new FormData();
            data.append("id_samochodu", params.id);
            data.append("id_uzytkownika", uzytkownik.id_uzytkownika);
            data.append("poczatek", startDay);
            data.append("koniec", endDay);

            let URL = "./backend/makeReservation.php";
            let res = await fetch(URL, {
                method: "POST",
                body: data,
            });

            res = await res.json();

            if (res) {
                window.location.href = "#/myreservations";
            }
        }
    }
</script>

<section class="text-gray-600 body-font overflow-hidden">
    {#if gotowy}
        <div class="container px-5 py-24 mx-auto">
            <div class="lg:w-4/5 mx-auto flex flex-wrap">
                <img
                    alt="ecommerce"
                    class="lg:w-1/2 w-full lg:h-auto h-64 object-cover object-center rounded"
                    src={wybrane_auto[0].sciezka_zdjecia}
                />
                <div class="lg:w-1/2 w-full lg:pl-10 lg:py-6 mt-6 lg:mt-0">
                    <h1
                        class="text-gray-900 text-3xl title-font font-medium mb-1"
                    >
                        {wybrane_auto[0].marka}
                        {wybrane_auto[0].model}
                    </h1>
                    <div class="flex mb-4" />
                    <div class="leading-relaxed">
                        <div style="display: flex;">
                            <img
                                src="https://carfree.pl/img/gearbox.png"
                                alt=""
                                style="margin-right: 10px; height:20px"
                            />Skrzynia biegów: {wybrane_auto[0].skrzynia}
                        </div>

                        <div style="display: flex;">
                            <img
                                src="https://carfree.pl/img/person.png"
                                alt=""
                                style="margin-right: 10px; height:20px"
                            />Ilość osób: {wybrane_auto[0].ilosc_osob}
                        </div>

                        <div style="display: flex;">
                            <img
                                src="https://carfree.pl/img/fuel.png"
                                alt=""
                                style="margin-right: 10px; height:20px"
                            />Silnik: {wybrane_auto[0].silnik}
                        </div>

                        <div style="display: flex;">
                            <img
                                src="https://carfree.pl/img/air_c.png"
                                alt=""
                                style="margin-right: 10px; height:20px"
                            />Klimatyzacja: {wybrane_auto[0].klimatyzacja}
                        </div>
                        {#if pobranoRezerwacje}
                            <div style="display: flex;">
                                Status samochodu: {status_rezerwacji}
                            </div>
                        {/if}
                        <div style="display: flex;">
                            {#if status_rezerwacji == "oczekujące"}
                                <div>Ilość osób w kolejce: {w_kolejce}</div>
                            {/if}
                        </div>
                    </div>
                    <div
                        class="flex mt-6 items-center pb-5 border-b-2 border-gray-100 mb-5"
                    />

                    <div style="display: flex;">Data odbioru:</div>
                    <input
                        type="date"
                        name="poczatek"
                        min={dateStartMin}
                        bind:value={startDay}
                        on:change={policzCene}
                    />

                    <div style="display: flex;">Data zwrotu:</div>
                    <input
                        type="date"
                        name="koniec"
                        min={startDay}
                        bind:value={endDay}
                        on:change={policzCene}
                    />

                    <div
                        class="flex mt-6 items-center pb-5 border-b-2 border-gray-100 mb-5"
                    />

                    <div style="display: flex;">
                        <span
                            class="title-font font-medium text-2xl text-gray-900"
                            >{wybrane_auto[0].cena}zł / dobra</span
                        >
                    </div>
                    <div style="display: flex;">
                        Cena za całkowity okres wypożyczenia samochodu: {calkowita_cena}
                    </div>
                    <div
                        class="flex mt-6 items-center pb-5 border-b-2 border-gray-100 mb-5"
                    />

                    <div class="flex">
                        {#if pobranoRezerwacje}
                            {#if status_rezerwacji == "oczekujące" || status_rezerwacji == "dostępne"}
                                {#if isLogged == true}
                                    <button
                                        class="flex ml-auto text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                                        on:click={zarezerwuj}>Zarezerwuj</button
                                    >
                                {:else if isLogged == false}
                                    <div
                                        class="flex ml-auto text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none;"
                                    >
                                        Aby wypożyczac auto należy się zalogować
                                    </div>
                                {/if}
                            {:else if status_rezerwacji == "niedostępne"}
                                <div
                                    class="flex ml-auto text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none;"
                                >
                                    Rezerwacja zablokowana - samochód w użyciu
                                    lub już złożono rezerwację
                                </div>
                            {/if}
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    {/if}
</section>
