From: Zachary Smith <plinius@comcast.net>
Subject: Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Thu, 14 Oct 2004 12:59:22 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <416EDA9A.9010809@comcast.net>
References: <416E6ADC.3007.294DF20D@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIBhG-0006vS-5Q
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Oct 2004 12:55:34 -0700
Received: from rwcrmhc12.comcast.net ([216.148.227.85])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CIBhE-0006yD-8s
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Oct 2004 12:55:34 -0700
In-Reply-To: <416E6ADC.3007.294DF20D@localhost>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: penguinppc-team@lists.penguinppc.org


This is a problem of the videocard manufacturers' making which,
in the spirit of good engineering, they should fix before requiring
a downstream kludge.

Specifically, ATI, rather than advocate x86 emulation in order
to use their BIOS on non-x86 machines, should put a pseudocode BIOS
(something like java bytecode) in the ROM instead, including
an interpreter of course, perhaps gutting the x86 BIOS calls to use the
pseudocode routines so there is only one version to maintain.
And provide an entrypoint for non-x86 CPUs.

Zack


Kendall Bennett wrote:
> Hello All,
> 
> I am writing this email to guage the interest in having code contributed 
> to the main stream Linux kernel that would support the user of a generic, 
> full featured VESA framebuffer driver that works on any CPU architecture 
> along with a generic Video card BOOT or POST mechanism.
> 
> We have been working on a project under contract to ATI that involves 
> porting a version of our SNAPBoot BIOS emulator solution to the PowerPC 
> Linux kernel. The SNAPBoot code supports initialising a graphics card 
> using an x86 BIOS image on any platform (currently tesed on x86, x86-64 
> and PowerPC). Initially SNAPBoot was developed to work across multiple 
> operating systems and CPU architectures from user space, but the desire 
> to use it to initialise the graphics card on embedded PowerPC kernels 
> prompted us to port a version of it for use within the Linux kernel. The 
> version we have ported for use in the kernel can be used to initialise 
> the graphics card for use with any accelerated framebuffer console 
> driver, such as the radeonfb driver which we are currently using it with.
> 
> Note that the SNAPBoot code uses the x86emu BIOS emulator project as the 
> core CPU emulation technology, and project we have been actively involved 
> with for many years since the licensing on the project was changed to 
> MIT/BSD style licensing and incorporated into the XFree86 project. We 
> have built code on top of x86emu to provide generic support for 
> initialising graphics cards on multiple platforms as well as supporting 
> initialisation of modern NonVGA graphics cards (like the ATI Radeon 
> family) without needing access to real VGA resources such as VGA I/O 
> ports and physical memory at 0xA0000-0xBFFFF.
> 
> More importantly we have used SNAPBoot to port our generic VESA SNAP 
> display driver to work on multiple operating systems and platforms, 
> including both x86-64 and PowerPC platforms. Using this driver you can 
> use any graphics card in the machine and it will support all the features 
> provided by the graphics cards VESA BIOS, including support for refresh 
> rate control on cards that support VBE 3.0 services. We have been 
> actively testing both the SNAPBoot capability and the BIOS emulator on 
> many platforms and graphics cards, and the latest version work flawlessly 
> on just about every graphics card we have tested.
> 
> What this means is that it should be possible to build a new version of 
> the VESA framebuffer console driver for the Linux kernel that will have 
> these important features:
> 
> 1. Be able to switch display modes on the fly, supporting all modes 
> enumerated by the Video BIOS.
> 
> 2. Be able to support refresh rate control on graphics cards that support 
> the VBE 3.0 services.
> 
> 3. Be able to support 8-bit and 32-bit display modes on any graphics card 
> on big endian machines (16-bit is not possible unless software rendering 
> code is written to enable endian swapping in software, which may be 
> possible).
> 
> So what we would like to find out is how much interest there might be in 
> both an updated VESA framebuffer console driver as well as the code for 
> the Video card BOOT process being contributed to the maintstream kernel. 
> If there is interest, we would start out by first contributing the core 
> emulator and Video BOOT code, and then work on building a better VESA 
> framebuffer console driver. 
> 
> So what do you guys think? 
> 
> Regards,
> 
> ---
> Kendall Bennett
> Chief Executive Officer
> SciTech Software, Inc.
> Phone: (530) 894 8400
> http://www.scitechsoft.com
> 
> ~ SciTech SNAP - The future of device driver technology! ~
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
