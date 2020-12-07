Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E920C4361B
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53DC8235E4
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 13:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgLGNyQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:54:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:53472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgLGNyQ (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 7 Dec 2020 08:54:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4635AC90;
        Mon,  7 Dec 2020 13:53:34 +0000 (UTC)
Subject: Re: [PATCH v3 13/13] video: fbdev: sis: Drop useless call to
 SiS_GetResInfo()
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
 <20201206190247.1861316-14-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <dc166b09-c745-d96c-f2da-b9725e53068a@suse.de>
Date:   Mon, 7 Dec 2020 14:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201206190247.1861316-14-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QnWIEOjQHJ8rq0ZZJUO0HtQm0NBqdd2M1"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QnWIEOjQHJ8rq0ZZJUO0HtQm0NBqdd2M1
Content-Type: multipart/mixed; boundary="gg1w0HXXa8TuALerNcm3xdZmZ4ZlD0MbD";
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
Message-ID: <dc166b09-c745-d96c-f2da-b9725e53068a@suse.de>
Subject: Re: [PATCH v3 13/13] video: fbdev: sis: Drop useless call to
 SiS_GetResInfo()
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-14-sam@ravnborg.org>
In-Reply-To: <20201206190247.1861316-14-sam@ravnborg.org>

--gg1w0HXXa8TuALerNcm3xdZmZ4ZlD0MbD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 06.12.20 um 20:02 schrieb Sam Ravnborg:
> Coverity reported:
>=20
>      Useless call (USELESS_CALL) side_effect_free: Calling
>       SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex) is only useful for it=
s
>      return value, which is ignored.
>=20
> And this is correct - so drop the call.
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Addresses-Coverity: ("Useless call")
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Thomas Winischhofer <thomas@winischhofer.net>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/sis/init.c | 1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/i=
nit.c
> index b77ea1a8825a..b568c646a76c 100644
> --- a/drivers/video/fbdev/sis/init.c
> +++ b/drivers/video/fbdev/sis/init.c
> @@ -2659,7 +2659,6 @@ SiS_SetCRT1ModeRegs(struct SiS_Private *SiS_Pr, u=
nsigned short ModeNo,
>      if(SiS_Pr->UseCustomMode) {
>         infoflag =3D SiS_Pr->CInfoFlag;
>      } else {
> -      SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex);
>         if(ModeNo > 0x13) {
>   	 infoflag =3D SiS_Pr->SiS_RefIndex[RRTI].Ext_InfoFlag;
>         }
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--gg1w0HXXa8TuALerNcm3xdZmZ4ZlD0MbD--

--QnWIEOjQHJ8rq0ZZJUO0HtQm0NBqdd2M1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/OM9wFAwAAAAAACgkQlh/E3EQov+DA
dRAAnKGPfA+F6LY25M6XWDadUAWadW8Y4ud6JfMd6r6STtcRIi7Se5mgZRVxhAEEEnM2SEd2UFrS
m7UNpYbN/aGPuwR+Xc+e1sOMQNzJmAAPR1Zgv5LYgUrs4Q5kTv3fJLFk57qSG4lHNhD57ilI0zIf
sgnayJXIU6k3FXXwiRxJwjw8oXNs/k/L2D/3u61S1GyIJVKtRqecBWfDIri49NXGwNVdTGFIfgnC
fn9e4KyY5T9Ee6ZDQGW1vJI3CzMLxySSHO827RNSgYPSWnCW1TbM8llj0BemJIhSroFyTmLEOQhf
a3R84nMLHIeBXPZiWhE0WH5kiRBofRbcKM9/mONwnnnVFKJIe/gkb0XkCH5JMTEuDdX6QQJC9QLT
lxkeQ7/mrSD2bso7FlLgPMwhSEWq92I3uzLKmjv+SZPub3D+uFt7wPc84tz4T1AvhRwSTf88Wyc8
+DroGi16ZxNvQZVH9rMrBWqpHF7PeV96oeH7RB+Mlp4HaE570lzrb/iwegk8bWyCJ5yE6J+XkLUn
a+P4ZFq11O5TEDfm69KNsj4J6XMFBI/O2SvrD8uohrh7m0++5u0/VjSHxSJD8JpZ1hT2isDEalPo
BUV90jlrQVoiAKNTMfbTcugfVaSVq7icXm5H9364AEnGaZmVQ5aWXkmE7x6EYXNEIx8pHcFK2Px8
Z1A=
=mfTB
-----END PGP SIGNATURE-----

--QnWIEOjQHJ8rq0ZZJUO0HtQm0NBqdd2M1--
