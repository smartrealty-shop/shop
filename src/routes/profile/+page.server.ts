import { fail, redirect } from '@sveltejs/kit';

import type { Actions, PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ locals: { getSession, supabase } }) => {
	const session = await getSession();

	// if the user is not logged in return them to home page
	if (!session) {
		throw redirect(303, '/login');
	}

	//
	const { data: profile } = await supabase
		.from('profiles')
		.select(`username, full_name, website, avatar_url`)
		.eq('id', session.user.id)
		.single();

	return { session, profile };
};

export const actions: Actions = {
	update: async ({ request, locals: { getSession, supabase } }) => {
		const formData = await request.formData();
		const fullName = formData.get('fullName') as string;
		const username = formData.get('username') as string;
		const website = formData.get('website') as string;
		const avatarUrl = formData.get('avatarUrl') as string;

		const session = await getSession();

		if (session?.user) {
			const { error } = await supabase.from('profiles').upsert({
				id: session.user.id,
				full_name: fullName,
				username,
				website,
				avatar_url: avatarUrl,
				updated_at: new Date().toISOString()
			});

			if (error) {
				return fail(500, {
					fullName,
					username,
					website,
					avatarUrl
				});
			}
		}

		return {
			fullName,
			username,
			website,
			avatarUrl
		};
	},
	signout: async ({ locals: { getSession, supabase } }) => {
		const session = await getSession();
		if (session) {
			await supabase.auth.signOut();
			throw redirect(303, '/');
		}
	}
};
