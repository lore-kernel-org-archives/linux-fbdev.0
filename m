From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Radeon framebuffer weirdness in -mm2
Date: Mon, 24 Jan 2005 15:00:37 +1100
Message-ID: <1106539238.5210.16.camel@gaston>
References: <20050120232122.GF3867@waste.org>
	 <20050120153921.11d7c4fa.akpm@osdl.org> <20050120234844.GF12076@waste.org>
	 <20050120160123.14f13ca6.akpm@osdl.org> <20050121035758.GH12076@waste.org>
	 <20050120200530.4d5871f9.akpm@osdl.org>
	 <20050120200711.4313dbcc.akpm@osdl.org>  <20050121060928.GI12076@waste.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsvPJ-0007rL-91
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 Jan 2005 20:00:53 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CsvPH-000765-Ow
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 Jan 2005 20:00:53 -0800
In-Reply-To: <20050121060928.GI12076@waste.org>
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
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2005-01-20 at 22:09 -0800, Matt Mackall wrote:

> 
> It's something in this batch. Which is good, as I'd be a bit
> disappointed if the "vt leakage" were somehow attributable to the fb
> layer. More bisection after dinner.

Regarding the radeonfb reboot problem, can you try this patch on
top of -mm2 ?

--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-01-24 12:19:09.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_base.c	2005-01-24 14:59:14.000000000 +1100
@@ -2435,13 +2435,16 @@
  
 	radeonfb_pm_exit(rinfo);
 
+#if 0
 	/* restore original state
 	 * 
-	 * Doesn't quite work yet, possibly because of the PPC hacking
-	 * I do on startup, disable for now. --BenH
+	 * Doesn't quite work yet, I suspect if we come from a legacy
+	 * VGA mode (or worse, text mode), we need to do some VGA black
+	 * magic here that I know nothing about. --BenH
 	 */
         radeon_write_mode (rinfo, &rinfo->init_state, 1);
- 
+ #endif
+
 	del_timer_sync(&rinfo->lvds_timer);
 
 #ifdef CONFIG_MTRR




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
