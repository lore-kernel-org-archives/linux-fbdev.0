From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/9] nvidiafb: Bring back generic ddc
	reading
Date: Sun, 25 Feb 2007 16:53:20 +0800
Message-ID: <1172393600.16179.31.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0346674400=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLFOR-00074H-DA for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:07 -0800
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLFOQ-0005hh-OB
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:07 -0800
Received: by py-out-1112.google.com with SMTP id a29so528629pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 01:10:06 -0800 (PST)
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


--===============0346674400==
Content-Type: multipart/alternative; boundary="=-77xyZT+lK906d5XGl7xZ"


--=-77xyZT+lK906d5XGl7xZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Make nvidiafb use fb_ddc_read().  This patch was submitted before but was
reverted due to problems in a non-x86 platform.  This includes a fix for that
where ddc reading is bypassed if there is no DDC bus (duh).

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_i2c.c |   44 ++---------------------------------------
 1 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index b858897..b91d404 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -70,8 +70,6 @@ static int nvidia_gpio_getscl(void *data
 	if (VGA_RD08(par->PCIO, 0x3d5) & 0x04)
 		val = 1;
 
-	val = VGA_RD08(par->PCIO, 0x3d5);
-
 	return val;
 }
 
@@ -159,51 +157,13 @@ void nvidia_delete_i2c_busses(struct nvi
 
 }
 
-static u8 *nvidia_do_probe_i2c_edid(struct nvidia_i2c_chan *chan)
-{
-	u8 start = 0x0;
-	struct i2c_msg msgs[] = {
-		{
-		 .addr = 0x50,
-		 .len = 1,
-		 .buf = &start,
-		 }, {
-		     .addr = 0x50,
-		     .flags = I2C_M_RD,
-		     .len = EDID_LENGTH,
-		     },
-	};
-	u8 *buf;
-
-	if (!chan->par)
-		return NULL;
-
-	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!buf) {
-		dev_warn(&chan->par->pci_dev->dev, "Out of memory!\n");
-		return NULL;
-	}
-	msgs[1].buf = buf;
-
-	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
-		return buf;
-	dev_dbg(&chan->par->pci_dev->dev, "Unable to read EDID block.\n");
-	kfree(buf);
-	return NULL;
-}
-
 int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
 {
 	struct nvidia_par *par = info->par;
 	u8 *edid = NULL;
-	int i;
 
-	for (i = 0; i < 3; i++) {
-		/* Do the real work */
-		edid = nvidia_do_probe_i2c_edid(&par->chan[conn - 1]);
-		if (edid)
-			break;
-	}
+	if (par->chan[conn - 1].par)
+		edid = fb_ddc_read(&par->chan[conn - 1].adapter);
 
 	if (!edid && conn == 1) {
 		/* try to get from firmware */


--=-77xyZT+lK906d5XGl7xZ
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
<!--+GtkHTML:<DATA class="ClueFlow" key="orig" value="0">-->Make nvidiafb use fb_ddc_read().&nbsp; This patch was submitted before but was
reverted due to problems in a non-x86 platform.&nbsp; This includes a fix for that
where ddc reading is bypassed if there is no DDC bus (duh).

Signed-off-by: Antonino Daplas &lt;<A HREF="mailto:adaplas@gmail.com">adaplas@gmail.com</A>&gt;
---

 drivers/video/nvidia/nv_i2c.c |&nbsp;&nbsp; 44 ++---------------------------------------
 1 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index b858897..b91d404 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -70,8 +70,6 @@ static int nvidia_gpio_getscl(void *data
 	if (VGA_RD08(par-&gt;PCIO, 0x3d5) &amp; 0x04)
 		val = 1;
 
-	val = VGA_RD08(par-&gt;PCIO, 0x3d5);
-
 	return val;
 }
 
@@ -159,51 +157,13 @@ void nvidia_delete_i2c_busses(struct nvi
 
 }
 
-static u8 *nvidia_do_probe_i2c_edid(struct nvidia_i2c_chan *chan)
-{
-	u8 start = 0x0;
-	struct i2c_msg msgs[] = {
-		{
-		 .addr = 0x50,
-		 .len = 1,
-		 .buf = &amp;start,
-		 }, {
-		&nbsp;&nbsp;&nbsp;&nbsp; .addr = 0x50,
-		&nbsp;&nbsp;&nbsp;&nbsp; .flags = I2C_M_RD,
-		&nbsp;&nbsp;&nbsp;&nbsp; .len = EDID_LENGTH,
-		&nbsp;&nbsp;&nbsp;&nbsp; },
-	};
-	u8 *buf;
-
-	if (!chan-&gt;par)
-		return NULL;
-
-	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!buf) {
-		dev_warn(&amp;chan-&gt;par-&gt;pci_dev-&gt;dev, &quot;Out of memory!\n&quot;);
-		return NULL;
-	}
-	msgs[1].buf = buf;
-
-	if (i2c_transfer(&amp;chan-&gt;adapter, msgs, 2) == 2)
-		return buf;
-	dev_dbg(&amp;chan-&gt;par-&gt;pci_dev-&gt;dev, &quot;Unable to read EDID block.\n&quot;);
-	kfree(buf);
-	return NULL;
-}
-
 int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
 {
 	struct nvidia_par *par = info-&gt;par;
 	u8 *edid = NULL;
-	int i;
 
-	for (i = 0; i &lt; 3; i++) {
-		/* Do the real work */
-		edid = nvidia_do_probe_i2c_edid(&amp;par-&gt;chan[conn - 1]);
-		if (edid)
-			break;
-	}
+	if (par-&gt;chan[conn - 1].par)
+		edid = fb_ddc_read(&amp;par-&gt;chan[conn - 1].adapter);
 
 	if (!edid &amp;&amp; conn == 1) {
 		/* try to get from firmware */

</PRE>
</BODY>
</HTML>

--=-77xyZT+lK906d5XGl7xZ--



--===============0346674400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0346674400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0346674400==--
