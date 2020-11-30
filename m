Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C4BC64E8A
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 10:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065B020727
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 10:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgK3KOz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 05:14:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:55702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbgK3KOz (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 05:14:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E73EABD2;
        Mon, 30 Nov 2020 10:14:13 +0000 (UTC)
Subject: Re: [PATCH v2 10/28] video: fbdev: sis: Fix set but not used warnings
 in sis_main
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
 <20201128224114.1033617-11-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <13590d76-7002-c8e9-a4b8-678594019d3d@suse.de>
Date:   Mon, 30 Nov 2020 11:14:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201128224114.1033617-11-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EZFS9fifP3HAiz40HDUDdA0Rtgd9T5GRr"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EZFS9fifP3HAiz40HDUDdA0Rtgd9T5GRr
Content-Type: multipart/mixed; boundary="BT3JQ8UCn039qRBxkN0a7FncAoNCJkgYo";
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
Message-ID: <13590d76-7002-c8e9-a4b8-678594019d3d@suse.de>
Subject: Re: [PATCH v2 10/28] video: fbdev: sis: Fix set but not used warnings
 in sis_main
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-11-sam@ravnborg.org>
In-Reply-To: <20201128224114.1033617-11-sam@ravnborg.org>

--BT3JQ8UCn039qRBxkN0a7FncAoNCJkgYo
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 28.11.20 um 23:40 schrieb Sam Ravnborg:
> Fix warnings by dropping unused variable and the
> unused assignments.
>=20
> v2:
>    - Update subject (Lee)
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Thomas Winischhofer <thomas@winischhofer.net>
> Cc: Lee Jones <lee.jones@linaro.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/sis/sis_main.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/s=
is/sis_main.c
> index 03c736f6f3d0..266a5582f94d 100644
> --- a/drivers/video/fbdev/sis/sis_main.c
> +++ b/drivers/video/fbdev/sis/sis_main.c
> @@ -5029,7 +5029,6 @@ static void sisfb_post_xgi_ddr2(struct sis_video_=
info *ivideo, u8 regb)
>   	static const u8 cs168[8] =3D {
>   		0x48, 0x78, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00
>   	};
> -	u8 reg;
>   	u8 v1;
>   	u8 v2;
>   	u8 v3;
> @@ -5037,9 +5036,9 @@ static void sisfb_post_xgi_ddr2(struct sis_video_=
info *ivideo, u8 regb)
>   	SiS_SetReg(SISCR, 0xb0, 0x80); /* DDR2 dual frequency mode */
>   	SiS_SetReg(SISCR, 0x82, 0x77);
>   	SiS_SetReg(SISCR, 0x86, 0x00);
> -	reg =3D SiS_GetReg(SISCR, 0x86);
> +	SiS_GetReg(SISCR, 0x86);
>   	SiS_SetReg(SISCR, 0x86, 0x88);
> -	reg =3D SiS_GetReg(SISCR, 0x86);
> +	SiS_GetReg(SISCR, 0x86);
>   	v1 =3D cs168[regb]; v2 =3D cs160[regb]; v3 =3D cs158[regb];
>   	if (ivideo->haveXGIROM) {
>   		v1 =3D bios[regb + 0x168];
> @@ -5049,9 +5048,9 @@ static void sisfb_post_xgi_ddr2(struct sis_video_=
info *ivideo, u8 regb)
>   	SiS_SetReg(SISCR, 0x86, v1);
>   	SiS_SetReg(SISCR, 0x82, 0x77);
>   	SiS_SetReg(SISCR, 0x85, 0x00);
> -	reg =3D SiS_GetReg(SISCR, 0x85);
> +	SiS_GetReg(SISCR, 0x85);
>   	SiS_SetReg(SISCR, 0x85, 0x88);
> -	reg =3D SiS_GetReg(SISCR, 0x85);
> +	SiS_GetReg(SISCR, 0x85);
>   	SiS_SetReg(SISCR, 0x85, v2);
>   	SiS_SetReg(SISCR, 0x82, v3);
>   	SiS_SetReg(SISCR, 0x98, 0x01);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--BT3JQ8UCn039qRBxkN0a7FncAoNCJkgYo--

--EZFS9fifP3HAiz40HDUDdA0Rtgd9T5GRr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/ExfAFAwAAAAAACgkQlh/E3EQov+B+
2g/9Hrmlf7JHIJJjemAogj51K3DCkPZ87NVJK2YLdmnT7qxUc1zQ92GpQpmrc+aaD8MofvFIyJW7
DhR6Elu9LmE98SYJtfwErHgCV4W0wkKhr3f8j12ch7ctDXsRN+Vxj6x2rUQja+gCHvEWdwe8Z0qT
EEOVi1V97EYl7h430QXdR+Yqkd1uTnXxQuXBCncmZ3piOC7SBnbEM4qH3mi20QwQ4YkWBshNpTcn
8oV1cSN1Rmt8yJLE/OncbwRduOhMk5k64Iv2Wc6THQ0y9AF0sh1x/JwtqTt/lqi8NID+IZcT5TEZ
/tMRTf+MQhFoXlhLKuh2Set+DgCls1WYmmsA6ARgDnQeZx+x6+0ThQ4mdtgRjjFQeQ+Dos7C3EFW
Ja4qe4gxBdzUcPDwHQaThm7zzulewy8w31jDfe/YLE5brbzChQcMMjwJZTlHyrEgrEB48vA4xbyv
TqXR7KfRkrxmZU6FxpJlhbHmHmLH6ofj8Gm01oeOLDMdo1q5lAmy/0CmCNw4Yk1pYMugjKBfJ1KF
16VYDO+hRhkDjfCGo5rzt7U4k9cJUrRfavtRa9V4tbz8B8oQMO7OJWOR5Gp2RPnIFEcCJNKBK3qd
hDxdwzO7uF300dOuCF7VbxNqt1+D12hEZl18hFdzlzwSexEtPMERuOj3g/7O+dxMKB7kTs9KK7Rh
5i4=
=Io81
-----END PGP SIGNATURE-----

--EZFS9fifP3HAiz40HDUDdA0Rtgd9T5GRr--
