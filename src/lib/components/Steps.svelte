<script lang="ts">
	import fig01 from '$lib/images/f1.webp';
	import fig02 from '$lib/images/f2.webp';
	import fig03 from '$lib/images/f3.webp';
	import fig04 from '$lib/images/f4.webp';
</script>

<div class="">
	<div class="stat-wrapper">
		<div class="figure-wrapper">
			<img class="h-full object-cover object-right" src={fig01} alt="" />
		</div>
		<div class="px-4">
			<h1 class="font-extrabold text-base-200 text-8xl">01</h1>
			<h2 class="text-2xl -mt-8 mb-4">Работа с проектами</h2>
			<p class="">Выбирай, фильтруй, анализируй. Вся информация всегда под рукой.</p>
		</div>
	</div>
	<div class="stat-wrapper">
		<div class="px-4">
			<h1 class="font-extrabold text-base-200 text-8xl">02</h1>
			<h2 class="text-2xl -mt-8 mb-4">Поддержка персонального менеджера 24/7</h2>
			<p class="">
				Расскажет про районы, проекты и застройщиков.<br />Поможет с выбором.<br />Обладает глубокой
				компетенцией по рынку ОАЭ.
			</p>
		</div>
		<div class="figure-wrapper">
			<img class="h-full object-cover object-left" src={fig02} alt="" />
		</div>
	</div>
	<div class="stat-wrapper">
		<div class="figure-wrapper">
			<img class="h-full object-cover object-right" src={fig03} alt="" />
		</div>
		<div class="px-4">
			<h1 class="font-extrabold text-base-200 text-8xl">03</h1>
			<h2 class="text-2xl -mt-8 mb-4">Полная информация о комиссии</h2>
			<p class="">Сразу видите Ваш доход со сделки, все данные открыты и прозрачны.</p>
		</div>
	</div>
	<div class="stat-wrapper">
		<div class="px-4">
			<h1 class="font-extrabold text-base-200 text-8xl">04</h1>
			<h2 class="text-2xl -mt-8 mb-4">Получай комиссию в любой точке мира</h2>
			<p class="">Выплата комиссии в любом формате, в том числе криптовалютой.</p>
		</div>
		<div class="figure-wrapper">
			<img class="h-full object-cover object-left" src={fig04} alt="" />
		</div>
	</div>
</div>

<style lang="postcss">
	.stat-wrapper {
		@apply flex flex-row items-center py-2;
	}

	.figure-wrapper {
		@apply h-80 w-56;
	}
</style>
