<script lang="ts">
	import logo from '$lib/images/logo.webp';

	import Hero from '$lib/components/Hero.svelte';
	import CardsGrid from '$lib/components/CardsGrid.svelte';
	import Stats from '$lib/components/Stats.svelte';
	import Manager from '$lib/components/Manager.svelte';
	import Steps from '$lib/components/Steps.svelte';
	import Mobile from '$lib/components/Mobile.svelte';

	const cardsOne = [
		{
			title: 'Все застройщики в одном месте',
			text: 'Структурированная и полная информация по всем застройщикам и объектам в ОАЭ',
			iconName: 'lucide:building-2'
		},
		{
			title: 'Полная информация по объектам',
			text: 'Цены, презентации, планировки, маркетинговые материалы в одном месте',
			iconName: 'lucide:book-open-text'
		},
		{
			title: 'Сопровождение на всех этапах сделки',
			text: 'Прозрачная коммуникация от выбора объекта для клиента, до заключения сделки и получения комиссии',
			iconName: 'lucide:heart-handshake'
		}
	];

	// https://stackoverflow.com/a/67944836
	// this used to turn off fixed navbar on scroll more than 60px
	let y: number = 0;
</script>

<svelte:window bind:scrollY={y} />

<div class="bg-base-100">
	<div class="container mx-auto max-w-screen-lg">
		<nav class="navbar">
			<div class="flex-1 whitespace-nowrap text-2xl font-semibold">
				<a href="/" class="">
					<img class="h-8" src={logo} alt="logo" />
				</a>
			</div>
		</nav>
		<main class="py-4">
			<Hero
				counter={6286}
				header="Портал&nbsp;недвижимости в&nbsp;ОАЭ"
				text="для&nbsp;профессионалов"
				buttonText="Присоединиться"
			/>
			<div class="-mt-10">
				<CardsGrid items={cardsOne} />
			</div>
			<Stats />
			<Manager />
			<Steps />
			<Mobile />
		</main>
		<footer class="footer footer-center bg-base-200 p-4 lg:rounded">
			<aside>
				<p class="mx-auto">&copy; 2023 — Smart Realty &trade;. All rights reserved</p>
			</aside>
		</footer>
	</div>
</div>

<style lang="postcss">
	/*  */
</style>
