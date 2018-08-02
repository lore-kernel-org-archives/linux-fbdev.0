From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 02 Aug 2018 11:28:39 +0000
Subject: [PATCH fix for 4.19 1/3] fbcon: Only allow FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER if fbdev is builtin
Message-Id: <20180802112841.27679-2-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180802112841.27679-1-hdegoede@redhat.com>
In-Reply-To: <20180802112841.27679-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Having FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER with fbdev+fbcon being build
as a module does not make much sense.

Having FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER only when fbdev+fbcon are
builtin was always the intention, hence the =y checks but they were
checking the wrong option, fbcon is build as part of fb.ko, so we must
check for FB=y.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index e91edef98633..787792c3d08d 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -152,7 +152,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
 
 config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 	bool "Framebuffer Console Deferred Takeover"
-	depends on FRAMEBUFFER_CONSOLE=y && DUMMY_CONSOLE=y
+	depends on FB=y && FRAMEBUFFER_CONSOLE && DUMMY_CONSOLE
 	help
 	  If enabled this defers the framebuffer console taking over the
 	  console from the dummy console until the first text is displayed on
-- 
2.18.0

