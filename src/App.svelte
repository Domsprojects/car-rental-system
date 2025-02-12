<script>
  import Router from "svelte-spa-router";
  import Home from "./routes/Home.svelte";
  import Header from "./components/Header.svelte";
  import Footer from "./components/Footer.svelte";
  import Tailwindcss from "./Tailwindcss.svelte";

  import NotFound from "./routes/NotFound.svelte";
  import Offerts from "./routes/Offerts.svelte";
  import Statute from "./routes/Statute.svelte";
  import Login from "./routes/Login.svelte";
  import Register from "./routes/Register.svelte";
  import Logout from "./routes/Logout.svelte";
  import ManageUsers from "./routes/ManageUsers.svelte";
  import Offert from "./routes/Offert.svelte";
  import MyReservations from "./routes/MyReservations.svelte";
  import ManageReservations from "./routes/ManageReservations.svelte";
  import AllArchive from "./routes/AllArchive.svelte";
  import MyArchive from "./routes/MyArchive.svelte";
  import ManageTime from "./routes/ManageTime.svelte";
</script>

<Tailwindcss />
<Header />
<Router
  routes={{
    "/": Home,
    "/offerts": Offerts,
    "/statute": Statute,
    "/login": Login,
    "/register": Register,
    "/logout": Logout,
    "/manageusers": ManageUsers,
    "/offert/:id": Offert,
    "/myreservations": MyReservations,
    "/managereservations": ManageReservations,
    "/allarchive": AllArchive,
    "/myarchive": MyArchive,
    "/managetime": ManageTime,
    "*": NotFound,
  }}
/>
<Footer />
