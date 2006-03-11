From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] newportcon: sparse: Fix warnings in newport driver about
 non-static functions
Date: Sat, 11 Mar 2006 09:54:53 +0800
Message-ID: <44122DED.2010505@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtvc-0005wT-1l
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:34:00 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtOP-0003lQ-4U
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:59:42 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:59:38 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Ralf Baechle <ralf@linux-mips.org>

There are more sparse warnings but fixing those will require some more
work than I want to do without hardware for testing at hand.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/newport_con.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 762c7a5..e99fe30 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -149,7 +149,7 @@ static inline void newport_clear_lines(i
 	newport_clear_screen(0, ystart, 1280 + 63, yend, ci);
 }
 
-void newport_reset(void)
+static void newport_reset(void)
 {
 	unsigned short treg;
 	int i;
@@ -193,7 +193,7 @@ void newport_reset(void)
  * calculate the actual screen size by reading
  * the video timing out of the VC2
  */
-void newport_get_screensize(void)
+static void newport_get_screensize(void)
 {
 	int i, cols;
 	unsigned short ventry, treg;



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
