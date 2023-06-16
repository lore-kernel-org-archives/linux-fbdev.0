Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24994EB64D7
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Jun 2023 19:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFPTgx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Jun 2023 15:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbjFPTgv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Jun 2023 15:36:51 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20435A7;
        Fri, 16 Jun 2023 12:36:49 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4BB1C1C0AB3; Fri, 16 Jun 2023 21:36:48 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:36:47 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Helge Deller <deller@gmx.de>, javierm@redhat.com,
        tzimmermann@suse.de, zyytlz.wz@163.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 4.14 5/6] fbdev: imsttfb: Release framebuffer and
 dealloc cmap on error path
Message-ID: <ZIy5z07fFRazOshY@duo.ucw.cz>
References: <20230615114016.649846-1-sashal@kernel.org>
 <20230615114016.649846-5-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Jt24rwAEGiQvM7C/"
Content-Disposition: inline
In-Reply-To: <20230615114016.649846-5-sashal@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--Jt24rwAEGiQvM7C/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Helge Deller <deller@gmx.de>
>=20
> [ Upstream commit 5cf9a090a39c97f4506b7b53739d469b1c05a7e9 ]
>=20
> Add missing cleanups in error path.

If we insist this is important enough for -stable, it will need
tweaking. The function returns void, so we can't return a value.

Best regards,
								Pavel
							=09
> +++ b/drivers/video/fbdev/imsttfb.c
> @@ -1452,9 +1452,13 @@ static void init_imstt(struct fb_info *info)
>  	              FBINFO_HWACCEL_FILLRECT |
>  	              FBINFO_HWACCEL_YPAN;
> =20
> -	fb_alloc_cmap(&info->cmap, 0, 0);
> +	if (fb_alloc_cmap(&info->cmap, 0, 0)) {
> +		framebuffer_release(info);
> +		return -ENODEV;
> +	}
> =20
>  	if (register_framebuffer(info) < 0) {
> +		fb_dealloc_cmap(&info->cmap);
>  		framebuffer_release(info);
>  		return;
>  	}

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Jt24rwAEGiQvM7C/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy5zwAKCRAw5/Bqldv6
8meCAKCgkOAKsby1J3tn/AOi2M2+igh3pQCgmXSLqtqZflXALW7hzkAjZz5lTd0=
=/Q0f
-----END PGP SIGNATURE-----

--Jt24rwAEGiQvM7C/--
