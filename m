Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D1AC4332F
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Nov 2023 06:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjKIGZG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Nov 2023 01:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKIGZF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Nov 2023 01:25:05 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3D119A5
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Nov 2023 22:25:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0yTN-0002rd-EG; Thu, 09 Nov 2023 07:25:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0yTL-007iId-Va; Thu, 09 Nov 2023 07:24:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0yTL-00Flau-M4; Thu, 09 Nov 2023 07:24:59 +0100
Date:   Thu, 9 Nov 2023 07:24:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, llvm@lists.linux.dev,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Nathan Chancellor <nathan@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 02/22] fb: atmel_lcdfb: Stop using platform_driver_probe()
Message-ID: <20231109062459.5hk7vb54t4iy5kp6@pengutronix.de>
References: <20231107091740.3924258-1-u.kleine-koenig@pengutronix.de>
 <20231107091740.3924258-3-u.kleine-koenig@pengutronix.de>
 <20231108184805.GA1579138@dev-arch.thelio-3990X>
 <20231108210018.ayo5b3afggmt6wfc@pengutronix.de>
 <24c4cc36-d14b-40cc-ad8d-dea029cf1845@gmx.de>
 <20231108215220.3iw5sydxad32gufj@pengutronix.de>
 <656080fb-7d10-47ec-bdeb-a099ceee99bf@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3kqb4iadfxwx3nek"
Content-Disposition: inline
In-Reply-To: <656080fb-7d10-47ec-bdeb-a099ceee99bf@gmx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--3kqb4iadfxwx3nek
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Nov 08, 2023 at 10:57:00PM +0100, Helge Deller wrote:
> On 11/8/23 22:52, Uwe Kleine-K=F6nig wrote:
> > But info and so info->fix live longer than the probe function, don't
> > they?
>=20
> Yes, they do.
> But AFAICS info->fix contains a *copy* of the initial atmel_lcdfb_fix str=
uct
> (and not a pointer to it). So that should be ok.

If you say so that's good. I grepped a bit around and didn't find a
place where a copy is made. But that's probably me and I'll consider the
case closed.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3kqb4iadfxwx3nek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVMezoACgkQj4D7WH0S
/k7q/wgArxm2BvyCentus6W2LMuLfhOlRWssY41U6crdkW2BAR8S85WMcflzm8x8
LJvcizkBfw+flQR/w4UHHmEqq/r3ITBa7AYlD/tYbwATihPQZtCLgmIf5OT/D8ur
RqhcnzFkdj6tHccaOLBQuLJ6lin946/ghokktbTDOwRbhJKxkV3uI8seepdGVg5Z
soUjFq8Da82cXiqeuEnHPUFizigl/RhMHmjeDA+nbA8A3TQYLXNMyKAZBzi2JQZs
lQsDlI5yatfWPOwRjA2H9PckJgNvysrcgqU2pVaxwXKx/cQur7GP8EnnCuJAma/k
n3hhvc6Fu/qozs6Tz1asn3kh10mj6w==
=bkJX
-----END PGP SIGNATURE-----

--3kqb4iadfxwx3nek--
