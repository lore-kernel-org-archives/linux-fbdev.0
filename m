From: Imre Deak <imre.deak@intel.com>
Date: Thu, 30 Jun 2016 12:47:51 +0000
Subject: Re: [PATCH] backlight: Avoid double fbcon backlight handling
Message-Id: <1467290871.5576.15.camel@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
In-Reply-To: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org
Cc: Milo Kim <milo.kim@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Jon Nettleton <jon.nettleton@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, linux-acpi@vger.kernel.org, Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Michael Hennerich <michael.hennerich@analog.com>, Jiri Kosina <jiko>

On to, 2016-06-30 at 12:30 +0100, Chris Wilson wrote:
> Backlights controlled by i915.ko and only associated with its
> connectors
> and also only associated with the intel_drmfb fbcon, controlled by
> i915.ko. In this situation, we already handle adjusting the backlight
> when the fbcon is blanked/unblanked and do not require backlight
> trying
> to do the same.
> 
> Attempting to register with the fbdev as a client causes lockdep to
> warn
> about a dependency cycle:
> 
> [   18.983763] ===========================
> [   18.983763] [ INFO: possible circular locking dependency detected
> ]
> [   18.983766] 4.7.0-rc5+ #524 Tainted: G           O
> [   18.983767] ------------------------------------------------------
> -
> [   18.983767] kworker/u8:0/6 is trying to acquire lock:
> [   18.983777]  (&dev->mode_config.mutex){+.+.+.}, at:
> [<ffffffff815afde0>] drm_modeset_lock_all+0x40/0x120
> [   18.983777]
>                but task is already holding lock:
> [   18.983782]  ((fb_notifier_list).rwsem){++++.+}, at:
> [<ffffffff810ac195>] __blocking_notifier_call_chain+0x35/0x70
> [   18.983783]
>                which lock already depends on the new lock.
> 
> [   18.983783]
>                the existing dependency chain (in reverse order) is:
> [   18.983785]
>                -> #1 ((fb_notifier_list).rwsem){++++.+}:
> [   18.983789]        [<ffffffff810df611>] lock_acquire+0xb1/0x200
> [   18.983792]        [<ffffffff819a55b4>] down_write+0x44/0x80
> [   18.983795]        [<ffffffff810abf91>]
> blocking_notifier_chain_register+0x21/0xb0
> [   18.983798]        [<ffffffff814c7448>]
> fb_register_client+0x18/0x20
> [   18.983800]        [<ffffffff814c6c86>]
> backlight_device_register+0x136/0x260
> [   18.983852]        [<ffffffffa0127eb2>]
> intel_backlight_device_register+0xa2/0x160 [i915]
> [   18.983892]        [<ffffffffa00f46be>]
> intel_connector_register+0xe/0x10 [i915]
> [   18.983932]        [<ffffffffa0112bfb>]
> intel_dp_connector_register+0x1b/0x80 [i915]
> [   18.983936]        [<ffffffff8159dfea>]
> drm_connector_register+0x4a/0x80
> [   18.983938]        [<ffffffff8159fe44>]
> drm_connector_register_all+0x64/0xf0
> [   18.983940]        [<ffffffff815a2a64>]
> drm_modeset_register_all+0x174/0x1c0
> [   18.983942]        [<ffffffff81599b72>] drm_dev_register+0xc2/0xd0
> [   18.983976]        [<ffffffffa00621d7>]
> i915_driver_load+0x1547/0x2200 [i915]
> [   18.984010]        [<ffffffffa006d80f>] i915_pci_probe+0x4f/0x70
> [i915]
> [   18.984014]        [<ffffffff814a2135>] local_pci_probe+0x45/0xa0
> [   18.984015]        [<ffffffff814a349b>]
> pci_device_probe+0xdb/0x130
> [   18.984018]        [<ffffffff815c07e3>]
> driver_probe_device+0x223/0x440
> [   18.984020]        [<ffffffff815c0ad5>] __driver_attach+0xd5/0x100
> [   18.984022]        [<ffffffff815be386>] bus_for_each_dev+0x66/0xa0
> [   18.984023]        [<ffffffff815c002e>] driver_attach+0x1e/0x20
> [   18.984025]        [<ffffffff815bf9be>] bus_add_driver+0x1ee/0x280
> [   18.984028]        [<ffffffff815c1810>] driver_register+0x60/0xe0
> [   18.984030]        [<ffffffff814a1a10>]
> __pci_register_driver+0x60/0x70
> [   18.984063]        [<ffffffffa01a905b>] i915_init+0x5b/0x62 [i915]
> [   18.984067]        [<ffffffff8100042d>] do_one_initcall+0x3d/0x150
> [   18.984070]        [<ffffffff811a935b>] do_init_module+0x5f/0x1d9
> [   18.984073]        [<ffffffff81124416>] load_module+0x20e6/0x27e0
> [   18.984075]        [<ffffffff81124d63>]
> SYSC_finit_module+0xc3/0xf0
> [   18.984076]        [<ffffffff81124dae>] SyS_finit_module+0xe/0x10
> [   18.984079]        [<ffffffff819a83a9>]
> entry_SYSCALL_64_fastpath+0x1c/0xac
> [   18.984081]
>                -> #0 (&dev->mode_config.mutex){+.+.+.}:
> [   18.984083]        [<ffffffff810df0ac>]
> __lock_acquire+0x10fc/0x1260
> [   18.984085]        [<ffffffff810df611>] lock_acquire+0xb1/0x200
> [   18.984088]        [<ffffffff819a3097>]
> mutex_lock_nested+0x67/0x3c0
> [   18.984090]        [<ffffffff815afde0>]
> drm_modeset_lock_all+0x40/0x120
> [   18.984093]        [<ffffffff8158f79b>]
> drm_fb_helper_restore_fbdev_mode_unlocked+0x2b/0x80
> [   18.984095]        [<ffffffff8158f81d>]
> drm_fb_helper_set_par+0x2d/0x50
> [   18.984134]        [<ffffffffa0105f7a>]
> intel_fbdev_set_par+0x1a/0x60 [i915]
> [   18.984136]        [<ffffffff814c13c6>] fbcon_init+0x586/0x610
> [   18.984139]        [<ffffffff8154d16a>] visual_init+0xca/0x130
> [   18.984141]        [<ffffffff8154e611>]
> do_bind_con_driver+0x1c1/0x3a0
> [   18.984143]        [<ffffffff8154eaf6>]
> do_take_over_console+0x116/0x180
> [   18.984145]        [<ffffffff814bd3a7>]
> do_fbcon_takeover+0x57/0xb0
> [   18.984147]        [<ffffffff814c1e48>]
> fbcon_event_notify+0x658/0x750
> [   18.984150]        [<ffffffff810abcae>]
> notifier_call_chain+0x3e/0xb0
> [   18.984152]        [<ffffffff810ac1ad>]
> __blocking_notifier_call_chain+0x4d/0x70
> [   18.984154]        [<ffffffff810ac1e6>]
> blocking_notifier_call_chain+0x16/0x20
> [   18.984156]        [<ffffffff814c748b>]
> fb_notifier_call_chain+0x1b/0x20
> [   18.984158]        [<ffffffff814c86b1>]
> register_framebuffer+0x251/0x330
> [   18.984160]        [<ffffffff8158fa9f>]
> drm_fb_helper_initial_config+0x25f/0x3f0
> [   18.984199]        [<ffffffffa0106b48>]
> intel_fbdev_initial_config+0x18/0x30 [i915]
> [   18.984201]        [<ffffffff810adfd8>]
> async_run_entry_fn+0x48/0x150
> [   18.984203]        [<ffffffff810a3947>]
> process_one_work+0x1e7/0x750
> [   18.984205]        [<ffffffff810a3efb>] worker_thread+0x4b/0x4f0
> [   18.984207]        [<ffffffff810aad4f>] kthread+0xef/0x110
> [   18.984208]        [<ffffffff819a85ef>] ret_from_fork+0x1f/0x40
> [   18.984209]
>                other info that might help us debug this:
> 
> [   18.984210]  Possible unsafe locking scenario:
> 
> [   18.984210]        CPU0                    CPU1
> [   18.984211]        ----                    ----
> [   18.984212]   lock((fb_notifier_list).rwsem);
> [   18.984213]                                lock(&dev-
> >mode_config.mutex);
> [   18.984215]                                lock((fb_notifier_list)
> .rwsem);
> [   18.984216]   lock(&dev->mode_config.mutex);
> [   18.984216]
>                 *** DEADLOCK ***
> 
> [   18.984217] 6 locks held by kworker/u8:0/6:
> [   18.984220]  #0:  ("events_unbound"){.+.+.+}, at:
> [<ffffffff810a38c9>] process_one_work+0x169/0x750
> [   18.984223]  #1:  ((&entry->work)){+.+.+.}, at:
> [<ffffffff810a38c9>] process_one_work+0x169/0x750
> [   18.984227]  #2:  (registration_lock){+.+.+.}, at:
> [<ffffffff814c8487>] register_framebuffer+0x27/0x330
> [   18.984231]  #3:  (console_lock){+.+.+.}, at: [<ffffffff814c86ce>]
> register_framebuffer+0x26e/0x330
> [   18.984234]  #4:  (&fb_info->lock){+.+.+.}, at:
> [<ffffffff814c78dd>] lock_fb_info+0x1d/0x40
> [   18.984238]  #5:  ((fb_notifier_list).rwsem){++++.+}, at:
> [<ffffffff810ac195>] __blocking_notifier_call_chain+0x35/0x70
> [   18.984238]
>                stack backtrace:
> [   18.984241] CPU: 2 PID: 6 Comm: kworker/u8:0 Tainted:
> G           O    4.7.0-rc5+ #524
> [   18.984242] Hardware name: Intel Corp. Broxton P/NOTEBOOK, BIOS
> APLKRVPA.X64.0138.B33.1606250842 06/25/2016
> [   18.984244] Workqueue: events_unbound async_run_entry_fn
> [   18.984248]  0000000000000000 ffff8800758577f0 ffffffff814507a5
> ffffffff828b9900
> [   18.984250]  ffffffff828b9900 ffff880075857830 ffffffff810dc6fa
> ffff880075857880
> [   18.984252]  ffff88007584d688 0000000000000005 0000000000000006
> ffff88007584d6b0
> [   18.984253] Call Trace:
> [   18.984257]  [<ffffffff814507a5>] dump_stack+0x67/0x92
> [   18.984259]  [<ffffffff810dc6fa>] print_circular_bug+0x1aa/0x200
> [   18.984261]  [<ffffffff810df0ac>] __lock_acquire+0x10fc/0x1260
> [   18.984264]  [<ffffffff810df611>] lock_acquire+0xb1/0x200
> [   18.984266]  [<ffffffff815afde0>] ?
> drm_modeset_lock_all+0x40/0x120
> [   18.984267]  [<ffffffff815afde0>] ?
> drm_modeset_lock_all+0x40/0x120
> [   18.984269]  [<ffffffff819a3097>] mutex_lock_nested+0x67/0x3c0
> [   18.984271]  [<ffffffff815afde0>] ?
> drm_modeset_lock_all+0x40/0x120
> [   18.984273]  [<ffffffff810fa85f>] ?
> rcu_read_lock_sched_held+0x7f/0x90
> [   18.984276]  [<ffffffff81208218>] ?
> kmem_cache_alloc_trace+0x248/0x2b0
> [   18.984277]  [<ffffffff815afdc5>] ?
> drm_modeset_lock_all+0x25/0x120
> [   18.984279]  [<ffffffff815afde0>] drm_modeset_lock_all+0x40/0x120
> [   18.984281]  [<ffffffff8158f79b>]
> drm_fb_helper_restore_fbdev_mode_unlocked+0x2b/0x80
> [   18.984283]  [<ffffffff8158f81d>] drm_fb_helper_set_par+0x2d/0x50
> [   18.984322]  [<ffffffffa0105f7a>] intel_fbdev_set_par+0x1a/0x60
> [i915]
> [   18.984324]  [<ffffffff814c13c6>] fbcon_init+0x586/0x610
> [   18.984326]  [<ffffffff8154d16a>] visual_init+0xca/0x130
> [   18.984328]  [<ffffffff8154e611>] do_bind_con_driver+0x1c1/0x3a0
> [   18.984330]  [<ffffffff8154eaf6>] do_take_over_console+0x116/0x180
> [   18.984332]  [<ffffffff814bd3a7>] do_fbcon_takeover+0x57/0xb0
> [   18.984334]  [<ffffffff814c1e48>] fbcon_event_notify+0x658/0x750
> [   18.984336]  [<ffffffff810abcae>] notifier_call_chain+0x3e/0xb0
> [   18.984338]  [<ffffffff810ac1ad>]
> __blocking_notifier_call_chain+0x4d/0x70
> [   18.984340]  [<ffffffff810ac1e6>]
> blocking_notifier_call_chain+0x16/0x20
> [   18.984342]  [<ffffffff814c748b>] fb_notifier_call_chain+0x1b/0x20
> [   18.984344]  [<ffffffff814c86b1>] register_framebuffer+0x251/0x330
> [   18.984347]  [<ffffffff815b7e8d>] ?
> vga_switcheroo_client_fb_set+0x5d/0x70
> [   18.984349]  [<ffffffff8158fa9f>]
> drm_fb_helper_initial_config+0x25f/0x3f0
> [   18.984388]  [<ffffffffa0106b48>]
> intel_fbdev_initial_config+0x18/0x30 [i915]
> [   18.984389]  [<ffffffff810adfd8>] async_run_entry_fn+0x48/0x150
> [   18.984391]  [<ffffffff810a3947>] process_one_work+0x1e7/0x750
> [   18.984392]  [<ffffffff810a38c9>] ? process_one_work+0x169/0x750
> [   18.984394]  [<ffffffff810a3efb>] worker_thread+0x4b/0x4f0
> [   18.984396]  [<ffffffff810a3eb0>] ? process_one_work+0x750/0x750
> [   18.984398]  [<ffffffff810aad4f>] kthread+0xef/0x110
> [   18.984401]  [<ffffffff819a85ef>] ret_from_fork+0x1f/0x40
> [   18.984402]  [<ffffffff810aac60>] ? kthread_stop+0x2e0/0x2e0
> 
> Reported-by: Imre Deak <imre.deak@intel.com>

Thanks, it gets rid of the problem:
Tested-by: Imre Deak <imre.deak@intel.com>

--Imre
