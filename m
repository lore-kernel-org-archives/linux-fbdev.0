Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC08C49EA5
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Jun 2021 20:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43B1613B3
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Jun 2021 20:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhFXUMd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhFXUMc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Jun 2021 16:12:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8CFC061574
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Jun 2021 13:10:13 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwVfu-0002BF-TB; Thu, 24 Jun 2021 22:10:10 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwVft-0005ob-Uy; Thu, 24 Jun 2021 22:10:09 +0200
Date:   Thu, 24 Jun 2021 22:10:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 2/2] backlight: lm3630a: convert to atomic PWM API and
 check for errors
Message-ID: <20210624201009.5se7o27b7m6bff4g@pengutronix.de>
References: <20210621122148.116863-1-u.kleine-koenig@pengutronix.de>
 <20210621122148.116863-3-u.kleine-koenig@pengutronix.de>
 <YNHh2cdcyzLWSCkK@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6q5sr5ki5ppu4gv"
Content-Disposition: inline
In-Reply-To: <YNHh2cdcyzLWSCkK@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--e6q5sr5ki5ppu4gv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Tue, Jun 22, 2021 at 02:12:57PM +0100, Lee Jones wrote:
> On Mon, 21 Jun 2021, Uwe Kleine-K=F6nig wrote:
>=20
> > The practical upside here is that this only needs a single API call to
> > program the hardware which (depending on the underlaying hardware) can
> > be more effective and prevents glitches.
> >=20
> > Up to now the return value of the pwm functions was ignored. Fix this
> > and propagate the error to the caller.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/video/backlight/lm3630a_bl.c | 42 +++++++++++++---------------
> >  1 file changed, 19 insertions(+), 23 deletions(-)
>=20
> Fixed the subject line and applied, thanks.

It's not obvious to me what needed fixing here, and I don't find where
you the patches, neither in next nor in
https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git; so I
cannot check what you actually changed.

I assume you did s/lm3630a/lm3630a_bl/ ? I didn't because it felt
tautological.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e6q5sr5ki5ppu4gv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDU5p4ACgkQwfwUeK3K
7AmTZwf/ZQn7nKoCAT8thn0EIoPpaCREmTbKgFd9pjB/yd43HL30wWUWsLR54BDp
YMhPwHHfdN8aNyFiZpJx5nYRdxBSWTYnW+kfFp0RcRarDMgrzIr4KdRBPGrzf9p3
V9NJys4V4KWpdja6Tld2hBhsuKkZjJa17i0tcCfsje8XWNVMvT0Txb7dRAcb7oYO
w2/X5dsO5X+atCCchKwdyI9rKlRB2MvX8MBG1xx6k6spoLG0q3/mW5oiWCAoJaJu
rm7AJl6HDO6LBtm41vj8WCW+D145cR5fLqL7jmhO1hSHvmGf+WaFBF/VMspoStBW
lvNdPE8/9mcO3+jIOYUNNzG5WI2Hcw==
=jj+6
-----END PGP SIGNATURE-----

--e6q5sr5ki5ppu4gv--
