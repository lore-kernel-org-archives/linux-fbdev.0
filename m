From: Siim Vahtre <siim@pld.ttu.ee>
Subject: bug in i810_init_cursor
Date: Sun, 13 Apr 2003 10:30:48 +0300 (EET DST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.53.0304131005420.17774@pitsa.pld.ttu.ee>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from wall.ttu.ee ([193.40.254.238])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 194bxW-000414-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Apr 2003 00:31:26 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


Hello.

The kernel is 2.5.67-bk3 with latest fbdev patches (Apr 11).

I loaded the fbdev like that:
modprobe i810fb mtrr=1 accel=1 xres=640 yres=480 hsync1=30 hsync2=60 vsync1=50 vsync2=100 bpp=16 dcolor=1
modprobe fbcon

And got:
PCI: Found IRQ 11 for device 00:02.0
I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP)
Framebuffer Device v0.9.0
I810FB: Video RAM   : 4096K
I810FB: Monitor     : H: 30-60 KHz V: 50-100 Hz
I810FB: Mode        : 640x480-16bpp@99Hz
Console: switching to colour frame buffer device 80x30

And now as soon as the "login: " came I did:
fbset mode -a
(the mode can be anything)

And I got following:
-------------------------------------------------------------------------
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c02459b4
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[soft_cursor+420/544]    Not tainted
EFLAGS: 00010287
EIP is at soft_cursor+0x1a4/0x220
eax: 00000000   ebx: 00000010   ecx: c7a534c0   edx: 00000000
esi: 00000000   edi: fffffff8   ebp: c79d7800   esp: c1153cb8
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c1152000 task=c115cc40)
Stack: c79d7800 00000010 c1153cdc 00000001 00000001 00000010 c7864c80
00000001
       00000001 00000000 00000000 00000000 00000000 00000001 c79d7800
c0109c4a
       c79d7800 08158001 08158001 c79d7908 c1203800 c1152000 cc974000
c010007b
Call Trace:
 [apic_timer_interrupt+26/32] apic_timer_interrupt+0x1a/0x20
 [<c896be55>] i810_init_cursor+0x25/0x50 [i810fb]
 [<c896ccfc>] i810fb_cursor+0x5c/0x250 [i810fb]
 [update_wall_time+22/64] update_wall_time+0x16/0x40
 [do_timer+224/240] do_timer+0xe0/0xf0
 [timer_interrupt+119/336] timer_interrupt+0x77/0x150
 [<c895761f>] +0x61f/0x640 [cfbimgblt]
 [do_IRQ+253/288] do_IRQ+0xfd/0x120
 [__rmqueue+193/272] __rmqueue+0xc1/0x110
 [buffered_rmqueue+177/336] buffered_rmqueue+0xb1/0x150
 [__alloc_pages+160/720] __alloc_pages+0xa0/0x2d0
 [<cc9fd4bb>] putcs_aligned+0x17b/0x1d0 [fbcon]
 [copy_process+2150/2928] copy_process+0x866/0xb70
 [cache_grow+318/544] cache_grow+0x13e/0x220
 [do_fork+160/352] do_fork+0xa0/0x160
 [__kfree_skb+105/240] __kfree_skb+0x69/0xf0
 [netlink_broadcast+328/672] netlink_broadcast+0x148/0x2a0
 [kernel_thread+142/176] kernel_thread+0x8e/0xb0
 [wait_for_helper+0/112] wait_for_helper+0x0/0x70
 [schedule+425/944] schedule+0x1a9/0x3b0
 [<cc9fd047>] +0x47/0x50 [fbcon]
 [worker_thread+491/736] worker_thread+0x1eb/0x2e0
 [<cc9fd000>] +0x0/0x50 [fbcon]
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [worker_thread+0/736] worker_thread+0x0/0x2e0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

Code: 32 04 32 88 44 14 24 42 39 da 0f 83 6c ff ff ff eb ea 89 d9
-------------------------------------------------------------------------

After that, the console is a bit scrambled (although mode is set) and
I can't see anything I am writing or doing. I simply use SysRq to reboot.

However, if I delay with fbset a bit it seem to work as expected... but
that might be a total random aswell.

Oh.. and if I get it running correctly the cursor is pretty strange
(somekind of red dots are falling down inside the transparent cursor
block). If I play with cursor as described in VGA-softcursor.txt, I
will be able to get a normal cursor.

Otherwise everything is just perfect :-)



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
