From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/13] intelfb: Documentation update
Date: Tue, 01 Aug 2006 07:28:07 +0800
Message-ID: <44CE9207.1030500@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hOP-00038j-EK for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:49 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hON-0004Mn-5Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:49 -0700
Received: by py-out-1112.google.com with SMTP id d42so802545pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:41:46 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: "Ph. Marek" <philipp.marek@bmlv.gv.at>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Ph. Marek <philipp.marek@bmlv.gv.at>

Correct sample boot line and add a remark on mode setting.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Documentation/fb/intelfb.txt |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/fb/intelfb.txt b/Documentation/fb/intelfb.txt
index c12d39a..0489b6b 100644
--- a/Documentation/fb/intelfb.txt
+++ b/Documentation/fb/intelfb.txt
@@ -85,12 +85,20 @@ Sample Usage
 
 In /etc/lilo.conf, add the line:
 
-append="video=intelfb:800x600-32@75,accel,hwcursor,vram=8"
+append="video=intelfb:mode=800x600-32@75,accel,hwcursor,vram=8"
 
 This will initialize the framebuffer to 800x600 at 32bpp and 75Hz. The
 framebuffer will use 8 MB of System RAM. hw acceleration of text and cursor
 will be enabled.
 
+Remarks
+-------
+
+If setting this parameter doesn't work (you stay in a 80x25 text-mode),
+you might need to set the "vga=<mode>" parameter too - see vesafb.txt
+in this directory.
+
+
 D.  Module options
 
 	The module parameters are essentially similar to the kernel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
