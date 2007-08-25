From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] uvesafb: select connector in Kconfig
Date: Sat, 25 Aug 2007 10:59:31 +0200
Message-ID: <20070825085931.GA9318@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOrUj-00027i-T4 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Aug 2007 01:59:50 -0700
Received: from 240.37.78.83.cust.bluewin.ch ([83.78.37.240] helo=spock.one.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IOrUh-0006A8-GX
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Aug 2007 01:59:49 -0700
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

Make uvesafb select connector instead of depending on it being already selected.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index f1cc899..e152eed 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -594,7 +594,8 @@ config FB_TGA
 
 config FB_UVESA
 	tristate "Userspace VESA VGA graphics support"
-	depends on FB && CONNECTOR
+	depends on FB
+	select CONNECTOR
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
