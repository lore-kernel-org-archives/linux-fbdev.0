Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28792C64E8A
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 12:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B9C206D8
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 12:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgK3MJH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 07:09:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:54854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgK3MJH (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 07:09:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA18DAB63;
        Mon, 30 Nov 2020 12:08:25 +0000 (UTC)
Subject: Re: [PATCH v2 11/28] video: fbdev: via: Fix set but not used warning
 for mode_crt_table
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
 <20201128224114.1033617-12-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <889feec2-fcd6-78cf-22fc-643f0a6f7c73@suse.de>
Date:   Mon, 30 Nov 2020 13:08:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201128224114.1033617-12-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CkBtuEZtfPCsJ55UCDtzKO199agjEU19i"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CkBtuEZtfPCsJ55UCDtzKO199agjEU19i
Content-Type: multipart/mixed; boundary="VCeIt9cDmcMB9swCoRU7mGZOkMHdPzlhC";
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
Message-ID: <889feec2-fcd6-78cf-22fc-643f0a6f7c73@suse.de>
Subject: Re: [PATCH v2 11/28] video: fbdev: via: Fix set but not used warning
 for mode_crt_table
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-12-sam@ravnborg.org>
In-Reply-To: <20201128224114.1033617-12-sam@ravnborg.org>

--VCeIt9cDmcMB9swCoRU7mGZOkMHdPzlhC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 28.11.20 um 23:40 schrieb Sam Ravnborg:
> Fix warning by deleting the variable. The function call
> viafb_get_best_mode() were verified to have no side-effects,

s/were/was

> and thus could be dropped too.
>=20
> v2:
>    - Update subject (Lee)
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Lee Jones <lee.jones@linaro.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/via/lcd.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/via/lcd.c b/drivers/video/fbdev/via/lc=
d.c
> index 4a869402d120..088b962076b5 100644
> --- a/drivers/video/fbdev/via/lcd.c
> +++ b/drivers/video/fbdev/via/lcd.c
> @@ -537,11 +537,9 @@ void viafb_lcd_set_mode(const struct fb_var_screen=
info *var, u16 cxres,
>   	u32 clock;
>   	struct via_display_timing timing;
>   	struct fb_var_screeninfo panel_var;
> -	const struct fb_videomode *mode_crt_table, *panel_crt_table;
> +	const struct fb_videomode *panel_crt_table;
>  =20
>   	DEBUG_MSG(KERN_INFO "viafb_lcd_set_mode!!\n");
> -	/* Get mode table */
> -	mode_crt_table =3D viafb_get_best_mode(set_hres, set_vres, 60);
>   	/* Get panel table Pointer */
>   	panel_crt_table =3D viafb_get_best_mode(panel_hres, panel_vres, 60);=

>   	viafb_fill_var_timing_info(&panel_var, panel_crt_table);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--VCeIt9cDmcMB9swCoRU7mGZOkMHdPzlhC--

--CkBtuEZtfPCsJ55UCDtzKO199agjEU19i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/E4LUFAwAAAAAACgkQlh/E3EQov+Br
LxAAqh8UCoiL1BmRgSwnDUY6vY8Ze/g1gV+xqAgtJK/h9byd50RIFwv4UCX22L7BpZY8dhVHylCB
xn6iD+6poDaj2S8+XjlLIU7Dd8CVJXDLh/1LAgPQ3VR1Sy7cQyPEf00QDeSA8rAeidJmCoV3Bz+0
B4Rx8tvhjrtp+PlQlelPcowXw3BZWOFjIMm8GdjcpfYsuQg4hsxkZxjfLp+gHSuPFHz75ciKpw3J
UKBkhyQmQMGNCer+1jQx9jV2kGAdldKORa+8pBSvcQSxW6egnb6cY1pUs43rgevSd+ILB0jUbBHy
wWNi09B4Gze1fZu226RGuitwVkoi61X3UY+CmDFelzj3N3VwdF1wsmQ1zi6qPdTKSJFrTqtn5J6k
Hmp7p6rbAvrUnwDJQI2ZC5Esf+fxWqCH0iR/CdexjZshlZRCjdk+dgcdSm1pJ1pkEdbWY/e5onnL
b6GuirCMNTqRtlzSS+WO2gSAy3qVvxHvnbStSDpcKXsZ0TwKQk48U0MxmPL7ZiL6aVqWjvT+6oKT
g7coYeEBk+4/WP7hlE3J4Px6VMXw8IkhUPnZLldpd9i592dr+sdniSpBhA+miQUFZm+wDAiYQ1gg
5Emi3SF66vzAU7+KuPnXFlha+Yc6a3aZC+QEvp1nzWGp1q32+4RI7ijCYZYwqsjMAdh3Q3zY76zh
EXM=
=fymq
-----END PGP SIGNATURE-----

--CkBtuEZtfPCsJ55UCDtzKO199agjEU19i--
