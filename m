From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH 1/1] Constant spelling
Date: Sat, 10 Dec 2005 19:45:06 +0100
Message-ID: <439B2232.9010906@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1El9ho-0003bV-RQ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 10:44:24 -0800
Received: from mailout05.sul.t-online.com ([194.25.134.82])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1El9hm-0001nG-FI
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 10:44:24 -0800
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Obviously constants should be spelled correctly.
Follow-up to fbdev-fixing-switch-to-kd_text-enhanced-version.patch


Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>


diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/fbcon.c linuxtmp/drivers/video/console/fbcon.c
--- linuxorig/drivers/video/console/fbcon.c	2005-12-10 19:36:49.000000000 +0100
+++ linuxtmp/drivers/video/console/fbcon.c	2005-12-10 19:36:40.000000000 +0100
@@ -2104,7 +2104,7 @@ static int fbcon_switch(struct vc_data *
  	ops->var = info->var;

  	if (old_info != NULL && (old_info != info ||
-				 info->flags & FBINFO_MISC_ALLWAYS_SETPAR)) {
+				 info->flags & FBINFO_MISC_ALWAYS_SETPAR)) {
  		if (info->fbops->fb_set_par)
  			info->fbops->fb_set_par(info);
  		fbcon_del_cursor_timer(old_info);
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/include/linux/fb.h linuxtmp/include/linux/fb.h
--- linuxorig/include/linux/fb.h	2005-12-10 19:36:49.000000000 +0100
+++ linuxtmp/include/linux/fb.h	2005-12-10 19:36:42.000000000 +0100
@@ -735,7 +735,7 @@ struct fb_tile_ops {
   * code whenever there is a bug report related to switching between X and the
   * framebuffer console.
   */
-#define FBINFO_MISC_ALLWAYS_SETPAR   0x40000
+#define FBINFO_MISC_ALWAYS_SETPAR   0x40000


  struct fb_info {



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
