Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1BDC27C76
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Jan 2023 17:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjA1RHS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Jan 2023 12:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjA1RHR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Jan 2023 12:07:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEE42385A
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Jan 2023 09:07:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pLofZ-0006go-ML; Sat, 28 Jan 2023 18:07:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pLofZ-00134b-MH; Sat, 28 Jan 2023 18:07:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pLofY-00GaBs-3F; Sat, 28 Jan 2023 18:07:12 +0100
Date:   Sat, 28 Jan 2023 18:07:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] backlight: ktz8866: Convert to i2c's .probe_new()
Message-ID: <20230128170708.om77umvc43bmskgv@pengutronix.de>
References: <20230127152639.1347229-1-u.kleine-koenig@pengutronix.de>
 <Y9RuDM9VAMBzj4vd@Gentoo>
 <20230128133239.ndanz4gzm73wwaiv@pengutronix.de>
 <Y9Utsbi5PYZ26m9j@Gentoo>
 <20230128161613.zx24zhdqj66vxhcz@pengutronix.de>
 <Y9VQ7oEBtR6bA8fP@Gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o3v37c5hagobeljr"
Content-Disposition: inline
In-Reply-To: <Y9VQ7oEBtR6bA8fP@Gentoo>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--o3v37c5hagobeljr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jan 29, 2023 at 12:44:30AM +0800, Jianhua Lu wrote:
> On Sat, Jan 28, 2023 at 05:16:13PM +0100, Uwe Kleine-K=F6nig wrote:
> > I don't want to squash the changes to the ktz8866 driver into the patch
> > that modifies struct i2c_driver, as this needlessly clutters the commit,
> > if it's that what you wanted. (There are more than 1000 i2c drivers and
> > the others are not converted in a single lockstep, too.)
>=20
> Do't squash this patch, I'd like you send a series patch instead of
> a single patch.

This series was already sent before. However that happend based on a
tree that didn't contain the ktz8866 backlight driver, so this patch
came later (and I didn't resend the whole series for the two drivers
that were added since then :-). See
https://lore.kernel.org/lkml/20221118224540.619276-1-uwe@kleine-koenig.org.
for the original post.

Letting this patch go in via the i2c tree together with the commit
changing i2c_driver is fine for me, it won't be the only one.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o3v37c5hagobeljr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPVVjkACgkQwfwUeK3K
7Anxfgf9E13JzNC1YMhCbFKctFnER5WhWuo++pqLMA5Cs24zd9HH3yOk7AuUtYx9
NnSzkpTPjCbAcvN1fTCo/PV+5pjP5VnYIKnEZ8Py/b4tYKI198rP+063guGMebEC
THSepj4EN8d/QyslW2k0dFsmOQymE7ZPrBowsqwbRHieN3octmanQu1RAJt7Uupc
sIPTVFZatA2Ib0RJKRPqytbEV5AGcdHvx2jYZiHwe2EVHumqV5yREVhd7jHCkXUa
tAvT06VwldQpBHsE5G7qqx4qwjgzibjfmRXSXlxLiS9Xefe6G2dVgvkAik9jy6a+
0SO5hvzSaT/Hx8/9irEtASfzTFxRLw==
=hrjO
-----END PGP SIGNATURE-----

--o3v37c5hagobeljr--
