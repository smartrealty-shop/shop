<script lang="ts">
	import welcome from '$lib/images/mock3.webp';
	// TODO: get some image
	import welcome_fallback from '$lib/images/svelte-welcome.png';

	export let header: string;
	export let text: string;
	export let buttonText = '';
	export let backgroundImage = '';
	export let counter: number | null = null;

	const formatNumber = (n: number) => {
		return new Intl.NumberFormat().format(n);
	};
</script>

<!--  lg:min-h-fit lg:pb16 lg:pt-32 -->
<div class="hero">
	<div class="hero-content flex-row items-start pr-0 md:pr-4 md:items-center">
		<div class="">
			{#if counter !== null}
				<div class="badge badge-sm py-4">
					Доступно <span class="font-semibold mx-1">{formatNumber(counter)}</span> объектов
				</div>
			{/if}
			<h1 class="text-2xl font-light pt-8">{header}</h1>
			<p class="text-xl text-secondary font-light pb-8">{text}</p>
			{#if buttonText}
				<a href="/login" class="btn px-6 btn-primary text-neutral">
					{buttonText}
				</a>
			{/if}
			{#if backgroundImage}
				<p>there is some bg</p>
			{/if}
		</div>
		<div class="h-80 w-40">
			<img class="h-full object-cover object-left-top" src={welcome} alt="Welcome" />
		</div>
	</div>
</div>

<style lang="postcss">
	/*  */
</style>
