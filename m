Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055EBC63777
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 09:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AD22074A
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 09:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgK3JNv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 04:13:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:40818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgK3JNu (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 04:13:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F329AD89;
        Mon, 30 Nov 2020 09:13:08 +0000 (UTC)
Subject: Re: [PATCH v2 08/28] video: fbdev: sis: Fix defined but not used
 warning of SiS_TVDelay
To:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        George Kennedy <george.kennedy@oracle.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-9-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <2b2809ab-a9ab-cf6d-248d-828ca584bdee@suse.de>
Date:   Mon, 30 Nov 2020 10:13:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201128224114.1033617-9-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p8bfYqIBnPG8eyTYnGJQcuVf04r3Z35CF"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p8bfYqIBnPG8eyTYnGJQcuVf04r3Z35CF
Content-Type: multipart/mixed; boundary="JO7obVMGflrwGfzxp3HQvgsxvJhHjbm3X";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Evgeny Novikov <novikov@ispras.ru>,
 Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Thomas Winischhofer <thomas@winischhofer.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Jani Nikula <jani.nikula@intel.com>, Aditya Pakki <pakki001@umn.edu>,
 Xiaofei Tan <tanxiaofei@huawei.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Alex Dewar <alex.dewar90@gmail.com>, Jason Yan <yanaijie@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Qilong Zhang <zhangqilong3@huawei.com>, Randy Dunlap
 <rdunlap@infradead.org>, Gustavo Silva <gustavoars@kernel.org>,
 Peter Rosin <peda@axentia.se>, George Kennedy <george.kennedy@oracle.com>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Alexander Klimov <grandmaster@al2klimov.de>,
 Jingoo Han <jingoohan1@gmail.com>, Joe Perches <joe@perches.com>,
 Peilin Ye <yepeilin.cs@gmail.com>, Mike Rapoport <rppt@kernel.org>
Message-ID: <2b2809ab-a9ab-cf6d-248d-828ca584bdee@suse.de>
Subject: Re: [PATCH v2 08/28] video: fbdev: sis: Fix defined but not used
 warning of SiS_TVDelay
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-9-sam@ravnborg.org>
In-Reply-To: <20201128224114.1033617-9-sam@ravnborg.org>

--JO7obVMGflrwGfzxp3HQvgsxvJhHjbm3X
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 28.11.20 um 23:40 schrieb Sam Ravnborg:
> Fix W=3D1 warning by commenting unused SiS_TVDelay* variables.
>=20
> The SiS_TVDelay* variables seem to contain some magic numbers
> so looks like data worth keeping around but not as code we build.

I would remove it. sisfb is broken beyond repair and no one's going to=20
try to use it anyway. In any case

Acked-by: Thomas Zimemrmann <tzimmermann@suse.de>

>=20
> v2:
>    - Update subject (Lee)
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Thomas Winischhofer <thomas@winischhofer.net>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/video/fbdev/sis/oem310.h | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/sis/oem310.h b/drivers/video/fbdev/sis=
/oem310.h
> index 8fce56e4482c..ed28755715ce 100644
> --- a/drivers/video/fbdev/sis/oem310.h
> +++ b/drivers/video/fbdev/sis/oem310.h
> @@ -200,6 +200,7 @@ static const unsigned char SiS310_TVDelayCompensati=
on_651302LV[] =3D	/* M650, 651,
>   	0x33,0x33
>   };
>  =20
> +#if 0 /* Not used */
>   static const unsigned char SiS_TVDelay661_301[] =3D			/* 661, 301 */
>   {
>   	0x44,0x44,
> @@ -219,6 +220,7 @@ static const unsigned char SiS_TVDelay661_301B[] =3D=
			/* 661, 301B et al */
>   	0x44,0x44,
>   	0x44,0x44
>   };
> +#endif
>  =20
>   static const unsigned char SiS310_TVDelayCompensation_LVDS[] =3D		/* =
LVDS */
>   {
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--JO7obVMGflrwGfzxp3HQvgsxvJhHjbm3X--

--p8bfYqIBnPG8eyTYnGJQcuVf04r3Z35CF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/Et6EFAwAAAAAACgkQlh/E3EQov+CC
BQ/+McYEQMk7L3ovNuVUeW+tDTYFyjPOeJXGjT27f1X2kf3YadEZ+n/72CvS5F50/99JWY9n+xbe
ODBQY5VeIOL4b0WQaBllTAfwUJOhmg33SZ0Ff0ONtqDCkLv8MFo8dOBqTFEoLrNZ/lhYafswbKr4
5n0q8CsAUhawNYJiNz0hoqIkFxuI9e+AGXGCWQ3VALa2ZpFUiBC8udSVKAOx/kQxbsfDmrAMqLVq
vdI7gJir6bVV+K9VY+LA5Ls83zZA+IYFb+NeyXb5MqobW3FbmGau4r2OWnTlhsBsD2upuEB3G6ZX
i52zWjDFWEXCFGptuY5ImM5VwaRVoBZ7yDWu+oEmwcllj8FF1e0nnPtGj6/EKFMaelXC6mj6u/CH
75n4svxYb1Q/vMwRWXfTQDYgiif5rtQ6doi4xKleiGdfsZ/mDLiAdY9cAB36omRlKYHcHELwU5Su
PD1b/FZH8jnjRzDVz3YDgmnm8E3jEIZPTgVhSDVrL9a2Jiitj2pPa7TTHIqC3C22mecNrlf2+3Fh
eLwQMYbgjVf/ikeXoH7kd2tOoTzoD6lx754fdi7rV1cB2W2NvoYBEo8OhShVvc5hqjkyQ/it6w2W
N6gdJBVo9hC5V185tRNkGPhyHXS3FAkwI0UBQ2o3cNg9YMVGgTZ+W4hIexkLCcvk4m/ZD08QwZjL
t2Y=
=oB0P
-----END PGP SIGNATURE-----

--p8bfYqIBnPG8eyTYnGJQcuVf04r3Z35CF--
