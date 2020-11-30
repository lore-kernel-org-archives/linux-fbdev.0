Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D2C64E7B
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 14:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD8E20656
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 14:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgK3O0d (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:26:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgK3O0d (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 09:26:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E7C5AD43;
        Mon, 30 Nov 2020 14:25:51 +0000 (UTC)
Subject: Re: [PATCH v2 19/28] video: fbdev: sstfb: Updated logging to fix set
 but not used warnings
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
 <20201128224114.1033617-20-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <ebdbca1d-6d09-2ec3-c9ba-e54fcb4d486e@suse.de>
Date:   Mon, 30 Nov 2020 15:25:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201128224114.1033617-20-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oKVEZsQ4Gl1QO64DcmU7A6quOhonPA1yU"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oKVEZsQ4Gl1QO64DcmU7A6quOhonPA1yU
Content-Type: multipart/mixed; boundary="6GlW8RECNrgYltyKYJL7sik5kPo4Y6MLP";
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
Message-ID: <ebdbca1d-6d09-2ec3-c9ba-e54fcb4d486e@suse.de>
Subject: Re: [PATCH v2 19/28] video: fbdev: sstfb: Updated logging to fix set
 but not used warnings
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-20-sam@ravnborg.org>
In-Reply-To: <20201128224114.1033617-20-sam@ravnborg.org>

--6GlW8RECNrgYltyKYJL7sik5kPo4Y6MLP
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 28.11.20 um 23:41 schrieb Sam Ravnborg:
> Fix set but not used warnings by introducing no_printk variants
> for the internal logging system for this driver.
>=20
> Fix a new warning that popped up now that logging was checked for
> correct printf format strings.
>=20
> A more invasive fix had been to replace all the internal logging with
> standard logging primitives - thats for another day.
>=20
> v2:
>    - Update subject (Lee)
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Alex Dewar <alex.dewar90@gmail.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Lee Jones <lee.jones@linaro.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/sstfb.c | 2 +-
>   include/video/sstfb.h       | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
> index c05cdabeb11c..27d4b0ace2d6 100644
> --- a/drivers/video/fbdev/sstfb.c
> +++ b/drivers/video/fbdev/sstfb.c
> @@ -1390,7 +1390,7 @@ static int sstfb_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>   	        fix->smem_start, info->screen_base,
>   	        fix->smem_len >> 20);
>  =20
> -	f_ddprintk("regbase_virt: %#lx\n", par->mmio_vbase);
> +	f_ddprintk("regbase_virt: %p\n", par->mmio_vbase);
>   	f_ddprintk("membase_phys: %#lx\n", fix->smem_start);
>   	f_ddprintk("fbbase_virt: %p\n", info->screen_base);
>  =20
> diff --git a/include/video/sstfb.h b/include/video/sstfb.h
> index 28384f354773..d4a5e41d1173 100644
> --- a/include/video/sstfb.h
> +++ b/include/video/sstfb.h
> @@ -23,7 +23,7 @@
>   #  define SST_DEBUG_FUNC 1
>   #  define SST_DEBUG_VAR  1
>   #else
> -#  define dprintk(X...)
> +#  define dprintk(X...)		no_printk(X)
>   #  define SST_DEBUG_REG  0
>   #  define SST_DEBUG_FUNC 0
>   #  define SST_DEBUG_VAR  0
> @@ -48,7 +48,7 @@
>   #if (SST_DEBUG_FUNC > 1)
>   #  define f_ddprintk(X...)	dprintk(" " X)
>   #else
> -#  define f_ddprintk(X...)
> +#  define f_ddprintk(X...)	no_printk(X)
>   #endif
>   #if (SST_DEBUG_FUNC > 2)
>   #  define f_dddprintk(X...)	dprintk(" " X)
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--6GlW8RECNrgYltyKYJL7sik5kPo4Y6MLP--

--oKVEZsQ4Gl1QO64DcmU7A6quOhonPA1yU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/FAOwFAwAAAAAACgkQlh/E3EQov+Ay
vg//aNDZXepK3P18TsWlcA6nJvsIP31yia5U1XM6hjj+31jZOHUiZRAScme7wJnnxLIzJuxDwiBW
rgnv7+hcgCOGMiTH+o+8wGIbLaGFvAl17Zay7O5IwrXRxOuOgFL9mri7zZZyLbixt3JP/haJjJf0
itIYeXmIVxQUe5htYgvjJhXDqbJ4dhYKKEeWKhCsztHKqFv7QHWwncSjUZEtgCjJUVtgRKONBdA3
QM1AbWUn048esaSdTiqA2EvkN69aOhObqbY1Hpn2LhQNKTCMJV9ZlWOaaDtvre68VQ1NJQVdig+N
nJ20YES1jF1mXcKn0cQvVgpZWMNbXPQsZFvPnMr/MVmg31zaSfWajfx+p5ReIlO7Drp0iErpBS/C
gxRJsRqedVRwAzQKvkBmoWgHId7GncwfPZ3mydl4imwF76dKnUR6hAnzwysKApu99sHsmkWoy2FK
EnudL6lm9eFwJgEX8K4GQmqHMhzlqxRdW+JNAyn7mrSp5MpvbNAOckmMMP74NQqSxKhNtT2T/WIN
zdmkE2RlNCfKrtkeQq9VCMonYYZnXUFsg8TnVUhS7hrwxjvjIwV/9kanHR5mo/vYWF21CPUDOMD8
NQBzZBDo4nssBi0l3tlJOl7Kf5ykD1Bqz3pNZyLY6pDop7J076X5Vr9RUNFaU8jpKMnz1ggGeL3c
h0U=
=uuZz
-----END PGP SIGNATURE-----

--oKVEZsQ4Gl1QO64DcmU7A6quOhonPA1yU--
