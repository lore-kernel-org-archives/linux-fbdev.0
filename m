From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/9] neofb: Fill transp->msb_right with
	the correct value
Date: Sun, 25 Feb 2007 16:56:41 +0800
Message-ID: <1172393801.16179.36.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1676020062=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLFOl-00074j-BL for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:27 -0800
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLFOl-0005hh-0D
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:27 -0800
Received: by py-out-1112.google.com with SMTP id a29so528629pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 01:10:26 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--===============1676020062==
Content-Type: multipart/alternative; boundary="=-/onPZR0VmXE+NSmDtN3b"


--=-/onPZR0VmXE+NSmDtN3b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Fill transp->msb_right with the correct value.  fbcon ignores this, but user
apps may not.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/neofb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 395cced..bd30aba 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -665,6 +665,7 @@ neofb_check_var(struct fb_var_screeninfo
 	var->red.msb_right = 0;
 	var->green.msb_right = 0;
 	var->blue.msb_right = 0;
+	var->transp.msb_right = 0;
 
 	switch (var->bits_per_pixel) {
 	case 8:		/* PSEUDOCOLOUR, 256 */


--=-/onPZR0VmXE+NSmDtN3b
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.2">
</HEAD>
<BODY>
<PRE>
<!--+GtkHTML:<DATA class="ClueFlow" key="orig" value="0">-->Fill transp-&gt;msb_right with the correct value.&nbsp; fbcon ignores this, but user
apps may not.

Signed-off-by: Antonino Daplas &lt;<A HREF="mailto:adaplas@gmail.com">adaplas@gmail.com</A>&gt;
---

 drivers/video/neofb.c |&nbsp;&nbsp;&nbsp; 1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 395cced..bd30aba 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -665,6 +665,7 @@ neofb_check_var(struct fb_var_screeninfo
 	var-&gt;red.msb_right = 0;
 	var-&gt;green.msb_right = 0;
 	var-&gt;blue.msb_right = 0;
+	var-&gt;transp.msb_right = 0;
 
 	switch (var-&gt;bits_per_pixel) {
 	case 8:		/* PSEUDOCOLOUR, 256 */

</PRE>
</BODY>
</HTML>

--=-/onPZR0VmXE+NSmDtN3b--



--===============1676020062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1676020062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1676020062==--
