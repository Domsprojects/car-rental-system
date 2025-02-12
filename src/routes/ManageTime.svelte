<script>
    async function sprawdzFunkcje() {
        const URL = "./backend/whoIsLogged.php";
        let res = await fetch(URL);
        res = await res.json();
        console.log(res);
        return res;
    }
    let funkcjaUżytkownika = sprawdzFunkcje();

    async function manipulujCzasem(akcja) {
        console.log(akcja);
        let data = new FormData();
        data.append("akcja", akcja);

        let URL = "./backend/manageTime.php";
        let res = await fetch(URL, {
            method: "POST",
            body: data,
        });
        res = await res.json();
    }
</script>

<section class="text-gray-600 body-font">
    {#await funkcjaUżytkownika}
        <p>Loading</p>
    {:then res}
        {#if res.funkcja == "moderator" || res.funkcja == "administrator"}
            <div class="container px-5 py-24 mx-auto">
                <button
                    class="flex mx-auto text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg"
                    style="margin-bottom: 20px;"
                    on:click={() => {
                        manipulujCzasem("cofnij");
                    }}>Cofnij czas</button
                >
                <button
                    class="flex mx-auto text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg"
                    style="margin-bottom: 20px;"
                    on:click={() => {
                        manipulujCzasem("stop");
                    }}>Stop</button
                >
                <button
                    style="margin-bottom: 20px;"
                    class="flex mx-auto text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg"
                    on:click={() => {
                        manipulujCzasem("przyspiesz");
                    }}>Przyspiesz czas</button
                >
            </div>
        {:else}
            <div id="info" class="flex flex-col text-center w-full mb-12">
                Brak uprawnień do wyświetlenia strony
            </div>
        {/if}
    {/await}
</section>
