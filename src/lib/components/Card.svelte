<script lang="ts">
	import Icon from '@iconify/svelte';

	export let title = '';
	export let text = '';
	export let iconName: string | null = null;
</script>

<div class="card card-compact card-side bg-neutral rounded-none lg:rounded-2xl">
	{#if iconName !== null}
		<figure class="px-6">
			<div class="btn btn-circle btn-secondary">
				<Icon icon={iconName} width="24" height="24" />
				<!-- <div class="rounded bg-base-200 object-cover w-24">
			</div> -->
			</div>
		</figure>
	{/if}
	<div class="card-body px-2">
		<h2 class="text-lg lg:text-xl">{title}</h2>
		<p class="text-sm">{text}</p>
	</div>
</div>

<style lang="postcss">
	/*  */
	.card-titlee {
		display: flex;
		align-items: center;
		gap: 0.5rem /* 8px */;
		font-size: 1.25rem /* 20px */;
		line-height: 1.75rem /* 28px */;
		font-weight: 600;
	}
	.card-compact .card-titlee {
		margin-bottom: 0.25rem /* 4px */;
	}
	.card-normal .card-titlee {
		margin-bottom: 0.75rem /* 12px */;
	}
</style>
