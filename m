From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Wed, 27 Jul 2016 19:57:00 +0000
Subject: Re: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
Message-Id: <20160727195700.GE5629@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56E2AA80.4050908@ti.com> <20160420191727.GS29108@pengutronix.de>
 <20160705100902.GM16643@pengutronix.de>
In-Reply-To: <20160705100902.GM16643@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello,

On Tue, Jul 05, 2016 at 12:09:02PM +0200, Uwe Kleine-K=F6nig wrote:
> To reach my goal to keep the display on (showing whatever the bootloader
> initialized the display with) until the application starts caring for
> the display some driver must enable the regulator. The only candidates
> are the lcd driver (i.e. the patch under discussion) or some mechanism
> in the fb core. As there doesn't seem to be code in the core (and the
> core is dead?) what do you suggest me to do?

Unfortunately I didn't get an answer here. Do you still have this mail
on your radar?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
