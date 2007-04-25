From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 15/41] vt: Add documentation for new
	boot/sysfs options
Date: Wed, 25 Apr 2007 14:35:18 +0800
Message-ID: <462EF6A6.9010700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc74-00013v-2G for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:40:30 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc73-0002pB-OO
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:40:30 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:40:29 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jan Engelhardt <jengelh@linux01.gwdg.de>

Add description to Documentation/kernel-parameters.txt on new options
default_blue, default_grn, default_red, and default_utf8.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 Documentation/kernel-parameters.txt |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 6dcdca1..b3a3508 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -467,6 +467,30 @@ and is between 256 and 4096 characters. 
 			Format: <area>[,<node>]
 			See also Documentation/networking/decnet.txt.
 
+	default_blu=	[VT]
+			Format: <blue0>,<blue1>,<blue2>,...,<blue15>
+			Change the default blue palette of the console.
+			This is a 16-member array composed of values
+			ranging from 0-255.
+
+	default_grn=	[VT]
+			Format: <green0>,<green1>,<green2>,...,<green15>
+			Change the default green palette of the console.
+			This is a 16-member array composed of values
+			ranging from 0-255.
+
+	default_red=	[VT]
+			Format: <red0>,<red1>,<red2>,...,<red15>
+			Change the default red palette of the console.
+			This is a 16-member array composed of values
+			ranging from 0-255.
+
+	default_utf8=   [VT]
+			Format=<0|1>
+			Set system-wide default UTF-8 mode for all tty's.
+			Default is 0 and by setting to 1, it enables UTF-8
+			mode for all newly opened or allocated terminals.
+
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
