From: Jakub Bogusz <qboosh@pld-linux.org>
Subject: [BUG] Oops on "rmmod fbcon" on 2.6.0-test3
Date: Sun, 10 Aug 2003 01:21:50 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030809232150.GB28322@satan.blackhosts>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pg104.warszawa.cvx.ppp.tpnet.pl ([213.76.102.104] helo=satan.blackhosts)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ld4s-00013O-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 09 Aug 2003 16:24:52 -0700
Received: from satan.blackhosts (localhost [127.0.0.1])
	by satan.blackhosts (8.12.9/8.12.9) with ESMTP id h79NQNPj028795
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 10 Aug 2003 01:26:25 +0200
Received: (from qboosh@localhost)
	by satan.blackhosts (8.12.9/8.12.9/Submit) id h79NLou5028355
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Aug 2003 01:21:50 +0200
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

"rmmod fbcon" causes an oops on 2.6.0-test3 (and 2.6.0-test2).
It seems that the module doesn't uninitialize some structures
properly...
ksymoops 2.4.9 doesn't like 2.6-style ksyms, so here is an oops decoded
manually:

kernel: Unable to handle kernel paging request at virtual address e28a2598
kernel: printing eip:
kernel: c01ccb1f
kernel: *pde = 143b3067
kernel: *pte = 00000000
kernel: Oops: 0000 [#1]
kernel: Unable to handle kernel paging request at virtual address e28a2598
kernel: printing eip:
kernel: c01cca5d
kernel: *pde = 143b3067
kernel: *pte = 00000000
kernel: Oops: 0000 [#2]
kernel: CPU:    0
kernel: EIP:    0060:[<c01cca5d>]    Not tainted
kernel: EFLAGS: 00010046
kernel: EIP is at hide_cursor+0x5d/0xb0
kernel: eax: e28a2580   ebx: 00000000   ecx: c13d8000   edx: 00000001
kernel: esi: c02fee36   edi: 00000000   ebp: 00000000   esp: d5d23c6c
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process bash (pid: 2628, threadinfo=d5d22000 task=d4ca2180)
kernel: Stack: c13d8000 00000002 00000001 d5d23cdb c13d8000 c01d0100 00000000 31343362 
kernel: c02b1a00 d5d23cf4 d5237ebf 000038a8 d5d23cf3 c028aea0 c02fee36 00000010 
kernel: ffffff63 c011b5e1 c028aea0 c02fee36 00000010 00001b86 00001b86 00000034 
kernel: Call Trace:
kernel: [<c01d0100>] vt_console_print+0x2e0/0x2f0
kernel: [<c011b5e1>] __call_console_drivers+0x51/0x60
kernel: [<c011b6e6>] call_console_drivers+0x76/0x120
kernel: [<c011ba0d>] release_console_sem+0x4d/0xd0
kernel: [<c011b92c>] printk+0x12c/0x180
kernel: [<c011b92c>] printk+0x12c/0x180
kernel: [<c01156a0>] do_page_fault+0x0/0x451
kernel: [<c0109829>] die+0x69/0xf0
kernel: [<c01157cc>] do_page_fault+0x12c/0x451
kernel: [<c01f38a8>] move_buf_aligned+0x38/0x50
kernel: [<c01f7da5>] soft_cursor+0x165/0x240
kernel: [<c0122c46>] update_process_times+0x46/0x60
kernel: [<c0122aab>] update_wall_time+0xb/0x40
kernel: [<c0122f1f>] do_timer+0xdf/0xf0
kernel: [<c01156a0>] do_page_fault+0x0/0x451
kernel: [<c0109245>] error_code+0x2d/0x38
kernel: [<c01ccb1f>] set_cursor+0x6f/0x90
kernel: [<c01d04e8>] con_flush_chars+0x48/0x50
kernel: [<c01c0845>] opost_block+0x125/0x1e0
kernel: [<c013f65d>] copy_page_range+0x11d/0x380
kernel: [<c01333f5>] unlock_page+0x15/0x60
kernel: [<c01409ee>] do_wp_page+0x38e/0x3e0
kernel: [<c01c2b5b>] write_chan+0x19b/0x230
kernel: [<c0117b70>] default_wake_function+0x0/0x30
kernel: [<c0117b70>] default_wake_function+0x0/0x30
kernel: [<c01bd4c8>] tty_write+0x248/0x300
kernel: [<c01c29c0>] write_chan+0x0/0x230
kernel: [<c01270f1>] sys_rt_sigaction+0xf1/0x120
kernel: [<c01bd280>] tty_write+0x0/0x300
kernel: [<c014f408>] vfs_write+0xd8/0x140
kernel: [<c0126115>] sys_rt_sigprocmask+0xa5/0x160
kernel: [<c014f522>] sys_write+0x42/0x70
kernel: [<c010909b>] syscall_call+0x7/0xb
kernel: 
kernel: Code: ff 50 18 8b 5c 24 10 83 c4 14 c3 8b 41 44 8b 51 28 89 44 24 
kernel: <6>note: bash[2628] exited with preempt_count 2
kernel: release_dev: tty1: read/write wait queue active!
[...last message repeated until reboot...]

symbols:
e28a2580 R fb_con       [fbcon]
c01cca00 t hide_cursor

(drivers/char/vt.c: hide_cursor)
00000c40 <hide_cursor>:
[...]
     c81:       39 08                   cmp    %ecx,(%eax)
     c83:       74 23                   je     ca8 <hide_cursor+0x68>
     c85:       c7 05 98 02 00 00 ff    movl   $0xffffffff,0x298
     c8c:       ff ff ff
     c8f:       8b 41 28                mov    0x28(%ecx),%eax
     c92:       89 0c 24                mov    %ecx,(%esp,1)
     c95:       c7 44 24 04 02 00 00    movl   $0x2,0x4(%esp,1)
     c9c:       00
==>  c9d:       ff 50 18                call   *0x18(%eax)
     ca0:       8b 5c 24 10             mov    0x10(%esp,1),%ebx
     ca4:       83 c4 14                add    $0x14,%esp
     ca7:       c3                      ret

static void hide_cursor(int currcons)
{
        if (currcons == sel_cons)
                clear_selection();
        if (softcursor_original != -1) {
                scr_writew(softcursor_original,(u16 *) pos);
                if (DO_UPDATE)
==>                     sw->con_putc(vc_cons[currcons].d, softcursor_original, y, x);
                softcursor_original = -1;
        }
        sw->con_cursor(vc_cons[currcons].d,CM_ERASE);
}


(sw, i.e. vc_cons[currcons].d->vc_sw, still pointed to destroyed fb_con)


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
