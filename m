From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: request_mem_region problem ...
Date: Fri, 1 Nov 2002 11:52:42 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021101105242.GA702@iliana>
References: <20021030130016.GA1573@iliana> <1036024416.644.23.camel@daplas> <20021031081007.GB617@iliana> <1036062270.638.25.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187ZQB-0005gF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Nov 2002 02:52:59 -0800
Content-Disposition: inline
In-Reply-To: <1036062270.638.25.camel@daplas>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Oct 31, 2002 at 07:05:13PM +0800, Antonino Daplas wrote:
> Running ksymoops on that might help.  The source can be found at
> ftp.kernel.org.  

Ok, got it from the debian package :)))

Erm, i am no more running the same kernel, so i specified the -o and the
-m options, but it looks at the wrong /proc/ksyms, should i save the
/proc/ksyms of kernel before/after insmodding the pm3fb module ?

> If you define FBCON_HAS_ACCEL, then fb_imageblit, fb_copyarea and
> fb_fillrect in info->fbops must not be null.  Otherwise, you'll always
> get an oops. If you don't define FBCON_HAS_ACCEL, you'll end up with
> fbcon_dummy, which is totally safe but will not show anything at all. 
> This is all assuming you use gen_set_var.  

Ok, i did copy the cfb_ functions to the driver, it works better (the
box does not hang anymore), the console apprently works (the cursor
blinks in the right place, and it could type stuff, switch VT and
shutdown the box) but there is nothing else written.

BTW, what is the difference between the full cursor and the underline
one ?

Anyway, here are the two Oops :


Nov  1 11:16:10 iliana kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000024
Nov  1 11:16:10 iliana kernel:  printing eip:
Nov  1 11:16:10 iliana kernel: c023a5a5
Nov  1 11:16:10 iliana kernel: *pde = 00000000
Nov  1 11:16:10 iliana kernel: Oops: 0000
Nov  1 11:16:10 iliana kernel: pm3fb nls_iso8859-15 nls_cp437 sym53c8xx  
Nov  1 11:16:10 iliana kernel: CPU:    0
Nov  1 11:16:10 iliana kernel: EIP:    0060:[fbcon_setup+677/2368]    Not tainted
Nov  1 11:16:10 iliana kernel: EFLAGS: 00010212
Nov  1 11:16:10 iliana kernel: eax: 00000080   ebx: 00000008   ecx: 00000007   edx: 00000000
Nov  1 11:16:10 iliana kernel: esi: 0000003f   edi: c042d37c   ebp: c1143240   esp: c3cfbdbc
Nov  1 11:16:10 iliana kernel: ds: 0068   es: 0068   ss: 0068
Nov  1 11:16:10 iliana kernel: Process modprobe (pid: 561, threadinfo=c3cfa000 task=c5aeacc0)
Nov  1 11:16:10 iliana kernel: Stack: c7941000 c7941294 c042d37c c1143240 00003389 000033af 00000004 00003386 
Nov  1 11:16:10 iliana kernel:        c00beea0 00000001 00000100 00000000 c03dfeaf 00000000 c1143240 c7941000 
Nov  1 11:16:10 iliana kernel:        c042d280 c023a1f7 00000000 00000000 00000000 00000000 00000000 c04156c0 
Nov  1 11:16:10 iliana kernel: Call Trace: [fbcon_init+151/192]  [visual_init+138/224]  [take_over_console+170/400]  [register_framebuffer+353/432]  [<c887b6f1>]  [<c887b123>]  [<c887b9e8>]  [pci_device_probe+65/96]  [<c887b980>]  [<c887b9e8>]  [<c887b9e8>]  [<c887b9c0>]  [bus_match+52/96]  [driver_attach+64/128]  [<c887b9e8>]  [<c887b9e8>]  [bus_add_driver+87/128]  [<c887b9e8>]  [<c887b9e8>]  [<c887a066>]  [driver_register+50/80]  [<c887b9e8>]  [pci_register_driver+54/80]  [<c887b9e8>]  [<c887b287>]  [<c887b9c0>]  [sys_init_module+1309/1536]  [<c887a060>]  [syscall_call+7/11] 
Nov  1 11:16:10 iliana kernel: Code: 85 42 24 75 1c 53 68 00 41 33 c0 e8 4b f0 ed ff 8b 74 24 48 

And :

Nov  1 11:16:30 iliana kernel:  <1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference at virtual address 00000018
Nov  1 11:16:30 iliana kernel:  printing eip:
Nov  1 11:16:30 iliana kernel: c023b00c
Nov  1 11:16:30 iliana kernel: *pde = 00000000
Nov  1 11:16:30 iliana kernel: Oops: 0000
Nov  1 11:16:30 iliana kernel: pm3fb nls_iso8859-15 nls_cp437 sym53c8xx  
Nov  1 11:16:30 iliana kernel: CPU:    0
Nov  1 11:16:30 iliana kernel: EIP:    0060:[fbcon_cursor+108/480]    Not tainted
Nov  1 11:16:30 iliana kernel: EFLAGS: 00010246
Nov  1 11:16:30 iliana kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c1143240
Nov  1 11:16:30 iliana kernel: esi: c042d280   edi: 00000002   ebp: 00000018   esp: c7fb1d78
Nov  1 11:16:30 iliana kernel: ds: 0068   es: 0068   ss: 0068
Nov  1 11:16:30 iliana kernel: Process events/0 (pid: 3, threadinfo=c7fb0000 task=c7fbccc0)
Nov  1 11:16:30 iliana kernel: Stack: 00000000 c04156c0 00000000 0000000e c01f21f8 c1143240 00000002 00000000 
Nov  1 11:16:30 iliana kernel:        c04156c0 c01f5435 00000000 c039efa0 c03e0387 00003887 000038ba c795e040 
Nov  1 11:16:30 iliana kernel:        00000000 c5a69e5c 00000000 c0119439 c039efa0 c03e0387 00000033 000038ba 
Nov  1 11:16:30 iliana kernel: Call Trace: [hide_cursor+120/128]  [vt_console_print+165/736]  [__call_console_drivers+57/80]  [_call_console_drivers+87/96]  [call_console_drivers+217/224]  [release_console_sem+77/192]  [printk+303/352]  [do_page_fault+618/1076]  [do_page_fault+0/1076]  [run_timer_tasklet+231/304]  [delayed_work_timer_fn+0/96]  [tasklet_hi_action+61/112]  [do_softirq+90/176]  [do_IRQ+240/272]  [apic_timer_interrupt+26/32]  [error_code+45/56]  [fbcon_switch+335/448]  [redraw_screen+224/336]  [complete_change_console+43/192]  [change_console+137/144]  [console_callback+58/176]  [worker_thread+482/720]  [worker_thread+0/720]  [console_callback+0/176]  [default_wake_function+0/64]  [default_wake_function+0/64]  [kernel_thread_helper+5/16] 
Nov  1 11:16:30 iliana kernel: Code: 83 7b 18 00 74 4e 8b 54 24 14 8b 8e cc 00 00 00 0f b7 42 2c 

I don't believe the result of running ksymoops on these are valid, i
will have to reboot in the 2.5.44 kernel for it.

> If you did not define fb_set_var at all, then info->disp.dispsw must
> point to valid console drawing hooks before you register the
> framebuffer.  (Actually, all fields in struct display must be valid
> before you register the framebuffer)

Mmm, still need to check those.

> Your oops tracing points to fbcon_cursor as the culprit.  If
> dispsw->cursor is NULL, then you must have a valid dispsw->revc.

There where two oops, the first in fbcon_setup, and the second in
fbcon_cursor, i think i will be looking in the first oops first.

Anyway, thanks for your help.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
