import { fail, redirect } from '@sveltejs/kit';
import { AuthApiError } from '@supabase/supabase-js';

import type { Actions, PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ locals: { getSession } }) => {
	const session = await getSession();

	// if the user is already logged in return them to their profile page
	if (session) {
		throw redirect(303, '/profile');
	}

	return {
		meta: {
			title: 'Login',
			description: ' Login to your account'
		}
	};
};

export const actions: Actions = {
	magic: async ({ request, url, locals: { supabase } }) => {
		const formData = await request.formData();
		const email = formData.get('email');

		if (typeof email !== 'string') {
			return fail(400, {
				error: 'Missing email'
			});
		}

		const emailRedirectTo = `${url.origin}/auth/callback`;

		const { error } = await supabase.auth.signInWithOtp({
			email,
			options: { emailRedirectTo }
		});

		if (error) {
			if (error instanceof AuthApiError && error.status === 400) {
				return fail(400, {
					message: 'We need your email for email login',
					values: { email }
				});
			}

			if (error.message === 'Email rate limit exceeded') {
				return fail(500, {
					message: 'We’ve sent too many magic links, please try again later?',
					email
				});
			}

			return fail(500, {
				message: error.message ?? 'We had a problem logging you in! Try again?',
				email
			})
		}

		return {email}
	}
};
