Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CE0C64E8A
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 08:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5372E2074A
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 08:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgK3Iwk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 03:52:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:35070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgK3Iwk (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 03:52:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6482CAC55;
        Mon, 30 Nov 2020 08:51:58 +0000 (UTC)
Subject: Re: [PATCH v2 04/28] video: fbdev: aty: Delete unused variable in
 radeon_monitor
To:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-5-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <bd320748-07b8-21fa-e700-1e909a75fae7@suse.de>
Date:   Mon, 30 Nov 2020 09:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201128224114.1033617-5-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E8UWEARDM6HKRI0Y34nYhs7OJMNkv2y9G"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E8UWEARDM6HKRI0Y34nYhs7OJMNkv2y9G
Content-Type: multipart/mixed; boundary="tR22UzywLGkBbCrLGNbCUw0R5cbSyRwBY";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Cc: Aditya Pakki <pakki001@umn.edu>,
 Alexander Klimov <grandmaster@al2klimov.de>,
 Alex Dewar <alex.dewar90@gmail.com>, Antonino Daplas <adaplas@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Evgeny Novikov <novikov@ispras.ru>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 George Kennedy <george.kennedy@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gustavo Silva <gustavoars@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 Jason Yan <yanaijie@huawei.com>, Jingoo Han <jingoohan1@gmail.com>,
 Jiri Slaby <jirislaby@kernel.org>, Joe Perches <joe@perches.com>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mike Rapoport <rppt@kernel.org>, Nathan Chancellor
 <natechancellor@gmail.com>, Peilin Ye <yepeilin.cs@gmail.com>,
 Peter Rosin <peda@axentia.se>, Qilong Zhang <zhangqilong3@huawei.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Winischhofer <thomas@winischhofer.net>,
 Vaibhav Gupta <vaibhavgupta40@gmail.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <bd320748-07b8-21fa-e700-1e909a75fae7@suse.de>
Subject: Re: [PATCH v2 04/28] video: fbdev: aty: Delete unused variable in
 radeon_monitor
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-5-sam@ravnborg.org>
In-Reply-To: <20201128224114.1033617-5-sam@ravnborg.org>

--tR22UzywLGkBbCrLGNbCUw0R5cbSyRwBY
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 28.11.20 um 23:40 schrieb Sam Ravnborg:
> Fix warning about variable that is asssigned a value but never used.
> The variable was indeed never used so delete it.
>=20
> Keep the call to radeon_probe_i2c_connector() as it may have
> side-effects. It is unlikely but I could not verify that is was safe to=

> drop the call.
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linux-fbdev@vger.kernel.org

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/aty/radeon_monitor.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/aty/radeon_monitor.c b/drivers/video/f=
bdev/aty/radeon_monitor.c
> index 9966c58aa26c..df55e23b7a5a 100644
> --- a/drivers/video/fbdev/aty/radeon_monitor.c
> +++ b/drivers/video/fbdev/aty/radeon_monitor.c
> @@ -488,12 +488,10 @@ void radeon_probe_screens(struct radeonfb_info *r=
info,
>   #if defined(DEBUG) && defined(CONFIG_FB_RADEON_I2C)
>   		{
>   			u8 *EDIDs[4] =3D { NULL, NULL, NULL, NULL };
> -			int mon_types[4] =3D {MT_NONE, MT_NONE, MT_NONE, MT_NONE};
>   			int i;
>  =20
>   			for (i =3D 0; i < 4; i++)
> -				mon_types[i] =3D radeon_probe_i2c_connector(rinfo,
> -									  i+1, &EDIDs[i]);
> +				radeon_probe_i2c_connector(rinfo, i + 1, &EDIDs[i]);
>   		}
>   #endif /* DEBUG */
>   		/*
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--tR22UzywLGkBbCrLGNbCUw0R5cbSyRwBY--

--E8UWEARDM6HKRI0Y34nYhs7OJMNkv2y9G
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/EsqkFAwAAAAAACgkQlh/E3EQov+Ci
aQ/+PDD2ItqHotyPeMPdMLOY+1KaRXwasH3WHlmEX9uJIQRq7sgtHcHU44fYq97DfTe4WK+VlWSf
x3XWM363J/QUBDImn77Gjc930WVvCBUWWUf+BDJhWg60vLaEbKC9C4BzKL81Bd14AXJIEHc1/Mpy
jvL2nEs6L1E+2FrLV+jw0U+m6FHRcSIqeOZ3E7Am0F/XrRaB72AifDnCpc2qjxwgHhiytOKCpRNg
BLvrboOjHBbCYfsanY1j+Z9afl9JDGYKmm1KM1Okq4+iH3+bTqThrErBf+x6g4mtv4TgLo/YZ8gx
QpCXmulYOfsQ4UHbSF+wa+Na1rLWTWpX8muY/7bTbgRG/n/siTHkyF1lqzJHwLXoj9HbpqMCkNu1
10qDbf52SHfDBwmagECqwJnwcIwSEyHY0Q+xGLk8PJoXh/CQhaAekg3B1wLbIl4S8Fe7YcRy+Lfr
rZnAzVvf3cH1yeSrYadyv9sTMWZjpOSJe2/OJNcNrJtUiwCleTDd9YfZadqSJGaC228S1b+xz7OX
2qu+eIzzsRmtjVDq1QpFJ1QPV3u93fFCOAoPri4n0FkyC1NXAsI+jkCUhcdIPo/EGY6EaKBppagb
vXIIkh4lo98v/h01gUHM+S4aWGosaFK/B7TIjBznPwf4BvwiwTaIa2lHBj7Sf6JbUk3V6ta+kO1m
ACY=
=kgZS
-----END PGP SIGNATURE-----

--E8UWEARDM6HKRI0Y34nYhs7OJMNkv2y9G--
