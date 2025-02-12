<script>
    let email, haslo, info;
    let emailValidation = /\S+@\S/;

    async function rejestruj() {
        if (email && haslo) {
            if (emailValidation.test(email)) {
                let data = new FormData();
                data.append("email", email);
                data.append("haslo", haslo);

                let URL = "./backend/register.php";
                let res = await fetch(URL, {
                    method: "POST",
                    body: data,
                });

                res = await res.json();
                if (res == true) {
                    document.getElementById("info").style.visibility =
                        "visible";
                    info =
                        "Konto zostało pomyślnie zarejestrowane, aby się zalogować poczekaj aż zostanie ono aktywowane przez moderatora";
                } else {
                    document.getElementById("info").style.visibility =
                        "visible";
                    info = "Konto o podanym adresie emial już istnieje";
                }
            } else {
                document.getElementById("info").style.visibility = "visible";
                info = "Nieprawidłowy adres email";
            }
        } else {
            document.getElementById("info").style.visibility = "visible";
            info = "Proszę uzupełnić wszystkie dane";
        }
    }
</script>

<section class="text-gray-600 body-font relative">
    <div class="container px-5 py-24 mx-auto">
        <div class="flex flex-col text-center w-full mb-12">
            <h1
                class="sm:text-3xl text-2xl font-medium title-font mb-4 text-gray-900"
            >
                Zarejestruj się
            </h1>
        </div>
        <div class="lg:w-1/2 md:w-2/3 mx-auto">
            <div class="flex flex-wrap -m-2">
                <div class="p-2 w-full">
                    <div class="relative">
                        <label
                            for="email"
                            class="leading-7 text-sm text-gray-600">Email</label
                        >
                        <input
                            bind:value={email}
                            type="email"
                            id="email"
                            name="email"
                            class="w-full bg-gray-100 bg-opacity-50 rounded border border-gray-300 focus:border-indigo-500 focus:bg-white focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
                        />
                    </div>
                </div>

                <div class="p-2 w-full">
                    <div class="relative">
                        <label
                            for="haslo"
                            class="leading-7 text-sm text-gray-600">Hasło</label
                        >
                        <input
                            bind:value={haslo}
                            type="password"
                            id="haslo"
                            name="haslo"
                            class="w-full bg-gray-100 bg-opacity-50 rounded border border-gray-300 focus:border-indigo-500 focus:bg-white focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
                        />
                    </div>
                </div>

                <div class="p-2 w-full">
                    <button
                        class="flex mx-auto text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg"
                        on:click={rejestruj}>Zarejestruj</button
                    >

                    <div
                        id="info"
                        style="visibility: hidden; margin-top: 20px "
                        class="flex flex-col text-center w-full mb-12"
                    >
                        {info}
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
