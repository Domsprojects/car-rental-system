<script>
    async function getOfferts() {
        const URL = "./backend/getOfferts.php";
        let res = await fetch(URL);
        res = await res.json();
        return res;
    }

    let cars = getOfferts();

    async function przejdzDoAuta(id_samochodu) {
        const URL = "./backend/isUserLogged.php";
        let res = await fetch(URL);
        res = await res.json();

        if (!res) {
            alert("Aby zarezerwować samochód musisz być zalogowany!");
        } else {
            window.location.href = "#/offert/" + id_samochodu;
        }
    }

    let filtr_marka = "",
        filtr_skrzynia = "",
        filtr_silnik = "",
        filtr_klimatyzacja = "";

    let phrase = "";
    $: filtered = cars.then((r) =>
        r.filter((item) => {
            return [
                item.marka,
                item.model,
                item.skrzynia,
                item.silnik,
                item.klimatyzacja,
            ].some((element) =>
                element
                    .toString()
                    .toLowerCase()
                    .includes(phrase.toString().toLowerCase())
            );
        })
    );
</script>

<section
    style="display: flex; align-items: center; flex-direction: column;"
    class="text-gray-600 body-font overflow-hidden"
>
    <div>
        <select name="filtr_marka" id="filtr_marka" bind:value={phrase}>
            <option disabled selected value> -- Marka-- </option>
            <option value="Toyota">Toyota</option>
            <option value="Skoda">Skoda</option>
            <option value="Ford">Ford</option>
        </select>

        <select name="filtr_skrzynia" id="filtr_skrzynia" bind:value={phrase}>
            <option disabled selected value> -- Skrzynia biegów -- </option>
            <option value="manualna">manualna</option>
            <option value="automatyczna">automatyczna</option>
        </select>

        <select name="filtr_silnik" id="filtr_silnik" bind:value={phrase}>
            <option disabled selected value> -- Silnik -- </option>
            <option value="diesel">diesel</option>
            <option value="benzyna">benzyna</option>
        </select>

        <select
            name="filtr_klimatyzacja"
            id="filtr_klimatyzacja"
            bind:value={phrase}
        >
            <option disabled selected value> -- Klimatyzacja -- </option>
            <option value="tak">tak</option>
            <option value="nie">nie</option>
        </select>
    </div>

    <div class="container px-5 py-24 mx-auto">
        {#await filtered}
            <p>Loading</p>
        {:then res}
            {#each res as car}
                {console.log(filtered)}
                <div class="lg:w-4/5 mx-auto flex flex-wrap">
                    <img
                        alt="ecommerce"
                        class="lg:w-1/2 w-full lg:h-auto h-64 object-cover object-center rounded"
                        src={car.sciezka_zdjecia}
                    />
                    <div class="lg:w-1/2 w-full lg:pl-10 lg:py-6 mt-6 lg:mt-0">
                        <h1
                            class="text-gray-900 text-3xl title-font font-medium mb-1"
                        >
                            {car.marka}
                            {car.model}
                        </h1>
                        <div class="flex mb-4" />
                        <div class="leading-relaxed">
                            <div style="display: flex;">
                                <img
                                    src="https://carfree.pl/img/gearbox.png"
                                    alt=""
                                    style="margin-right: 10px; height:20px"
                                />Skrzynia biegów: {car.skrzynia}
                            </div>

                            <div style="display: flex;">
                                <img
                                    src="https://carfree.pl/img/person.png"
                                    alt=""
                                    style="margin-right: 10px; height:20px"
                                />Ilość osób: {car.ilosc_osob}
                            </div>

                            <div style="display: flex;">
                                <img
                                    src="https://carfree.pl/img/fuel.png"
                                    alt=""
                                    style="margin-right: 10px; height:20px"
                                />Silnik: {car.silnik}
                            </div>

                            <div style="display: flex;">
                                <img
                                    src="https://carfree.pl/img/air_c.png"
                                    alt=""
                                    style="margin-right: 10px; height:20px"
                                />Klimatyzacja: {car.klimatyzacja}
                            </div>
                        </div>

                        <div class="flex">
                            <span
                                class="title-font font-medium text-2xl text-gray-900"
                                style="margin-top: 20px;"
                                >{car.cena}zł / doba</span
                            >
                            <button
                                class="flex ml-auto text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded"
                                on:click={() => {
                                    przejdzDoAuta(car.id_samochodu);
                                }}>Zarezerwuj auto</button
                            >
                        </div>
                    </div>
                </div>
            {/each}
        {/await}
    </div>
</section>
