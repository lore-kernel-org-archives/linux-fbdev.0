From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Thu, 14 Apr 2005 13:51:11 +0800
Message-ID: <200504141351.11605.adaplas@hotpop.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com> <20050324203118.345c6004.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLxGw-0000wP-RQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Apr 2005 22:52:14 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DLxGv-0004Ml-5X
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Apr 2005 22:52:14 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DA21D106D9ED
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Apr 2005 05:52:00 +0000 (UTC)
In-Reply-To: <20050324203118.345c6004.akpm@osdl.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>
Cc: khali@linux-fr.org, linux-fbdev-devel@lists.sourceforge.net

On Friday 25 March 2005 12:31, Andrew Morton wrote:
> (Added the mailing list - trust that's ok)
>
> Miles Lane <miles.lane@gmail.com> wrote:
> > Kernel command line: BOOT_IMAGE=Linux ro root=306 video=nvidiafb
> > init=/etc/init lang=us apm=power-off nomce
> > nvidiafb: nVidia device/chipset 10DE0312
> > nvidiafb: nVidia Corporation NV31 [GeForce FX 5600]
> > nvidiafb: CRTC0 found
> > nvidiafb: CRTC1 not found
> > nvidiafb: EDID found from BUS1
> > nvidiafb: CRTC 0 appears to have a CRT attached
> > nvidiafb: Using CRT on CRTC 0
> >
> > >> I am wondering whether the following two lines point to the problem.
> >
> > allocation failed: out of vmalloc space - use vmalloc=<size> to increase
> > size. nvidiafb: cannot ioremap FB base
>

Sorry for answering very, very late. I have been busy for the past 2 weeks
and still am busy.

I'm attaching a patch that adds a vram option that allows the user to
specify the amount of video ram to remap.  This is useful for cards
with huge amounts of vram.

You can use, for example:

video=nvidiafb:vram:8

to remap only 8 MiB of video RAM.

(Or perhaps, we can always limit the amount to not more than 128 MiB? I'm 
attaching an incremental patch in another mail, if people want this).

As for the i2c problem, this is probably due to a misplaced label in the
failure path, and the reason why I had a difficult time reproducing this bug.
When nvidiafb failed with the ioremap, it skipped deletion of the i2c busses
causing the crash whenever the bus created by nvidiafb is read.  The fix is
also included in this patch.

So, can you test this patch and see if it helps?

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nvidia.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-04-14 12:44:06 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-04-14 13:33:38 +08:00
@@ -408,6 +408,7 @@
 static int noaccel __devinitdata = 0;
 static int noscale __devinitdata = 0;
 static int paneltweak __devinitdata = 0;
+static int vram __devinitdata = 0;
 #ifdef CONFIG_MTRR
 static int nomtrr __devinitdata = 0;
 #endif
@@ -1507,6 +1508,10 @@
 
 	par->FbAddress = nvidiafb_fix.smem_start;
 	par->FbMapSize = par->RamAmountKBytes * 1024;
+
+	if (vram && vram * 1024 * 1024 < par->FbMapSize)
+	    par->FbMapSize = vram * 1024 * 1024;
+
 	par->FbUsableSize = par->FbMapSize - (128 * 1024);
 	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :
 	    16 * 1024;
@@ -1566,9 +1571,9 @@
 
       err_out_iounmap_fb:
 	iounmap(info->screen_base);
+      err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
-      err_out_free_base1:
 	iounmap(par->REGS);
       err_out_free_base0:
 	pci_release_regions(pd);
@@ -1645,6 +1650,8 @@
 			noscale = 1;
 		} else if (!strncmp(this_opt, "paneltweak:", 11)) {
 			paneltweak = simple_strtoul(this_opt+11, NULL, 0);
+		} else if (!strncmp(this_opt, "vram:", 5)) {
+			vram = simple_strtoul(this_opt+5, NULL, 0);
 #ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
@@ -1716,6 +1723,10 @@
 MODULE_PARM_DESC(forceCRTC,
 		 "Forces usage of a particular CRTC in case autodetection "
 		 "fails. (0 or 1) (default=autodetect)");
+module_param(vram, int, 0);
+MODULE_PARM_DESC(vram,
+		 "amount of framebuffer memory to remap in MiB"
+		 "(default=0 - remap entire memory)");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) "





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
