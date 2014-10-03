From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 03 Oct 2014 11:52:01 +0000
Subject: [PATCH v2 1/5] simplefb: Add simplefb MAINTAINERS entry
Message-Id: <1412337125-14388-2-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
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
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3705430..01a5fd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8289,6 +8289,13 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIMPLEFB FB DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/video/simple-framebuffer.txt
+F:	drivers/video/fbdev/simplefb.c
+
 SH_VEU V4L2 MEM2MEM DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.1.0

