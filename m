From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/9] fbdev: Fix typos in Kconfig
Date: Wed, 21 Dec 2005 15:17:52 +0800
Message-ID: <43A901A0.4010802@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoyFy-0002F1-KY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:19:26 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoyFx-0005Kv-BN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:19:26 -0800
Received: by zproxy.gmail.com with SMTP id z3so76970nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 23:19:25 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

FB: Fix typoes in Kconfig.
    
Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index d6940ec..276601c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1370,7 +1370,7 @@ config FB_PXA
 
 	  This driver is also available as a module ( = code which can be
 	  inserted and removed from the running kernel whenever you want). The
-	  module will be called vfb. If you want to compile it as a module,
+	  module will be called pxafb. If you want to compile it as a module,
 	  say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say N.
@@ -1403,7 +1403,7 @@ config FB_W100
 
 	  This driver is also available as a module ( = code which can be
 	  inserted and removed from the running kernel whenever you want). The
-	  module will be called vfb. If you want to compile it as a module,
+	  module will be called w100fb. If you want to compile it as a module,
 	  say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say N.





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
