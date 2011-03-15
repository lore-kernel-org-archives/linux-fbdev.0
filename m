From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Tue, 15 Mar 2011 22:53:19 +0000
Subject: [PATCH 07/13] vmlfb: use list_move() instead of list_del()/list_add() combination
Message-Id: <1300229605-14499-7-git-send-email-kirill@shutemov.name>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300229605-14499-1-git-send-email-kirill@shutemov.name>
In-Reply-To: <1300229605-14499-1-git-send-email-kirill@shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Tejun Heo <tj@kernel.org>, linux-fbdev@vger.kernel.org

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/vermilion/vermilion.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index 931a567..970e43d 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -891,8 +891,7 @@ static int vmlfb_set_par(struct fb_info *info)
 	int ret;
 
 	mutex_lock(&vml_mutex);
-	list_del(&vinfo->head);
-	list_add(&vinfo->head, (subsys) ? &global_has_mode : &global_no_mode);
+	list_move(&vinfo->head, (subsys) ? &global_has_mode : &global_no_mode);
 	ret = vmlfb_set_par_locked(vinfo);
 
 	mutex_unlock(&vml_mutex);
-- 
1.7.4.1

