From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 12 Nov 2014 16:15:48 +0000
Subject: [PATCH v5 1/5] simplefb: Add simplefb MAINTAINERS entry
Message-Id: <1415808952-23549-2-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415808952-23549-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415808952-23549-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

During the discussion about adding clock handling code to simplefb, it became
clear that simplefb currently does not have an active maintainer.

I've discussed this with Stephen Warren <swarren@wwwdotorg.org>, the original
author of simplefb, and with his permisson I'm picking up maintainership of
simplefb.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Grant Likely <grant.likely@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index df82827..7678808 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8442,6 +8442,14 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIMPLEFB FB DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/video/simple-framebuffer.txt
+F:	drivers/video/fbdev/simplefb.c
+F:	include/linux/platform_data/simplefb.h
+
 SH_VEU V4L2 MEM2MEM DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.1.0

