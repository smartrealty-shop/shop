<script lang="ts">
	import { enhance } from '$app/forms';
	import type { Snapshot } from './$types';

	let loginOrSignup: 'login' | 'signup' = 'login';

	let formState: 'idle' | 'submitting' | 'done' | Error = 'idle';

	let email: string;
	let confirmationEmail: string | null = null;

	export const snapshot: Snapshot = {
		capture: () => email,
		restore: (value) => (email = value)
	};
</script>

<main class="container flex grow flex-col">
	<section>
		{#if loginOrSignup === 'login'}
			<form
				action="?/magic"
				method="post"
				use:enhance={() => {
					formState = 'submitting';
					confirmationEmail = email;

					return async ({ result, update }) => {
						if (result.type === 'failure') {
							const message =
								typeof result.data?.message === 'string'
									? result.data?.message
									: `There was a problem sending a magic link to ${confirmationEmail}...`;
							formState = new Error(message);
						}

						if (result.type === 'success') {
							formState = 'done';
							if (typeof result.data?.email === 'string') {
								confirmationEmail = result.data.email;
							}
						}

						await update();
					};
				}}
			>
				<input class="input input-bordered w-full max-w-xs" type="email" name="email" bind:value={email} required />
				<input class="btn" disabled={formState !== 'idle'} type="submit" value="Login with magic link!" />
			</form>
			<form action="?/password" method="post" use:enhance>
				<input type="hidden" name="email" bind:value={email} required />
				<input class="input input-bordered w-full max-w-xs" type="password" name="password" minlength="6" required />
				<input class="btn" disabled={formState !== 'idle'} type="submit" value="Login with email + password" />
			</form>
			<button
				on:click={() => {
					loginOrSignup = 'signup';
				}}>or create a new account!</button
			>
		{:else}
			<form action="?/signUp" method="post" use:enhance>
				<input type="email" name="email" autocomplete="email" required bind:value={email} />
				<input
					type="password"
					name="password"
					placeholder="password"
					required
					minlength="6"
					autocomplete="new-password"
				/>
				<input type="submit" value="Signup" />
			</form>
			<button
				on:click={() => {
					loginOrSignup = 'login';
				}}>or login to an existing account</button
			>
		{/if}
		{#if formState === 'done' && confirmationEmail}
			<div>
				💌 Please check your email: <strong>{confirmationEmail}</strong> 💌
			</div>
		{/if}
		{#if formState === 'submitting'}
			<span class="loading loading-dots loading-lg"></span>
		{/if}
		{#if formState instanceof Error}
			<strong>🚨 {formState.message} 🚨</strong>
			{#if formState.message.includes('Invalid credentials')}
				<div>
					<p>
						You may want to double-check your email & password, or try logging in with a magic link
						instead!
					</p>
					<form
						method="POST"
						action="?/reset"
						use:enhance={() => {
							formState = 'submitting';

							return async ({ result, update }) => {
								if (result.type === 'failure') {
									const message =
										typeof result.data?.message === 'string'
											? result.data?.message
											: `There was a problem sending a password reset email to ${confirmationEmail}...`;
									formState = new Error(message);
								}

								if (result.type === 'success') {
									formState = 'done';
									if (typeof result.data?.email === 'string') {
										confirmationEmail = result.data.email;
									}
								}

								await update();
							};
						}}
					>
						<input type="hidden" name="email" bind:value={email} required />
						<p>
							You may also <button
								class="underline decoration-emphasis hover:decoration-emphasis-hover"
								>reset your password</button
							>.
						</p>
					</form>
				</div>
			{/if}
		{/if}
	</section>
</main>

<style lang="postcss">
	/* button {
		color: oklch(96.57% 0.02 309);
		text-shadow:
			0 1px 2px oklch(14.21% 0.061 306.04),
			0 2px 2px oklch(14.21% 0.061 306.04);
	} */
</style>
