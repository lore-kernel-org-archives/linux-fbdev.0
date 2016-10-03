From: Jiri Slaby <jslaby@suse.cz>
Date: Mon, 03 Oct 2016 09:07:34 +0000
Subject: [PATCH -resend 4/6] mdacon: enable COMPILE_TEST build
Message-Id: <20161003090736.19926-4-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161003090736.19926-1-jslaby@suse.cz>
In-Reply-To: <20161003090736.19926-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

It can be built even on systems without ISA. So enable compile testing
by specifying ISA || COMPILE_TEST.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 38da6e299149..7e9e8be24134 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -48,7 +48,7 @@ config VGACON_SOFT_SCROLLBACK_SIZE
 	 screenfuls of scrollback buffer
 
 config MDA_CONSOLE
-	depends on !M68K && !PARISC && ISA
+	depends on !M68K && !PARISC && (ISA || COMPILE_TEST)
 	tristate "MDA text console (dual-headed)"
 	---help---
 	  Say Y here if you have an old MDA or monochrome Hercules graphics
-- 
2.10.0

