From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 17 Apr 2013 15:17:19 +0000
Subject: [RFC 07/10] mfd: vexpress: Allow external drivers to parse site ids
Message-Id: <1366211842-21497-8-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>

... by providing a function translating the MASTER
value into the currently valid site number and
a _LAST constant providing all possible site id values.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mfd/vexpress-sysreg.c |    5 +++++
 include/linux/vexpress.h      |    2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index bf75e96..4158e26 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -81,6 +81,11 @@ void vexpress_flags_set(u32 data)
 	writel(data, vexpress_sysreg_base + SYS_FLAGSSET);
 }
 
+u32 vexpress_get_site(int site)
+{
+	return site == VEXPRESS_SITE_MASTER ? vexpress_master_site : site;
+}
+
 u32 vexpress_get_procid(int site)
 {
 	if (site == VEXPRESS_SITE_MASTER)
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index 7581874..1ebbcf5 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -19,6 +19,7 @@
 #define VEXPRESS_SITE_MB		0
 #define VEXPRESS_SITE_DB1		1
 #define VEXPRESS_SITE_DB2		2
+#define __VEXPRESS_SITE_LAST		3
 #define VEXPRESS_SITE_MASTER		0xf
 
 #define VEXPRESS_CONFIG_STATUS_DONE	0
@@ -103,6 +104,7 @@ int vexpress_config_write(struct vexpress_config_func *func, int offset,
 
 /* Platform control */
 
+u32 vexpress_get_site(int site);
 u32 vexpress_get_procid(int site);
 u32 vexpress_get_hbi(int site);
 void *vexpress_get_24mhz_clock_base(void);
-- 
1.7.10.4


