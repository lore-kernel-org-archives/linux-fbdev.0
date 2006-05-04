From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/9] fbdev: Coverity Bug 85
Date: Thu, 04 May 2006 20:34:51 +0800
Message-ID: <4459F4EB.7070101@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fbd61-0007rz-Bj
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:38:17 -0700
Received: from wx-out-0102.google.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fbd61-0002Pa-7y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:38:17 -0700
Received: by wx-out-0102.google.com with SMTP id h26so310349wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 May 2006 05:38:16 -0700 (PDT)
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

 drivers/video/cfbimgblt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 8ba6152..ad8a89b 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -230,6 +230,7 @@ static inline void fast_imageblit(const 
 		tab = cfb_tab16;
 		break;
 	case 32:
+	default:
 		tab = cfb_tab32;
 		break;
 	}



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
