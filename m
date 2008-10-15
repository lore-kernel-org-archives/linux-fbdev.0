From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 11765] New: Intelfb + HW
 text accel on Acer Extensa 5220
Date: Wed, 15 Oct 2008 10:14:09 -0700
Message-ID: <20081015101409.51463c54.akpm@linux-foundation.org>
References: <bug-11765-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1Kq9zT-0006N6-HU
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Oct 2008 17:16:55 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Kq9wt-0004uZ-4I
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Oct 2008 17:16:55 +0000
In-Reply-To: <bug-11765-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: hanzelpeter@gmail.com, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed, 15 Oct 2008 04:56:27 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11765
> 
>            Summary: Intelfb + HW text accel on Acer Extensa 5220
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.27
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: hanzelpeter@gmail.com
> 
> 
> Latest working kernel version: unknown
> Earliest failing kernel version: 2.6.25.4
> Distribution: LFS 6.3
> Hardware Environment: Acer Extensa 5220. Gr. card Intel 965GM X3100
> Software Environment: intelfb compiled in kernel
> Problem Description:
> 
> Steps to reproduce: boot with acceleration enabled.
> 
> I cannot get working text HW accel in intelfb framebuffer.
> Framebuffer without accel is working good.
> 
> I've got this is dmesg:
> 
> Kernel command line: root=/dev/sda6 vga=0x362 video=intelfb:mode=1280x800 
> 
> [drm] Initialized i915 1.6.0 20060119 on minor 0
> intelfb: intelfb_init
> intelfb: Framebuffer driver for Intel(R)
> 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets
> intelfb: Version 0.9.5
> intelfb: intelfb_setup
> intelfb: options: mode=1280x800
> intelfb: intelfb_pci_register
> intelfb: fb aperture: 0xd0000000/0x10000000, MMIO region: 0xfc000000/0x100000
> intelfb: 00:02.0: Intel(R) 965GM, aperture size 256MB, stolen memory 7932kB
> intelfb: fb: 0xd0000000(+ 0x0)/0x7bf000 (0xf8c00000)
> intelfb: MMIO: 0xfc000000/0x80000 (0xfc400000)
> intelfb: ring buffer: 0xd3001000/0x10000 (0xfbc01000)
> intelfb: HW cursor: 0x0/0x0 (0x00000000) (offset 0x0) (phys 0x0)
> intelfb: options: vram = 4, accel = 1, hwcursor = 0, fixed = 0, noinit = 0
> intelfb: options: mode = "1280x800"
> intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
> intelfb: get_initial_mode
> intelfb: Initial info: FB is 0xd0000000/0x770000 (7616 kByte)
> intelfb: Initial info: mode is 1280x800-32 (5120)
> intelfb: update_dinfo
> intelfb: intelfb_var_to_depth: bpp: 32, green.length is 8
> intelfb: intelfb_set_fbinfo
> intelfb: intelfb_init_var
> intelfb: Initial video mode is 1280x800-32@60.
> intelfb: Initial video mode is from 5.
> intelfb: update_dinfo
> intelfb: intelfb_var_to_depth: bpp: 32, green.length is 8
> intelfb: I2C bus CRTDDC_A registered.
> intelfb: I2C bus SDVOCTRL_E registered.
> intelfb: intelfbhw_print_hw_state
> hw state dump start
>         VGA0_DIVISOR:           0x00031108
>         VGA1_DIVISOR:           0x00031406
>         VGAPD:                  0x00020002
>         VGA0: (m1, m2, n, p1, p2) = (17, 8, 3, 2, 0)
>         VGA0: clock is 100800
>         VGA1: (m1, m2, n, p1, p2) = (20, 6, 3, 2, 0)
>         VGA1: clock is 113280
>         DPLL_A:                 0x04800c00
>         DPLL_B:                 0x98046a00
>         FPA0:                   0x00031108
>         FPA1:                   0x00031108
>         FPB0:                   0x00021309
>         FPB1:                   0x00031108
>         PLLA0: (m1, m2, n, p1, p2) = (17, 8, 3, 8, 0)
>         PLLA0: clock is 25200
>         PLLA1: (m1, m2, n, p1, p2) = (17, 8, 3, 8, 0)
>         PLLA1: clock is 25200
>         HTOTAL_A:               0x031f027f
>         HBLANK_A:               0x03170287
>         HSYNC_A:                0x02ef028f
>         VTOTAL_A:               0x020c01df
>         VBLANK_A:               0x020401e7
>         VSYNC_A:                0x01eb01e9
>         SRC_SIZE_A:             0x027f01df
>         BCLRPAT_A:              0x00000000
>         HTOTAL_B:               0x057f04ff
>         HBLANK_B:               0x057f04ff
>         HSYNC_B:                0x053f050f
>         VTOTAL_B:               0x032f031f
>         VBLANK_B:               0x032f031f
>         VSYNC_B:                0x03230320
>         SRC_SIZE_B:             0x04ff031f
>         BCLRPAT_B:              0x00000000
>         ADPA:                   0x40008c18
>         DVOA:                   0x00000000
>         DVOB:                   0x00080018
>         DVOC:                   0x00080018
>         DVOA_SRCDIM:            0x00000000
>         DVOB_SRCDIM:            0x00000000
>         DVOC_SRCDIM:            0x00000000
>         LVDS:                   0xc2308300
>         PIPEACONF:              0x00000000
>         PIPEBCONF:              0xc0000000
>         DISPARB:                0x00001d9c
>         CURSOR_A_CONTROL:       0x00000000
>         CURSOR_B_CONTROL:       0x00000000
>         CURSOR_A_BASEADDR:      0x00000000
>         CURSOR_B_BASEADDR:      0x00000000
>         CURSOR_A_PALETTE:       0x00000000, 0x00000000, 0x00000000, 0x00000000
>         CURSOR_B_PALETTE:       0x00000000, 0x00000000, 0x00000000, 0x00000000
>         CURSOR_SIZE:            0x00000000
>         DSPACNTR:               0x00000000
>         DSPBCNTR:               0x99000000
>         DSPABASE:               0x00000000
>         DSPBBASE:               0x00000000
>         DSPASTRIDE:             0x00000000
>         DSPBSTRIDE:             0x00001400
>         VGACNTRL:               0xa2c4008e
>         ADD_ID:                 0x00000000
>         SWF00                   0x00000000
>         SWF01                   0x00000001
>         SWF02                   0x00000000
>         SWF03                   0x00000000
>         SWF04                   0x00000000
>         SWF05                   0x00000000
>         SWF06                   0x00000000
>         SWF10                   0x01000800
>         SWF11                   0x00001c00
>         SWF12                   0x00000000
>         SWF13                   0x62620000
>         SWF14                   0xc0000000
>         SWF15                   0x0000020b
>         SWF16                   0x00000000
>         SWF30                   0x00000000
>         SWF31                   0x00000000
>         SWF32                   0x00000000
>         FENCE0                  0x00000000
>         FENCE1                  0x00000000
>         FENCE2                  0x00000000
>         FENCE3                  0x00000000
>         FENCE4                  0x00000000
>         FENCE5                  0x00000000
>         FENCE6                  0x00000000
>         FENCE7                  0x00000000
>         INSTPM                  0x00000000
>         MEM_MODE                0x00000000
>         FW_BLC_0                0x00000000
>         FW_BLC_1                0x00000000
>         HWSTAM                  0xdfff
>         IER                     0x0000
>         IIR                     0x0000
>         IMR                     0xdfff
> hw state dump end
> intelfb: Changing the video mode is not supported.
> Switched to NOHz mode on CPU #0
> intelfb: ring buffer : space: 65400 wanted 65472
> intelfb: lockup - turning off hardware acceleration
> Console: switching to colour frame buffer device 160x50
> Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> brd: module loaded
> loop: module loaded
> acer-wmi: Acer Laptop ACPI-WMI Extras 
> 
> Searched forums, wrote mails, but no response.
> I am loosing ideas what to do.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
