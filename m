From: Darren Etheridge <detheridge@ti.com>
Date: Fri, 23 Aug 2013 18:17:01 +0000
Subject: [PATCH v3 0/1] Adding DT support to video/da8xx-fb.c
Message-Id: <1377281822-29659-1-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: prabhakar.csengg@gmail.com, devicetree@vger.kernel.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, detheridge@ti.com
Cc: afzal@ti.com

This is part of a larger series of patches to upgrade the da8xx-fb.c driver
to support the Texas Instruments AM335x device.  As part of this upgrade
we also want to add devicetree support for both the original da8xx and the
am335x.  Tomi Valkeinen has reviewed the fbdev changes but he suggested
that it was prudent to extract the dt pieces and run it through the
devicetree mailing list for review.

v2: incorporates -
	* review comment changes from Prabhakar Lad
	* changes the .compatible naming to match that of the exiting drm 
		driver for am335x devices.
	* Renames the devicetree bindings documentation file to match the
		actual driver filename
v3: updated documentation to make clear which compatible to use for DA850 
	SoC devices.

Thanks,
Darren

Darren Etheridge (1):
  video: da8xx-fb: adding dt support

 .../devicetree/bindings/video/da8xx-fb.txt         |   42 ++++++++++++
 drivers/video/da8xx-fb.c                           |   66 +++++++++++++++++++-
 2 files changed, 105 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/da8xx-fb.txt

