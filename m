From: Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 13 Jul 2010 23:30:45 +0000
Subject: [PATCH] viafb: Add transitive dependencies via gpiolib
Message-Id: <1279063845.6139.129.camel@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

FB_VIA now selects GPIOLIB, but that is not available on all
architectures.  Change FB_VIA dependencies to include GPIOLIB
dependencies.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
I think the better solution is to make GPIOLIB available for all
platforms, but this will deal with the problem in the short term (i.e.
for 2.6.35).

Ben.

 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3d94a14..bc4534d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1505,7 +1505,7 @@ config FB_SIS_315
 
 config FB_VIA
        tristate "VIA UniChrome (Pro) and Chrome9 display support"
-       depends on FB && PCI
+       depends on FB && PCI && (ARCH_WANT_OPTIONAL_GPIOLIB || ARCH_REQUIRE_GPIOLIB)
        select FB_CFB_FILLRECT
        select FB_CFB_COPYAREA
        select FB_CFB_IMAGEBLIT
-- 
1.7.1


