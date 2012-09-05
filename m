From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Wed, 05 Sep 2012 06:40:43 +0000
Subject: [PATCH] vmlfb: use list_move_tail instead of list_del/list_add_tail
Message-Id: <CAPgLHd_SinBfmVH2erdTq5howN3yAsjhoV+MdSShPgT5Nr5mLg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Using list_move_tail() instead of list_del() + list_add_tail().

spatch with a semantic match is used to found this problem.
(http://coccinelle.lip6.fr/)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/vermilion/vermilion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index 970e43d..083f0c8 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -1168,8 +1168,7 @@ void vmlfb_unregister_subsys(struct vml_sys *sys)
 	list_for_each_entry_safe(entry, next, &global_has_mode, head) {
 		printk(KERN_DEBUG MODULE_NAME ": subsys disable pipe\n");
 		vmlfb_disable_pipe(entry);
-		list_del(&entry->head);
-		list_add_tail(&entry->head, &global_no_mode);
+		list_move_tail(&entry->head, &global_no_mode);
 	}
 	mutex_unlock(&vml_mutex);
 }


