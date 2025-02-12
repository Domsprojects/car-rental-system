<script>
  async function logowanie() {
    const URL = "./backend/isUserLogged.php";
    let res = await fetch(URL);
    res = await res.json();
    return res;
  }
  let zalogowano = logowanie();

  async function sprawdzFunkcje() {
    const URL = "./backend/whoIsLogged.php";
    let res = await fetch(URL);
    res = await res.json();
    return res;
  }
  let funkcjaUżytkownika = sprawdzFunkcje();
</script>

<header class="text-gray-600 body-font">
  <div
    class="container mx-auto flex flex-wrap p-5 flex-col md:flex-row items-center"
  >
    <a
      class="flex title-font font-medium items-center text-gray-900 mb-4 md:mb-0"
      href="#/"
    >
      <img
        src="./backend/logo.png"
        style="height: 40px; width:70px;"
        alt="logo"
      />
      <span class="ml-3 text-xl">CarRent</span>
    </a>
    <nav
      class="md:ml-auto flex flex-wrap items-center text-base justify-center"
    >
      <a href="#/" class="mr-5 hover:text-gray-900">Home</a>
      <a href="#/offerts" class="mr-5 hover:text-gray-900">Oferta</a>
      <a href="#/statute" class="mr-5 hover:text-gray-900">Regulamin</a>

      {#await funkcjaUżytkownika}
        <p>Loading</p>
      {:then res}
        {#if res.funkcja == "administrator"}
          <a href="#/manageusers" class="mr-5 hover:text-gray-900"
            >Zarządzaj użytkownikami</a
          >
          <a href="" class="mr-5 hover:text-gray-900">Zarządzaj czasem</a>
        {:else if res.funkcja == "moderator"}
          <a href="#/managereservations" class="mr-5 hover:text-gray-900"
            >Zarządzaj rezerwacjami</a
          >
          <a href="#/allarchive" class="mr-5 hover:text-gray-900"
            >Archiwum rezerwacji</a
          >
          <a href="#/managetime" class="mr-5 hover:text-gray-900"
            >Zarządzaj czasem</a
          >
        {:else if res.funkcja == "uzytkownik"}
          <a href="#/myreservations" class="mr-5 hover:text-gray-900"
            >Moje rezerwacje</a
          >
          <a href="#/myarchive" class="mr-5 hover:text-gray-900"
            >Moje archiwum</a
          >
        {/if}
      {/await}

      {#await zalogowano}
        <p>Loading</p>
      {:then res}
        {#if res == true}
          <a href="#/logout" class="mr-5 hover:text-gray-900">Wyloguj się</a>
        {:else if res == false}
          <a href="#/login" class="mr-5 hover:text-gray-900">Zaloguj się</a>
          <a href="#/register" class="mr-5 hover:text-gray-900"
            >Zarejestruj się</a
          >
        {/if}
      {/await}
    </nav>
  </div>
</header>
