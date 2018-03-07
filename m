From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 07 Mar 2018 19:54:15 +0000
Subject: [PATCH] video: fbdev: via_aux_vt1632: remove VLA usage
Message-Id: <20180307195415.GA666@embeddedgus>
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
 drivers/video/fbdev/via/via_aux_vt1632.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/via/via_aux_vt1632.c b/drivers/video/fbdev/via/via_aux_vt1632.c
index d24f4cd..0cd0d2a 100644
--- a/drivers/video/fbdev/via/via_aux_vt1632.c
+++ b/drivers/video/fbdev/via/via_aux_vt1632.c
@@ -35,10 +35,10 @@ static void probe(struct via_aux_bus *bus, u8 addr)
 		.addr	=	addr,
 		.name	=	name};
 	/* check vendor id and device id */
-	const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
-	u8 tmp[len];
+	const u8 id[4] = {0x06, 0x11, 0x92, 0x31};
+	u8 tmp[4];
 
-	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
+	if (!via_aux_read(&drv, 0x00, tmp, 4) || memcmp(id, tmp, 4))
 		return;
 
 	printk(KERN_INFO "viafb: Found %s at address 0x%x\n", name, addr);
-- 
2.7.4

