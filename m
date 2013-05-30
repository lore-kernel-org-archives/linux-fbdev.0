From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 30 May 2013 20:23:44 +0000
Subject: [RESEND PATCH 1/1] MAINTAINERS: Framebuffer Layer maintainers update
Message-Id: <1369945424-3121-1-git-send-email-plagnioj@jcrosoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

Tomi and I will now take care of the Framebuffer Layer

The git tree is now on kernel.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
Hi,

	resend as git send-email drop my name in the From

Best Regards,
J.
 MAINTAINERS |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd3a495..7714c3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3322,11 +3322,12 @@ F:	drivers/net/wan/dlci.c
 F:	drivers/net/wan/sdla.c
 
 FRAMEBUFFER LAYER
-M:	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
+M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
+M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
 L:	linux-fbdev@vger.kernel.org
 W:	http://linux-fbdev.sourceforge.net/
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
-T:	git git://github.com/schandinat/linux-2.6.git fbdev-next
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/plagnioj/linux-fbdev.git
 S:	Maintained
 F:	Documentation/fb/
 F:	Documentation/devicetree/bindings/fb/
-- 
1.7.10.4

