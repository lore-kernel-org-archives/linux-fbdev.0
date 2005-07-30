From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] vesafb: Document mtrr boot option usage
Date: Sat, 30 Jul 2005 09:55:47 +0800
Message-ID: <42EADE23.6010006@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DygZu-0007kx-9W
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 18:55:54 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DygZu-0004JR-8i
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 18:55:54 -0700
Received: by wproxy.gmail.com with SMTP id i20so683152wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 18:55:48 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Document mtrr boot option usage to Documentation/fb/vesafb.txt.

    From: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 vesafb.txt |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

--- a/Documentation/fb/vesafb.txt
+++ b/Documentation/fb/vesafb.txt
@@ -144,7 +144,21 @@ vgapal	Use the standard vga registers fo
 	This is the default.
 pmipal	Use the protected mode interface for palette changes.
 
-mtrr	setup memory type range registers for the vesafb framebuffer.
+mtrr:n	setup memory type range registers for the vesafb framebuffer
+	where n: 
+	      0 - disabled (equivalent to nomtrr)
+	      1 - uncachable
+	      2 - write-back
+	      3 - write-combining (default)
+	      4 - write-through
+
+	If you see the following in dmesg, choose the type that matches the
+	old one. In this example, use "mtrr:2". 
+...
+mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining 
+...
+      
+nomtrr  disable mtrr
 
 vremap:n
         remap 'n' MiB of video RAM. If 0 or not specified, remap memory


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
