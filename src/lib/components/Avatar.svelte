<script lang="ts">
	import Icon from '@iconify/svelte';
	import { createEventDispatcher } from 'svelte';

	import type { SupabaseClient } from '@supabase/supabase-js';

	export let size = 10;
	export let url: string;
	export let supabase: SupabaseClient;

	let avatarUrl: string | null = null;
	let uploading = false;
	let files: FileList;

	const dispatch = createEventDispatcher();

	const downloadImage = async (path: string) => {
		try {
			const { data, error } = await supabase.storage.from('avatars').download(path, {
				transform: {
					width: 160,
					height: 160,
					// quality: 80,
					resize: 'cover'
				}
			});

			if (error) {
				throw error;
			}

			const url = URL.createObjectURL(data);
			avatarUrl = url;
		} catch (e) {
			if (e instanceof Error) {
				console.error('Error downloading image: ', e.message);
			}
		}
	};

	const uploadAvatar = async () => {
		try {
			uploading = true;

			if (!files || files.length === 0) {
				throw new Error('You must select an image to upload.');
			}

			const file = files[0];
			const fileExt = file.name.split('.').pop();
			const filePath = `${Math.random()}.${fileExt}`;

			const { error } = await supabase.storage.from('avatars').upload(filePath, file);

			if (error) {
				throw error;
			}

			url = filePath;
			setTimeout(() => {
				dispatch('upload');
			}, 100);
		} catch (e) {
			if (e instanceof Error) {
				alert(e.message);
			}
		} finally {
			uploading = false;
		}
	};

	$: if (url) downloadImage(url);
</script>

<div class="flex flex-col">
	<div class="form-control w-full max-w-lg">
		<!-- <label class="label font-medium pb-1" for="avatar">
				<span class="label-text">Profile Picture</span>
			</label> -->
		<label
			for="avatar"
			class="avatar w-32 rounded-full ring ring-primary ring-offset-base-100 ring-offset-2 hover:cursor-pointer"
		>
			<label for="avatar" class="absolute -bottom-0.5 -right-0.5 hover:cursor-pointer">
				<span class="btn btn-circle btn-sm btn-secondary">
					<Icon icon="lucide:pen" width="1rem" height="1rem" />
				</span>
			</label>
			<div class="w-32 rounded-full">
				{#if avatarUrl}
					<img src={avatarUrl} alt={avatarUrl ? 'Avatar' : 'No image'} class="" />
				{:else}
					<div class="avatar placeholder">
						<div class="rounded-full w-32">
							<span class="text-xl">No image</span>
						</div>
					</div>
				{/if}
			</div>
		</label>
		<!-- <input type="file" name="avatar" id="avatar" value="" accept="image/*" hidden class="" on:change={showPreview} /> -->
		<input type="hidden" name="avatarUrl" value={url} />
		<input
			type="file"
			name="avatar"
			id="avatar"
			accept="image/*"
			hidden
			bind:files
			on:change={uploadAvatar}
			disabled={uploading}
		/>
	</div>
</div>

<style lang="postcss">
	/*  */
</style>
