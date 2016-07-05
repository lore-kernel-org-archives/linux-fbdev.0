From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Tue, 05 Jul 2016 12:22:28 +0000
Subject: Re: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
Message-Id: <20160705122228.GO16643@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56E2AA80.4050908@ti.com> <20160420191727.GS29108@pengutronix.de>
 <20160705100902.GM16643@pengutronix.de>
 <20160705140838.52014e4b@ipc1.ka-ro>
In-Reply-To: <20160705140838.52014e4b@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Lothar,

On Tue, Jul 05, 2016 at 02:08:38PM +0200, Lothar Wa=DFmann wrote:
> On Tue, 5 Jul 2016 12:09:02 +0200 Uwe Kleine-K=F6nig wrote:
> > To reach my goal to keep the display on (showing whatever the bootloader
> > initialized the display with) until the application starts caring for
> > the display some driver must enable the regulator. The only candidates
> > are the lcd driver (i.e. the patch under discussion) or some mechanism
> > in the fb core. As there doesn't seem to be code in the core (and the
> > core is dead?) what do you suggest me to do?
> >=20
> The simplefb driver (CONFIG_FB_SIMPLE) is designed for exactly this
> purpose. If you rely on the bootloader's framebuffer being preserved
> until your application starts without any driver that reserves the
> corresponding memory, the framebuffer contents may be corrupted by the
> booting kernel.

I don't want to use the simplefb driver because the application makes
use of planes which isn't supported by simplefb. To prevent the
framebuffer being overwritten a chunk of memory at the end of RAM is
reserved (similar to how simplefb is supposed to work).

And even without my usecase of a persistent splash screen, if the fb is
used as console, it should not be disabled either.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
