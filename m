From: Petr Cvek <petr.cvek@tul.cz>
Date: Fri, 07 Aug 2015 19:14:47 +0000
Subject: [BUG, RFC] Different bitfields in documentation and driver
Message-Id: <55C503A7.6020304@tul.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,
It seems that PXA2xx framebuffer has switched bitfields in nonstd definition (when using overlay).

This:

	http://lxr.free-electrons.com/source/drivers/video/fbdev/pxafb.h#L80

versus this:

	http://lxr.free-electrons.com/source/Documentation/fb/pxafb.txt#L128

Should be this changed in documentation or in driver? I was able to find only one use (in form of little outdated mplayer patch) and it fills both bitfields with zero (so potential change in driver will not break it).

P.S. Lack of overlay2's use is probably caused by errata "E24: LCD: Enabling Overlay 2 for YUV420 hangs LCD controller.", which is not workarounded in this driver. It should be mentioned in documentation and/or code, because the only way to start the LCD again is a full PXA SoC reset.

Petr Cvek
