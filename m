Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B0CC433ED
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 May 2021 08:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19A66128B
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 May 2021 08:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhEGIVh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 May 2021 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbhEGIVh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 May 2021 04:21:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6E9C061574
        for <linux-fbdev@vger.kernel.org>; Fri,  7 May 2021 01:20:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1levis-0001mt-7n; Fri, 07 May 2021 10:20:34 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1levir-0003Zc-J2; Fri, 07 May 2021 10:20:33 +0200
Date:   Fri, 7 May 2021 10:20:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-fbdev@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel-janitors@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        j.beisert@pengutronix.de, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] video: fbdev: imxfb: Fix an error message
Message-ID: <20210507082033.ihp2ozulam72wezw@pengutronix.de>
References: <d7b25026f82659da3c6f7159eea480faa9d738be.1620327302.git.christophe.jaillet@wanadoo.fr>
 <20210507050503.iwrcis2xzhjjthmp@pengutronix.de>
 <5cd9c8de-acd9-9594-38a0-62ecf5734c10@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k6uy7cv4js3qqvsf"
Content-Disposition: inline
In-Reply-To: <5cd9c8de-acd9-9594-38a0-62ecf5734c10@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--k6uy7cv4js3qqvsf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Christophe,

[dropping krzysztof.h1@poczta.fm from recipents, the address doesn't
seem to exist]

On Fri, May 07, 2021 at 09:11:19AM +0200, Christophe JAILLET wrote:
> Le 07/05/2021 =E0 07:05, Uwe Kleine-K=F6nig a =E9crit=A0:
> > On Thu, May 06, 2021 at 08:57:05PM +0200, Christophe JAILLET wrote:
> > > 'ret' is known to be 0 here.
> > > No error code is available, so just remove it from the error message.
> > >=20
> > > Fixes: 72330b0eeefc ("i.MX Framebuffer: Use readl/writel instead of d=
irect pointer deref")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > >   drivers/video/fbdev/imxfb.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> > > index 7f8debd2da06..ad598257ab38 100644
> > > --- a/drivers/video/fbdev/imxfb.c
> > > +++ b/drivers/video/fbdev/imxfb.c
> > > @@ -992,7 +992,7 @@ static int imxfb_probe(struct platform_device *pd=
ev)
> > >   	info->screen_buffer =3D dma_alloc_wc(&pdev->dev, fbi->map_size,
> > >   					   &fbi->map_dma, GFP_KERNEL);
> > >   	if (!info->screen_buffer) {
> > > -		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
> > > +		dev_err(&pdev->dev, "Failed to allocate video RAM\n");
> > >   		ret =3D -ENOMEM;
> > >   		goto failed_map;
> > >   	}
> >=20
> > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > Are you using this driver, or did you find that problem using some
> > static checker?
>=20
> No, I'm not using this driver AFAIK.

OK, thanks. (We're working on a DRM driver for this hardware. So you
could have been an interested tester.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k6uy7cv4js3qqvsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCU+E4ACgkQwfwUeK3K
7AkjAAgAnt/sPpkqRLMXAau9y9HiswDIt+I8Pdi7OOyx53eECYY1KD+2Lo9YSg6I
8bnnHAEmSLebkh98Wb83wa61xTi7t66L/MtIjPY+aYjg7AFWiXNmbFVQLgmXeobc
L9bsN2CwMZtCsu50jJt6vVIgWrg5Ddzn7/9oiGCQNlCmSX16dmKQepIxnzEOuima
XWxQrAsctEYpn7ms0MnTqVruHFKGs7jFyA0K9MQN8FD8odvLXE3/VQhmXmpCpAKY
wm4LEJlqsfoasRQa1pevm5iHksq6YBNEtVOs9r6r9rLkUydHbaJLWydO/3k3Sj4S
7sKqBYyFG144lPJarkg5E77+61g39g==
=tg7t
-----END PGP SIGNATURE-----

--k6uy7cv4js3qqvsf--
