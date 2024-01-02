<script lang="ts">
	import { enhance } from '$app/forms';

	import type { SubmitFunction } from '@sveltejs/kit';

	export let data;
	export let form;

	let { session, supabase, profile } = data;
	$: ({ session, supabase, profile } = data);

	let profileForm: HTMLFormElement;
	let loading = false;
	let fullName: string = profile?.full_name ?? '';
	let username: string = profile?.username ?? '';
	let website: string = profile?.website ?? '';
	let avatarUrl: string = profile?.avatar_url ?? '';

	const handleSubmit: SubmitFunction = () => {
		loading = true;
		return async () => {
			loading = false;
		};
	};

	const handleSignOut: SubmitFunction = () => {
		loading = true;
		return async ({ update }) => {
			loading = false;
			update();
		};
	};

	import Avatar from './Avatar.svelte';

	// export let data;
</script>

<main class="container max-w-prose grow px-2 text-lg">
	<h1>Profile</h1>
	<div class="form-widget">
		<form
			action="?/update"
			method="post"
			class="form-widget"
			use:enhance={handleSubmit}
			bind:this={profileForm}
		>
			<Avatar
				{supabase}
				bind:url={avatarUrl}
				size={10}
				on:upload={() => {
					profileForm.requestSubmit();
				}}
			/>
			<div>
				<label for="email">Email</label>
				<input type="text" id="email" value={session.user.email} disabled />
			</div>
			<div>
				<label for="fullName">Full Name</label>
				<input id="fullName" name="fullName" type="text" value={form?.fullName ?? fullName} />
			</div>
			<div>
				<label for="username">Username</label>
				<input id="username" name="username" type="text" value={form?.username ?? username} />
			</div>
			<div>
				<label for="website">Website</label>
				<input id="website" name="website" type="text" value={form?.website ?? website} />
			</div>
			<div>
				<input
					type="submit"
					class="btn"
					value={loading ? 'Loading...' : 'Update'}
					disabled={loading}
				/>
			</div>
		</form>
		<form action="?/signout" method="post" use:enhance={handleSignOut}>
			<input type="submit" value="Sign Out" disabled={loading} class="btn">
		</form>
	</div>
	<!-- <section>
		<a href="/auth/change-password">🔐 Set / change your password</a>
	</section>
	<section>
		<form action="?/signOut" method="post" use:enhance>
			<input type="submit" value="Logout" />
		</form>
	</section> -->
</main>

<style lang="postcss">
	.form-widget {
		@apply flex flex-col gap-20;
	}
</style>
