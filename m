Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A2C48BE8
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Jun 2021 21:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A97961209
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Jun 2021 21:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhFRVUE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhFRVUE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Jun 2021 17:20:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E66C061574
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Jun 2021 14:17:54 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1luLs7-0006kT-D9; Fri, 18 Jun 2021 23:17:51 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1luLs5-0007AJ-Nt; Fri, 18 Jun 2021 23:17:49 +0200
Date:   Fri, 18 Jun 2021 23:17:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: lm3630a: convert to atomic PWM API and check
 for errors
Message-ID: <20210618211746.2kuwm3hlrhefuczl@pengutronix.de>
References: <20210618085844.231751-1-u.kleine-koenig@pengutronix.de>
 <20210618103109.j7vtuif4taldtt5d@maple.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xw5l75a42p7hetib"
Content-Disposition: inline
In-Reply-To: <20210618103109.j7vtuif4taldtt5d@maple.lan>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--xw5l75a42p7hetib
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 18, 2021 at 11:31:09AM +0100, Daniel Thompson wrote:
> On Fri, Jun 18, 2021 at 10:58:44AM +0200, Uwe Kleine-K=F6nig wrote:
> > The practical upside here is that this only needs a single API call to
> > program the hardware which (depending on the underlaying hardware) can
> > be more effective and prevents glitches.
> >=20
> > Up to now the return value of the pwm functions was ignored. Fix this
> > and propagate the error to the caller.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> New code looks OK but these changes reveal just how crazy the return codes
> from this driver's update_status() methods are since now the new (PWM) er=
ror path is
> structured completely differently to the existing (I2C) error path.

Indeed, while working on the patch I noticed that sometimes a positive
value is returned but failed to note that when I sent out the patch.

> Are you OK to add a patch *before* this one to fix the existing code
> paths before making the PWM changes?

I didn't do that because I was unsure what is the right thing to do. Now
that you confirmed the documentation I can add such a patch. Will add
this to my todo list.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xw5l75a42p7hetib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDNDXcACgkQwfwUeK3K
7Ak+cQf+IAfvHGYaQofmq45aZXwZgNDF6M7Sc8SyxX99h3woKvRWdD21cmkA09j9
mAVOhOyIbbT2QUl25VRiLlN2ZThcWukxR3dHsM0SSc4ddC2dnRcEG5zHmko3xxCF
UjGDrG6gL/Opz1gz6XD2sTI3bvc/KkQJ9jTLPW9tQfQ835X+mRYGE6puFyAI4Rf/
drN5Kzk43O2jJj0VJCxxrrOKG+MmL51KpNuFDOA/AWhIYQkO1S6rKd55SVk/ArJH
bifTXnodbIFULG1EfQpiDfk2f+uAa0J4jlffhvszlc00jaLU6pUzngchd8dKL6Me
tGAHDwZGboR9h3unn9iv55I6fx50nw==
=c04F
-----END PGP SIGNATURE-----

--xw5l75a42p7hetib--
