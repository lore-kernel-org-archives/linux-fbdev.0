From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 28 Feb 2017 11:45:54 +0000
Subject: Re: [PATCH 1/2] video: fbdev: imxfb: support AUS mode
Message-Id: <1818329.3fFh8n00zk@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
 <CGME20170227230550epcas3p22975b9f391431fc25f3a504f6192a441@epcas3p2.samsung.com>
 <20170227223336.GA28519@botnar.kaiser.cx>
In-Reply-To: <20170227223336.GA28519@botnar.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Martin Kaiser <martin@kaiser.cx>
Cc: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>


Hi,

On Monday, February 27, 2017 11:33:36 PM Martin Kaiser wrote:
> Hello Uwe,
>=20
> Thus wrote Uwe Kleine-K=F6nig (u.kleine-koenig@pengutronix.de):
>=20
> > given fbdev is orphaned
> > (http://git.kernel.org/linus/238600783d7470bec19350b0ee79e01825d3c84f)
>=20
> fbdev is no longer orphaned, Bartlomiej is the new maintainer.
>=20
> > I think it would be nice to move the imxfb driver over to drm.
> > I don't know much about drm, so I cannot say if that is easy or not, but
> > long term I think this is more robust than fbdev.
>=20
> I am aware that fbdev is in maintenance mode. However, I hope that small
> modifications like the one I submitted are still possible.

Yes, such changes are fine.

BTW Please merge both patches into one or at least make Cc:
list complete so people can see the whole context easily
(i.e. I didn't get patch #2 in my patches folder and Rob
didn't get patch #1).

> In the long run, I agree that we should move imxfb to drm.
>=20
> Best regards,
> Martin

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

