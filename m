From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: 2.6.19-rc5: Geode GX frame buffer takes 13
 seconds to initialize
Date: Mon, 20 Nov 2006 17:34:47 -0700
Message-ID: <20061121003447.GD5160@cosmic.amd.com>
References: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
	<Pine.LNX.4.64.0611201633240.17639@pentafluge.infradead.org>
	<808c8e9d0611201447y6e053e89m9a5333af91a235aa@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=IJpNTDwzlM2Ie8A6
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmJXS-0008WR-DP for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 16:31:02 -0800
Received: from outbound-fra.frontbridge.com ([62.209.45.174]
	helo=outbound3-fra-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmJXR-00073P-7M
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 16:31:02 -0800
In-Reply-To: <808c8e9d0611201447y6e053e89m9a5333af91a235aa@mail.gmail.com>
Content-Disposition: inline
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
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 20/11/06 16:47 -0600, Ben Gardner wrote:
> I tracked it down to the memset_io() call in gxfb_core.c that clears
> all the video memory.
> 
> It take 12.5 seconds to memset() a mere 16,384 Kibyte of memory.
> That seems a bit strange to me.
> 
> What's stranger is the time it takes to clear the fb memory:
> The first 4 MB clear in 0.01 s each.
> The last 12MB are SLOW.
 
Hmmm - thats interesting.  One thing about the current gxfb driver is that
it assumes a 16Mb framebuffer, which may or may not be what you have, since 
the amount of memory that is assigned to the graphics engine is configurable.

Its possible that you only have 4Mb of memory assigned to the graphics
engine, and that memsetting further is out being subtractively decoded on
the PCI bus and going nowhere slowly.

The attached patch queries the BIOS for the true amount of memory that
is configured.  The patch has been kicking around in the Geode git tree and 
-mm for a while so it should be sane.  Give it a try and see if it helps.

Jordan

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=patch_011
Content-Transfer-Encoding: 7bit

Author: Jordan Crouse <jordan.crouse@amd.com>
Date:   Mon May 15 20:54:51 2006 -0600

    FB: Get the Geode GX frambuffer size from the BIOS
    
    Use the Geode GX BIOS virtual registers to get the actual size of the
    framebuffer.
    
    Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>

diff --git a/drivers/video/geode/display_gx.c b/drivers/video/geode/display_gx.c
index 825c340..0245169 100644
--- a/drivers/video/geode/display_gx.c
+++ b/drivers/video/geode/display_gx.c
@@ -21,10 +21,19 @@ #include <asm/delay.h>
 #include "geodefb.h"
 #include "display_gx.h"
 
-int gx_frame_buffer_size(void)
+unsigned int gx_frame_buffer_size(void)
 {
-	/* Assuming 16 MiB. */
-	return 16*1024*1024;
+	unsigned int val;
+
+	/* FB size is reported by a virtual register */
+	/* Virtual register class = 0x02 */
+	/* VG_MEM_SIZE(512Kb units) = 0x00 */
+
+	outw(0xFC53, 0xAC1C);
+	outw(0x0200, 0xAC1C);
+
+	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
+	return (val << 19);
 }
 
 int gx_line_delta(int xres, int bpp)
diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
index 86c6233..41e79f4 100644
--- a/drivers/video/geode/display_gx.h
+++ b/drivers/video/geode/display_gx.h
@@ -11,7 +11,7 @@
 #ifndef __DISPLAY_GX_H__
 #define __DISPLAY_GX_H__
 
-int gx_frame_buffer_size(void);
+unsigned int gx_frame_buffer_size(void);
 int gx_line_delta(int xres, int bpp);
 
 extern struct geode_dc_ops gx_dc_ops;


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--IJpNTDwzlM2Ie8A6--
