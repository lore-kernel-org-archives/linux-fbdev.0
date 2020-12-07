Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBFBC433FE
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DECD3229C6
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 08:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLGIUk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Dec 2020 03:20:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:43946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgLGIUk (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 7 Dec 2020 03:20:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B056AD4A;
        Mon,  7 Dec 2020 08:19:58 +0000 (UTC)
Subject: Re: [PATCH v3 05/13] sh: Fix set but not used warnings with
 !CONFIG_MMU
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
 <20201206190247.1861316-6-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <5898de38-a8bb-0b12-e6c1-f7d8a4ea1e5e@suse.de>
Date:   Mon, 7 Dec 2020 09:19:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201206190247.1861316-6-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9H5BNjCuIFTY6tpt2sPpHzia3K44WDeKS"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9H5BNjCuIFTY6tpt2sPpHzia3K44WDeKS
Content-Type: multipart/mixed; boundary="3DPXPP4aUZ153U97gC1JfOk2hhT42kcYe";
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
Message-ID: <5898de38-a8bb-0b12-e6c1-f7d8a4ea1e5e@suse.de>
Subject: Re: [PATCH v3 05/13] sh: Fix set but not used warnings with
 !CONFIG_MMU
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-6-sam@ravnborg.org>
In-Reply-To: <20201206190247.1861316-6-sam@ravnborg.org>

--3DPXPP4aUZ153U97gC1JfOk2hhT42kcYe
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 06.12.20 um 20:02 schrieb Sam Ravnborg:
> Building fbdev drivers for sh with W=3D1 produces the following warning=
:
>=20
>      tmiofb.c: In function =E2=80=98tmiofb_remove=E2=80=99:
>      tmiofb.c:805:21: warning: variable =E2=80=98par=E2=80=99 set but n=
ot used
>=20
> This is with allmodconfig and ARCH=3Dsh
>=20
> This boiled down to iounmap() defined as empty for !CONFIG_MMU.
> Fix this by by adding "(void)addr;" to tell the compiler the
> argument to iounmap() should be considered used.
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   arch/sh/include/asm/io.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index 6d5c6463bc07..5ad56c6c1e1e 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -271,7 +271,7 @@ static inline void __iomem *ioremap_prot(phys_addr_=
t offset, unsigned long size,
>   #endif /* CONFIG_HAVE_IOREMAP_PROT */
>  =20
>   #else /* CONFIG_MMU */
> -#define iounmap(addr)		do { } while (0)
> +#define iounmap(addr)		do { (void)addr; } while (0)
>   #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset=
))
>   #endif /* CONFIG_MMU */
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--3DPXPP4aUZ153U97gC1JfOk2hhT42kcYe--

--9H5BNjCuIFTY6tpt2sPpHzia3K44WDeKS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/N5awFAwAAAAAACgkQlh/E3EQov+DI
RA/+IavdE6N8ameVFFX/mBxJNTowUTEAj8v4gU/giooB4tylvVZPOJh2Ce/nt1RDbyZ6qn8Jo4xE
uGJy6aaHJypvWaNWick3UW2LqFKlZ+65U9dYYes+9EmJZGkcR1ikG7cP03gIB8YTZAi0yYWFu63L
apVxhrmWyijTT7KN58DD5roklRlwcM667zxhWa5wa7sbkMnwEruiIlc4zlCpJqKAHfnanrqtSgv9
u/qEdxG8cQG6QBAALE2MJaTg8HL0C2YqKBh/pB7SaLM2PybvUxKwcuXx6aUqfxc/1ruOfMV7HxFU
sTPYzq6eCBX91pqmMZEEZ2oIK0ni1rOnpNOS9ffhazygcP3Aa3Umt3QpGk+9DF2W49bGh+55KPi5
+kHGG0Vx29QmrvU+8OX6wXBIrZe8DiZZYf9EIMyPxWDFoetUZ+q3ZPv7czqrkL4jkae/XqF6pIKa
r3KZE8bFs8/iBt34Xb8IViL0u7H9iEjrqGDN8cAdq+L+Ejeiv+V72WXdGVTcHTD3RnrD6nNxMmHT
6yt1yD8sfezLtmOd9QZZDK8/LgdQiVTXKvegGWX9YKHN/kxULYwzkRAtFUwaZlQ4Bu6iti4FzFqE
raYml9RuRug/OElQ5239tSiqA/utwM/YMTijunN19CoKtA60/immYEsl/5Lqxm81iIZxTrsuQzVD
ekc=
=bHRQ
-----END PGP SIGNATURE-----

--9H5BNjCuIFTY6tpt2sPpHzia3K44WDeKS--
