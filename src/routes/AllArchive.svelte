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

    async function pokazArchiwum() {
        const URL = "./backend/getArchive.php";
        let res = await fetch(URL);
        res = await res.json();
        return res;
    }

    let archiwum = pokazArchiwum();
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
                            {#await archiwum}
                                <p>Loading</p>
                            {:then res}
                                {#each res as record}
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
