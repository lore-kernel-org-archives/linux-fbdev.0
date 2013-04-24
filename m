From: Markus Pargmann <mpa@pengutronix.de>
Date: Wed, 24 Apr 2013 08:08:12 +0000
Subject: [PATCH 0/2] drivers/video: mxs-fb: build fixes
Message-Id: <1366790894-20426-1-git-send-email-mpa@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

mxs-fb commit

669406534b4abb827d1bdc39bb5e2d5255818ae2 video: mxsfb: get display timings from device tree

creates a build failure together with those commits:

a38884f681a4d044befd30d9f3d19a0821bae63a videomode: simplify videomode Kconfig and Makefile
6cd2c7db41eab204b6474534df4ca68a7dc53d86 videomode: videomode_from_timing work

All of them are in linux-next, so mxs-fb fails to build there.

Regards,

Markus


