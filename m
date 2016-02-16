From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Tue, 16 Feb 2016 13:31:36 +0000
Subject: Re: [PATCH v2 2/3] fbdev: omap2: panel-dpi: make (limited) use of a reset gpio
Message-Id: <20160216133136.GB9853@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-3-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Tue, Feb 16, 2016 at 03:01:55PM +0200, Tomi Valkeinen wrote:
>=20
> On 20/12/15 13:13, Uwe Kleine-K=F6nig wrote:
> > Some displays have a reset input. To assert that the display is
> > functional the reset gpio must be deasserted.
> >=20
> > Teach the driver to get and drive such a gpio accordingly.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > --
> > Changes since (implicit) v1, sent with
> > Message-Id: 1449753107-11410-4-git-send-email-uwe@kleine-koenig.org :
> >=20
> >  - never assert reset because there are too many different panels with
> >    too many different needs for their reset.
> >  - split out dt binding changes
> >  - reword commit log
>=20
> Please add these extra texts below the --- line below. Otherwise they
> end up in the commit description.

This was an accident. Should I resend for that one?

Best regards
Uwe
