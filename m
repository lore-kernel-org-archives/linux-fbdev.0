From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: New radeonfb, mostly untested
Date: Mon, 8 Sep 2003 01:03:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030907230334.GA847@dreamland.darkstar.lan>
References: <1062952639.655.6.camel@gaston>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19w8aA-0000Yb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Sep 2003 16:04:37 -0700
Received: from mail-1.tiscali.it ([195.130.225.147])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19w8a9-0001Uz-7n
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Sep 2003 16:04:33 -0700
Content-Disposition: inline
In-Reply-To: <1062952639.655.6.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Sun, Sep 07, 2003 at 06:37:20PM +0200, Benjamin Herrenschmidt ha scritto: 
> I didn't test anything else
> yet nor x86, let me know what you think...

It dies on boot:

ksymoops 2.4.9 on i686 2.6.0-test4-benh.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test4-benh/ (default)
     -m /home/kronos/c/src/linux-2.5-benh/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000014
c02e33c7
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02e33c7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: ee49c010   ecx: 00000001   edx: ef631dd4
esi: ee49c000   edi: 00000000   ebp: ef631d90   esp: ef631d80
ds: 007b   es: 007b   ss: 0068
Stack: ffffffff ee49c000 ee49c000 ef631dd4 ef631e60 f09442f0 ee49c010 ee49c000 
       ef631dd4 00000008 ef631de4 ee49c010 00000000 00003a55 00000400 c0399bcc 
       ef631e0c ef631e14 c012b837 ef630000 fffffaf8 00000286 c046e445 00000280 
Call Trace:
 [<f09442f0>] radeon_check_modes+0x240/0x390 [radeonfb]
 [<c012b837>] printk+0x277/0x400
 [<c02e2315>] show_edid+0x145/0x1b0
 [<f0943af3>] radeon_probe_screens+0x133/0x5f0 [radeonfb]
 [<f0941709>] radeonfb_pci_register+0x419/0x800 [radeonfb]
 [<c0216f6b>] pci_device_probe_static+0x4b/0x60
 [<c02172d6>] __pci_device_probe+0x36/0x50
 [<c021731c>] pci_device_probe+0x2c/0x50
 [<c02a2bbd>] bus_match+0x3d/0x70
 [<c02a2d10>] driver_attach+0x70/0xb0
 [<c02a305e>] bus_add_driver+0xbe/0xd0
 [<c02a3568>] driver_register+0x88/0x90
 [<c021771e>] pci_register_driver+0x8e/0xb0
 [<f094a015>] init_module+0x15/0x40 [radeonfb]
 [<c014d0cf>] sys_init_module+0x1ff/0x3e0
 [<c010b20f>] syscall_call+0x7/0xb
Code: 8b 50 14 85 d2 75 12 83 63 54 fd 31 c0 85 c9 0f 94 c0 83 c4 


>>EIP; c02e33c7 <__fb_try_mode+87/c0>   <=====

>>ebx; ee49c010 <_end+2e010f48/3fb72f38>
>>edx; ef631dd4 <_end+2f1a6d0c/3fb72f38>
>>esi; ee49c000 <_end+2e010f38/3fb72f38>
>>ebp; ef631d90 <_end+2f1a6cc8/3fb72f38>
>>esp; ef631d80 <_end+2f1a6cb8/3fb72f38>

Trace; f09442f0 <_end+304b9228/3fb72f38>
Trace; c012b837 <printk+277/400>
Trace; c02e2315 <show_edid+145/1b0>
Trace; f0943af3 <_end+304b8a2b/3fb72f38>
Trace; f0941709 <_end+304b6641/3fb72f38>
Trace; c0216f6b <pci_device_probe_static+4b/60>
Trace; c02172d6 <__pci_device_probe+36/50>
Trace; c021731c <pci_device_probe+2c/50>
Trace; c02a2bbd <bus_match+3d/70>
Trace; c02a2d10 <driver_attach+70/b0>
Trace; c02a305e <bus_add_driver+be/d0>
Trace; c02a3568 <driver_register+88/90>
Trace; c021771e <pci_register_driver+8e/b0>
Trace; f094a015 <_end+304bef4d/3fb72f38>
Trace; c014d0cf <sys_init_module+1ff/3e0>
Trace; c010b20f <syscall_call+7/b>

Code;  c02e33c7 <__fb_try_mode+87/c0>
00000000 <_EIP>:
Code;  c02e33c7 <__fb_try_mode+87/c0>   <=====
   0:   8b 50 14                  mov    0x14(%eax),%edx   <=====
Code;  c02e33ca <__fb_try_mode+8a/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c02e33cc <__fb_try_mode+8c/c0>
   5:   75 12                     jne    19 <_EIP+0x19> c02e33e0 <__fb_try_mode+a0/c0>
Code;  c02e33ce <__fb_try_mode+8e/c0>
   7:   83 63 54 fd               andl   $0xfffffffd,0x54(%ebx)
Code;  c02e33d2 <__fb_try_mode+92/c0>
   b:   31 c0                     xor    %eax,%eax
Code;  c02e33d4 <__fb_try_mode+94/c0>
   d:   85 c9                     test   %ecx,%ecx
Code;  c02e33d6 <__fb_try_mode+96/c0>
   f:   0f 94 c0                  sete   %al
Code;  c02e33d9 <__fb_try_mode+99/c0>
  12:   83 c4 00                  add    $0x0,%esp


1 error issued.  Results may not be reliable.

We are in  modedb.c:411, and info->fbops is NULL. info->fbops  is set in
radeon_set_fbinfo, which is called after radeon_probe_screens. Moving
radeon_set_fbinfo up should fix this:

===== drivers/video/aty/radeon_base.c 1.2 vs edited =====
--- 1.2/drivers/video/aty/radeon_base.c	Sun Sep  7 23:31:18 2003
+++ edited/drivers/video/aty/radeon_base.c	Mon Sep  8 00:55:03 2003
@@ -2003,6 +2003,9 @@
 	radeon_create_i2c_busses(rinfo);
 #endif
 
+	/* set all the vital stuff */
+	radeon_set_fbinfo (rinfo);
+
 	/* Probe screen types */
 	radeon_probe_screens(rinfo, monitor_layout, ignore_edid);
 
@@ -2024,9 +2027,6 @@
 		/* initialize the engine */
 		radeon_engine_init (rinfo);
 	}
-
-	/* set all the vital stuff */
-	radeon_set_fbinfo (rinfo);
 
 	pci_set_drvdata(pdev, rinfo);
 	rinfo->next = board_list;


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
