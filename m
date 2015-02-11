From: Kiran Padwal <kiran.padwal@smartplayin.com>
Date: Wed, 11 Feb 2015 09:48:45 +0000
Subject: [PATCH] video: ARM CLCD: Add missing error check for devm_kzalloc
Message-Id: <1423647406-858-1-git-send-email-kiran.padwal@smartplayin.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kiran Padwal <kiran.padwal21@gmail.com>, Kiran Padwal <kiran.padwal@smartplayin.com>

This patch add a missing check on the return value of devm_kzalloc,
which would cause a NULL pointer dereference in a OOM situation.

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
 drivers/video/fbdev/amba-clcd.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 32c0b6b..9362424 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -599,6 +599,9 @@ static int clcdfb_of_get_mode(struct device *dev, struct device_node *endpoint,
 
 	len = clcdfb_snprintf_mode(NULL, 0, mode);
 	name = devm_kzalloc(dev, len + 1, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
 	clcdfb_snprintf_mode(name, len + 1, mode);
 	mode->name = name;
 
-- 
1.7.9.5

