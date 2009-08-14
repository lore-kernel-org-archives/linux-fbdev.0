From: Roman Sergeev <sungeneral@gmail.com>
Subject: Re: [Bugme-new] [Bug 13976] New: viafb + vmalloc
Date: Fri, 14 Aug 2009 14:46:02 +0400
Message-ID: <9B8E82A6-A4A5-4654-8555-5590A7B1D0F3@gmail.com>
References: <bug-13976-10286@http.bugzilla.kernel.org/>
	<20090813123622.624240c7.akpm@linux-foundation.org>
	<4A84849A.3000807@gmx.de>
	<FE2B7370-64DF-43D4-B0E3-C65EB1AD1986@gmail.com>
	<4A852527.7040705@gmx.de>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sungeneral@gmail.com>) id 1MbuIf-0006pt-Qy
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Aug 2009 10:46:21 +0000
Received: from mail-ew0-f210.google.com ([209.85.219.210])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbuIY-00010P-Fd for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Aug 2009 10:46:21 +0000
Received: by ewy6 with SMTP id 6so1404974ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Aug 2009 03:46:07 -0700 (PDT)
In-Reply-To: <4A852527.7040705@gmx.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Scott Fang <ScottFang@viatech.com.cn>, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi!

On 14.08.2009, at 12:49, Florian Tobias Schandinat wrote:

> Roman Sergeev schrieb:
>> 01:00.0 VGA compatible controller: VIA Technologies, Inc. P4M900  
>> [Chrome 9 HC] (rev 01)
>> with shadow ram (total 2Gb, but system see 1768Mb... maybe 280Mb)
>
> This makes sense:
> 2 GB physical RAM
> - 256 MB used as shared memory video RAM
> = 1792 MB available
> I don't know where the other memory is lost but the video memory  
> size seems to be detected correctly.
>
>> after modprobe viafb don't die, they going to new state
>> viafb 75212 1 - Loading 0xef642000
>
> I don't know if I get you right here:
> After "modprobe viafb viafb_accel=0" the module does no longer  
> crash? But I don't know what state you are talking about. Is the  
> module usable? (i.e. does "modprobe fbcon" give you a working  
> framebuffer console?) Or can you otherwise post a new log?
>
>

i make some "test"

test # 0

# modprobe viafb
FATAL: Error inserting viafb (/lib/modules/2.6.30-gentoo-r4/kernel/ 
drivers/video/via/viafb.ko): Operation not permitted

log:
Jun 22 00:34:48 mini2133 [   89.952746] VIA Graphics Intergration  
Chipset framebuffer 2.4 initializing
Jun 22 00:34:48 mini2133 [   90.031236] vmap allocation for size  
268439552 failed: use vmalloc=<size> to increase size.
Jun 22 00:34:48 mini2133 [   90.031244] ioremap failed

test # 1
* send to kernel "vmalloc=260M"

# modprobe viafb
Killed

log:
Jun 22 00:41:50 mini2133 [   46.690400] VIA Graphics Intergration  
Chipset framebuffer 2.4 initializing
Jun 22 00:41:50 mini2133 [   46.770663] vmap allocation for size  
16781312 failed: use vmalloc=<size> to increase size.
Jun 22 00:41:50 mini2133 [   46.770684] BUG: unable to handle kernel  
NULL pointer dereference at 00000004
Jun 22 00:41:50 mini2133 [   46.770885] IP: [<ef64a798>]  
viafb_init_2d_engine+0x16/0x583 [viafb]
Jun 22 00:41:50 mini2133 [   46.771005] *pde = 00000000
Jun 22 00:41:50 mini2133 [   46.771005] Oops: 0002 [#1] SMP
Jun 22 00:41:50 mini2133 [   46.771005] last sysfs file: /sys/devices/ 
pci0000:00/0000:00:0f.0/host0/target0:0:0/0:0:0:0/block/sda/uevent
Jun 22 00:41:50 mini2133 [   46.771005] Modules linked in: viafb(+)  
i2c_algo_bit via drm via_agp agpgart
Jun 22 00:41:50 mini2133 [   46.771005]
Jun 22 00:41:50 mini2133 [   46.771005] Pid: 4094, comm: modprobe Not  
tainted (2.6.30-gentoo-r4 #13)
Jun 22 00:41:50 mini2133 [   46.771005] EIP: 0060:[<ef64a798>] EFLAGS:  
00010202 CPU: 0
Jun 22 00:41:50 mini2133 [   46.771005] EIP is at viafb_init_2d_engine 
+0x16/0x583 [viafb]
Jun 22 00:41:50 mini2133 [   46.771005] EAX: 00000004 EBX: ed8bd280  
ECX: c256d700 EDX: 00000000
Jun 22 00:41:50 mini2133 [   46.771005] ESI: fffffffc EDI: 00000000  
EBP: ed8c1f18 ESP: ed8c1f08
Jun 22 00:41:50 mini2133 [   46.771005]  DS: 007b ES: 007b FS: 00d8  
GS: 0033 SS: 0068
Jun 22 00:41:50 mini2133 [   46.771005] Process modprobe (pid: 4094,  
ti=ed8c0000 task=ee7d84e0 task.ti=ed8c0000)
Jun 22 00:41:50 mini2133 [   46.771005] Stack:
Jun 22 00:41:50 mini2133 [   46.771005]  00000000 ed8bd280 fffffffc  
00000000 ed8c1f40 ef656505 00000000 ed8c1f40
Jun 22 00:41:50 mini2133 [   46.771005]  c1062132 00000000 00000000  
ef6535e4 fffffffc 00000000 ed8c1f9c c1001137
Jun 22 00:41:50 mini2133 [   46.771005]  ef656000 00000000 ef6535e4  
00000001 00000000 c15dec24 00000000 c15dec34
Jun 22 00:41:50 mini2133 [   46.771005] Call Trace:
Jun 22 00:41:50 mini2133 [   46.771005]  [<ef656505>] ? viafb_init 
+0x505/0xd2c [viafb]
Jun 22 00:41:50 mini2133 [   46.771005]  [<c1062132>] ?  
marker_update_probe_range+0x1cf/0x1de
Jun 22 00:41:50 mini2133 [   46.771005]  [<c1001137>] ? do_one_initcall 
+0x4a/0x10c
Jun 22 00:41:50 mini2133 [   46.771005]  [<ef656000>] ? viafb_init 
+0x0/0xd2c [viafb]
Jun 22 00:41:50 mini2133 [   46.771005]  [<c103ae2d>] ?  
__blocking_notifier_call_chain+0x40/0x4c
Jun 22 00:41:50 mini2133 [   46.771005]  [<c10481f6>] ? sys_init_module 
+0x87/0x18b
Jun 22 00:41:50 mini2133 [   46.771005]  [<c1002a44>] ?  
sysenter_do_call+0x12/0x22
Jun 22 00:41:50 mini2133 [   46.771005] Code: ff ff 03 00 89 42 44 a1  
44 38 65 ef 81 40 38 00 20 04 00 5d c3 55 31 d2 89 e5 57 56 53 83 ec  
04 a1 44 38 65 ef 8b 40 1c 83 c0 04 <89> 10 a1 44 38 65 ef 8b 40 1c 83  
c0 08 89 10 a1 44 38 65 ef 8b
Jun 22 00:41:50 mini2133 [   46.771005] EIP: [<ef64a798>]  
viafb_init_2d_engine+0x16/0x583 [viafb] SS:ESP 0068:ed8c1f08
Jun 22 00:41:50 mini2133 [   46.771005] CR2: 0000000000000004
Jun 22 00:41:50 mini2133 [   46.777862] ---[ end trace  
e41091c450ca8ab2 ]---

status:
# grep viafb /proc/modules
viafb 75212 1 - Loading 0xef642000
i2c_algo_bit 4656 1 viafb, Live 0xef624000


test # 2
* send to kernel "vmalloc=300M"
* modprobe viafb
* loaded ok

status:
# grep viafb /proc/modules
viafb 71840 1 - Live 0xece42000
i2c_algo_bit 4656 1 viafb, Live 0xece24000

log:
Jun 21 23:52:12 mini2133 [   47.308459] VIA Graphics Intergration  
Chipset framebuffer 2.4 initializing
Jun 21 23:52:12 mini2133 [   47.393518] Console: switching to colour  
frame buffer device 80x30

but i see "test color mode"

fbset -i

mode "640x480-60"
     # D: 25.175 MHz, H: 31.469 kHz, V: 59.940 Hz
     geometry 640 480 640 480 32
     timings 39722 48 16 33 10 96 2
     accel true
     rgba 8/16,8/8,8/0,0/0
endmode

Frame buffer device information:
     Name        : Via
     Address     : 0xc0000000
     Size        : 268156928
     Type        : PACKED PIXELS
     Visual      : TRUECOLOR
     XPanStep    : 0
     YPanStep    : 1
     YWrapStep   : 0
     LineLength  : 2560
     MMIO Address: 0xfc000000
     MMIO Size   : 16777216
     Accelerator : Unknown (50)

if i loading  module with parametrs "modprobe viafb viafb_mode=800x600  
viafb_refresh=60"
they still go "test color mode"
log:
Jun 22 00:28:11 mini2133 [  142.994541] VIA Graphics Intergration  
Chipset framebuffer 2.4 initializing
Jun 22 00:28:11 mini2133 [  143.079079] Console: switching to colour  
frame buffer device 100x37

ps: other \ standart  kernel framebuffer module on this card works well


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
