From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: intelfb updates
Date: Tue, 30 May 2006 14:05:31 -0400
Message-ID: <509BC7A5-C965-47C5-BB5F-416EC23D508A@cecropia.com>
References: <21d7e9970605270158l1ee8551cw7cc8910378cc43de@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fl8aB-0004gE-H3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 11:04:43 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fl8aB-0001oR-F4
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 11:04:43 -0700
Received: from mail5.sea5.speakeasy.net ([69.17.117.7])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Fl8aB-0004s0-0h
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 11:04:43 -0700
In-Reply-To: <21d7e9970605270158l1ee8551cw7cc8910378cc43de@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Dave Airlie <airlied@skynet.ie>, Eric Hustvedt <ehustvedt@cecropia.com>

Hi Dave --

I pulled down the changes in your git tree, and when I apply them, I  
get a kernel panic:

> Linux agpgart interface v0.101 (c) Dave Jones
> agpgart: Detected an Intel 945G Chipset.
> agpgart: Detected 7932K stolen memory.
> agpgart: AGP aperture is 256M @ 0x20000000
> intelfb: intelfb_init
> intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/ 
> 915G/915GM/945G/945GM chipsets
> intelfb: Version 0.9.4
> intelfb: intelfb_setup
> intelfb: options: 1366x768-32@60,vram=16
> intelfb: intelfb_pci_register
> ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 11  
> (level, low) -> IRQ 11
> intelfb: fb aperture: 0x20000000/0x8000000, MMIO region:  
> 0x28200000/0x80000
> intelfb: 00:02.0: Intel(R) 945G, aperture size 256MB, stolen memory  
> 7932kB
> intelfb: fb: 0x23011000(+ 0x3011)/0x1000000 (0xe3211000)
> intelfb: MMIO: 0x28200000/0x80000 (0xe7280000)
> intelfb: ring buffer: 0x23001000/0x10000 (0xe3201000)
> intelfb: HW cursor: 0x0/0x0 (0x0) (offset 0x0) (phys 0x0)
> intelfb: options: vram = 16, accel = 1, hwcursor = 0, fixed = 0,  
> noinit = 0
> intelfb: options: mode = "1366x768-32@60"
> intelfb: intelfb_set_fbinfo
> intelfb: intelfb_init_var
> intelfb: Looking for mode in private database
> intelfb: intelfb_check_var: accel_flags is 0
> intelfb: intelfb_var_to_depth: bpp: 32, green.length is 0
> intelfb: Initial video mode is 1366x768-32@60.
> intelfb: Initial video mode is from 1.
> intelfb: update_dinfo
> intelfb: intelfb_var_to_depth: bpp: 32, green.length is 8
> intelfb: intelfbhw_print_hw_state
> hw state dump start
>         VGA0_DIVISOR:           0x00031108
>         VGA1_DIVISOR:           0x00031406
>         VGAPD:                  0x00020002
>         VGA0: (m1, m2, n, p1, p2) = (17, 8, 3, 2, 0)
>         VGA0: clock is 100800
>         VGA1: (m1, m2, n, p1, p2) = (20, 6, 3, 0, 0)
> divide error: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c025aab7>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.17-rc5 #2)
> EIP is at calc_vclock+0x84/0x92
> eax: 00229200   ebx: 00000000   ecx: 00000001   edx: 00000000
> esi: 00000000   edi: 00000000   ebp: 00000005   esp: c1461da4
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=c1460000 task=df652a10)
> Stack: 00000000 c1637248 00000000 00000014 c025ac7a 00000001  
> 00000014 00000006
>        00000003 00000000 00000000 00000000 00000001 00000003  
> 00000006 c163723c
>        c163723c 00000000 c1637248 00000002 c0258314 c163723c  
> c1637248 00000000
> Call Trace:
> <c025ac7a> intelfbhw_print_hw_state+0x1b5/0x9f2  <c0258314>  
> intelfb_pci_register+0x7db/0xc5e
> <c01ffb06> __pci_device_probe+0x5f/0x6d  <c01ffb43> pci_device_probe 
> +0x2f/0x59
> <c02664d5> driver_probe_device+0x96/0xe8  <c0266590> __driver_attach 
> +0x0/0x69
> <c02665f7> __driver_attach+0x67/0x69  <c0265951> bus_for_each_dev 
> +0x58/0x78
> <c01f5f6a> kobject_set_name+0x42/0xcc  <c026661f> driver_attach 
> +0x26/0x2a
> <c0266590> __driver_attach+0x0/0x69  <c0265ec4> bus_add_driver 
> +0x83/0xc2
> <c0266ade> driver_register+0x64/0x95  <c0266a66> klist_devices_get 
> +0x0/0xa
> <c0266a70> klist_devices_put+0x0/0xa  <c01ff8e3>  
> pci_create_newid_file+0x27/0x2b
> <c01ffda4> __pci_register_driver+0x40/0x56  <c0482ffe> intelfb_init 
> +0x7a/0x82
> <c04707be> do_initcalls+0x78/0x11e  <c01908bd> proc_mkdir+0x1f/0x23
> <c01378bb> register_irq_proc+0x7b/0x8e  <c0190000>  
> proc_notify_change+0x22/0x67
> <c0137923> init_irq_proc+0x2e/0x3b  <c01002b5> init+0x0/0x16b
> <c01002eb> init+0x36/0x16b  <c0101375> kernel_thread_helper+0x5/0xb
> Code: f6 8b 1c 24 8b 74 24 04 8b 7c 24 08 8b 6c 24 0c 83 c4 10 c3  
> 85 ff 8d 14 b6 75 de 8d 14 12 89 d8 8b 7c 24 08 89 d6 31 d
> EIP: [<c025aab7>] calc_vclock+0x84/0x92 SS:ESP 0068:c1461da4
> <0>Kernel panic - not syncing: Attempted to kill init!

The changes are caused specifically by your changes to calc_vclock()  
-- if you look at the values for VGA1 right before the panic, p1 is  
equal to 0, and that means in that in calc_vclock(), p will be zero,  
and when you divide vco by p, you get a divide by zero error.

The old version of calc_vclock() before your patch would return 0 for  
those values passed in.

But, even without the changes to calc_vclock(), but including the  
other changes, the driver still gives me a blank display.  If I apply  
the 1 line patch I posted last week, I get a working display.

I had merged some of your code from the x driver over by hand, and I  
was able to get a working display -- but, when i made changes to  
seemingly minor areas, the display went to black again.  I'm going to  
tackle that area again today to see if I get anything up and running.

dennis

On May 27, 2006, at 4:58 AM, Dave Airlie wrote:
> I've just pushed my latest intelfb-2.6 tree to kernel.org, it contains
> the patches from Dennis, and a sync of my X.org code.
>
> Dennis I'd appreciate you testing this on your i945 system to see if
> the PLL register problem is fixed, I'm a bit snowed under and my 945
> isn't connected to anything at the moment.


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
