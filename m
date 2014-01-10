From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 10 Jan 2014 17:25:11 +0000
Subject: Re: [Intel-gfx] [PATCH] fbcon: Avoid corrupting active workqueue entries
Message-Id: <20140110172511.GG4770@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387290459-26440-1-git-send-email-chris@chris-wilson.co.uk>
In-Reply-To: <1387290459-26440-1-git-send-email-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, stable@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Tue, Dec 17, 2013 at 02:27:39PM +0000, Chris Wilson wrote:
> We attempt to reschedule an active work which can itself corrupt the
> workqueue lists, and we may then free the work item whilst the task is
> still pending. Both of these may lead to a system deadlock and an
> unresponsive machine without any outputs for a panic to even be shown.
> 
> [    7.372961] WARNING: at kernel/workqueue.c:1365 __queue_work+0x216/0x292()
> [    7.372964] Modules linked in: coretemp arc4 kvm_intel kvm iwldvm crc32c_intel mac80211 ghash_clmulni_intel cryptd joydev hid_lenovo_tpkbd lib80211 iTCO_wdt iwlwifi iTCO_vendor_support i915(+) btusb snd_hda_codec_hdmi bluetooth evdev snd_hda_intel usbhid snd_hda_codec pcspkr hid cfg80211 microcode snd_hwdep i2c_i801 snd_pcm drm_kms_helper lpc_ich drm mfd_core snd_page_alloc rfkill snd_timer snd soundcore mei_me i2c_algo_bit video mei acpi_cpufreq mperf i2c_core button processor ext4 crc16 jbd2 mbcache sg sd_mod crc_t10dif ahci libahci libata scsi_mod thermal fan ehci_pci ehci_hcd thermal_sys usbcore usb_common
> [    7.373068] CPU: 0 PID: 660 Comm: ps Not tainted 3.10.9+ #55
> [    7.373071] Hardware name:                  /D33217CK, BIOS GKPPT10H.86A.0025.2012.1011.1534 10/11/2012
> [    7.373075]  ffffffff81596a1e ffff88045f203d38 ffffffff813eaef6 ffff88045f203d78
> [    7.373083]  ffffffff81041027 ffff88045f203d78 0000000000000000 ffff88045f217f00
> [    7.373091]  ffff88044a89c800 ffff88042b473aa0 0000000000000000 ffff88045f203d88
> [    7.373098] Call Trace:
> [    7.373101]  <IRQ>  [<ffffffff813eaef6>] dump_stack+0x19/0x1b
> [    7.373115]  [<ffffffff81041027>] warn_slowpath_common+0x62/0x7b
> [    7.373121]  [<ffffffff81041055>] warn_slowpath_null+0x15/0x17
> [    7.373127]  [<ffffffff8105aa82>] __queue_work+0x216/0x292
> [    7.373133]  [<ffffffff8105ab65>] queue_work_on+0x4c/0x7c
> [    7.373140]  [<ffffffff8123cebb>] ? fbcon_add_cursor_timer+0xfb/0xfb
> [    7.373146]  [<ffffffff8123cee1>] cursor_timer_handler+0x26/0x42
> [    7.373153]  [<ffffffff8104ee1f>] call_timer_fn+0xcc/0x1ea
> [    7.373160]  [<ffffffff8104ed53>] ? detach_if_pending+0x7a/0x7a
> [    7.373166]  [<ffffffff8123cebb>] ? fbcon_add_cursor_timer+0xfb/0xfb
> [    7.373172]  [<ffffffff8104f27b>] run_timer_softirq+0x19c/0x1e4
> [    7.373178]  [<ffffffff8104874e>] ? __do_softirq+0x9e/0x2a7
> [    7.373183]  [<ffffffff810487e9>] __do_softirq+0x139/0x2a7
> [    7.373189]  [<ffffffff81048a7a>] irq_exit+0x56/0x9b
> [    7.373196]  [<ffffffff8102af31>] smp_apic_timer_interrupt+0x77/0x85
> [    7.373203]  [<ffffffff813f5ff2>] apic_timer_interrupt+0x72/0x80
> [    7.373206]  <EOI>  [<ffffffff8113ea70>] ? spin_lock+0x9/0xb
> [    7.373217]  [<ffffffff8120d8c1>] ? do_raw_spin_trylock+0x42/0x42
> [    7.373223]  [<ffffffff813ef2e0>] ? _raw_spin_unlock+0x23/0x36
> [    7.373229]  [<ffffffff8113ea7b>] spin_unlock+0x9/0xb
> [    7.373235]  [<ffffffff8113fd25>] dput+0xd9/0xf8
> [    7.373241]  [<ffffffff8113685e>] path_put+0x13/0x20
> [    7.373247]  [<ffffffff8113a6f3>] do_last+0x925/0xa0d
> [    7.373253]  [<ffffffff81137fa4>] ? inode_permission+0x40/0x42
> [    7.373259]  [<ffffffff8113a89c>] path_openat+0xc1/0x325
> [    7.373265]  [<ffffffff8113ae0c>] do_filp_open+0x33/0x81
> [    7.373271]  [<ffffffff811455bd>] ? __alloc_fd+0x169/0x17b
> [    7.373279]  [<ffffffff8112d78f>] do_sys_open+0x67/0xf4
> [    7.373285]  [<ffffffff8112d839>] SyS_open+0x1d/0x1f
> [    7.373290]  [<ffffffff813f5369>] system_call_fastpath+0x16/0x1b
> [    7.373294] ---[ end trace 78bba0b9776072a9 ]---
> [    7.538936] fbcon: inteldrmfb (fb0) is primary device
> [    7.539446] Console: switching consoles 2-6 to frame buffer device
> [    7.539463] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
> [    7.539468] i915 0000:00:02.0: registered panic notifier
> 
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?idr765
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: stable@vger.kernel.org
> ---
>  drivers/video/console/fbcon.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index cd8a8027f8ae..f474976f6b34 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -397,6 +397,8 @@ static void fb_flashcursor(struct work_struct *work)
>  	ops->cursor(vc, info, mode, softback_lines, get_color(vc, info, c, 1),
>  		    get_color(vc, info, c, 0));
>  	console_unlock();
> +
> +	mod_timer(&ops->cursor_timer, jiffies + HZ/5);
>  }
>  
>  static void cursor_timer_handler(unsigned long dev_addr)
> @@ -405,7 +407,6 @@ static void cursor_timer_handler(unsigned long dev_addr)
>  	struct fbcon_ops *ops = info->fbcon_par;
>  
>  	queue_work(system_power_efficient_wq, &info->queue);
> -	mod_timer(&ops->cursor_timer, jiffies + HZ/5);
>  }
>  
>  static void fbcon_add_cursor_timer(struct fb_info *info)
> @@ -417,6 +418,8 @@ static void fbcon_add_cursor_timer(struct fb_info *info)
>  	    !fbcon_cursor_noblink) {
>  		if (!info->queue.func)
>  			INIT_WORK(&info->queue, fb_flashcursor);
> +		else
> +			flush_work(&info->queue);
>  
>  		init_timer(&ops->cursor_timer);
>  		ops->cursor_timer.function = cursor_timer_handler;
> @@ -433,6 +436,7 @@ static void fbcon_del_cursor_timer(struct fb_info *info)
>  
>  	if (info->queue.func = fb_flashcursor &&
>  	    ops->flags & FBCON_FLAGS_CURSOR_TIMER) {
> +		flush_work(&info->queue);
>  		del_timer_sync(&ops->cursor_timer);

I think this is still racy - we'd need to loop the flush work and
del_timer until they're both dead, otherwise it could get re-armed.
Probably better to convert this to a delayed_work and just use
cancel_delayed_work_sync.
-Daniel

>  		ops->flags &= ~FBCON_FLAGS_CURSOR_TIMER;
>  	}
> -- 
> 1.8.5.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
