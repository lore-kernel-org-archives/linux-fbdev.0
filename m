From: Xishi Qiu <qiuxishi@huawei.com>
Date: Wed, 04 Sep 2013 10:41:40 +0000
Subject: [PATCH 2/2] mm/driver: use __free_reserved_page() to simplify the code
Message-Id: <52270E64.20401@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, james.hogan@imgtec.com, monstr@monstr.eu, benh@kernel.crashing.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Xishi Qiu <qiuxishi@huawei.com>, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org

Use __free_reserved_page() to simplify the code in the others.

Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
---
 drivers/video/acornfb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index 6488a73..4ef302a 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -1205,9 +1205,7 @@ free_unused_pages(unsigned int virtual_start, unsigned int virtual_end)
 		 * the page.
 		 */
 		page = virt_to_page(virtual_start);
-		ClearPageReserved(page);
-		init_page_count(page);
-		free_page(virtual_start);
+		__free_reserved_page(page);
 
 		virtual_start += PAGE_SIZE;
 		mb_freed += PAGE_SIZE / 1024;
-- 
1.7.1


