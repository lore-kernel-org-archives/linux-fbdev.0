Return-Path: <linux-fbdev+bounces-5-linux-fbdev=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95912C4167B
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:49:01 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C6281880
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275833AC22;
	Fri, 10 Nov 2023 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F93C06E
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 17:46:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EFDA5CB
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 00:57:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r1NKK-0006gx-6X; Fri, 10 Nov 2023 09:57:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r1NKJ-007yjJ-Cv; Fri, 10 Nov 2023 09:57:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r1NKJ-00GaEG-3K; Fri, 10 Nov 2023 09:57:19 +0100
Date: Fri, 10 Nov 2023 09:57:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, kernel@pengutronix.de,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Atul Raut <rauji.raut@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] fb: amifb: Mark driver struct with __refdata to
 prevent section mismatch warning
Message-ID: <20231110085718.tzn7crqcahx2yo63@pengutronix.de>
References: <20231109220151.10654-1-u.kleine-koenig@pengutronix.de>
 <20231109220151.10654-2-u.kleine-koenig@pengutronix.de>
 <CAMuHMdWEGxU8STZrv4q3JgT+U=+Vyr4w_e_VnN23f36kBRBJXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dpfm435ya3db43pg"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWEGxU8STZrv4q3JgT+U=+Vyr4w_e_VnN23f36kBRBJXA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org


--dpfm435ya3db43pg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 10, 2023 at 08:58:37AM +0100, Geert Uytterhoeven wrote:
> On Thu, Nov 9, 2023 at 11:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > As described in the added code comment, a reference to .exit.text is ok
> > for drivers registered via module_platform_driver_probe(). Make this
> > explicit to prevent a section mismatch warning.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thanks for your patch!
> Why am I not seeing the actual section mismatch warning, not even
> with W=3D1?

Do you have f177cd0c15fcc7bdbb68d8d1a3166dead95314c8 in your tree? And
note it's only there if you compile the driver as a module and it is
only emitted once you completed the whole build.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dpfm435ya3db43pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVN8G4ACgkQj4D7WH0S
/k6pGwf/doqv5UqF7kkqKDJoYOUfOm2oNlLCy2YIGdSkf1WLJd+tFaOf6ed/qWZb
OnUUZlOWajf+9hoUiJiXrk2+FbyRvbnkL1c8iKE7655SXJfuf/21D5IoY/iGW4mE
gB7LsRO7Sfk7GvMx4YzHGvSOy82N80FMMRgp4qFvKoKEYDjjo5f+RlhccV9rsnSQ
DcsDRg5Q7g9Ve0q2IAtZfskfuTe2ZraCZSq2KJmhBwRBihjIybyR6rtM6gTifjEc
e1ETkXjw3NkPnMcYTqGWxbGgP86fT5dHh17ZG0hDPWLfSLcBfY+Jt/2Kvr6ByQJz
cBYbE3R/zgQFO99GUhEvjHY1B/GA0Q==
=D5er
-----END PGP SIGNATURE-----

--dpfm435ya3db43pg--

