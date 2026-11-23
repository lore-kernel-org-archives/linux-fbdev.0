Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438632;
	b=NBnKBpz/wWobzWTm6+1RxC5Ti/HxSdbA2SuIPYeNTJdOYhgfwcZdVUPLbEC4hsIwo6Uq
	 LiifiQYbuuZ1z7+vfZN6prrK8ssfCR8TdKKTSOPzUZN36/oH7DFtT/eWXdE6hDquKwC9G
	 gO7OYcD8alG6nAdiwARg/VWjLWZLkFqtnR8CiwjbVtsnmSiihhbFI1sWUgJlfjFZlgAkY
	 u/lMkpq6LSy62FBgeVOy9EJARtY4It7Lj7sRN0Pdsr+M8e7jZ0QjWmHRoMwA7gR9L74uk
	 ju97OzDeLMb+x16ybKB49Fw9B4EuXv9d8sJ+nONCIpo920Jh2DFx0OsXI2WlAdsdLkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438632;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6xC+qQtflU5U3Wz1JTDXOkRZw08r536ARZ5RUEh7XO4=;
	b=frCqwKieLeUo2M3rX5rM8X+b5ktdDpTM3JTfGWO8GRBS9GLI4Ut6SAxAKnR9Wo01Lty+
	 DfXi+gsLNMmEVfWZ/qaU7n9hZIbWBj1q+4k/PlzhXtWMNXRWJNuxxThM6fb2hd7KgVN6A
	 CkzvQG4NLxZTspEeVHDCFi6z2Mqnr2Ayv7Xk6S0DnEIasI9fx30sLpcs7P7WGNzNlPINR
	 Y49PgmSrf5JsIzEfmnS8c869zxdGfTVxL1PPwLDqYsghmXtuhv736Z52Tik+bu28NpTqv
	 LuaBhKT6zgXBmnnXNN03hf3TtamTbw3SQz3E8HyS8u+OolBrUO8u7w+pAFeluIWNtjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngxGdBdr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD82606A31E;
	Mon, 23 Nov 2026 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngxGdBdr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCD81F000D4;
	Mon, 23 Nov 2026 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438631;
	bh=6xC+qQtflU5U3Wz1JTDXOkRZw08r536ARZ5RUEh7XO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ngxGdBdrT4mFWFNO4TMhNpYMhXgq4DnNnoBgOn83U6pMnpkLwsEcqLfLTkxoIISal
	 nn6mA4Y3w2W6oJDgK0cLq0uorqJqqhqHB3Bq6ztWFhl0FLhtXZD8G0RHoNDp6RNMW+
	 W+Jdtvo2l//U0UeWQXKa0rUz0eCtCVlLnQBKSF8SEUiCOePf2deKq3ufqt0WE44D2p
	 YklgDpwx7YidSUdUOT4ae/6n0SIAgzydkZ6jxgIXoI4H99xThA80sXGEUls8tWZylR
	 r7fDuTa3vaMCusWjiuaTsEyna0Dy/ZAwR3nWUn3e5wx/vH/HNMgDS/H/cq5KHdVNVA
	 KHEixhvNo8WVw==
Date: Mon, 23 Nov 2026 13:57:08 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
	Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/25] drm/display: hdmi-state-helper: Reject connectors
 lacking HDMI funcs
Message-ID: <awQ37kPdVr3Rb4rL@houat>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-4-20e8a33a2286@collabora.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="qx5b66ufh54666op"
Content-Disposition: inline
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-4-20e8a33a2286@collabora.com>


--qx5b66ufh54666op
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 04/25] drm/display: hdmi-state-helper: Reject connectors
 lacking HDMI funcs
MIME-Version: 1.0

On Sat, Nov 14, 2026 at 08:03:28PM +0200, Cristian Ciocaltea wrote:
> drm_atomic_helper_connector_hdmi_check() must only be used with
> connectors set up via drmm_connector_hdmi_init(), which guarantees
> connector->hdmi.funcs is set.

I don't think that's true or mandated anywhere, and just like any other
helpers, we'll probably end up with a driver reusing parts of the states
but reimplementing part of the logic.

Maxime

> Other connectors used to fail gracefully: with max_bpc and
> supported_formats both zero, hdmi_compute_config() found no usable
> format/bpc combination and returned -EINVAL before
> hdmi_generate_infoframes() dereferenced hdmi.funcs.
>=20
> As those fields are being replaced by drm_connector_hdmi_funcs
> counterparts, hdmi_compute_config() would dereference hdmi.funcs right
> away.  To preserve the old behaviour, return an error early for such
> connectors, and use drm_WARN_ON_ONCE() to flag the driver bug.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index c50cedc7fa65..f533d5a7aab9 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -912,6 +912,9 @@ int drm_atomic_helper_connector_hdmi_check(struct drm=
_connector *connector,
>  	if (!new_conn_state->crtc || !new_conn_state->best_encoder)
>  		return 0;
> =20
> +	if (drm_WARN_ON_ONCE(connector->dev, !connector->hdmi.funcs))
> +		return -EINVAL;
> +
>  	ret =3D hdmi_compute_config(connector, new_conn_state, mode);
>  	if (ret)
>  		return ret;
>=20
> --=20
> 2.56.0
>=20

--qx5b66ufh54666op
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawQ4GwAKCRAnX84Zoj2+
ds//AX9CJWpjKGhBD4c7jTHw77WJ1wZ/VduARkhUAOHIQVa9DAZB7BaiCOnvwRfO
TQc1Ac8BgNThyMRnPLJUNHpMFi4IC9+OwVrnYKaJri9hWUEzyNcZfz4YJOn8nk1B
AFbDVP5UHg==
=78q1
-----END PGP SIGNATURE-----

--qx5b66ufh54666op--
