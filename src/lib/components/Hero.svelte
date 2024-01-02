<script lang="ts">
	import welcome from '$lib/images/mock3.webp';
	// TODO: get some image
	import welcome_fallback from '$lib/images/svelte-welcome.png';

	export let header: string;
	export let text: string;
	export let buttonText = '';
	export let counter: number | null = null;

	const formatNumber = (n: number) => {
		return new Intl.NumberFormat().format(n);
	};
</script>

<div class="heroo p-2">
	<div class="hero-contentt">
		<div class="">
			{#if counter !== null}
				<div class="badge badge-sm py-4">
					Доступно <span class="font-semibold mx-1">{formatNumber(counter)}</span> объектов
				</div>
			{/if}
			<h1 class="text-2xl md:text-5xl font-light py-6">{header}</h1>
			<p class="text-xl md:text-3xl text-secondary font-light pb-6">{text}</p>
			{#if buttonText}
				<a href="/login" class="btn px-6 btn-primary">
					{buttonText}
				</a>
			{/if}
		</div>
		<div class="">
			<img class="" src={welcome} alt="Welcome" />
		</div>
	</div>
</div>

<style lang="postcss">
	img {
		width: 260px;
		height: 400px;
		object-fit: cover;
		object-position: left top;
	}

	.heroo {
		/* display: grid; */
		/* width: 100%; */
		/* place-items: center; */
		/* background-size: cover; */
		/* background-position: center; */
	}

	.heroo > * {
		//grid-column-start: 1;
		//grid-row-start: 1;
	}

	.hero-contentt {
		//z-index: 0;
		display: flex;
		align-items: center;
		justify-content: space-between;
		/* justify-content: center; */
		//max-width: 80rem; /* 1280px */
		//gap: 1rem; /* 16px */
		//padding: 1rem; /* 16px */
	}
</style>
