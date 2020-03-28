From: Qiujun Huang <hqjagain@gmail.com>
Date: Sat, 28 Mar 2020 15:15:10 +0000
Subject: [PATCH] fbcon: fix null-ptr-deref in fbcon_switch
Message-Id: <20200328151511.22932-1-hqjagain@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: daniel.thompson@linaro.org, daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, ghalat@redhat.com, sam@ravnborg.org, Qiujun Huang <hqjagain@gmail.com>

Add check for vc_cons[logo_shown].d, as it can be released by
vt_ioctl(VT_DISALLOCATE).

Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bb6ae995c2e5..7ee0f7b55829 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2254,7 +2254,7 @@ static int fbcon_switch(struct vc_data *vc)
 		fbcon_update_softback(vc);
 	}
 
-	if (logo_shown >= 0) {
+	if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
 		struct vc_data *conp2 = vc_cons[logo_shown].d;
 
 		if (conp2->vc_top = logo_lines
@@ -2852,7 +2852,7 @@ static void fbcon_scrolldelta(struct vc_data *vc, int lines)
 			return;
 		if (vc->vc_mode != KD_TEXT || !lines)
 			return;
-		if (logo_shown >= 0) {
+		if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
 			struct vc_data *conp2 = vc_cons[logo_shown].d;
 
 			if (conp2->vc_top = logo_lines
-- 
2.17.1
