From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Tue, 15 Mar 2011 22:53:18 +0000
Subject: [PATCH 06/13] omap: use list_move() instead of list_del()/list_add() combination
Message-Id: <1300229605-14499-6-git-send-email-kirill@shutemov.name>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300229605-14499-1-git-send-email-kirill@shutemov.name>
In-Reply-To: <1300229605-14499-1-git-send-email-kirill@shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org
---
 drivers/video/omap/blizzard.c |    3 +--
 drivers/video/omap/hwa742.c   |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index 87785c2..c0504a8 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -397,8 +397,7 @@ static inline void free_req(struct blizzard_request *req)
 
 	spin_lock_irqsave(&blizzard.req_lock, flags);
 
-	list_del(&req->entry);
-	list_add(&req->entry, &blizzard.free_req_list);
+	list_move(&req->entry, &blizzard.free_req_list);
 	if (!(req->flags & REQ_FROM_IRQ_POOL))
 		up(&blizzard.req_sema);
 
diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index 0016f77..084aa0a 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -269,8 +269,7 @@ static inline void free_req(struct hwa742_request *req)
 
 	spin_lock_irqsave(&hwa742.req_lock, flags);
 
-	list_del(&req->entry);
-	list_add(&req->entry, &hwa742.free_req_list);
+	list_move(&req->entry, &hwa742.free_req_list);
 	if (!(req->flags & REQ_FROM_IRQ_POOL))
 		up(&hwa742.req_sema);
 
-- 
1.7.4.1

