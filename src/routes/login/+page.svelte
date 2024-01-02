<script lang="ts">
	import { enhance } from '$app/forms';
	import type { Snapshot } from './$types';

	import IconLogo from '$lib/components/IconLogo.svelte';

	// let loginOrSignup: 'login' | 'signup' = 'login';

	let formState: 'idle' | 'submitting' | 'done' | Error = 'idle';

	let email: string;
	let confirmationEmail: string | null = null;

	export const snapshot: Snapshot = {
		capture: () => email,
		restore: (value) => (email = value)
	};
</script>

<section class="">
	<div class="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">
		<a href="/" class="mb-6">
			<IconLogo size={2} />
		</a>

		<div class="bg-neutral w-full rounded-lg shadow md:mt-0 sm:max-w-md xl:p-0">
			<div class="flex flex-col p-6 space-y-4 md:space-y-6 sm:p-8">
				<form
					class="space-y-4 md:space-y-6"
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
										: `There was a problem sending magic link to ${confirmationEmail}...`;
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
					<div>
						<label>
							<p class="text-sm font-medium mb-2">Электронная почта</p>
							<input
								class="input input-secondary bg-neutral w-full"
								autocomplete="username"
								type="email"
								name="email"
								placeholder="john@doe.com"
								bind:value={email}
								required
							/>
						</label>
					</div>
					<input
						class="btn btn-primary focus:btn-secondary w-full"
						disabled={formState !== 'idle'}
						type="submit"
						value="Получить волшебную ссылку!"
					/>
				</form>
			</div>
		</div>
		<div class="mx-auto text-center h-24 pt-4">
			{#if formState === 'submitting'}
				<p class="loading loading-dots loading-lg mx-auto"></p>
			{/if}
			{#if formState === 'done' && confirmationEmail !== null}
				<!-- TODO translate -->
				<p>Please check your email:</p>
				<p><strong>{confirmationEmail}</strong></p>
			{/if}
		</div>
	</div>
</section>

<!--
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
				<input
					class="input input-bordered w-full max-w-xs"
					type="email"
					name="email"
					bind:value={email}
					required
				/>
				<input
					class="btn"
					disabled={formState !== 'idle'}
					type="submit"
					value="Login with magic link!"
				/>
			</form>
			<form action="?/password" method="post" use:enhance>
				<input type="hidden" name="email" bind:value={email} required />
				<input
					class="input input-bordered w-full max-w-xs"
					type="password"
					name="password"
					minlength="6"
					required
				/>
				<input
					class="btn"
					disabled={formState !== 'idle'}
					type="submit"
					value="Login with email + password"
				/>
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
-->

<style lang="postcss">
	/* button {
		color: oklch(96.57% 0.02 309);
		text-shadow:
			0 1px 2px oklch(14.21% 0.061 306.04),
			0 2px 2px oklch(14.21% 0.061 306.04);
	} */
</style>
