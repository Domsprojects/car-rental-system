<script>
    async function logowanie() {
        const URL = "./backend/isUserLogged.php";
        let res = await fetch(URL);
        res = await res.json();
        return res;
    }
    let zalogowano = logowanie();

    let uzytkownik = {};
    let archiwum = [];

    async function sprawdzFunkcje() {
        const URL = "./backend/whoIsLogged.php";
        let res = await fetch(URL);
        res = await res.json();
        uzytkownik = res;
        let archiwum_uzytkownika = wczytajArchiwum();
    }
    let funkcjaUżytkownika = sprawdzFunkcje();

    async function wczytajArchiwum() {
        let data = new FormData();
        data.append("id_uzytkownika", uzytkownik.id_uzytkownika);

        let URL = "./backend/getUserArchive.php";
        let res = await fetch(URL, {
            method: "POST",
            body: data,
        });

        res = await res.json();
        console.log("A");
        console.log(res);
        let tab = [];
        res.forEach((element) => {
            tab.push(element);
        });

        archiwum = tab;
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
                                    >Id</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Użytkownik</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Marka</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Model</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Początek</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Koniec</th
                                >
                                <th
                                    class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100"
                                    >Status</th
                                >
                            </tr>
                        </thead>
                        <tbody>
                            {#await funkcjaUżytkownika}
                                <p>Loading</p>
                            {:then res}
                                {#each archiwum as record}
                                    <tr>
                                        <td class="text-center px-4 py-3"
                                            >{record.id_archiwum}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{record.email}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{record.model}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{record.marka}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{record.poczatek}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{record.koniec}</td
                                        >
                                        <td class="text-center px-4 py-3"
                                            >{record.status}</td
                                        >
                                    </tr>
                                {/each}
                            {/await}
                        </tbody>
                    </table>
                </div>
            </div>
        {:else}
            <div id="info" class="flex flex-col text-center w-full mb-12">
                Brak uprawnień do wyświetlenia strony
            </div>
        {/if}
    {/await}
</section>
