From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH] Set default of FB_GBE_MEM to 4 MB since >= 4 MB allocation breaks fb
Date: Fri, 17 Feb 2006 12:46:54 +0000
Message-ID: <20060217124654.GA17201@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FA50s-00008b-FH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Feb 2006 04:47:06 -0800
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FA50q-00008G-EU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Feb 2006 04:47:06 -0800
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

[PATCH] Set default of FB_GBE_MEM to 4 MB since >= 4 MB allocation breaks fb

Allocating more than 4 MB memory for the GBE (SGI O2) framebuffer
completely breakfs gbefb support at the moment.  According to comments
on #mipslinux, more than 4 MB has never worked correctly in Linux.
Therefore, the default should be 4 MB.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7d7724c..9d684bb 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -520,7 +520,7 @@ config FB_GBE
 config FB_GBE_MEM
 	int "Video memory size in MB"
 	depends on FB_GBE
-	default 8
+	default 4
 	help
 	  This is the amount of memory reserved for the framebuffer,
 	  which can be any value between 1MB and 8MB.

-- 
Martin Michlmayr
http://www.cyrius.com/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
