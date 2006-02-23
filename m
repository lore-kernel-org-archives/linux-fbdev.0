From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/5] gbefb: Set default of FB_GBE_MEM to 4 MB
Date: Thu, 23 Feb 2006 19:57:52 +0800
Message-ID: <43FDA340.2050503@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCOik-00010G-E4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 14:13:58 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCOif-0002OH-V3
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 14:13:58 -0800
Received: by pproxy.gmail.com with SMTP id i75so194893pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Feb 2006 14:13:52 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Martin Michlmayr <tbm@cyrius.com>

From: Martin Michlmayr <tbm@cyrius.com>

Allocating more than 4 MB memory for the GBE (SGI O2) framebuffer
completely breakfs gbefb support at the moment.  According to comments
on #mipslinux, more than 4 MB has never worked correctly in Linux.
Therefore, the default should be 4 MB.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4da95d8..e31390a 100644
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



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
