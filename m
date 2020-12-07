Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ADFC4361B
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 08:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E5522ADF
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 08:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgLGISV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Dec 2020 03:18:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:42302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgLGISV (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 7 Dec 2020 03:18:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2BCEAD71;
        Mon,  7 Dec 2020 08:17:38 +0000 (UTC)
Subject: Re: [PATCH v3 03/13] video: fbdev: omapfb: Fix set but not used
 warnings in hdmi*_core
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
 <20201206190247.1861316-4-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <f48fa582-03a7-0b00-1ff9-29a4f42bb829@suse.de>
Date:   Mon, 7 Dec 2020 09:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201206190247.1861316-4-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E3lrt3AO1UboYAcLRO95c4R22Ins7taIx"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E3lrt3AO1UboYAcLRO95c4R22Ins7taIx
Content-Type: multipart/mixed; boundary="OUWhZbPPdmE84pqiaWXJaw69CHLHuUKK9";
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
Message-ID: <f48fa582-03a7-0b00-1ff9-29a4f42bb829@suse.de>
Subject: Re: [PATCH v3 03/13] video: fbdev: omapfb: Fix set but not used
 warnings in hdmi*_core
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-4-sam@ravnborg.org>
In-Reply-To: <20201206190247.1861316-4-sam@ravnborg.org>

--OUWhZbPPdmE84pqiaWXJaw69CHLHuUKK9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 06.12.20 um 20:02 schrieb Sam Ravnborg:
> Fix a few W=3D1 warnings about unused assignments.
> Drop the unused error code.
>=20
> v2:
>    - Subject updated (Lee)
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Qilong Zhang <zhangqilong3@huawei.com>
> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c | 4 ++--
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c b/driver=
s/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
> index 726c190862d4..e6363a420933 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
> @@ -679,7 +679,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core,=
 struct hdmi_wp_data *wp,
>   	struct hdmi_audio_format audio_format;
>   	struct hdmi_audio_dma audio_dma;
>   	struct hdmi_core_audio_config acore;
> -	int err, n, cts, channel_count;
> +	int n, cts, channel_count;
>   	unsigned int fs_nr;
>   	bool word_length_16b =3D false;
>  =20
> @@ -741,7 +741,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core,=
 struct hdmi_wp_data *wp,
>   		return -EINVAL;
>   	}
>  =20
> -	err =3D hdmi_compute_acr(pclk, fs_nr, &n, &cts);
> +	hdmi_compute_acr(pclk, fs_nr, &n, &cts);
>  =20
>   	/* Audio clock regeneration settings */
>   	acore.n =3D n;
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c b/driver=
s/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
> index eda29d3032e1..cb63bc0e92ca 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
> @@ -790,7 +790,7 @@ int hdmi5_audio_config(struct hdmi_core_data *core,=
 struct hdmi_wp_data *wp,
>   	struct hdmi_audio_format audio_format;
>   	struct hdmi_audio_dma audio_dma;
>   	struct hdmi_core_audio_config core_cfg;
> -	int err, n, cts, channel_count;
> +	int n, cts, channel_count;
>   	unsigned int fs_nr;
>   	bool word_length_16b =3D false;
>  =20
> @@ -833,7 +833,7 @@ int hdmi5_audio_config(struct hdmi_core_data *core,=
 struct hdmi_wp_data *wp,
>   		return -EINVAL;
>   	}
>  =20
> -	err =3D hdmi_compute_acr(pclk, fs_nr, &n, &cts);
> +	hdmi_compute_acr(pclk, fs_nr, &n, &cts);
>   	core_cfg.n =3D n;
>   	core_cfg.cts =3D cts;
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--OUWhZbPPdmE84pqiaWXJaw69CHLHuUKK9--

--E3lrt3AO1UboYAcLRO95c4R22Ins7taIx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/N5SAFAwAAAAAACgkQlh/E3EQov+Bw
rg/+LR5m0fPa5U9oIwT4rwsKunaIejtxjKhv4yTaKVPunhtVb87Jqt+IqwsZ52d5O2enBQb43e3V
fZQT55Mrk6m0m7mLG/lhk27hLemh4wSRgVJ0ZEg3YmQzTZZWQdupqbTJE7bcUJdwx8zIUcmzI1po
5trUyBPf46eRTNliM5Vc244dtzFgPgfuLBXZu/dCq8Zzn9Qxh757mW4HjMYMspJoaWNbgD8LvEsN
LCU2Nk+1Ew7qY27KDzGOrfZllPIUnDgWqni8Ej5zCTuCMzvZXGV5wcbX9KzzjxV2KRkxByE/rivI
3/bGCRDkU8zda578ct2LHXr+8Fg/aoRxs6j1mxHylRDNHaMYG8ZHuQRY84PdOf/fcboIw3yr2ptH
Sirs1DQo+tLuG86Z45W5uZkQQdWWkPmtv7LJDeHIUkMRKpN3OFM7YRVt/SdsB0lcIq306nd/mqk4
F/BfLqrs/KmDFnlpJOXYE0XXziSbK23CG2r/MZ/nUu+wMqa0gl6Ey9ZudSBYRAwZteFJ/nfelbvk
vbx/2Mq8qN1WBRF6Rz4/YdTNSTrVg/tK45CFfBZzCiwGxoszbKzeg9/W8l229XJDx2q7B7+vsbqK
uJDg97WCP4M4YssswkEdMf4GkaLsdva9ah2EiMkVB6fsOWMzQ7WlTuJ2Qow5yNgaG2ZyvldkV+H0
/to=
=vrgS
-----END PGP SIGNATURE-----

--E3lrt3AO1UboYAcLRO95c4R22Ins7taIx--
