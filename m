From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH 1/7] uvesafb: set the refresh rate to
	60Hz if nocrtc is used
Date: Sat, 11 Aug 2007 16:38:16 +0200
Message-ID: <20070811143816.GB13632@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJs6z-0005G6-K9 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Aug 2007 07:38:41 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148] helo=spock.one.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IJs6y-0002lr-88
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Aug 2007 07:38:41 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

If the nocrtc flag is set, make sure the timings in fb_var are set to
60Hz and thus reflect the default BIOS refresh rate that is being
used.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 9c21791..aa5a9c3 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -903,7 +903,7 @@ gotmode:
 	 * If we are not VBE3.0+ compliant, we're done -- the BIOS will
 	 * ignore our timings anyway.
 	 */
-	if (par->vbe_ib.vbe_version < 0x0300)
+	if (par->vbe_ib.vbe_version < 0x0300 || par->nocrtc)
 		fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON, 60,
 					&info->var, info);



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
