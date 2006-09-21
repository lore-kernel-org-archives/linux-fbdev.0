From: Andrew Morton <akpm@osdl.org>
Subject: Re: backlight: oops in __mutex_lock_slowpath
 during head /sys/class/graphics/fb0/* in 2.6.18
Date: Thu, 21 Sep 2006 12:37:42 -0700
Message-ID: <20060921123742.ec225cc2.akpm@osdl.org>
References: <20060921121952.GA16927@aepfle.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GQUNF-0002iW-Gy for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Sep 2006 12:38:17 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GQUNE-00034e-3D
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Sep 2006 12:38:17 -0700
In-Reply-To: <20060921121952.GA16927@aepfle.de>
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
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Daniel R Thompson <daniel.thompson@st.com>, Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org, Smirl <jonsmirl@gmail.com>, "Antonino A. Daplas" <adaplas@pol.net>, Jon@sc8-sf-spam2.sourceforge.net

On Thu, 21 Sep 2006 14:19:52 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> The bl_curve code has some room for improvement.
> 
> ...
> <6>Monitor sense value = 0x60b
> <6>using video mode 13 and color mode 0.
> <4>Console: switching to colour frame buffer device 104x39
> <6>fb0: valkyrie frame buffer device
> ...
> 
> inst-sys:~ # cat /proc/fb
> 0 valkyrie
> inst-sys:~ # l /sys/class/graphics/fb0/
> total 0
> drwxr-xr-x 2 root root    0 Sep 21 11:54 ./
> drwxr-xr-x 4 root root    0 Sep 21 11:53 ../
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 bits_per_pixel
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 bl_curve
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 blank
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 console
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 cursor
> -r--r--r-- 1 root root 4096 Sep 21 12:15 dev
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 mode
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 modes
> -r--r--r-- 1 root root 4096 Sep 21 12:15 name
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 pan
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 rotate
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 state
> -r--r--r-- 1 root root 4096 Sep 21 12:15 stride
> lrwxrwxrwx 1 root root    0 Sep 21 12:15 subsystem -> ../../../class/graphics/
> --w------- 1 root root 4096 Sep 21 12:15 uevent
> -rw-r--r-- 1 root root 4096 Sep 21 12:15 virtual_size
> inst-sys:~ # head /sys/class/graphics/fb0/*
> ==> /sys/class/graphics/fb0/bits_per_pixel <==
> 8
> 
> ==> /sys/class/graphics/fb0/bl_curve <==
> Segmentation fault
> inst-sys:~ # dmesg
> valkyriefb: vmode 13 does not support cmode 1.
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc02c7bd8
> Oops: Kernel access of bad area, sig: 11 [#1]
> 
> Modules linked in: tulip mesh cpufreq_ondemand loop nfs nfs_acl lockd sunrpc sg st sd_mod sr_mod scsi_mod ide_cd cdrom
> NIP: C02C7BD8 LR: C0170EBC CTR: C0170E90
> REGS: c4209db0 TRAP: 0300   Not tainted  (2.6.18-rc7-git1-2-default)
> MSR: 00009032 <EE,ME,IR,DR>  CR: 28042488  XER: 00000000
> DAR: 00000000, DSISR: 22000000
> TASK = c7fc8190[2853] 'head' THREAD: c4208000
> GPR00: C4209E6C C4209E60 C7FC8190 C0B77614 C41D5000 C41D5000 00000000 00008000
> GPR08: 00000000 C0B77618 00000000 00000000 00000000 100200C8 10020000 00000001
> GPR16: 10006D08 7FDF9B3C 100A0000 10080000 00000003 7FDF9CAB C4209F20 C2FCDC78
> GPR24: C038BC14 C01EF568 7FDF7858 C41D5000 C0B77614 C0B77400 C7FC8190 C0B77614
> NIP [C02C7BD8] __mutex_lock_slowpath+0x2c/0xa4
> LR [C0170EBC] show_bl_curve+0x2c/0xa0
> Call Trace:  
> [C4209E60] [C02C7A54] mutex_lock+0x18/0x5c (unreliable)
> [C4209E80] [C0170EBC] show_bl_curve+0x2c/0xa0
> [C4209EB0] [C01EF594] class_device_attr_show+0x2c/0x44
> [C4209EC0] [C00CC3BC] sysfs_read_file+0xb8/0x204
> [C4209EF0] [C0083FE4] vfs_read+0xec/0x1c8
> [C4209F10] [C0084444] sys_read+0x4c/0x8c
> [C4209F40] [C00125F8] ret_from_syscall+0x0/0x40
> --- Exception: c01 at 0xff589f8
>     LR = 0x100045e0
> Instruction dump:
> 4e800020 9421ffe0 7c0802a6 39230004 bfc10018 7c7f1b78 7c5e1378 90010024
> 3801000c 9121000c 81690004 90090004 <900b0000> 91610010 90410014 3800ffff
> 

cc's added.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
