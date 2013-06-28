From: "Alexandra N. Kossovsky" <Alexandra.Kossovsky@oktetlabs.ru>
Date: Fri, 28 Jun 2013 17:34:46 +0000
Subject: possible circular locking dependency in efifb
Message-Id: <20130628173444.GA24717@sanechka.spb.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Kernel 3.9.6 with lockdep prints following:

[  600.453133] ===========================
[  600.453133] [ INFO: possible circular locking dependency detected ]
[  600.453134] 3.9.6-1-debug-amd64 #1 Tainted: G        W  O
[  600.453135] -------------------------------------------------------
[  600.453135] kworker/0:0/4 is trying to acquire lock:
[  600.453140]  (&fb_info->lock){+.+.+.}, at: [<ffffffff81242e88>] lock_fb_info+0x18/0x37
[  600.453141] 
[  600.453141] but task is already holding lock:
[  600.453144]  (console_lock){+.+.+.}, at: [<ffffffff812ae160>] console_callback+0xa/0xf3
[  600.453144] 
[  600.453144] which lock already depends on the new lock.
[  600.453144] 
[  600.453144] 
[  600.453144] the existing dependency chain (in reverse order) is:
[  600.453145] 
[  600.453145] -> #1 (console_lock){+.+.+.}:
[  600.453148]        [<ffffffff81092274>] lock_acquire+0x10a/0x15f
[  600.453150]        [<ffffffff81044551>] console_lock+0x69/0x6b
[  600.453151]        [<ffffffff81243c57>] register_framebuffer+0x201/0x278
[  600.453153]        [<ffffffff81af4aea>] efifb_probe+0x408/0x48f
[  600.453156]        [<ffffffff812cd81c>] platform_drv_probe+0x34/0x5e
[  600.453157]        [<ffffffff812cc00d>] driver_probe_device+0x98/0x1b1
[  600.453159]        [<ffffffff812cc174>] __driver_attach+0x4e/0x6f
[  600.453160]        [<ffffffff812ca7bf>] bus_for_each_dev+0x57/0x8a
[  600.453161]        [<ffffffff812cbb2c>] driver_attach+0x19/0x1b
[  600.453162]        [<ffffffff812cb7d0>] bus_add_driver+0xde/0x201
[  600.453164]        [<ffffffff812cc6db>] driver_register+0x8c/0x110
[  600.453165]        [<ffffffff812cd2b1>] platform_driver_register+0x41/0x43
[  600.453167]        [<ffffffff812cd2cb>] platform_driver_probe+0x18/0x8a
[  600.453168]        [<ffffffff81af46c3>] efifb_init+0x276/0x295
[  600.453170]        [<ffffffff810020b4>] do_one_initcall+0x7a/0x136
[  600.453172]        [<ffffffff81ac7ecf>] kernel_init_freeable+0x13f/0x1cc
[  600.453174]        [<ffffffff813de02a>] kernel_init+0x9/0xd6
[  600.453177]        [<ffffffff814005bc>] ret_from_fork+0x7c/0xb0
[  600.453178] 
[  600.453178] -> #0 (&fb_info->lock){+.+.+.}:
[  600.453179]        [<ffffffff81091a17>] __lock_acquire+0xa64/0xdc0
[  600.453180]        [<ffffffff81092274>] lock_acquire+0x10a/0x15f
[  600.453182]        [<ffffffff813f81b7>] __mutex_lock_common+0x5d/0x371
[  600.453183]        [<ffffffff813f85c6>] mutex_lock_nested+0x3b/0x40
[  600.453184]        [<ffffffff81242e88>] lock_fb_info+0x18/0x37
[  600.453185]        [<ffffffff8124cab2>] fbcon_blank+0x168/0x1ee
[  600.453187]        [<ffffffff812abc46>] do_blank_screen+0x13e/0x1d8
[  600.453188]        [<ffffffff812ae220>] console_callback+0xca/0xf3
[  600.453190]        [<ffffffff8105d4b3>] process_one_work+0x249/0x416
[  600.453191]        [<ffffffff8105dea6>] worker_thread+0x121/0x1ce
[  600.453193]        [<ffffffff81065b2d>] kthread+0xac/0xb4
[  600.453194]        [<ffffffff814005bc>] ret_from_fork+0x7c/0xb0
[  600.453194] 
[  600.453194] other info that might help us debug this:
[  600.453194] 
[  600.453195]  Possible unsafe locking scenario:
[  600.453195] 
[  600.453195]        CPU0                    CPU1
[  600.453195]        ----                    ----
[  600.453196]   lock(console_lock);
[  600.453197]                                lock(&fb_info->lock);
[  600.453197]                                lock(console_lock);
[  600.453198]   lock(&fb_info->lock);
[  600.453198] 
[  600.453198]  *** DEADLOCK ***
[  600.453198] 
[  600.453199] 3 locks held by kworker/0:0/4:
[  600.453201]  #0:  (events){.+.+.+}, at: [<ffffffff8105d3e9>] process_one_work+0x17f/0x416
[  600.453203]  #1:  (console_work){+.+...}, at: [<ffffffff8105d3e9>] process_one_work+0x17f/0x416
[  600.453205]  #2:  (console_lock){+.+.+.}, at: [<ffffffff812ae160>] console_callback+0xa/0xf3
[  600.453205] 
[  600.453205] stack backtrace:
[  600.453206] Pid: 4, comm: kworker/0:0 Tainted: G        W  O 3.9.6-1-debug-amd64 #1
[  600.453206] Call Trace:
[  600.453209]  [<ffffffff813f39d3>] print_circular_bug+0x1f6/0x204
[  600.453211]  [<ffffffff81091a17>] __lock_acquire+0xa64/0xdc0
[  600.453212]  [<ffffffff81092274>] lock_acquire+0x10a/0x15f
[  600.453213]  [<ffffffff81242e88>] ? lock_fb_info+0x18/0x37
[  600.453214]  [<ffffffff813f81b7>] __mutex_lock_common+0x5d/0x371
[  600.453216]  [<ffffffff81242e88>] ? lock_fb_info+0x18/0x37
[  600.453217]  [<ffffffff81242e88>] ? lock_fb_info+0x18/0x37
[  600.453218]  [<ffffffff8108f45d>] ? lock_is_held+0x4e/0x5f
[  600.453219]  [<ffffffff813f85c6>] mutex_lock_nested+0x3b/0x40
[  600.453220]  [<ffffffff81242e88>] lock_fb_info+0x18/0x37
[  600.453221]  [<ffffffff8124cab2>] fbcon_blank+0x168/0x1ee
[  600.453223]  [<ffffffff810926d2>] ? trace_hardirqs_on_caller+0x117/0x173
[  600.453224]  [<ffffffff813fa6a5>] ? _raw_spin_unlock_irqrestore+0x48/0x5c
[  600.453226]  [<ffffffff81052285>] ? try_to_del_timer_sync+0x5c/0x67
[  600.453228]  [<ffffffff812abc46>] do_blank_screen+0x13e/0x1d8
[  600.453229]  [<ffffffff812ae220>] console_callback+0xca/0xf3
[  600.453230]  [<ffffffff8105d4b3>] process_one_work+0x249/0x416
[  600.453231]  [<ffffffff8105d3e9>] ? process_one_work+0x17f/0x416
[  600.453232]  [<ffffffff8105dea6>] worker_thread+0x121/0x1ce
[  600.453233]  [<ffffffff8105dd85>] ? manage_workers+0x23c/0x23c
[  600.453234]  [<ffffffff81065b2d>] kthread+0xac/0xb4
[  600.453235]  [<ffffffff81065a81>] ? __kthread_parkme+0x60/0x60
[  600.453237]  [<ffffffff814005bc>] ret_from_fork+0x7c/0xb0
[  600.453238]  [<ffffffff81065a81>] ? __kthread_parkme+0x60/0x60

Feel free to ask me to try a patch or another kernel version.

-- 
Alexandra N. Kossovsky
OKTET Labs (http://www.oktetlabs.ru/)
e-mail: sasha@oktetlabs.ru
