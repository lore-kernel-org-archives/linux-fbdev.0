Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C61C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Oct 2022 20:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiJSUYG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Oct 2022 16:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiJSUYF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Oct 2022 16:24:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15681C5A70
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Oct 2022 13:24:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1olFbZ-0005rR-Ku; Wed, 19 Oct 2022 22:23:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1olFbY-000C52-Fz; Wed, 19 Oct 2022 22:23:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1olFbX-009A19-S0; Wed, 19 Oct 2022 22:23:55 +0200
Date:   Wed, 19 Oct 2022 22:23:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Make xilinxfb_release() return void
Message-ID: <20221019202355.qhvrlavvxlabwgom@pengutronix.de>
References: <20221019132422.78505-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eusgjvxyfskayn4d"
Content-Disposition: inline
In-Reply-To: <20221019132422.78505-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--eusgjvxyfskayn4d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I failed to add a proper subject prefix. "fbdev: xilinxfb: " would have
been a good choice. I can resend, but I wouldn't say no if you are
willing to fixup while applying this patch :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eusgjvxyfskayn4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNQXNgACgkQwfwUeK3K
7AnLJgf/b6pvSKg3Pm/QbY//gtR2iXSnM2Fr1+rJe0kqaW9gkh5JN2FNsitXefXR
DtuwKShfoWPvM7kUg75oWFZoBHEL08U3VqAu6HmdcmOIvo9CZRdVDUfwIhwYLPIn
IE53kvls0r00OnXfqtg/E1am7+jgStHaTAn4QYyROTtSPLzZDzJj/F9f7PodgBgL
/C9k2hDf8VpcoSXho+xmpIWzdswZtTDT3ihxa8iS6LoUHAq7krq79WDrO6veUNxL
8R7gh3vIBA9lidLEAGVuCpMey87uei7aTRCrO4MnPXWoavu/0VBccNNPpyanI3+j
OOJ8Firg3/PnmVcCDUtd5FUAm+QzAA==
=07br
-----END PGP SIGNATURE-----

--eusgjvxyfskayn4d--
