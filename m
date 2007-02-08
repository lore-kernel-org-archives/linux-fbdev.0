From: James Simmons <jsimmons@infradead.org>
Subject: Re: Fw: [Bugme-new] [Bug 7966] New: atyfb
 (mach64_ct) framebuffer hangs at boot time
Date: Thu, 8 Feb 2007 18:47:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702081847190.7686@pentafluge.infradead.org>
References: <20070208103343.b93f27d1.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFEJg-0001ex-5s for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 10:48:21 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HFEJb-0005Bx-Bs
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 10:48:20 -0800
In-Reply-To: <20070208103343.b93f27d1.akpm@linux-foundation.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ville Syrjala <syrjala@sci.fi>, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>, rootshell@web.de


From what I gather it is a compiler bug.

On Thu, 8 Feb 2007, Andrew Morton wrote:

> 
> 
> Begin forwarded message:
> 
> Date: Thu, 8 Feb 2007 06:59:27 -0800
> From: bugme-daemon@bugzilla.kernel.org
> To: bugme-new@lists.osdl.org
> Subject: [Bugme-new] [Bug 7966] New: atyfb (mach64_ct) framebuffer hangs at boot time
> 
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7966
> 
>            Summary: atyfb (mach64_ct) framebuffer hangs at boot time
>     Kernel Version: 2.6.20 (2.6.19.2)
>             Status: NEW
>           Severity: normal
>              Owner: jsimmons@infradead.org
>          Submitter: rootshell@web.de
> 
> 
> Distribution: OpenSuse 10.2
> 
> Hardware Environment:
>  Machine: FujitsuSiemens Primergy TX150
>  Board: ServerWorks D1501 
>  Chipset: Broadcom CSB6
>  Graphic: ati 3d rage xl (mach64 gr) (onBoard) 
> 
> Problem Description:
> System hangs at boot time, when it tries to switch to frame buffer console. Last
> messages are:
> atyfb: using auxiliary register aperture
> atyfb: 3D RAGE XL (Mach64 GR, PCI-33) [0x4752 rev 0x27]
> atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
> atyfb: BIOS frequency table:
> atyfb: PCLK_min_freq 984, PCLK_max_freq 23600, ref_freq 2950, ref_divider 64
> atyfb: MCLK_pwd 4200, MCLK_max_freq 8300, XCLK_max_freq 6250, SCLK_freq 0
> atyfb: 8M SDRAM (2:1) (32-bit), 29.498928 MHz XTAL, 236 MHz PLL, 83 Mhz MCLK, 62
> MHz XCLK
> atyfb: atyfb(aty_init_pll_ct): mckl_fb_mult=4, xclk_post_div=1
> atyfb: atyfb(aty_init_pll_ct): pllmclk=247 MHz, xclk=61 MHz
> atyfb: atyfb(aty_init_pll_ct): use sclk, pllsclk=165 MHz, sclk=mclk=82 MHz
> 
> Work around:
> After enabling and adding some debugging outputs it suddenly works. After
> disabling one to one the debugging printk I found this small patch for me. But I
> don't understand why it works.
> 
> mach64_ct.c.patch:
> --- linux-2.6.20/drivers/video/aty/mach64_ct.c.orig     2007-02-04
> 19:44:54.000000000 +0100
> +++ linux-2.6.20/drivers/video/aty/mach64_ct.c  2007-02-07 14:07:09.000000000 +0100
> @@ -29,6 +29,8 @@ u8 aty_ld_pll_ct(int offset, const struc
>  
>  static void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par)
>  {
> +       printk( " atyfb(%s): \n", __FUNCTION__ );
> +
>         /* write addr byte */
>         aty_st_8(CLOCK_CNTL_ADDR, ((offset << 2) & PLL_ADDR) | PLL_WR_EN, par);
>         /* write the register value */
> 
> misc:
> Maybe it's at the end the same bug as http://bugme.osdl.org/show_bug.cgi?id=7176
> 
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
