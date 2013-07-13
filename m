From: Pavel Machek <pavel@ucw.cz>
Date: Sat, 13 Jul 2013 18:27:34 +0000
Subject: Re: [PATCH] omapfb: In omapfb_probe return -EPROBE_DEFER when display driver is not loaded yet
Message-Id: <20130713182733.GA25019@amd.pavel.ucw.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373461739-10168-1-git-send-email-pali.rohar@gmail.com>
In-Reply-To: <1373461739-10168-1-git-send-email-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>

On Wed 2013-07-10 15:08:59, Pali Roh=E1r wrote:
> * On RX-51 probing for acx565akm driver is later then for omapfb which ca=
use that omapfb probe fail and framebuffer is not working
> * EPROBE_DEFER causing that kernel try to probe for omapfb later again wh=
ich fixing this problem
>=20
> * Without this patch display on Nokia RX-51 (N900) phone not working
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Tested-by: Pavel Machek <pavel@ucw.cz>

(Actually, do we know which commit broke the ordering? We may want to
simply revert that one...)

BTW I'm currently trying to set-up automated scripts for n900/qemu
testing. I guess I'll try to run them on mainline kernel to catch such
stuff earlier.

One thing I'd like to know: how do you configure kernel to get output
on qemu? I was doing CONFIG_DEBUG_LL with specific uart, but that
needed patching the kernel, you apparently have something more clever.

I tried doing:

# CONFIG_DEBUG_LL is not set
CONFIG_DEBUG_LL_INCLUDE=3D"mach/debug-macro.S"
CONFIG_UNCOMPRESS_INCLUDE=3D"debug/uncompress.h"

but no output on console...

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
