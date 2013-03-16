From: Jiang Liu <liuj97@gmail.com>
Date: Sat, 16 Mar 2013 17:03:27 +0000
Subject: [PATCH v2, part3 06/12] mm/acornfb: use common help functions to free reserved pages
Message-Id: <1363453413-8139-7-git-send-email-jiang.liu@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363453413-8139-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1363453413-8139-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Use common help functions to free reserved pages.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Florian Tobias Schandinat
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/video/acornfb.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index 6488a73..344f2bb 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -1188,32 +1188,8 @@ static int acornfb_detect_monitortype(void)
 static inline void
 free_unused_pages(unsigned int virtual_start, unsigned int virtual_end)
 {
-	int mb_freed = 0;
-
-	/*
-	 * Align addresses
-	 */
-	virtual_start = PAGE_ALIGN(virtual_start);
-	virtual_end = PAGE_ALIGN(virtual_end);
-
-	while (virtual_start < virtual_end) {
-		struct page *page;
-
-		/*
-		 * Clear page reserved bit,
-		 * set count to 1, and free
-		 * the page.
-		 */
-		page = virt_to_page(virtual_start);
-		ClearPageReserved(page);
-		init_page_count(page);
-		free_page(virtual_start);
-
-		virtual_start += PAGE_SIZE;
-		mb_freed += PAGE_SIZE / 1024;
-	}
-
-	printk("acornfb: freed %dK memory\n", mb_freed);
+	free_reserved_area(virtual_start, PAGE_ALIGN(virtual_end),
+			   -1, "acornfb");
 }
 
 static int acornfb_probe(struct platform_device *dev)
-- 
1.7.9.5

