From: Alex Thiel <stderr@web.de>
Subject: Neomagic fb driver oopses with linux 2.5
Date: Mon, 21 Jul 2003 11:30:18 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <m3fzl0mdlh.fsf@spock.alex.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
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
To: linux-fbdev-devel@sourceforge.net

Hallo,

trying the 2.5 kernel series on my laptop lately I found that the fb
driver for Neomagic chips would oops after a few lines have
scrolled off the screen.

I have tried the patchset available at http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
(seems to be dated Jul 3rd), but still have the same problem.

The machine is a Sony Vaio PCG-505FX, lspci reports the graphic chip as
00:08.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] (rev 01)

Kernel is 2.5.75 compiled with gcc 2.95.4. Here is the decoded oops,
this one is with the patches applied.

Unable to handle kernel paging request<1>Unable to handle kernel paging request at virtual address c4c011c0
c01e2d03
*pde = 010d8067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01e2d03>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 0000004b   ecx: c02a9fe0   edx: c4c011c0
esi: 00000004   edi: 00000130   ebp: 00000000   esp: c2eeda34
ds: 007b   es: 007b   ss: 0068
Stack: c10f8584 c10b8ac6 ffffffff 00000026 00000010 c02da2cc c10b8cb4 c4c011c0 
       07070707 00000000 c3f53378 c2eeda94 c10b8cda e0eeda9c c01d1b67 c02da2cc 
       c2eeda94 c2eeda94 c02da2cc c3f53378 002ea7d7 c02da418 c2eeda94 c8f52288 
Call Trace: [<c01d1b67>]  [<c01e1167>]  [<c01d8577>]  [<c012627b>]  [<c01d939e>]  [<c01ba538>]  [<c0114286>]  [<c01142eb>]  [<c01143c9>]  [<c01145ae>]  [<c0114537>]  [<c011005b>]  [<c010fe00>]  [<c01e2aad>]  [<c01e2aad>]  [<c0108d0d>]  [<c01e1a2d>]  [<c01e19d0>]  [<c01e1fe3>]  [<c01e1167>]  [<c01e1107>]  [<c01d868b>]  [<c01da118>]  [<c01b6652>]  [<c01b7ba0>]  [<c01b8f22>]  [<c01ba13a>]  [<c01ba7a6>]  [<c01ac1ab>]  [<c01ae33c>]  [<c0111484>]  [<c0111484>]  [<c01a9829>]  [<c01ae1f4>]  [<c013c0ac>]  [<c013c159>]  [<c0108aa7>] 
Code: 89 02 83 c2 04 89 54 24 1c 85 f6 75 09 be 08 00 00 00 ff 44 


>>EIP; c01e2d03 <cfb_imageblit+323/6a0>   <=====

>>ecx; c02a9fe0 <cfb_tab8+0/40>
>>edx; c4c011c0 <__crc_single_release+39ecce/3f2bab>
>>esp; c2eeda34 <__crc_xfrm_policy_register_afinfo+2f842/6cfe28>

Trace; c01d1b67 <lba_28_rw_disk+af/bc>
Trace; c01e1167 <neofb_imageblit+2b/30>
Trace; c01d8577 <accel_putcs+2d7/314>
Trace; c012627b <__lock_page+a3/ac>
Trace; c01d939e <fbcon_putcs+6e/74>
Trace; c01ba538 <vt_console_print+278/2d0>
Trace; c0114286 <__call_console_drivers+3e/50>
Trace; c01142eb <_call_console_drivers+53/58>
Trace; c01143c9 <call_console_drivers+d9/e0>
Trace; c01145ae <release_console_sem+2e/84>
Trace; c0114537 <printk+ff/114>
Trace; c011005b <do_page_fault+25b/413>
Trace; c010fe00 <do_page_fault+0/413>
Trace; c01e2aad <cfb_imageblit+cd/6a0>
Trace; c01e2aad <cfb_imageblit+cd/6a0>
Trace; c0108d0d <error_code+2d/40>
Trace; c01e1a2d <bitfill32+5d/ec>
Trace; c01e19d0 <bitfill32+0/ec>
Trace; c01e1fe3 <cfb_fillrect+18f/29c>
Trace; c01e1167 <neofb_imageblit+2b/30>
Trace; c01e1107 <neofb_fillrect+2b/30>
Trace; c01d868b <accel_clear_margins+d7/e4>
Trace; c01da118 <fbcon_scroll+468/9bc>
Trace; c01b6652 <scrup+76/108>
Trace; c01b7ba0 <lf+34/60>
Trace; c01b8f22 <do_con_trol+166/d78>
Trace; c01ba13a <do_con_write+606/6cc>
Trace; c01ba7a6 <con_put_char+2e/34>
Trace; c01ac1ab <opost+1c3/1d0>
Trace; c01ae33c <write_chan+148/21c>
Trace; c0111484 <default_wake_function+0/20>
Trace; c0111484 <default_wake_function+0/20>
Trace; c01a9829 <tty_write+19d/220>
Trace; c01ae1f4 <write_chan+0/21c>
Trace; c013c0ac <vfs_write+a0/d0>
Trace; c013c159 <sys_write+31/4c>
Trace; c0108aa7 <syscall_call+7/b>

Code;  c01e2d03 <cfb_imageblit+323/6a0>
00000000 <_EIP>:
Code;  c01e2d03 <cfb_imageblit+323/6a0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c01e2d05 <cfb_imageblit+325/6a0>
   2:   83 c2 04                  add    $0x4,%edx
Code;  c01e2d08 <cfb_imageblit+328/6a0>
   5:   89 54 24 1c               mov    %edx,0x1c(%esp,1)
Code;  c01e2d0c <cfb_imageblit+32c/6a0>
   9:   85 f6                     test   %esi,%esi
Code;  c01e2d0e <cfb_imageblit+32e/6a0>
   b:   75 09                     jne    16 <_EIP+0x16>
Code;  c01e2d10 <cfb_imageblit+330/6a0>
   d:   be 08 00 00 00            mov    $0x8,%esi
Code;  c01e2d15 <cfb_imageblit+335/6a0>
  12:   ff 44 00 00               incl   0x0(%eax,%eax,1)


Cheers,

        Alex

P.S.: Please CC me as I am not subscibed to this list.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
