From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: Computer with 1GB and radeonfb
Date: Sat, 31 May 2003 07:42:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030531054213.GA7494@middle.of.nowhere>
References: <elmo105432563416005480015305@arbeitspferd>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtpzilla5.xs4all.nl ([194.109.127.141])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Lz8q-0006vA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 30 May 2003 22:42:56 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtpzilla5.xs4all.nl (8.12.9/8.12.9) with ESMTP id h4V5gb2B049152
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 31 May 2003 07:42:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <elmo105432563416005480015305@arbeitspferd>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Sieper <msi@ngi-box.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Martin Sieper <msi@ngi-box.de>
Date: Fri, May 30, 2003 at 10:13:54PM +0200
> Hello developers,
> 
> I have a P4 computer with 1GB of RAM and a Radeon 9100 and I'm
> using linux 2.4.20.
> 
> I had try the vesafb but it's failed. OK I've found a
> patch for big memory on this list  and now vasafb works fine.
> 
> The radeonfb doesn't work. OK I've found these patch
> radeonfb-041103-2.4.20.diff also on this list but the
> radeonfb doesn't work:
> 
> May 30 13:22:22 arbeitspferd kernel: radeonfb_pci_register BEGIN
> May 30 13:22:22 arbeitspferd kernel: radeonfb: ref_clk=2700, ref_div=12, xclk=20000 from BIOS
> May 30 13:22:22 arbeitspferd kernel: radeonfb: probed DDR SGRAM 131072k videoram
> May 30 13:22:22 arbeitspferd kernel: BIOS 4 scratch = 2000002
> May 30 13:22:22 arbeitspferd kernel: FP_GEN_CNTL: 0, FP2_GEN_CNTL: 8
> May 30 13:22:22 arbeitspferd kernel: TMDS_TRANSMITTER_CNTL: 10000082, TMDS_CNTL: 1000000, LVDS_GEN_CNTL: 0
> May 30 13:22:22 arbeitspferd kernel: DAC_CNTL: ff604002, DAC_CNTL2: 0, CRTC_GEN_CNTL: 2000200
> May 30 13:22:22 arbeitspferd kernel: radeonfb: cannot map FB
> 
> I think it's also a big memory problem like the vesafb.
> I'm not a kernel hacker, can someone help me please?
> 
There were two patches floating around - one to limit the amount of
reserved memory, and one to increase the amount of kernel memory you can
reserve.

The first one probably only affects the vesafb-driver. You could adapt
it to the radeonfb-driver, just search for the correct lines in the
radeonfb source and change them like the patch changes them.
There's nothing like booting a kernel whose sources you've changed
yourself to make you feel the power of open source :-)

The second one should also work with the radeonfb driver. It looks
something like this:

====================================================================
This means with "mem=512M", you will probably have about 500M of
vmalloc space, which is more than enough to ioremap the framebuffer.

With the full 1 GB of memory, you might think that there would be no
vmalloc space available at all.  However, <asm/page.h> defines a
constant VMALLOC_RESERVE (which by default is 128 MB), and the kernel
makes sure that there is at least this much vmalloc space available.
However, by the time you load the module, at least some of this space
has been consumed, so the ioremap fails.  (If nothing else uses
vmalloc space, just loading a module will call vmalloc() to get space
for the module to be loaded into!)

One not very good way for you to proceed would be to change the
definition of VMALLOC_RESERVE from (128 << 20) to something like (256
<< 20), which should leave the driver room to ioremap the framebuffer.
This is a little ugly.  However, I don't see why a framebuffer driver
would need to ioremap _all_ of a video card's memory -- so a better
solution would be to fix the driver to only ioremap what it needs to.
=====================================================================

HTH,
Jurriaan
-- 
REAL LIFE MANAGEMENT 'DILBERT QUOTATIONS':
4: This project is so important, we can't let things that are more
   important interfere with it. (Advertising/Marketing manager, United
   Parcel Service)
Debian (Unstable) GNU/Linux 2.5.70 4112 bogomips load av: 0.38 0.13 0.11


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
