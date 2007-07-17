From: Arnd Bergmann <arnd@arndb.de>
Subject: fbdev: make fb_append_extra_logo() depend on
	fb=y
Date: Wed, 18 Jul 2007 00:52:03 +0200
Message-ID: <200707180052.04659.arnd@arndb.de>
References: <20070716135550.010775000@pademelon.sonytel.be>
	<20070716135950.895120000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IAvvF-0007Qh-AB for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jul 2007 15:53:37 -0700
Received: from moutng.kundenserver.de ([212.227.126.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IAvvD-0002lt-Qg
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jul 2007 15:53:37 -0700
In-Reply-To: <20070716135950.895120000@pademelon.sonytel.be>
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
To: cbe-oss-dev@ozlabs.org
Cc: James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

We can't show the extra logo from boot code if FB is built as
a module. Make the FB_LOGO_EXTRA depend on FB=y.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Reported by Al Viro. I don't know how this ended up in the final
patch, as I'm pretty sure we talked about this scenario before
and had a solution...

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index da219c0..9de1c11 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -12,7 +12,7 @@ if LOGO
 
 config FB_LOGO_EXTRA
 	bool
-	depends on FB
+	depends on FB=y
 	default y if SPU_BASE
 
 config LOGO_LINUX_MONO

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
