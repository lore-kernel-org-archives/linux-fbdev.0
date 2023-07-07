Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F4EB64DA
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jul 2023 12:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjGGM1Z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jul 2023 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGGM1Y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 Jul 2023 08:27:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC10B19B2;
        Fri,  7 Jul 2023 05:27:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so20102035e9.1;
        Fri, 07 Jul 2023 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688732842; x=1691324842;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miiLkM0CrGFVGmHvIpnji0OMSUMh4Pbjaf/A3Rfnl5o=;
        b=Vu5HWx9u3V9rXjZ4b4cB27G2d1VvXosrTKjM62C0xR+Vm1RTEjQfsWlLhODdnfh+tA
         NB3rn89cWz4qLytgjearKzt0ClfhXfJXOJbnfO/iFeEgZvk8pxVUUnjyIw83CYflUfLl
         DD5J8sYd1Qe5cyuYg4DSfwfYG4eurGDn8/X42i+kCBp4m9jhmUBEEM5i0bS4xukKzwD3
         hTqZTPjM2DaiNfyEbUk8TRaerLnlcF2ftVtmkhsx9PGW86QFBsnn6nCasIfEqjesNfnx
         bbyRddGR1ejbebLA3tT3JdUtF3RG+tCCBzSkD+dvKTOFKaFudZ51V4MHlORZNPpyiexf
         /yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688732842; x=1691324842;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miiLkM0CrGFVGmHvIpnji0OMSUMh4Pbjaf/A3Rfnl5o=;
        b=A0SfjYfVF0kbEE/+UNDBDxphZsVlWr4lvwGBS07uGhV89mzJzDpkzEz/OuAf29PUbD
         nrHJDd6ObBH93MkvrVm9UbhDZWCyWNH+4+zY4nKEH2f25M1wovLLcTCt8R+m4GSfPbQI
         TR8ifXqK9g3saFm/TbQovOKtXhXBQ4XVM/0Qm6VyrGEG26YXb+DavnOvEGmE2iUHP9te
         SvwJYSu1CITiKNrAMUFFfTF3TautKaKC2ltJOsTPQHK/bJFgV2SY+ABXMj61TI8tXsKf
         VKlYfVxoimxWhHY8x0HoFImmxdBghc2yGSj11jaSbud03QIykvWEGENNoeYWMeT2Tg6Z
         OyZQ==
X-Gm-Message-State: ABy/qLbuBV4uM4WbCZ3GpjST1BQF9BKLbC7nIRS7FSzCy0aNo++z/MDy
        8jv4jiMQihtk5vrzmlT+wNQ=
X-Google-Smtp-Source: APBJJlF7fR1W+pHh1Mzn9BUQbJN/Uj+O9uypICWZaJN5U8ZkOD+qBbjYftweSghkV2agxYEfbczIIQ==
X-Received: by 2002:a05:600c:3654:b0:3fb:b3aa:1c8a with SMTP id y20-20020a05600c365400b003fbb3aa1c8amr4260905wmq.16.1688732842067;
        Fri, 07 Jul 2023 05:27:22 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c16-20020a7bc850000000b003fbb06af219sm2363613wml.32.2023.07.07.05.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:27:21 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:27:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 04/12] drm/tegra: Set fbdev FBINFO_VIRTFB flag
Message-ID: <ZKgEqBVCkCpGyFI7@orome>
References: <20230707083422.18691-1-tzimmermann@suse.de>
 <20230707083422.18691-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ts1b/mYBCw25ZidD"
Content-Disposition: inline
In-Reply-To: <20230707083422.18691-5-tzimmermann@suse.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--ts1b/mYBCw25ZidD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 10:31:55AM +0200, Thomas Zimmermann wrote:
> Mark the framebuffer with FBINFO_VIRTFB. The framebuffer range is
> in DMA-able memory and should be accessed with the CPU's regular
> memory ops.
>=20
> v2:
> 	* drop FBINFO_DEFAULT
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/drm/tegra/fbdev.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--ts1b/mYBCw25ZidD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSoBKcACgkQ3SOs138+
s6GeKg//UisIKLJ5ssVJTPCXmJuMbWZch/UGKG7Zu3f04RzbsdSVXFaPDCOgDyQJ
gBZafMU0tRBU7fDa+0HCqcD9ojEDAz1QvsrjSrkmONRrh6LrOHCt4LUsia7jvXq/
dk4apSMa5apZSxNpDj8JxQtKjuYSu6kyZRHU7xLskuZf+Tm/YfxQUeKcVhgCRWWf
s3Gwnpzb5dORUnYa24l3mZYkCv2aXmv+C4/dBd3nYZ7HwWFlIr+TLKLo765BbEKe
8BUA0uQYTK5hrJap32b6x6r+Qr9LYInwYFfFqucXc2L8f36kpDJtLGbMetYKWsXK
YKI+gXRtYD/BvPf2BlPNKx4fpSrrHnv91U71pcsY1Y2N+dj2PSt3gZbuRH/q2IYa
sqmFaDKfm+Y9asUP6oZ5IrKOK4Z1Jy8jy/RN3ll06elD6EFlF9gYchuJ6b0dx40u
hNiLSOI0yQ8h1S+8D1NdeFJ8WtExkLuImoIf/I/h2Aw8zp3pnl+if2tRzm5k2UmH
3w/QpxbkqzRGmKnfQIPPQQnFJ3h7JtBX1i+EE0BxOBm0oXDPUJFUmU/rTeHWy6PI
joVQF8R7AJhj08s+7d/jJVbVn1QHV9v1ff40XD6V+5Ankg48cKlwEJCeOL0GEYoR
QbknvsvKNaGObh+/1LOkqr1qOj+jhXr1WLEhZdEzN0W9OrUDULU=
=vRiE
-----END PGP SIGNATURE-----

--ts1b/mYBCw25ZidD--
