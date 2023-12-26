<script lang="ts">
	import { enhance } from '$app/forms';

	// export let data;
</script>

<main class="container max-w-prose grow px-2 text-lg">
	<h1>Profile</h1>
	<section>
		<a href="/auth/change-password">🔐 Set / change your password</a>
	</section>
	<section>
		<form action="?/signOut" method="post" use:enhance>
			<input type="submit" value="Logout" />
		</form>
	</section>
</main>
