<script>
    async function wyloguj() {
        const URL = "./backend/logout.php";
        let res = await fetch(URL);
        res = await res.json();
        console.log(res);

        setTimeout(() => {
            window.location.href = "#/";
            window.location.reload(true);
        }, 1000);
    }

    wyloguj();
</script>

<section class="text-gray-600 body-font relative">
    <div class="container px-5 py-24 mx-auto">
        <div class="flex flex-col text-center w-full mb-12">
            <h1
                class="sm:text-3xl text-2xl font-medium title-font mb-4 text-gray-900"
            >
                Wylogowano z konta
            </h1>
        </div>
    </div>
</section>
