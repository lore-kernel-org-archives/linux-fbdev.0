Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35D0EE14C3
	for <linux-fbdev@archiver.kernel.org>; Sat,  9 Sep 2023 20:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjIIUXY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 9 Sep 2023 16:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjIIUXX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 9 Sep 2023 16:23:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8EDCCC
        for <linux-fbdev@vger.kernel.org>; Sat,  9 Sep 2023 13:22:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qf4SA-0000Iw-Ci; Sat, 09 Sep 2023 22:21:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qf4S7-005Ann-7d; Sat, 09 Sep 2023 22:21:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qf4S6-000E4T-GZ; Sat, 09 Sep 2023 22:21:10 +0200
Date:   Sat, 9 Sep 2023 22:21:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jilin Yuan <yuanjilin@cdjrlc.com>, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] video: fbdev: ssd1307fb: Print the PWM's label
 instead of its number
Message-ID: <20230909202110.bcz5qvb7bfrzco73@pengutronix.de>
References: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
 <20230728145824.616687-3-u.kleine-koenig@pengutronix.de>
 <87lef0xcw4.fsf@minerva.mail-host-address-is-not-set>
 <87zg1vif8b.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fur7e2akxpm43452"
Content-Disposition: inline
In-Reply-To: <87zg1vif8b.fsf@minerva.mail-host-address-is-not-set>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--fur7e2akxpm43452
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Sep 09, 2023 at 04:38:28PM +0200, Javier Martinez Canillas wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
>=20
> > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
> >
> >> struct pwm_device::pwm is a write-only variable in the pwm core and us=
ed
> >> nowhere apart from this and another dev_dbg. So it isn't useful to
> >> identify the used PWM. Emit the PWM's label instead in the debug
> >> message.
> >>
> >> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >> ---
> >
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> >
>=20
> Pushed to drm-misc (drm-misc-next). Thanks!

JFTR: This patch is already in linus/master. And Javier pushed
"drm/ssd130x: Print the PWM's label instead of its number" to
drm-misc-next which is great. So the "Pushed to ..." mail is just in
reply to the wrong patch in this thread and in git everything is fine.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fur7e2akxpm43452
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT807UACgkQj4D7WH0S
/k5gEAgApJDMf6qFSjEhYdieBJ4vC6YIQlzyH4Ro807Y/FwmsB/0Vt2x6N3Mx4TF
kVgD5VDwiYViHskX9/UK7iqa7K2dkLExcIK7hLL5PZRhf2BGEOk/JapbypBHNm9m
cT4h1m3DnThc4av2TbnfKg6SlhwYTb++RDjOSc3kzqVegwQEThB1OvTKXzrawKXz
hYJDn/iwa7k5aD/nviy1yhqyQROqeNrtEMswo+I2T887iRIM/h/mKg78J7Rr98FT
bigt5kxPEhoLCRb3pB+bXe6NIFF1uiG0qmGtu+Zad9/Onm4fbMg1xNSJX+nMY8hO
nd1Jl1ph/9uYigX4HJCUX/DSHXSiGA==
=F+dV
-----END PGP SIGNATURE-----

--fur7e2akxpm43452--
