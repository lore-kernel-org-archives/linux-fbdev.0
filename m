Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17453C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F99233EA
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 13:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLGNtI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:49:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:48188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgLGNtI (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 7 Dec 2020 08:49:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85EA6AC90;
        Mon,  7 Dec 2020 13:48:26 +0000 (UTC)
Subject: Re: [PATCH v3 07/13] video: fbdev: mmp: Fix kernel-doc warning for
 lcd_spi_write
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
 <20201206190247.1861316-8-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <60d3548a-833b-6247-f1f2-20f9b0fc0098@suse.de>
Date:   Mon, 7 Dec 2020 14:48:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201206190247.1861316-8-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="keDAahjnpMjF6lOwy0GHcGQHD76owIQba"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--keDAahjnpMjF6lOwy0GHcGQHD76owIQba
Content-Type: multipart/mixed; boundary="E6Czz1MS3FrkSrCKsvH3iR0CySa7tPFs1";
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
Message-ID: <60d3548a-833b-6247-f1f2-20f9b0fc0098@suse.de>
Subject: Re: [PATCH v3 07/13] video: fbdev: mmp: Fix kernel-doc warning for
 lcd_spi_write
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-8-sam@ravnborg.org>
In-Reply-To: <20201206190247.1861316-8-sam@ravnborg.org>

--E6Czz1MS3FrkSrCKsvH3iR0CySa7tPFs1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 06.12.20 um 20:02 schrieb Sam Ravnborg:
> Add missing parameter and drop parameter that is not present
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/mmp/hw/mmp_spi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/mmp/hw/mmp_spi.c b/drivers/video/fbdev=
/mmp/hw/mmp_spi.c
> index 1911a47769b6..16401eb95c6c 100644
> --- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
> +++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
> @@ -17,8 +17,8 @@
>  =20
>   /**
>    * spi_write - write command to the SPI port
> + * @spi:  the SPI device.
>    * @data: can be 8/16/32-bit, MSB justified data to write.
> - * @len:  data length.
>    *
>    * Wait bus transfer complete IRQ.
>    * The caller is expected to perform the necessary locking.
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--E6Czz1MS3FrkSrCKsvH3iR0CySa7tPFs1--

--keDAahjnpMjF6lOwy0GHcGQHD76owIQba
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/OMqcFAwAAAAAACgkQlh/E3EQov+Dr
KhAAut37TrgGrSl2E2r7ye2J6mVmlvjRdFRmgZEuxOUksxxVWHqCHv7hEs0uvzUqAYv3l8nwiuY6
FX2FiXsYGfySie4tzo92F9IivjN4k5oU54SHO9GwXDn8BuBxG/dQC7NTX99YF7dQQx/kPxsHA+Nz
dqMowEU5ImakEEXnB330xGlvT+KrSSVOX6EVjMboFtqGpGlgbgf+W+ypV8LX8Iv/Vkk7lLgAz+7G
w1SqvkAO/7TrC3F4qtJylfvoMxg9M+/k8yOWyRhrVSRWOFYPFvm7gx1hsZsxVma9yQzib0zEJPx8
lHFE9nEOrMJIxAqLBiina4/dLQlLdFVf+0p3tvbayCoGwUvpziE9tBLUSwkncdDCaiDAqex2MHro
gpUzOlU3w6NMMny26PxTGcAAXGugjXxnZLpXN5GDfg//6lIhRwIqcKjwro5K+dqTqf+QnNcvPJ0g
yux1SqFZpzPXhpKGJTZY29/UkM0CWykfKkosR8gdphXr9Clhkj9eRYjd9aklVQ/i9fxWXDesDHlT
B/FQ25AGoRblJ0eoVzG8NAhqKukZRPARV7im5wG4InxQD23o3gXgkKDxg6jg4957VOyFNnITOfNd
D0oxn5e9Zy+d8E9s1iK6UxTKVbb4RT45Ltsmu5yRlcCAsNgGjdI9hzw8/r5kkN6rvnnRKth0FS4O
zWM=
=AnqY
-----END PGP SIGNATURE-----

--keDAahjnpMjF6lOwy0GHcGQHD76owIQba--
