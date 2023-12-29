<script lang="ts">
	import logo from '$lib/images/logo.webp';

	import Hero from '$lib/components/Hero.svelte';
	import CardsGrid from '$lib/components/CardsGrid.svelte';
	import Stats from '$lib/components/Stats.svelte';
	import Manager from '$lib/components/Manager.svelte';
	import Steps from '$lib/components/Steps.svelte';
	import Mobile from '$lib/components/Mobile.svelte';
	// import Chat from '$lib/components/Chat.svelte';
	// import HeroCards from '$lib/components/HeroCards.svelte';
	// import Mobile from '$lib/components/Mobile.svelte';
	// import Stats from '$lib/components/Stats.svelte';

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

<nav class="navbar z-10 w-full bg-base-100 fixed top-0" class:shadow-xl={y > 5}>
	<div class="container mx-auto max-w-screen-lg items-center justify-between px-4">
		<div class="flex-1 whitespace-nowrap text-2xl font-semibold">
			<a href="/" class="">
				<img class="h-8" src={logo} alt="logo" />
			</a>
		</div>
	</div>
</nav>

<!-- <div class="bg-base-100">
</div> -->

<!-- bg-base-300 -->
<div class="bg-base-100 pt-16">
	<div class="container mx-auto max-w-screen-xl">
		<Hero
			counter={6286}
			header="Портал недвижимости в&nbsp;ОАЭ"
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
		<!-- 
		<Stats
			header="Статистика сервиса"
			subhead="Немного цифр, демонстрирующих возможности $martRealty.shop. Это возможности, которые мы предлагаем всем нашим клиентам!"
		/>
		<Chat />
		<HeroCards />
		<Mobile /> -->
	</div>
</div>

<footer class="footer border-t-1 bg-primary text-primary-content mt-8">
	<div class="container mx-auto w-full max-w-screen-lg p-4 justify-center">
		<p class="">&copy; 2023 — Smart Realty &trade;</p>
	</div>
</footer>

<style lang="postcss">
	/*  */
</style>
