From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/17] vt: VT ioctl race fix
Date: Sat, 29 Sep 2007 09:24:45 +0800
Message-ID: <46FDA95D.8060303@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSN0-0007yd-5G for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:47:56 -0700
Received: from qb-out-0506.google.com ([72.14.204.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSMw-00070M-Qg
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:47:53 -0700
Received: by qb-out-0506.google.com with SMTP id c8so581761qbc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:47:49 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Samuel Ortiz <sameo@openedhand.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Samuel Ortiz <sameo@openedhand.com>

When calling the RELDISP VT ioctl, we are reading vt_newvt while the console
workqueue could be messing with it (through change_console()).
We fix this race by taking the console semaphore before reading vt_newvt.

Signed-off-by: Samuel Ortiz <sameo@openedhand.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/char/vt_ioctl.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index 60111a7..c872774 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -812,6 +812,7 @@ #endif
 		/*
 		 * Switching-from response
 		 */
+		acquire_console_sem();
 		if (vc->vt_newvt >= 0) {
 			if (arg == 0)
 				/*
@@ -826,7 +827,6 @@ #endif
 				 * complete the switch.
 				 */
 				int newvt;
-				acquire_console_sem();
 				newvt = vc->vt_newvt;
 				vc->vt_newvt = -1;
 				i = vc_allocate(newvt);
@@ -840,7 +840,6 @@ #endif
 				 * other console switches..
 				 */
 				complete_change_console(vc_cons[newvt].d);
-				release_console_sem();
 			}
 		}
 
@@ -852,9 +851,12 @@ #endif
 			/*
 			 * If it's just an ACK, ignore it
 			 */
-			if (arg != VT_ACKACQ)
+			if (arg != VT_ACKACQ) {
+				release_console_sem();
 				return -EINVAL;
+			}
 		}
+		release_console_sem();
 
 		return 0;
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
