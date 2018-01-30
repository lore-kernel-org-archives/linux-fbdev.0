From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 30 Jan 2018 19:22:57 +0000
Subject: [PATCH v2 02/10] video: fbdev: kconfig: Remove empty help text
Message-Id: <20180130192349.8420-3-ulfalizer@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180130192349.8420-1-ulfalizer@gmail.com>
In-Reply-To: <20180130192349.8420-1-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com, mcgrof@kernel.org, Ulf Magnusson <ulfalizer@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michal Simek <michal.simek@xilinx.com>, Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Hans de Goede <j.w.r.degoede@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

In preparation for adding a warning ("kconfig: Warn if help text is
blank"): https://lkml.org/lkml/2018/1/30/516

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/video/fbdev/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 6962b4583fd7..11e699f1062b 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1156,7 +1156,6 @@ config FB_I810_I2C
 	bool "Enable DDC Support"
 	depends on FB_I810 && FB_I810_GTF
 	select FB_DDC
-	help
 
 config FB_LE80578
 	tristate "Intel LE80578 (Vermilion) support"
-- 
2.14.1

