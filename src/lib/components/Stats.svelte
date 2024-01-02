<script lang="ts">
	import mock1 from '$lib/images/mock1.webp';
	import mock2 from '$lib/images/mock2.webp';
	import mock3 from '$lib/images/mock3.webp';
	import mock4 from '$lib/images/mock4.webp';
	import mock5 from '$lib/images/mock5.webp';
</script>

<div class="">
	<h1 class="text-xl sm:text-3xl font-light py-4 text-center">Статистика сервиса</h1>

	<div class="screen-wrapper">
		<div class="screen-stack">
			<img src={mock1} alt="iPhone Screen 1" class="screen screen-1" />
			<img src={mock2} alt="iPhone Screen 2" class="screen screen-2" />
			<img src={mock3} alt="iPhone Screen 3" class="screen screen-3" />
			<img src={mock4} alt="iPhone Screen 4" class="screen screen-4" />
			<img src={mock5} alt="iPhone Screen 5" class="screen screen-5" />
		</div>
	</div>

	<!--  grid-cols-2 md:grid-flow-row -->
	<div class="grid p-4 gap-4 grid-cols-2 sm:grid-cols-4">
		<div class="stata">
			<p class="stata-text">Объектов</p>
			<p class="stata-number">200+</p>
		</div>
		<div class="stata">
			<p class="stata-text">Застройщиков</p>
			<p class="stata-number">89%</p>
		</div>
		<div class="stata">
			<p class="stata-text">Агентов</p>
			<p class="stata-number">23</p>
		</div>
		<div class="stata">
			<p class="stata-text">Комиссия</p>
			<p class="stata-number">до 5%</p>
		</div>
	</div>
</div>

<style lang="postcss">
	/*  */

	.stata {
		@apply border-l-2 border-accent px-4;
	}

	.stata-text {
	}

	.stata-number {
		@apply font-bold text-2xl;
		@apply md:text-4xl;
	}

	.screen-wrapper {
		width: 100%;
		/* max-width: 1200px; */
		margin: auto;
		position: relative;
		height: 350px;
	}

	.screen-stack {
		position: relative;
		height: 100%;
		display: flex;
		justify-content: center;
	}

	.screen {
		transition: transform 0.3s ease;
		position: absolute;
		height: 100%;
	}

	.screen-1,
	.screen-5 {
		z-index: 1;
	}

	.screen-2,
	.screen-4 {
		z-index: 2;
	}

	.screen-3 {
		z-index: 3;
	}

	.screen-1 {
		transform: scale(0.6) translateX(-200%);
	}
	.screen-2 {
		transform: scale(0.8) translateX(-85%);
	}
	.screen-4 {
		transform: scale(0.8) translateX(85%);
	}
	.screen-5 {
		transform: scale(0.6) translateX(200%);
	}

	/* @media (max-width: 768px) { */
	@media (max-width: 640px) {
		.screen-wrapper {
			height: 350px;
		}

		.screen-1,
		.screen-5 {
			transform: scale(0.6);
		}
		.screen-2 {
			transform: scale(0.8) translateX(-85%);
		}
		.screen-4 {
			transform: scale(0.8) translateX(85%);
		}
	}
</style>
