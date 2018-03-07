From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 07 Mar 2018 19:47:03 +0000
Subject: [PATCH] video: fbdev: via_aux_vt1636: remove VLA usage
Message-Id: <20180307194703.GA3862@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

In preparation to enabling -Wvla, remove VLA and replace it
with a fixed-length array instead. Also, remove variable 'len'.

Notice that no new IDs have been added in seven years.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/via/via_aux_vt1636.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/via/via_aux_vt1636.c b/drivers/video/fbdev/via/via_aux_vt1636.c
index 9e015c1..d6273a4 100644
--- a/drivers/video/fbdev/via/via_aux_vt1636.c
+++ b/drivers/video/fbdev/via/via_aux_vt1636.c
@@ -35,10 +35,10 @@ void via_aux_vt1636_probe(struct via_aux_bus *bus)
 		.addr	=	0x40,
 		.name	=	name};
 	/* check vendor id and device id */
-	const u8 id[] = {0x06, 0x11, 0x45, 0x33}, len = ARRAY_SIZE(id);
-	u8 tmp[len];
+	const u8 id[4] = {0x06, 0x11, 0x45, 0x33};
+	u8 tmp[4];
 
-	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
+	if (!via_aux_read(&drv, 0x00, tmp, 4) || memcmp(id, tmp, 4))
 		return;
 
 	printk(KERN_INFO "viafb: Found %s\n", name);
-- 
2.7.4

