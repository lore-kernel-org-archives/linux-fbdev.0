Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C824535B7
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365812; cv=none; b=XHoRGmu41V+iYl/YMESO/xKkRMfhpOeTsQvAW3WA31v2/tt/UoAQMNWsX4UAobFpOCCYp18GH7EFsBW+djpKYqbqRU2KwG2vc9i/gr85o1PsLKP53F6kLeH4qBfN5wDVVFZ/GwTjR/c8Z1YhFao1iH9mqd0SujM9XT3wXQMnMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365812; c=relaxed/simple;
	bh=glrAd7XBqPELw6mAyBrQxWn5qdaq0KM0oKch/fQW2/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slGULlQpyBSM3Fj+A96mbfn4sceB/bgrOx9N9shItwl7D8PWOISXUAp97wFokuDP4ncdgeveyR+xHYxsWq4DB56kFS87rRmt9oNGmQ6OiubRwNvXEhLYh7rE2x+bQJFE3V+6W7mlvD0LBsxTSkW7WYQql+WfxnFb4y9uTVJDLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkWHD-0001HS-TG; Wed, 13 Mar 2024 22:36:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkWHC-006Bjl-Tv; Wed, 13 Mar 2024 22:36:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkWHC-005gLf-2i;
	Wed, 13 Mar 2024 22:36:42 +0100
Date: Wed, 13 Mar 2024 22:36:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	kernel@pengutronix.de, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] backlight: lp8788: Drop support for platform data
Message-ID: <7nvqboywxhviyuzkiesy4qfqybxx7vc5sw2seluc3dwnhk3q5h@hlzwxhnm2q6r>
References: <20240313124828.861731-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rrug4xskydudt2mq"
Content-Disposition: inline
In-Reply-To: <20240313124828.861731-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org


--rrug4xskydudt2mq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Mar 13, 2024 at 01:48:27PM +0100, Uwe Kleine-K=F6nig wrote:
> diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backligh=
t/lp8788_bl.c
> index 31f97230ee50..f3a89677c31c 100644
> --- a/drivers/video/backlight/lp8788_bl.c
> +++ b/drivers/video/backlight/lp8788_bl.c
> @@ -12,7 +12,6 @@
>  #include <linux/mfd/lp8788.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/pwm.h>
>  #include <linux/slab.h>
> =20
>  /* Register address */
> @@ -31,149 +30,41 @@
>  #define MAX_BRIGHTNESS			127
>  #define DEFAULT_BL_NAME			"lcd-backlight"
> =20
> -struct lp8788_bl_config {
> -	enum lp8788_bl_ctrl_mode bl_mode;
> -	enum lp8788_bl_dim_mode dim_mode;
> -	enum lp8788_bl_full_scale_current full_scale;
> -	enum lp8788_bl_ramp_step rise_time;
> -	enum lp8788_bl_ramp_step fall_time;
> -	enum pwm_polarity pwm_pol;
> -};
> -
>  struct lp8788_bl {
>  	struct lp8788 *lp;
>  	struct backlight_device *bl_dev;
> -	struct lp8788_backlight_platform_data *pdata;
> -	enum lp8788_bl_ctrl_mode mode;
>  	struct pwm_device *pwm;

Actually this pwm_device member should be dropped, too. I wonder why
this even passes a W=3D1 build without a warning ...

@Lee: Feel free to fix this up while applying, or tell me if you prefer
an incremental fixup or a complete v2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rrug4xskydudt2mq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXyHGkACgkQj4D7WH0S
/k4u0QgArwWZJ34iALZlyB21fTRNwZLFRkn8DH8i/rtsUENrdd5riGV7cah3K30s
4ctn1nCAv6m4RYIbvPuroR5DzCnzL3wKMzuD/ppwNtKIB9gAxUaJA5cBenfjBy0u
aMlLsKzZzE/UG/m3e3/FOqhn/Z9WZfCJX2mpCikA1w84EO1bYYO6VSTOjye+0gtN
w/9a7picJxEmSYYAG1zARRiQB8bFTQ6oUwjJQ+dkThAN8R5mX2nkDOVH6t0POQrI
iBqTzn9jhT560SNjYmv9TJRE8Xul7jr6zgOq9GwD6F8WvDY4/WNzU/qljrwoKCX8
icE/sHySbg0K2hUhVNRUzTXMBVLL1w==
=dgpE
-----END PGP SIGNATURE-----

--rrug4xskydudt2mq--
