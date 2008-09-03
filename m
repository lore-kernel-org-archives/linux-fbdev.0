From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/2] atmel_lcdfb: Fix oops in rmmod
 when framebuffer fail to register
Date: Wed, 3 Sep 2008 20:51:03 +0200
Message-ID: <20080903205103.3c291b3d.krzysztof.h1@poczta.fm>
References: <200809031536.50390.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaxKz-0003PW-Hd for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 11:44:17 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KaxKx-0006ra-SF
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 11:44:17 -0700
In-Reply-To: <200809031536.50390.stf_xl@wp.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

On Wed, 3 Sep 2008 15:36:50 +0200
Stanislaw Gruszka <stf_xl@wp.pl> wrote:

> If framebuffer registration failed in platform driver ->probe() callback,
> dev_get_drvdata() points to freed memory region, but ->remove()
> function try to use it and the following oops occurs:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000228
> pgd = c3a20000
> [00000228] *pgd=23a2b031, *pte=00000000, *ppte=00000000
> Internal error: Oops: 17 [#1]
> Modules linked in: atmel_lcdfb(-) cfbcopyarea cfbimgblt cfbfillrect [last unloaded: atmel_lcdfb]
> CPU: 0    Not tainted  (2.6.27-rc2 #116)
> PC is at atmel_lcdfb_remove+0x14/0xf8 [atmel_lcdfb]
> LR is at platform_drv_remove+0x20/0x24
> pc : [<bf006bc4>]    lr : [<c0157d28>]    psr: a0000013
> sp : c3a45e84  ip : c3a45ea0  fp : c3a45e9c
> r10: 00000002  r9 : c3a44000  r8 : c0026c04
> r7 : 00000880  r6 : c02bb228  r5 : 00000000  r4 : c02bb230
> r3 : bf007e3c  r2 : c02bb230  r1 : 00000004  r0 : c02bb228
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 0005317f  Table: 23a20000  DAC: 00000015
> Process rmmod (pid: 6799, stack limit = 0xc3a44260)
> Stack: (0xc3a45e84 to 0xc3a46000)
> 5e80:          c02bb230 bf007e3c bf007e3c c3a45eac c3a45ea0 c0157d28 bf006bc0
> 5ea0: c3a45ec4 c3a45eb0 c0156d20 c0157d18 c02bb230 c02bb2d8 c3a45ee0 c3a45ec8
> 5ec0: c0156da8 c0156cb8 bf007e3c bf007ee0 c02c8e14 c3a45efc c3a45ee4 c0156018
> 5ee0: c0156d50 bf007e3c bf007ee0 00000000 c3a45f18 c3a45f00 c0157220 c0155f9c
> 5f00: 00000000 bf007ee0 bf008000 c3a45f28 c3a45f1c c0157e34 c01571ec c3a45f38
> 5f20: c3a45f2c bf006ba8 c0157e30 c3a45fa4 c3a45f3c c005772c bf006ba4 656d7461
> 5f40: 636c5f6c 00626664 c004c988 c3a45f80 c3a45f5c 00000000 c3a45fb0 00000000
> 5f60: ffffffff becaccd8 00000880 00000000 000a5e80 00000001 bf007ee0 00000880
> 5f80: c3a45f84 00000000 becaccd4 00000002 000003df 00000081 00000000 c3a45fa8
> 5fa0: c0026a60 c0057584 00000002 000003df 00900081 000a5e80 00000880 00000000
> 5fc0: becaccd4 00000002 000003df 00000000 000a5e80 00000001 00000002 0000005f
> 5fe0: 4004f5ec becacbe8 0001a158 4004f5fc 20000010 00900081 f9ffbadf 7bbfb2bb
> Backtrace:
> [<bf006bb0>] (atmel_lcdfb_remove+0x0/0xf8 [atmel_lcdfb]) from [<c0157d28>] (platform_drv_remove+0x20/0x24)
>  r6:bf007e3c r5:bf007e3c r4:c02bb230
> [<c0157d08>] (platform_drv_remove+0x0/0x24) from [<c0156d20>] (__device_release_driver+0x78/0x98)
> [<c0156ca8>] (__device_release_driver+0x0/0x98) from [<c0156da8>] (driver_detach+0x68/0x90)
>  r5:c02bb2d8 r4:c02bb230
> [<c0156d40>] (driver_detach+0x0/0x90) from [<c0156018>] (bus_remove_driver+0x8c/0xb4)
>  r6:c02c8e14 r5:bf007ee0 r4:bf007e3c
> [<c0155f8c>] (bus_remove_driver+0x0/0xb4) from [<c0157220>] (driver_unregister+0x44/0x48)
>  r6:00000000 r5:bf007ee0 r4:bf007e3c
> [<c01571dc>] (driver_unregister+0x0/0x48) from [<c0157e34>] (platform_driver_unregister+0x14/0x18)
>  r6:bf008000 r5:bf007ee0 r4:00000000
> [<c0157e20>] (platform_driver_unregister+0x0/0x18) from [<bf006ba8>] (atmel_lcdfb_exit+0x14/0x1c [atmel_lcdfb])
> [<bf006b94>] (atmel_lcdfb_exit+0x0/0x1c [atmel_lcdfb]) from [<c005772c>] (sys_delete_module+0x1b8/0x22c)
> [<c0057574>] (sys_delete_module+0x0/0x22c) from [<c0026a60>] (ret_fast_syscall+0x0/0x2c)
>  r7:00000081 r6:000003df r5:00000002 r4:becaccd4
> Code: e92dd870 e24cb004 e59050c4 e1a06000 (e5954228)
> ---[ end trace 85476b184d9e68d8 ]---
> 
> This patch fix oops.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Tylko u nas - swieza krew w rozsadnych cenach!
>> http://link.interia.pl/f1eed


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
