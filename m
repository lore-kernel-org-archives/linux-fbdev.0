From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/9] fbdev: Coverity Bug 90
Date: Thu, 04 May 2006 20:35:43 +0800
Message-ID: <4459F51F.7000009@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fbd65-0007sA-K2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:38:21 -0700
Received: from wx-out-0102.google.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fbd65-0002Pa-G7
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:38:21 -0700
Received: by wx-out-0102.google.com with SMTP id h26so310349wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 May 2006 05:38:21 -0700 (PDT)
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

It's a false positive, but let's suppress it anyway.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/modedb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 1aa36d3..7e539b6 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -791,8 +791,9 @@ struct fb_videomode *fb_find_best_mode(s
 			if (diff > d) {
 				diff = d;
 				best = mode;
-			} else if (diff == d && mode->refresh > best->refresh)
-			    best = mode;
+			} else if (diff == d && best &&
+				   mode->refresh > best->refresh)
+				best = mode;
 		}
 	}
 	return best;



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
