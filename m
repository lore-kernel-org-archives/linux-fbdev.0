From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH] cyber2000fb.c: Fix 16bpp mode
Date: Thu, 8 Nov 2007 09:22:00 +0100
Message-ID: <20071108082159.GB23626@deprecation.cyrius.com>
References: <000501c81e5e$c1334160$4399c420$@nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iq2ea-0006La-Ql for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Nov 2007 00:22:20 -0800
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Iq2eY-00025G-H4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Nov 2007 00:22:20 -0800
Content-Disposition: inline
In-Reply-To: <000501c81e5e$c1334160$4399c420$@nl>
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
Cc: Woody Suwalski <woody@suwalski.net>, Jan Rinze <janrinze@home.nl>

Jan Rinze noticed that 16bpp screen mode is not working on Netwinder:
"After some deduction it appeared that it was running in 24bpp instead
of 16bpp. Found the bug: a missing 'break' statement at the end of a
switch case.  After adding the break statement 16bpp works fine."

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Cc: Jan Rinze <janrinze@home.nl>
Cc: Woody Suwalski <woody@suwalski.net>

--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -874,6 +874,8 @@ static int cyber2000fb_set_par(struct fb_info *info)
 		default:
 			BUG();
 		}
+		break;
+
 	case 24:/* TRUECOLOUR, 16m */
 		hw.co_pixfmt		= CO_PIXFMT_24BPP;
 		hw.width		*= 3;

-- 
Martin Michlmayr
http://www.cyrius.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
