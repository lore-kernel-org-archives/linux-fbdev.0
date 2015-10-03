From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 03 Oct 2015 16:11:52 +0000
Subject: [PATCH 0/2] video: fbdev: pxafb: devicetree conversion
Message-Id: <1443888714-12362-1-git-send-email-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

This patchset aims at bringing support for the pxa framebuffer driver to a
devicetree pxa platform.

This was tested on a pxa27x platform, in both a devicetree build and a classic
platform data one.

Robert Jarzmik (2):
  video: fbdev: pxafb: loosen the platform data bond
  video: fbdev: pxafb: initial devicetree conversion

 drivers/video/fbdev/Kconfig |   2 +
 drivers/video/fbdev/pxafb.c | 212 +++++++++++++++++++++++++++++++++++++++-----
 drivers/video/fbdev/pxafb.h |   2 +
 3 files changed, 195 insertions(+), 21 deletions(-)

-- 
2.1.4

