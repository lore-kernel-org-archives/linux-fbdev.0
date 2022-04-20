Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68728C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Apr 2022 14:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354568AbiDTOjE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Apr 2022 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379578AbiDTOjD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Apr 2022 10:39:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6099E017
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Apr 2022 07:36:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhBRE-0003Xe-NM; Wed, 20 Apr 2022 16:36:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhBRD-004BQJ-A6; Wed, 20 Apr 2022 16:36:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhBRB-004UqT-6h; Wed, 20 Apr 2022 16:36:09 +0200
Date:   Wed, 20 Apr 2022 16:36:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: fbtft: Fix style problem in header
Message-ID: <20220420143608.yuxleiffs234dfog@pengutronix.de>
References: <20220419192128.445023-1-ian@linux.cowan.aero>
 <20220420064711.xuhuyhtgcrs3avhk@pengutronix.de>
 <YmARR6+XQeVqlusK@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f7hoyxknyagqhwtl"
Content-Disposition: inline
In-Reply-To: <YmARR6+XQeVqlusK@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--f7hoyxknyagqhwtl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Wed, Apr 20, 2022 at 09:57:27AM -0400, Ian Cowan wrote:
> On Wed, Apr 20, 2022 at 08:47:11AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 19, 2022 at 03:21:28PM -0400, Ian Cowan wrote:
> > > Removed an unnecessary semicolon at the end of a macro call
> > >=20
> > > Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
> > > ---
> > >  drivers/staging/fbtft/fbtft.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fb=
tft.h
> > > index 2c2b5f1c1df3..aa66760e1a9c 100644
> > > --- a/drivers/staging/fbtft/fbtft.h
> > > +++ b/drivers/staging/fbtft/fbtft.h
> > > @@ -277,7 +277,7 @@ static const struct of_device_id dt_ids[] =3D {		=
			\
> > >  	{ .compatible =3D _compatible },						\
> > >  	{},									\
> > >  };										\
> > > -MODULE_DEVICE_TABLE(of, dt_ids);
> > > +MODULE_DEVICE_TABLE(of, dt_ids)
> >=20
> > In fact the ; after MODULE_DEVICE_TABLE is necessary. There is only a
> > single instance in the kernel without a semicolon[1]. That's in
> > drivers/pci/controller/pcie-microchip-host.c and this only works because
> > this driver cannot be compiled as a module and so MODULE_DEVICE_TABLE
> > evaluates to nothing. Will send a patch for that one.

FTR: Patch was sent: https://lore.kernel.org/linux-pci/20220420065832.14173=
-1-u.kleine-koenig@pengutronix.de

> When I built this, it appeared to succeed. I used the command "make
> M=3D/drivers/staging/fbtft modules". Is this incorrect? For reference this
> is my first patch so it's highly likely I did this incorrectly.

I don't know for sure, but I'd have said that the M=3D stuff is for
out-of-tree modules only.

I'd recommend:

	make allmodconfig
	make drivers/staging/fbtft/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f7hoyxknyagqhwtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJgGlMACgkQwfwUeK3K
7AkmVQf/ULc5C4BOsXhP5Yxd0efu3wQ7TGqRegYd/q3ZzvwzMwlc8g8VHCnSYBt1
Ub1qvQ3EAzBn/vNsRfQb6zXcJxmNAB9OS999dzGLa7I0WS7/uosHvLJVLeoffXRR
pJ0n3cmZGOBcO2abrhqBJPGOqfgTV/OMxEkFS3fRdjKrkWYMwBKl96Ckt0m/t7ai
qbu9/771JLKH6L+vM3O8LoL53T1CA27qGrtS3JTNvhHOgNvVem9Rz1XCDQ5pTtHB
rmBmZfhSWHyD/YFXm83L0iofqVJcOrDuysF329jBFYu1btc5h5S1X7Xk/nqeKf9N
mNSwdVl2fdCS6r7ao2IdmdN6GGUrXQ==
=se4c
-----END PGP SIGNATURE-----

--f7hoyxknyagqhwtl--
