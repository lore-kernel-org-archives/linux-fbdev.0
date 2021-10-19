Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2659FC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 19 Oct 2021 16:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC7C6103B
	for <linux-fbdev@archiver.kernel.org>; Tue, 19 Oct 2021 16:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhJSQih (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 19 Oct 2021 12:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbhJSQig (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 19 Oct 2021 12:38:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC96C06161C
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Oct 2021 09:36:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mcs6A-0000hm-4x; Tue, 19 Oct 2021 18:36:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mcs69-0003gj-Jd; Tue, 19 Oct 2021 18:36:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mcs69-0006en-Im; Tue, 19 Oct 2021 18:36:21 +0200
Date:   Tue, 19 Oct 2021 18:36:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH] video: backlight: ili9320: Make ili9320_remove() return
 void
Message-ID: <20211019163621.bzgwufqkp7hcin4m@pengutronix.de>
References: <20211019120927.3822792-1-u.kleine-koenig@pengutronix.de>
 <20211019153037.5uwqixmg7k4m3api@maple.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lke7ulqa7udmcszx"
Content-Disposition: inline
In-Reply-To: <20211019153037.5uwqixmg7k4m3api@maple.lan>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--lke7ulqa7udmcszx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2021 at 04:30:37PM +0100, Daniel Thompson wrote:
> On Tue, Oct 19, 2021 at 02:09:27PM +0200, Uwe Kleine-K=F6nig wrote:
> > Up to now ili9320_remove() returns zero unconditionally. Make it return
> > void instead which makes it easier to see in the callers that there is
> > no error to handle.
>=20
> Ultimately the actions here boil down to an SPI write which could fail
> so we could make an attempt to correct the broken error propagation
> inside ili9320.c instead...
>=20
> > Also the return value of spi remove callbacks is ignored anyway.
>=20
> ... which does inform the above question.
>=20
> Is this patch a local fix or part of a larger plan to eventually change
> the return value of the spi_remove to void?

This is the motivation yes, so there isn't any sane way to propagate an
error. The only thing you could sensibly do is to print an error
message. But the device will go away no matter what you do. (Well, you
could do an endless-loop to "delay" removing, but ...)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lke7ulqa7udmcszx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFu9AIACgkQwfwUeK3K
7AlOxQf/Rs8uIiRVSkN2LKFCYLzn6NHji1JE3W/TfCauotMzwpWrxfbKK3NqAf5T
Cu7Jjt98LGliC4PlUU9azOtx83CDrybhj6lkLSTJ1U8JKOghb1SUDGqafbISuXjo
zh8fQeIq3XMUS9rnTkvlCGfazBaF6d2E/RQdt2DoyfmOd8o8oXHj/7lqXmaJMMCd
7T3WI885dKX9JmiR4znYNfPeGvmf2mpEWeeLBtN2d6PDoO6df5zmfmBoxxrLj52W
xPF7XtZsI/UsWqeheYdEWQHFtRfUmIWSH9XwPLkdU0J8iMCXPravegihR0QgljOo
F/yQqSurMu0o9GWpn7ShH+eD31MbAg==
=IMHd
-----END PGP SIGNATURE-----

--lke7ulqa7udmcszx--
