From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Fri, 31 Aug 2018 09:07:42 +0000
Subject: Re: [PATCH v2 00/12] remove_conflicting_framebuffers() cleanup
Message-Id: <153570646209.15613.3061584574975657074@skylake-alporthouse-com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
 <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
 <20180831090439.GT21634@phenom.ffwll.local>
In-Reply-To: <20180831090439.GT21634-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?b?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Quoting Daniel Vetter (2018-08-31 10:04:39)
> On Thu, Aug 30, 2018 at 11:00:01PM +0200, Michał Mirosław wrote:
> > This series cleans up duplicated code for replacing firmware FB
> > driver with proper DRI driver and adds handover support to
> > Tegra driver.
> > 
> > This is a sligtly updated version of a series sent on 24 Nov 2017.
> > 
> > v2:
> >  - rebased on current drm-next
> >  - dropped staging/sm750fb changes
> >  - added kernel docs for DRM helpers
> > 
> > Michał Mirosław (12):
> >   fbdev: show fbdev number for debugging
> >   fbdev: allow apertures = NULL in remove_conflicting_framebuffers()
> >   fbdev: add remove_conflicting_pci_framebuffers()
> >   drm/amdgpu: use simpler remove_conflicting_pci_framebuffers()
> >   drm/bochs: use simpler remove_conflicting_pci_framebuffers()
> >   drm/cirrus: use simpler remove_conflicting_pci_framebuffers()
> >   drm/mgag200: use simpler remove_conflicting_pci_framebuffers()
> >   drm/radeon: use simpler remove_conflicting_pci_framebuffers()
> >   drm/virtio: use simpler remove_conflicting_pci_framebuffers()
> >   drm/vc4: use simpler remove_conflicting_framebuffers(NULL)
> >   drm/sun4i: use simpler remove_conflicting_framebuffers(NULL)
> >   drm/tegra: kick out simplefb
> 
> Looks very neat. A bit confused about the drm changes in the fbdev-titled
> patches 1&3, but I guess we can merge as-is. Up to you whether you want to
> split or not I'd say.

Ahah, someone is looking at remove_conflicting_framebuffers(). May I
interest you in a use-after-free?

[  378.423513] stack segment: 0000 [#1] PREEMPT SMP PTI
[  378.423530] CPU: 1 PID: 4338 Comm: pm_rpm Tainted: G     U            4.19.0-rc1-CI-CI_DRM_4746+ #1
[  378.423548] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./J4205-ITX, BIOS P1.10 09/29/2016
[  378.423570] RIP: 0010:do_remove_conflicting_framebuffers+0x56/0x170
[  378.423587] Code: 49 8b 45 00 48 85 c0 74 50 f6 40 0a 08 74 4a 4d 85 e4 48 8b a8 78 04 00 00 74 1f 48 85 ed 74 1a 41 8b 0c 24 31 db 85 c9 74 10 <8b> 55 00 85 d2 75 42 83 c3 01 41 39 1c 24 77 f0 48 85 ed 74 1a 45
[  378.423620] RSP: 0018:ffffc900001dfa88 EFLAGS: 00010202
[  378.423632] RAX: ffff880274470008 RBX: 0000000000000000 RCX: 0000000000000001
[  378.423646] RDX: 0000000000000001 RSI: ffffffffa025c634 RDI: ffff88025cc3b428
[  378.423660] RBP: 6b6b6b6b6b6b6b6b R08: 000000001edaddfa R09: ffffffffa025c634
[  378.423673] R10: ffffc900001dfae8 R11: ffffffff820de938 R12: ffff88025cc3b428
[  378.423687] R13: ffffffff8234ca20 R14: ffffffff8234cb20 R15: 0000000000000001
[  378.423701] FS:  00007fcf03d0a980(0000) GS:ffff880277e80000(0000) knlGS:0000000000000000
[  378.423717] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  378.423729] CR2: 00007fffece1fdb8 CR3: 00000001fe32e000 CR4: 00000000003406e0
[  378.423742] Call Trace:
[  378.423756]  remove_conflicting_framebuffers+0x28/0x40
[  378.423856]  i915_driver_load+0x7f5/0x10c0 [i915]
[  378.423873]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[  378.423887]  ? lockdep_hardirqs_on+0xe0/0x1b0
[  378.423962]  i915_pci_probe+0x29/0xa0 [i915]
[  378.423977]  pci_device_probe+0xa1/0x130
[  378.423990]  really_probe+0x25d/0x3c0
[  378.424002]  driver_probe_device+0x10a/0x120
[  378.424013]  __driver_attach+0xdb/0x100
[  378.424025]  ? driver_probe_device+0x120/0x120
[  378.424037]  bus_for_each_dev+0x74/0xc0
[  378.424048]  bus_add_driver+0x15f/0x250
[  378.424060]  ? 0xffffffffa069d000
[  378.424070]  driver_register+0x56/0xe0
[  378.424080]  ? 0xffffffffa069d000
[  378.424090]  do_one_initcall+0x58/0x2e0
[  378.424101]  ? rcu_lockdep_current_cpu_online+0x8f/0xd0
[  378.424116]  ? do_init_module+0x1d/0x1ea
[  378.424127]  ? rcu_read_lock_sched_held+0x6f/0x80
[  378.424141]  ? kmem_cache_alloc_trace+0x264/0x290
[  378.424154]  do_init_module+0x56/0x1ea
[  378.424167]  load_module+0x26ba/0x29a0
[  378.424182]  ? vfs_read+0x122/0x140
[  378.424199]  ? __se_sys_finit_module+0xd3/0xf0
[  378.424210]  __se_sys_finit_module+0xd3/0xf0
[  378.424226]  do_syscall_64+0x55/0x190
[  378.424237]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  378.424249] RIP: 0033:0x7fcf02f9b839
[  378.424258] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[  378.424290] RSP: 002b:00007fffece21f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  378.424307] RAX: ffffffffffffffda RBX: 000056344e1a4d80 RCX: 00007fcf02f9b839
[  378.424321] RDX: 0000000000000000 RSI: 00007fcf026470e5 RDI: 0000000000000003
[  378.424336] RBP: 00007fcf026470e5 R08: 0000000000000000 R09: 0000000000000000
[  378.424349] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[  378.424363] R13: 000056344e1a0000 R14: 0000000000000000 R15: 000056344e1a4d80

https://intel-gfx-ci.01.org/tree/drm-tip/IGT_4613/fi-bxt-j4205/dmesg0.log
-Chris
