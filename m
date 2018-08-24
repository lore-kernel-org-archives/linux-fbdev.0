From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Fri, 24 Aug 2018 10:04:59 +0000
Subject: [PATCH 3/3] drivers/block/z2ram: use ioremap_wt() instead of __ioremap(_PAGE_WRITETHRU)
Message-Id: <adb9282f01ca9ae55874639b8c26d6d1bba1fda0.1535104490.git.christophe.leroy@c-s.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4f905a9d9752768c628623276f5e2fb465c947c8.1535104490.git.christophe.leroy@c-s.fr>
In-Reply-To: <4f905a9d9752768c628623276f5e2fb465c947c8.1535104490.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org

_PAGE_WRITETHRU is a target specific flag. Prefer generic functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/block/z2ram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index d0c5bc4e0703..cfbd70520eeb 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -190,8 +190,7 @@ static int z2_open(struct block_device *bdev, fmode_t mode)
 			vfree(vmalloc (size));
 		}
 
-		vaddr = (unsigned long) __ioremap (paddr, size, 
-						   _PAGE_WRITETHRU);
+		vaddr = (unsigned long)ioremap_wt(paddr, size);
 
 #else
 		vaddr = (unsigned long)z_remap_nocache_nonser(paddr, size);
-- 
2.13.3
