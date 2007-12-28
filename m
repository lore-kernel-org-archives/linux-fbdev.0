From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] sm501fb: clear framebuffer memory and
	palette
Date: Fri, 28 Dec 2007 14:55:52 +0900
Message-ID: <20071228055552.813.58357.sendpatchset@clockwork.opensource.se>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J88E0-0006SE-Qp for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 21:57:41 -0800
Received: from wa-out-1112.google.com ([209.85.146.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J88E0-0003SW-Kj
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 21:57:40 -0800
Received: by wa-out-1112.google.com with SMTP id k22so5675471waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 27 Dec 2007 21:57:40 -0800 (PST)
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
Cc: akpm@linux-foundation.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, syrjala@sci.fi, ben-linux@fluff.org

sm501fb: clear framebuffer memory and palette

Avoid displaying garbage on unused framebuffers. For most users a single
framebuffer is used together with fbcon. sm501fb supports two framebuffers
where one often is assigned to fbcon and the other one is left unused during
the boot.

The problem here is that framebuffers not in use by fbcon happen to display
garbage. This can easily be solved by making sure that framebuffer memory and
palette ram are cleared.

The problem can be observed by using looking at the panel output (fb1)
after booting the kernel with fbcon on crt (fb0). This is the default
configuration. It's also possible to watch the garbage on the crt framebuffer
by passing "fbcon=map:1" on the kernel cmdline. This will assign fbcon to
the panel (fb1) and leave the crt (fb0) unused.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies to 2.6.24-rc6.

 drivers/video/sm501fb.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- 0002/drivers/video/sm501fb.c
+++ work/drivers/video/sm501fb.c	2007-12-27 13:24:20.000000000 +0900
@@ -1264,6 +1264,7 @@ static int sm501fb_start(struct sm501fb_
 {
 	struct resource	*res;
 	struct device *dev;
+	int k;
 	int ret;
 
 	info->dev = dev = &pdev->dev;
@@ -1325,6 +1326,13 @@ static int sm501fb_start(struct sm501fb_
 
 	info->fbmem_len = (res->end - res->start)+1;
 
+	/* clear framebuffer memory - avoids garbage data on unused fb */
+	memset(info->fbmem, 0, info->fbmem_len);
+
+	/* clear palette ram - undefined at power on */
+	for (k = 0; k < (256 * 3); k++)
+		writel(0, info->regs + SM501_DC_PANEL_PALETTE + (k * 4));
+
 	/* enable display controller */
 	sm501_unit_power(dev->parent, SM501_GATE_DISPLAY, 1);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
