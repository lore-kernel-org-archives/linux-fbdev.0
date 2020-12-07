Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D1C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 13:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75FF233ED
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 13:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLGNtq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:49:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:49296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGNtq (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 7 Dec 2020 08:49:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 055F9AB63;
        Mon,  7 Dec 2020 13:49:05 +0000 (UTC)
Subject: Re: [PATCH v3 08/13] video: fbdev: wmt_ge_rops: Fix function not
 declared warnings
To:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Cc:     Alexander Klimov <grandmaster@al2klimov.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gustavo A R Silva <gustavoars@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Tony Prisk <linux@prisktech.co.nz>
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-9-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <a04863b5-2e4d-d2c7-c214-64082680d93c@suse.de>
Date:   Mon, 7 Dec 2020 14:49:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201206190247.1861316-9-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="njtWkoaK6xo8QOxYEMefHs1zyGHvXMxBB"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--njtWkoaK6xo8QOxYEMefHs1zyGHvXMxBB
Content-Type: multipart/mixed; boundary="Fjnjez7WFVtaCBnoS8cqNKoJBJRvXCpZv";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Cc: Alexander Klimov <grandmaster@al2klimov.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Colin Ian King <colin.king@canonical.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Douglas Anderson <dianders@chromium.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Gustavo A R Silva <gustavoars@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-arm-kernel@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Rapoport <rppt@kernel.org>, Peter Jones <pjones@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Qilong Zhang
 <zhangqilong3@huawei.com>, Randy Dunlap <rdunlap@infradead.org>,
 Rich Felker <dalias@libc.org>, Thierry Reding <thierry.reding@gmail.com>,
 Thomas Winischhofer <thomas@winischhofer.net>,
 Tony Prisk <linux@prisktech.co.nz>
Message-ID: <a04863b5-2e4d-d2c7-c214-64082680d93c@suse.de>
Subject: Re: [PATCH v3 08/13] video: fbdev: wmt_ge_rops: Fix function not
 declared warnings
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-9-sam@ravnborg.org>
In-Reply-To: <20201206190247.1861316-9-sam@ravnborg.org>

--Fjnjez7WFVtaCBnoS8cqNKoJBJRvXCpZv
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 06.12.20 um 20:02 schrieb Sam Ravnborg:
> Include own header to fix "function not declared" warnings.
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/wmt_ge_rops.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/wmt_ge_rops.c b/drivers/video/fbdev/wm=
t_ge_rops.c
> index 2445cfe617a9..42255d27a1db 100644
> --- a/drivers/video/fbdev/wmt_ge_rops.c
> +++ b/drivers/video/fbdev/wmt_ge_rops.c
> @@ -11,6 +11,7 @@
>   #include <linux/fb.h>
>   #include <linux/platform_device.h>
>   #include "core/fb_draw.h"
> +#include "wmt_ge_rops.h"
>  =20
>   #define GE_COMMAND_OFF		0x00
>   #define GE_DEPTH_OFF		0x04
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--Fjnjez7WFVtaCBnoS8cqNKoJBJRvXCpZv--

--njtWkoaK6xo8QOxYEMefHs1zyGHvXMxBB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/OMs8FAwAAAAAACgkQlh/E3EQov+Bu
JQ/+MOGFCxxt70wxW1rnQQ94jDjuavr21Qcrf6l5cP3kkEFH3GkPe1N+3bAUrcyuHGOfMXW0sqA9
qXElqrqdOQ+JTX7WLecQL1bMcsYxWqr4UE/crW3xs6B8G6/NXuLU2yfJLsK920pc5/LVMbGyaqcu
eOsQg88TRGTrb05WecvM24mR7sIwCq2Hv2O1OczJQqzHReU0MphhwkQuG1g2JieGdUZ976cFgTM8
nBIsgRpGKyyIG1TStuQKQQckJwIaksTFuIStHHAPcwWw0/G0jyL8DEpMms9mMcF1h3GuvhXssjaj
IK7zVbOx0Skf6As5FrI83LM+DAgkGfeh18Wc00+kIDtEytukCmEPksGtV76/SoEJCh4CaK2yGsJ+
Eh+YMaOcqoN3xIHTaEoHy6h8FXP+XE+R8GWROOc6fOIATEuVxwsupBIQ0q0VE0n5os+uOa/p6Cg7
1PUeEHQMRm7Bw/InQTCb2ZnBg53jY1Ow+UwFuA/jyPprQg++sUFppyVc77z4tFnLzp3KW/KjijgS
GWwNRrkyvwWNAqJkdwVLQ13efOpI2wzta9LfD3mwvzLUrbszRu6Rr6WhSP+WVpGwr8RQPLMyHBtH
8slIw4a4qSeM9VN53etEno/1eBOzq5F1bCj9BTrC7QLYMNg6h01Xg4TRB5eX9n5uNcriRivBeIhW
upk=
=E9hV
-----END PGP SIGNATURE-----

--njtWkoaK6xo8QOxYEMefHs1zyGHvXMxBB--
