From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 02 Aug 2013 12:05:27 +0000
Subject: [PATCH RESEND 8/8] fbdev: fbcon: select VT_HW_CONSOLE_BINDING
Message-Id: <1375445127-15480-9-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375445127-15480-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1375445127-15480-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Warren <swarren@wwwdotorg.org>, Peter Jones <pjones@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-fbdev@vger.kernel.org, akpm@linux-foundation.org, David Herrmann <dh.herrmann@gmail.com>

fbdev provides framebuffer hotplugging, hence, we need to allow fbcon to
unbind from framebuffers. Unfortunately, fbcon_fb_unbind() cannot unbind
from the last framebuffer, unless console-unbinding is supported.

Fixing fbcon_unbind() to return 0 caused some horrible NULL-derefs in the
VT layer and I couldn't figure out why. Hence, lets just require
console-unbinding so fbdev hotplugging works with fbcon.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/video/console/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 8c30603..846caab 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -92,7 +92,8 @@ config DUMMY_CONSOLE_ROWS
 
 config FRAMEBUFFER_CONSOLE
 	tristate "Framebuffer Console support"
-	depends on FB
+	depends on FB && !UML
+	select VT_HW_CONSOLE_BINDING
 	select CRC32
 	select FONT_SUPPORT
 	help
-- 
1.8.3.4

