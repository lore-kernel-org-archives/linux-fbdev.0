From: Darren Etheridge <detheridge@ti.com>
Date: Thu, 08 Aug 2013 20:15:35 +0000
Subject: [RFC 0/1] Adding DT support to video/da8xx-fb.c
Message-Id: <1375992936-16755-1-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, detheridge@ti.com
Cc: afzal@ti.com

This is part of a larger series of patches to upgrade the da8xx-fb.c driver
to support the Texas Instruments AM335x device.  As part of this upgrade
we also want to add devicetree support for both the original da8xx and the
am335x.  Tomi Valkeinen has reviewed the fbdev changes but he suggested
that it was prudent to extract the dt pieces and run it through the
devicetree mailing list for review.

Thanks,
Darren

Darren Etheridge (1):
  video: da8xx-fb: adding dt support

 .../devicetree/bindings/video/fb-da8xx.txt         |   37 +++++++++++
 drivers/video/da8xx-fb.c                           |   67 +++++++++++++++++++-
 2 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fb-da8xx.txt

