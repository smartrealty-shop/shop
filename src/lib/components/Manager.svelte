<script lang="ts">
	//
	import managers from '$lib/images/managers.webp';
</script>

<div class="">
	<h1 class="text-2xl font-light py-4 text-center">Персональный менеджер</h1>

	<p class="">
		Для каждого клиента сервиса мы предоставляем персонального менеджера, который будет вести Вашу
		сделку от нажатия на кнопку ”Бронировать”, до последней подписи в договоре!
	</p>

	<img class="" src={managers} alt="Personal Manager" />
</div>

<style lang="postcss">
	p {
		text-align: center;
		padding-left: 1rem /* 16px */;
		padding-right: 1rem /* 16px */;
		position: relative;
		z-index: 1;
	}

	img {
		position: relative;
		top: -1rem;
		z-index: 0;
		width: 100%;
		height: auto;
		mask-image: linear-gradient(to bottom, transparent 0%, black 20%);
		@apply sm:rounded-b-box;
	}
</style>
