From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Wed, 12 May 2010 21:31:51 +0000
Subject: Buildfailure for omap3_defconfig due to patch OMAP: RX51: Add LCD Panel support
Message-Id: <201005122331.51347.PeterHuewe@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tomi.valkeinen@nokia.com, roger.quadros@nokia.com, tony@atomide.com, khilman@deeprootsystems.com, paul@pwsan.com, jpihet@mvista.com, kalle.valo@iki.fi, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Roger,

I just wanted to inform you that your Patch
OMAP: RX51: Add LCD Panel support (b499d77834ae292465f8d06bb0a88f1a647dfa1a) 
introduces a build failure for the omap3_defconfig.

You can see the error message here:
http://kisskb.ellerman.id.au/kisskb/buildresult/2601981/

This is due to the fact that omap3_defconfig has
CONFIG_MACH_NOKIA_RX51=y
set which enables the compilation of arch/arm/mach-omap2/board-rx51.c

board-rx51.c calls rx51_video_mem_init in arch/arm/mach-omap2/board-rx51-
video.c which is guarded by 
#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)

Unfortunately none if them is set in the omap3_defconfig.

Would be nice if you could fix this :)

Thanks,
Peter

Reported-by: Peter Huewe <peterhuewe@gmx.de>
