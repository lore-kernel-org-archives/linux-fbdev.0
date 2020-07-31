From: George Kennedy <george.kennedy@oracle.com>
Date: Fri, 31 Jul 2020 16:33:12 +0000
Subject: [PATCH 2/2] vt_ioctl: change VT_RESIZEX ioctl to check for error return from vc_resize()
Message-Id: <1596213192-6635-2-git-send-email-george.kennedy@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1596213192-6635-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1596213192-6635-1-git-send-email-george.kennedy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: george.kennedy@oracle.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, dhaval.giani@oracle.com

vc_resize() can return with an error after failure. Change VT_RESIZEX ioctl
to save struct vc_data values that are modified and restore the original
values in case of error.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
---
Version of patch available for Mainline also.

 drivers/tty/vt/vt_ioctl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 91c3017..a4e520b 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -806,12 +806,22 @@ static int vt_resizex(struct vc_data *vc, struct vt_consize __user *cs)
 		console_lock();
 		vcp = vc_cons[i].d;
 		if (vcp) {
+			int ret;
+			int save_scan_lines = vcp->vc_scan_lines;
+			int save_font_height = vcp->vc_font.height;
+
 			if (v.v_vlin)
 				vcp->vc_scan_lines = v.v_vlin;
 			if (v.v_clin)
 				vcp->vc_font.height = v.v_clin;
 			vcp->vc_resize_user = 1;
-			vc_resize(vcp, v.v_cols, v.v_rows);
+			ret = vc_resize(vcp, v.v_cols, v.v_rows);
+			if (ret) {
+				vcp->vc_scan_lines = save_scan_lines;
+				vcp->vc_font.height = save_font_height;
+				console_unlock();
+				return ret;
+			}
 		}
 		console_unlock();
 	}
-- 
1.8.3.1
