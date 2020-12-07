Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52B2C4361B
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 13:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BF4233ED
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 13:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgLGNug (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:50:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:50358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgLGNug (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 7 Dec 2020 08:50:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0E90AB63;
        Mon,  7 Dec 2020 13:49:54 +0000 (UTC)
Subject: Re: [PATCH v3 09/13] video: fbdev: goldfishfb: Fix defined but not
 used warning
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
 <20201206190247.1861316-10-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <1cce2b10-3741-36d7-d443-a21af185944f@suse.de>
Date:   Mon, 7 Dec 2020 14:49:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201206190247.1861316-10-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NhsiOswEOgUVDV7VcJczMKHtcwYClE9XL"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NhsiOswEOgUVDV7VcJczMKHtcwYClE9XL
Content-Type: multipart/mixed; boundary="quZktaO0eywkk6bgeXdOD8UUeW5tgFIGA";
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
Message-ID: <1cce2b10-3741-36d7-d443-a21af185944f@suse.de>
Subject: Re: [PATCH v3 09/13] video: fbdev: goldfishfb: Fix defined but not
 used warning
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-10-sam@ravnborg.org>
In-Reply-To: <20201206190247.1861316-10-sam@ravnborg.org>

--quZktaO0eywkk6bgeXdOD8UUeW5tgFIGA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 06.12.20 um 20:02 schrieb Sam Ravnborg:
> The goldfish_fb_acpi_match table is only used with ACPI enabled.
> Ifdef it out unless it is needed.
> This is a similar fix to what other acpi drivers do.
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/goldfishfb.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/gol=
dfishfb.c
> index 9c83ec3f8e1f..2b885cd046fe 100644
> --- a/drivers/video/fbdev/goldfishfb.c
> +++ b/drivers/video/fbdev/goldfishfb.c
> @@ -305,11 +305,13 @@ static const struct of_device_id goldfish_fb_of_m=
atch[] =3D {
>   };
>   MODULE_DEVICE_TABLE(of, goldfish_fb_of_match);
>  =20
> +#ifdef CONFIG_ACPI
>   static const struct acpi_device_id goldfish_fb_acpi_match[] =3D {
>   	{ "GFSH0004", 0 },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(acpi, goldfish_fb_acpi_match);
> +#endif
>  =20
>   static struct platform_driver goldfish_fb_driver =3D {
>   	.probe		=3D goldfish_fb_probe,
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--quZktaO0eywkk6bgeXdOD8UUeW5tgFIGA--

--NhsiOswEOgUVDV7VcJczMKHtcwYClE9XL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/OMwAFAwAAAAAACgkQlh/E3EQov+DP
wBAAh8D02f4DJXA7/czxIQcAnAnvi9BjHdcCZYvPALnoUu0IUdIMOBTho6rKEh5/y2Ef2urcBpb2
xyq7TF1Y7QGM1QRPpHahTj8kEc+OkaKjsTAu+VkbGuP+Wom+xLpKxoxhPN1aADnW6VCyrbaaB9gq
farAB5fTib2poSNedtbfkIiaKAESkMvzHGZR60SqpdCqpbTM9P6vgw0odo7mNouGp0B3vvNn+9O0
OOKImlxDmj3o+tfjO5PQdmh9oSKKW4ZtmnyczK5unuDe+aakchzs/RgMRW/MG2illrmB+6JbKKE5
pi0gfgLw2E8f2xWSp56W9KzzL6lk2yt60f/JSgnJG0kTvSM+Hgq4G+48sX6OyzcclWdlTKfnNvD3
CIH3P9aZ4PJQNO+urzwVwbEqWHZQ9lWbt444F3pIJV/BF7LKSE1TBWThgDMtt0Xq0rLzTEQ3APpI
+EGDry4t2gtxf/v5l3GJqS7UcYbKiFayeHTpzi6UQzhP2KKfOR5iZ6S46ISg8/WJGIorCqHzBACa
uQCUBDGKTjDJdFZjlM6vIvQfr0b5RWZM3mG0gyT1h8cZ6XF5Vx64OPZpEn0vMIBomqsH3MqQFMV0
UOCvT8/XhT10NbqPaxs9kRJFxUYatIC1pAtiS0ZaknvSg/X1PI5cHxP5J8rIFK3/w6pGKtZ03k25
VXU=
=e2Vw
-----END PGP SIGNATURE-----

--NhsiOswEOgUVDV7VcJczMKHtcwYClE9XL--
