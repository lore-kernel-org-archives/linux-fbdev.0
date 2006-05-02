From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH] vt: Delay the update of the visible framebuffer console
Date: Tue, 2 May 2006 17:12:39 -0600
Message-ID: <20060502231239.GB23644@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=CE+1k2dSO48ffgeK
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fb3oW-00082G-Mv
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 May 2006 15:57:52 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fb3oW-0002GS-T4
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 May 2006 15:57:52 -0700
Received: from amdext4.amd.com ([163.181.251.6])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fb3oU-0001Xv-HZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 May 2006 15:57:52 -0700
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: david.hollister@amd.com


--CE+1k2dSO48ffgeK
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This is a patch that delays updating the visible framebuffer console
until the other consoles have been initialized in order to avoid losing
output lines.  This problem was discovered when loading a framebuffer driver
as a module.  Comments welcome.

Jordan

--CE+1k2dSO48ffgeK
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=vt.patch
Content-Transfer-Encoding: 7bit

[PATCH] vt:  Delay the update of the visible framebuffer console

From: David Hollister <david.hollister@amd.com>

This patch delays the update of the visible framebuffer console until
all other consoles have been initialized in order to avoid losing
information.  This only seems to be a problem with modules, not with
built-in drivers.

Signed-off-by: David Hollister <david.hollister@amd.com>
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/char/vt.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index acc5d47..30f0f24 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2700,9 +2700,11 @@ int take_over_console(const struct consw
 		if (!vc || !vc->vc_sw)
 			continue;
 
-		j = i;
-		if (CON_IS_VISIBLE(vc))
+		if (CON_IS_VISIBLE(vc)) {
+			j = i;
 			save_screen(vc);
+		}
+
 		old_was_color = vc->vc_can_do_color;
 		vc->vc_sw->con_deinit(vc);
 		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
@@ -2718,17 +2720,21 @@ int take_over_console(const struct consw
 		 */
 		if (old_was_color != vc->vc_can_do_color)
 			clear_buffer_attributes(vc);
-
-		if (CON_IS_VISIBLE(vc))
-			update_screen(vc);
 	}
+
 	printk("Console: switching ");
 	if (!deflt)
 		printk("consoles %d-%d ", first+1, last+1);
-	if (j >= 0)
+	if (j >= 0) {
+		struct vc_data *vc = vc_cons[j].d;
+
 		printk("to %s %s %dx%d\n",
-		       vc_cons[j].d->vc_can_do_color ? "colour" : "mono",
-		       desc, vc_cons[j].d->vc_cols, vc_cons[j].d->vc_rows);
+		       vc->vc_can_do_color ? "colour" : "mono",
+		       desc, vc->vc_cols, vc->vc_rows);
+
+		if (CON_IS_VISIBLE(vc))
+			update_screen(vc);
+	}
 	else
 		printk("to %s\n", desc);
 

--CE+1k2dSO48ffgeK--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
