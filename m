From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [fbdev] Lockdep error
Date: Mon, 15 Sep 2008 16:21:52 +0400
Message-ID: <20080915122152.GA4570@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KfD8Y-0002BY-PP for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Sep 2008 05:25:03 -0700
Received: from mail-gx0-f19.google.com ([209.85.217.19])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KfD8X-0002Ry-JM
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Sep 2008 05:25:02 -0700
Received: by gxk12 with SMTP id 12so23437694gxk.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 15 Sep 2008 05:24:55 -0700 (PDT)
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: rpurdie@rpsys.net, adaplas@gmail.com

Hi,

After doing
# echo 1 > /sys/class/graphics/fb0/blank
I got the following in my kernel log:

=============================================
[ INFO: possible recursive locking detected ]
2.6.27-rc6-00086-gda63874-dirty #97
---------------------------------------------
echo/1564 is trying to acquire lock:
 ((fb_notifier_list).rwsem){..--}, at: [<c005a384>] __blocking_notifier_call_chain+0x38/0x6c

but task is already holding lock:
 ((fb_notifier_list).rwsem){..--}, at: [<c005a384>] __blocking_notifier_call_chain+0x38/0x6c

other info that might help us debug this:
2 locks held by echo/1564:
 #0:  (&buffer->mutex){--..}, at: [<c00ddde0>] sysfs_write_file+0x30/0x80
 #1:  ((fb_notifier_list).rwsem){..--}, at: [<c005a384>] __blocking_notifier_call_chain+0x38/0x6c

stack backtrace:
[<c0029fe4>] (dump_stack+0x0/0x14) from [<c0060ce0>] (print_deadlock_bug+0xa4/0xd0)
[<c0060c3c>] (print_deadlock_bug+0x0/0xd0) from [<c0060e54>] (check_deadlock+0x148/0x17c)
 r6:c397a1e0 r5:c397a530 r4:c04fcf98
[<c0060d0c>] (check_deadlock+0x0/0x17c) from [<c00637e8>] (validate_chain+0x3c4/0x4f0)
[<c0063424>] (validate_chain+0x0/0x4f0) from [<c0063efc>] (__lock_acquire+0x5e8/0x6b4)
[<c0063914>] (__lock_acquire+0x0/0x6b4) from [<c006402c>] (lock_acquire+0x64/0x78)
[<c0063fc8>] (lock_acquire+0x0/0x78) from [<c0316ca8>] (down_read+0x4c/0x60)
 r7:00000009 r6:ffffffff r5:c0427a40 r4:c005a384
[<c0316c5c>] (down_read+0x0/0x60) from [<c005a384>] (__blocking_notifier_call_chain+0x38/0x6c)
 r5:c0427a40 r4:c0427a74
[<c005a34c>] (__blocking_notifier_call_chain+0x0/0x6c) from [<c005a3d8>] (blocking_notifier_call_chain+0x20/0x28)
 r8:00000009 r7:c086d640 r6:c3967940 r5:00000000 r4:c38984b8
[<c005a3b8>] (blocking_notifier_call_chain+0x0/0x28) from [<c014baa0>] (fb_notifier_call_chain+0x1c/0x24)
[<c014ba84>] (fb_notifier_call_chain+0x0/0x24) from [<c014c18c>] (fb_blank+0x64/0x70)
[<c014c128>] (fb_blank+0x0/0x70) from [<c0155978>] (fbcon_blank+0x114/0x1bc)
 r5:00000001 r4:c38984b8
[<c0155864>] (fbcon_blank+0x0/0x1bc) from [<c0170ea8>] (do_blank_screen+0x1e0/0x2a0)
[<c0170cc8>] (do_blank_screen+0x0/0x2a0) from [<c0154024>] (fbcon_fb_blanked+0x74/0x94)
 r5:c3967940 r4:00000001
[<c0153fb0>] (fbcon_fb_blanked+0x0/0x94) from [<c0154228>] (fbcon_event_notify+0x100/0x12c)
 r5:fffffffe r4:c39bc194
[<c0154128>] (fbcon_event_notify+0x0/0x12c) from [<c005a0d4>] (notifier_call_chain+0x38/0x7c)
[<c005a09c>] (notifier_call_chain+0x0/0x7c) from [<c005a3a0>] (__blocking_notifier_call_chain+0x54/0x6c)
 r8:c3b51ea0 r7:00000009 r6:ffffffff r5:c0427a40 r4:c0427a74
[<c005a34c>] (__blocking_notifier_call_chain+0x0/0x6c) from [<c005a3d8>] (blocking_notifier_call_chain+0x20/0x28)
 r8:00000001 r7:c3a7e000 r6:00000000 r5:00000000 r4:c38984b8
[<c005a3b8>] (blocking_notifier_call_chain+0x0/0x28) from [<c014baa0>] (fb_notifier_call_chain+0x1c/0x24)
[<c014ba84>] (fb_notifier_call_chain+0x0/0x24) from [<c014c18c>] (fb_blank+0x64/0x70)
[<c014c128>] (fb_blank+0x0/0x70) from [<c014e450>] (store_blank+0x54/0x7c)
 r5:c38984b8 r4:c3b51ec4
[<c014e3fc>] (store_blank+0x0/0x7c) from [<c017981c>] (dev_attr_store+0x28/0x2c)
 r8:00000001 r7:c042bf80 r6:c39eba10 r5:c3967c30 r4:c38e0140
[<c01797f4>] (dev_attr_store+0x0/0x2c) from [<c00ddaac>] (flush_write_buffer+0x54/0x68)
[<c00dda58>] (flush_write_buffer+0x0/0x68) from [<c00dde08>] (sysfs_write_file+0x58/0x80)
 r8:c3b51f78 r7:c3bcb070 r6:c39eba10 r5:00000001 r4:00000001
[<c00dddb0>] (sysfs_write_file+0x0/0x80) from [<c009de04>] (vfs_write+0xb8/0x148)
[<c009dd4c>] (vfs_write+0x0/0x148) from [<c009e384>] (sys_write+0x44/0x70)
 r7:00000004 r6:c3bcb070 r5:00000000 r4:00000000
[<c009e340>] (sys_write+0x0/0x70) from [<c0025d00>] (ret_fast_syscall+0x0/0x2c)
 r6:4001b000 r5:00000001 r4:401dc658

-- 
With best wishes
Dmitry


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
