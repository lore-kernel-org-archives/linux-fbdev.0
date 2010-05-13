From: Roger Quadros <roger.quadros@nokia.com>
Date: Thu, 13 May 2010 07:35:02 +0000
Subject: Re: Buildfailure for omap3_defconfig due to patch OMAP: RX51: Add
Message-Id: <4BEBABA6.6040907@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201005122331.51347.PeterHuewe@gmx.de>
In-Reply-To: <201005122331.51347.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?ext_Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "jpihet@mvista.com" <jpihet@mvista.com>, "kalle.valo@iki.fi" <kalle.valo@iki.fi>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Peter,

ext Peter H=FCwe wrote:
> Hi Roger,
>=20
> I just wanted to inform you that your Patch
> OMAP: RX51: Add LCD Panel support (b499d77834ae292465f8d06bb0a88f1a647dfa=
1a)=20
> introduces a build failure for the omap3_defconfig.
>=20
> You can see the error message here:
> http://kisskb.ellerman.id.au/kisskb/buildresult/2601981/
>=20
> This is due to the fact that omap3_defconfig has
> CONFIG_MACH_NOKIA_RX51=3Dy
> set which enables the compilation of arch/arm/mach-omap2/board-rx51.c
>=20
> board-rx51.c calls rx51_video_mem_init in arch/arm/mach-omap2/board-rx51-
> video.c which is guarded by=20
> #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
>=20
> Unfortunately none if them is set in the omap3_defconfig.
>=20
> Would be nice if you could fix this :)
>=20
Thanks for pointing this out. Kevin Hilman had already informed me of this =
earlier.

The patch with the fix is here
https://patchwork.kernel.org/patch/98092/

Tomi has picked up the fixed patch in his tree in the for-next branch
http://gitorious.org/linux-omap-dss2/linux/commit/9585a7e56c51d224830adb29b=
1843310a87cd034

regards,
-roger
