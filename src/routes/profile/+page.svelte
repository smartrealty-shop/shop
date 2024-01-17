<script lang="ts">
	import logo from '$lib/images/logo.svg';
	import logoWithText from '$lib/images/logo-with-text.svg';
	import { enhance } from '$app/forms';
	import Icon from '@iconify/svelte';
	import { Avatar, Input } from '$lib/components';
	import Drawer from '$lib/components/Drawer.svelte';
	import AdvancedTelInput from '$lib/components/AdvancedTelInput.svelte';

	import type { SubmitFunction } from '@sveltejs/kit';

	export let data;
	export let form;

	let { session, supabase, profile } = data;
	$: ({ session, supabase, profile } = data);

	let profileForm: HTMLFormElement;
	let loading = false;
	let fullName: string = profile?.full_name ?? '';
	let username: string = profile?.username ?? '';
	let phone: string = profile?.phone ?? '';
	let website: string = profile?.website ?? '';
	let avatarUrl: string = profile?.avatar_url ?? '';

	let navbarAvatar: string = '';

	const downloadAvatar = async (path: string) => {
		try {
			const { data, error } = await supabase.storage.from('avatars').download(path, {
				transform: {
					width: 80,
					height: 80,
					// quality: 80,
					resize: 'cover'
				}
			});

			if (error) {
				throw error;
			}

			const url = URL.createObjectURL(data);
			navbarAvatar = url;
		} catch (e) {
			if (e instanceof Error) {
				console.error('Error downloading image: ', e.message);
			}
		}
	};

	$: if (avatarUrl) downloadAvatar(avatarUrl);

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

	// Drawer activation logic
	let isOpen = false;
	const handleToggle = () => {
		isOpen = !isOpen;
	};
</script>

<section class="container mx-auto max-w-screen-lg">
	<nav class="navbar">
		<div class="navbar-start">
			<!--  -->
			<a href="/" class="">
				<img class="h-10 hidden md:flex" src={logoWithText} alt="logo" />
			</a>
		</div>
		<div class="navbar-center">
			<!--  -->
			<!-- <div class=""> -->
			<a href="/" class="">
				<!-- <img class="h-10 hidden md:block" src={logo} alt="logo" /> -->
				<img class="h-10 md:hidden" src={logoWithText} alt="logo" />
			</a>
			<!-- </div> -->
			<ul class="menu menu-horizontal p-0 hidden md:flex">
				<li><a href="/collections">Подборки</a></li>
				<li><a href="/blog">Блог</a></li>
				<li><a href="/learn">Обучение</a></li>
				<li><a href="/support">Поддержка</a></li>
				<!--
				<li>
					<details>
						<summary>Parent</summary>
						<ul class="p-2">
							<li><a href="">Submenu 1</a></li>
							<li><a href="">Submenu 2</a></li>
						</ul>
					</details>
				</li>
				<li><a href="">Item 3</a></li>
				-->
			</ul>
		</div>
		<div class="navbar-end">
			<div class="dropdown dropdown-end">
				<div tabindex="0" role="button" class="btn btn-ghost btn-circle avatar hidden md:flex">
					<div class="w-10 rounded-full">
						<img alt="user avatar" src={navbarAvatar} />
					</div>
				</div>
				<ul
					class="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-52"
				>
					<li><a href="/profile"> Профиль </a></li>
					<!-- <li>
						<a class="justify-between" href="/profile">
							Profile
							<span class="badge">New</span>
						</a>
					</li> -->
					<!-- <li><a href="/settings">Settings</a></li> -->
					<!-- <li><a href="/signout">Signout</a></li> -->
					<li>
						<form class="flex p-0" action="?/signout" method="post" use:enhance={handleSignOut}>
							<button type="submit" class="px-3 w-full text-left rounded-box"> Выйти </button>
						</form>
					</li>
				</ul>
			</div>

			<!-- Navbar button for drawer activation -->
			<div class="md:hidden">
				<button class="btn btn-primary mask mask-squircle" on:click={handleToggle}>
					<Icon icon="lucide:menu" width="24" height="24" />
				</button>
			</div>
		</div>
	</nav>
	<section class="max-w-lg mx-auto px-4">
		<h1 class="text-3xl font-bold text-center py-6 lg:py-12">Профиль</h1>
		<form
			action="?/update"
			method="post"
			enctype="multipart/form-data"
			class=""
			use:enhance={handleSubmit}
			bind:this={profileForm}
		>
			<div class="flex justify-center pb-4">
				<Avatar
					{supabase}
					bind:url={avatarUrl}
					size={10}
					on:upload={() => {
						profileForm.requestSubmit();
					}}
				/>
			</div>
			<Input label="Электронная почта" disabled={true} value={session.user.email} />
			<Input id="fullName" label="Имя пользователя" value={form?.fullName ?? fullName} />
			<label class="form-control w-full">
				<div class="label">
					<span class="label-text">Телефон</span>
				</div>
				<input type="hidden" name="phone" value={phone} />
				<AdvancedTelInput bind:value={phone} />
			</label>
			<div class="flex justify-end mt-4">
				<input
					type="submit"
					class="form-control btn btn-primary"
					value={loading ? 'Занят...' : 'Сохранить'}
					disabled={loading}
				/>
			</div>
		</form>
	</section>
</section>

<Drawer {isOpen} maxScreenSize="max-w-xs" on:clickAway={handleToggle}>
	<!-- <h5 class="font-semibold uppercase">Menu</h5> -->
	<!-- <button
		type="button"
		class="bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 absolute top-2.5 end-2.5 inline-flex items-center justify-center"
	>
		<Icon icon="lucide:x" width="24" height="24" />
	</button> -->
	<div class="py-4 overflow-y-auto">
		<ul class="space-y-2 font-medium text-2xl">
			<li>
				<a href="/collections" class="flex items-center p-2 rounded-lg hover:bg-base-200 group">
					<Icon icon="lucide:book-heart" class="w-8 h-8" />
					<span class="ms-3">Подборки</span>
				</a>
			</li>
			<li>
				<a href="/blog" class="flex items-center p-2 rounded-lg hover:bg-base-200 group">
					<Icon icon="lucide:scroll-text" class="w-8 h-8" />
					<span class="flex-1 ms-3 whitespace-nowrap">Блог</span>
				</a>
			</li>
			<li>
				<a href="/learn" class="flex items-center p-2 rounded-lg hover:bg-base-200 group">
					<Icon icon="lucide:baby" class="w-8 h-8" />
					<span class="flex-1 ms-3 whitespace-nowrap">Обучение</span>
				</a>
			</li>
			<li>
				<a href="/support" class="flex items-center p-2 rounded-lg hover:bg-base-200 group">
					<Icon icon="lucide:clover" class="w-8 h-8" />
					<span class="flex-1 ms-3 whitespace-nowrap">Поддержка</span>
				</a>
			</li>
		</ul>

		<div class="divider"></div>

		<ul class="space-y-2 font-medium text-2xl">
			<li>
				<a href="/profile" class="flex items-center p-2 rounded-lg hover:bg-base-200 group">
					<Icon icon="lucide:circle-user" class="w-8 h-8" />
					<span class="ms-3">Профиль</span>
				</a>
			</li>
			<!--
			<li>
				<a href="signout" class="flex items-center p-2 rounded-lg hover:bg-base-200 group">
					<Icon icon="lucide:door-open" class="w-8 h-8" />
					<span class="ms-3">Выйти</span>
				</a>
			</li>
			-->
		</ul>

		<form
			class="flex mt-4 justify-center"
			action="?/signout"
			method="post"
			use:enhance={handleSignOut}
		>
			<button class="btn btn-link" type="submit">
				<span class="ms-3">Выйти</span>
			</button>
		</form>
	</div>
</Drawer>

<style lang="postcss">
	/*  */
</style>
