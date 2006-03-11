From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 18/18] radeonfb: Fix static array overrun
Date: Sat, 11 Mar 2006 09:53:00 +0800
Message-ID: <44122D7C.4040501@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHuq0-0003A5-IP
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 19:32:16 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtOG-0003lQ-8i
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:59:33 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:59:29 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

radeonfb_parse_monitor_layout() will produce an array overrun if passed
with a substring of length higher than 4 (ie, "XXXXX,YYYYYY").

Coverity Bug 494

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/radeon_monitor.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeon_monitor.c
index 7f9838d..98c05bc 100644
--- a/drivers/video/aty/radeon_monitor.c
+++ b/drivers/video/aty/radeon_monitor.c
@@ -396,6 +396,10 @@ static int __devinit radeon_parse_monito
 				s1[i] = *s;
 			i++;
 		}
+
+		if (i > 4)
+			i = 4;
+
 	} while (*s++);
 	if (second)
 		s2[i] = 0;



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
