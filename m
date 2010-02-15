From: Bernie Thompson <bernie@plugable.com>
Date: Mon, 15 Feb 2010 14:45:12 +0000
Subject: [PATCH 0/10] udlfb: enhancements to DisplayLink USB framebuffer
Message-Id: <1266245112.4353.3287.camel@bernie-aspireone>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

udlfb is the framebuffer driver for USB 2.0 era DisplayLink devices.

This patch series is intended to help move it along out of staging. It
builds on the prior accepted patch for dynamic modesetting based on
vesa/raw input timings (applied by gregkh, currently in linux-next).
Each patch in the series should be considered dependent on the prior
patch.

For more background on the development and testing of these patches, see
http://lists.freedesktop.org/archives/libdlo/
http://plugable.com/category/project/udlfb

I'm a Linux kernel newbie, and this is a staging driver. Any feedback is
welcome, especially any opportunities to make significant improvements
in later patches.

And if evolution or gmail mess with the formating of anything, the
matching quilt patches directory is available here:
http://plugable.com/udlfb-patches-2.6.34-2.tar.gz

Many people have contributed, but thanks especially to Roberto DeIoris
and Jaya Kumar for their work in the creation of this driver.

Best wishes,
Bernie Thompson
http://plugable.com/


