From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [Bugme-new] [Bug 13976] New: viafb + vmalloc
Date: Thu, 13 Aug 2009 23:24:42 +0200
Message-ID: <4A84849A.3000807@gmx.de>
References: <bug-13976-10286@http.bugzilla.kernel.org/>
	<20090813123622.624240c7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <FlorianSchandinat@gmx.de>) id 1Mbhmr-0004ch-QG
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Aug 2009 21:24:41 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Mbhml-0000Le-FO for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Aug 2009 21:24:41 +0000
In-Reply-To: <20090813123622.624240c7.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Scott Fang <ScottFang@viatech.com.cn>, bugme-daemon@bugzilla.kernel.org, sungeneral@gmail.com

Hi,

excuse me to interfere although I don't know the memory 
subsystem/functions very well.

Andrew Morton schrieb:
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Thu, 13 Aug 2009 15:22:41 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=13976
>>
>>            Summary: viafb + vmalloc
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: 2.6.30.4
>>           Platform: All
>>         OS/Version: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: Video(Other)
>>         AssignedTo: drivers_video-other@kernel-bugs.osdl.org
>>         ReportedBy: sungeneral@gmail.com
>>         Regression: No
> 
> OK, this is bad.
> 
>> #modprobe viafb
>> Jun 21 05:17:53 mini2133 [   50.504357] VIA Graphics Intergration Chipset
>> framebuffer 2.4 initializing
>> Jun 21 05:17:53 mini2133 [   50.583434] vmap allocation for size 268439552
>> failed: use vmalloc=<size> to increase size.
>> Jun 21 05:17:53 mini2133 [   50.583443] ioremap failed
>>
>> if add parametr vmalloc=260M to kernel 
>>
>> #modprobe viafb
>> Jun 21 05:11:17 mini2133 [   60.692317] VIA Graphics Intergration Chipset
>> framebuffer 2.4 initializing
>> Jun 21 05:11:17 mini2133 [   60.772731] vmap allocation for size 16781312
>> failed: use vmalloc=<size> to increase size.
>> Jun 21 05:11:17 mini2133 [   60.772750] BUG: unable to handle kernel NULL
>> pointer dereference at 00000004
>> Jun 21 05:11:17 mini2133 [   60.772921] IP: [<ef64a798>]
>> viafb_init_2d_engine+0x16/0x583 [viafb]
>> Jun 21 05:11:17 mini2133 [   60.773005] *pde = 00000000 
>> Jun 21 05:11:17 mini2133 [   60.773005] Oops: 0002 [#1] SMP 
>> Jun 21 05:11:17 mini2133 [   60.773005] last sysfs file:
>> /sys/devices/pci0000:00/0000:00:0f.0/host0/target0:0:0/0:0:0:0/block/sda/uevent
>> Jun 21 05:11:17 mini2133 [   60.773005] Modules linked in: viafb(+)
>> i2c_algo_bit via drm via_agp agpgart
>> Jun 21 05:11:17 mini2133 [   60.773005] 
>> Jun 21 05:11:17 mini2133 [   60.773005] Pid: 4084, comm: modprobe Not tainted
>> (2.6.30-gentoo-r4 #13)         
>> Jun 21 05:11:17 mini2133 [   60.773005] EIP: 0060:[<ef64a798>] EFLAGS: 00010202
>> CPU: 0
>> Jun 21 05:11:17 mini2133 [   60.773005] EIP is at
>> viafb_init_2d_engine+0x16/0x583 [viafb]
>> Jun 21 05:11:17 mini2133 [   60.773005] EAX: 00000004 EBX: ed8a5280 ECX:
>> c256d700 EDX: 00000000
>> Jun 21 05:11:17 mini2133 [   60.773005] ESI: fffffffc EDI: 00000000 EBP:
>> ed8b3f18 ESP: ed8b3f08
>> Jun 21 05:11:17 mini2133 [   60.773005]  DS: 007b ES: 007b FS: 00d8 GS: 0033
>> SS: 0068
>> Jun 21 05:11:17 mini2133 [   60.773005] Process modprobe (pid: 4084,
>> ti=ed8b2000 task=ee7da220 task.ti=ed8b2000)
>> Jun 21 05:11:17 mini2133 [   60.773005] Stack:
>> Jun 21 05:11:17 mini2133 [   60.773005]  00000000 ed8a5280 fffffffc 00000000
>> ed8b3f40 ef656505 00000000 ed8b3f40
>> Jun 21 05:11:17 mini2133 [   60.773005]  c1062132 00000000 00000000 ef6535e4
>> fffffffc 00000000 ed8b3f9c c1001137
>> Jun 21 05:11:17 mini2133 [   60.773005]  ef656000 00000000 ef6535e4 00000001
>> 00000000 c15dec24 00000000 c15dec34
>> Jun 21 05:11:17 mini2133 [   60.773005] Call Trace:
>> Jun 21 05:11:17 mini2133 [   60.773005]  [<ef656505>] ? viafb_init+0x505/0xd2c
>> [viafb]
>> Jun 21 05:11:17 mini2133 [   60.773005]  [<c1062132>] ?
>> marker_update_probe_range+0x1cf/0x1de
>> Jun 21 05:11:17 mini2133 [   60.773005]  [<c1001137>] ?
>> do_one_initcall+0x4a/0x10c
>> Jun 21 05:11:17 mini2133 [   60.773005]  [<ef656000>] ? viafb_init+0x0/0xd2c
>> [viafb]
>> Jun 21 05:11:17 mini2133 [   60.773005]  [<c103ae2d>] ?
>> __blocking_notifier_call_chain+0x40/0x4c
>> Jun 21 05:11:17 mini2133 [   60.773005]  [<c10481f6>] ?
>> sys_init_module+0x87/0x18b
>> Jun 21 05:11:17 mini2133 [   60.773005]  [<c1002a44>] ?
>> sysenter_do_call+0x12/0x22
>> Jun 21 05:11:17 mini2133 [   60.773005] Code: ff ff 03 00 89 42 44 a1 44 38 65
>> ef 81 40 38 00 20 04 00 5d c3 55 31 d2 89 e5 57 56 53 83 ec 04 a1 44 38 65 ef
>> 8b 40 1c 83 c0 04 <89> 10 a1 44 38 65 ef 8b 40 1c 83 c0 08 89 10 a1 44 38 65 ef
>> 8b 
>> Jun 21 05:11:17 mini2133 [   60.773005] EIP: [<ef64a798>]
>> viafb_init_2d_engine+0x16/0x583 [viafb] SS:ESP 0068:ed8b3f08
>> Jun 21 05:11:17 mini2133 [   60.773005] CR2: 0000000000000004
>> Jun 21 05:11:17 mini2133 [   60.779905] ---[ end trace c390d80983a29e06 ]---
>>
>> ps: viafb build as a module
>>
> 
> a) The driver appears to be ioremapping more virtual address space
>    than the machine can provide.
> 
>    Is that expected?

I don't know.
Is the video memory size detection of (I think) 256 MB correct?
What is the graphic chip? (CLE266, CN400, CN700, KM400, CX700 or VX800?)

> b) When ioremap_nocache() failed, the driver went and crashed the
>    machine.  I don't see how this can happen - via_pci_probe() seems to
>    handle this correctly.
> 
>    It should return -ENOMEM rather than -1, but that's minor.

If an ioremap_nocache() can cause this, I don't see why it can't be the 
later one:
viaparinfo->io_virt = ioremap_nocache()
As far as I know this is only used for acceleration so a quick test can 
be done with viafb_accel=0 module parameter.


Regards,

Florian Tobias Schandinat

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
