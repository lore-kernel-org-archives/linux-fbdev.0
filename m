From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 02 Aug 2016 17:47:18 +0000
Subject: Re: [Intel-gfx] [drm-intel-nightly] 2016y-07m-14d-21h-13m-02s UTC: locking dependency: drm_modeset_l
Message-Id: <CA+icZUU2Q7e5rthM9+ydPM5EtROufY1wVmg-MvKwGbPq=o3a0A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUUUUCybFnneuhVVT4Z_vymMcLp4HdCe3CDY5SerFnP+tg@mail.gmail.com>
 <87oa5ctxzm.fsf@intel.com>
In-Reply-To: <87oa5ctxzm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

On Mon, Aug 1, 2016 at 3:33 PM, Jani Nikula <jani.nikula@linux.intel.com> w=
rote:
> On Fri, 15 Jul 2016, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> Hi,
>>
>> I see the below call-trace with latest d-i-n, guess latest linux-next
>
> FWIW, "d-i-n" is ambiguous (drm-intel-next vs. drm-intel-nightly) and we
> don't use that ourselves.
>

Oh, sorry with d-i-n I meant drm-intel-nightly.
Normally, I also point to the "integration manifest"
like...drm-intel-nightly: 2016y-08m-02d-14h-10m-12s UTC integration
manifest.
You do not test d-i-n yourself?
Strange.
The Ubuntu kernel-team is regularly building packages see [1] if you
did not know.

- Sedat -

[1] http://kernel.ubuntu.com/~kernel-ppa/mainline/drm-intel-nightly/

> BR,
> Jani.
>
>
>> will cause same issues.
>> ( Beyond this, there exist also a build failure which me and Stephen
>> have reported. )
>> The call-trace is reproducible with my setup and seen on every boot.
>>
>> Not sure if this is a problem in intel-gfx or fbdev.
>>
>> My linux-config and full dmesg-output is attached.
>>
>> If you need additional informations, please let me know.
>>
>> Regards,
>> - Sedat -
>>
>> [1] https://lists.freedesktop.org/archives/intel-gfx/2016-July/100693.ht=
ml
>> [2] https://lists.freedesktop.org/archives/intel-gfx/2016-July/100691.ht=
ml
>>
>> P.S.: INFO: possible circular locking dependency detected
>>
>> [   16.955703] fbcon: inteldrmfb (fb0) is primary device
>> [   16.956579]
>> [   16.956580] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> [   16.956581] [ INFO: possible circular locking dependency detected ]
>> [   16.956583] 4.7.0-rc7-4-iniza-small #1 Not tainted
>> [   16.956583] -------------------------------------------------------
>> [   16.956585] kworker/u16:1/79 is trying to acquire lock:
>> [   16.956618]  (&dev->mode_config.mutex){+.+.+.}, at:
>> [<ffffffffa00f2b30>] drm_modeset_lock_all+0x40/0x120 [drm]
>> [   16.956619]
>> [   16.956619] but task is already holding lock:
>> [   16.956626]  ((fb_notifier_list).rwsem){++++.+}, at:
>> [<ffffffff810aae25>] __blocking_notifier_call_chain+0x35/0x70
>> [   16.956627]
>> [   16.956627] which lock already depends on the new lock.
>> [   16.956627]
>> [   16.956627]
>> [   16.956627] the existing dependency chain (in reverse order) is:
>> [   16.956631]
>> [   16.956631] -> #1 ((fb_notifier_list).rwsem){++++.+}:
>> [   16.956635]        [<ffffffff810dff49>] lock_acquire+0x119/0x220
>> [   16.956639]        [<ffffffff8182afd9>] down_write+0x49/0x80
>> [   16.956642]        [<ffffffff810aafb1>]
>> blocking_notifier_chain_register+0x21/0xb0
>> [   16.956646]        [<ffffffff814a17c8>] fb_register_client+0x18/0x20
>> [   16.956648]        [<ffffffff814a108b>] backlight_device_register+0x1=
2b/0x240
>> [   16.956710]        [<ffffffffa058b5f2>]
>> intel_backlight_device_register+0xa2/0x170 [i915]
>> [   16.956764]        [<ffffffffa05591ee>]
>> intel_connector_register+0xe/0x10 [i915]
>> [   16.956778]        [<ffffffffa00e14ba>]
>> drm_connector_register+0x4a/0x80 [drm]
>> [   16.956792]        [<ffffffffa00e5903>]
>> drm_modeset_register_all+0x163/0x1c0 [drm]
>> [   16.956805]        [<ffffffffa00dcc52>] drm_dev_register+0xc2/0xd0 [d=
rm]
>> [   16.956848]        [<ffffffffa04c82f3>] i915_driver_load+0x753/0x13e0=
 [i915]
>> [   16.956892]        [<ffffffffa04d367f>] i915_pci_probe+0x4f/0x70 [i91=
5]
>> [   16.956896]        [<ffffffff8146e215>] local_pci_probe+0x45/0xa0
>> [   16.956899]        [<ffffffff8146f63d>] pci_device_probe+0xdd/0x130
>> [   16.956901]        [<ffffffff8157288e>] driver_probe_device+0x18e/0x2=
d0
>> [   16.956902]        [<ffffffff81572a67>] __driver_attach+0x97/0xa0
>> [   16.956905]        [<ffffffff815706a6>] bus_for_each_dev+0x66/0xa0
>> [   16.956908]        [<ffffffff8157220e>] driver_attach+0x1e/0x20
>> [   16.956910]        [<ffffffff81571de8>] bus_add_driver+0x1b8/0x230
>> [   16.956911]        [<ffffffff81573780>] driver_register+0x60/0xe0
>> [   16.956913]        [<ffffffff8146db80>] __pci_register_driver+0x60/0x=
70
>> [   16.956949]        [<ffffffffa061005d>] i915_init+0x5d/0x64 [i915]
>> [   16.956952]        [<ffffffff8100213d>] do_one_initcall+0x3d/0x160
>> [   16.956954]        [<ffffffff811abb85>] do_init_module+0x60/0x1dc
>> [   16.956957]        [<ffffffff81124f82>] load_module+0x2012/0x2610
>> [   16.956959]        [<ffffffff811256a6>] SYSC_init_module+0x126/0x140
>> [   16.956962]        [<ffffffff8112577e>] SyS_init_module+0xe/0x10
>> [   16.956964]        [<ffffffff8182d800>] entry_SYSCALL_64_fastpath+0x2=
3/0xc1
>> [   16.956966]
>> [   16.956966] -> #0 (&dev->mode_config.mutex){+.+.+.}:
>> [   16.956968]        [<ffffffff810df7ad>] __lock_acquire+0x19ed/0x1aa0
>> [   16.956970]        [<ffffffff810dff49>] lock_acquire+0x119/0x220
>> [   16.956971]        [<ffffffff81829339>] mutex_lock_nested+0x69/0x3c0
>> [   16.956988]        [<ffffffffa00f2b30>] drm_modeset_lock_all+0x40/0x1=
20 [drm]
>> [   16.956998]        [<ffffffffa021afbb>]
>> drm_fb_helper_restore_fbdev_mode_unlocked+0x2b/0x80 [drm_kms_helper]
>> [   16.957004]        [<ffffffffa021b03d>]
>> drm_fb_helper_set_par+0x2d/0x50 [drm_kms_helper]
>> [   16.957043]        [<ffffffffa0569d8a>] intel_fbdev_set_par+0x1a/0x60=
 [i915]
>> [   16.957046]        [<ffffffff8149e9ec>] fbcon_init+0x53c/0x5b0
>> [   16.957048]        [<ffffffff81526666>] visual_init+0xd6/0x130
>> [   16.957050]        [<ffffffff81528bb7>] do_bind_con_driver+0x167/0x3a0
>> [   16.957052]        [<ffffffff8152911f>] do_take_over_console+0x12f/0x=
1a0
>> [   16.957054]        [<ffffffff81499e67>] do_fbcon_takeover+0x57/0xb0
>> [   16.957056]        [<ffffffff8149f572>] fbcon_event_notify+0x752/0x860
>> [   16.957058]        [<ffffffff810aac2d>] notifier_call_chain+0x5d/0x80
>> [   16.957060]        [<ffffffff810aae3d>]
>> __blocking_notifier_call_chain+0x4d/0x70
>> [   16.957062]        [<ffffffff810aae76>]
>> blocking_notifier_call_chain+0x16/0x20
>> [   16.957064]        [<ffffffff814a180b>] fb_notifier_call_chain+0x1b/0=
x20
>> [   16.957065]        [<ffffffff814a3903>] register_framebuffer+0x253/0x=
340
>> [   16.957072]        [<ffffffffa021b29a>]
>> drm_fb_helper_initial_config+0x23a/0x3d0 [drm_kms_helper]
>> [   16.957108]        [<ffffffffa056b078>]
>> intel_fbdev_initial_config+0x18/0x30 [i915]
>> [   16.957110]        [<ffffffff810ac967>] async_run_entry_fn+0x37/0xe0
>> [   16.957113]        [<ffffffff810a29e2>] process_one_work+0x1d2/0x690
>> [   16.957115]        [<ffffffff810a2f09>] worker_thread+0x69/0x4c0
>> [   16.957116]        [<ffffffff810a983a>] kthread+0x10a/0x120
>> [   16.957118]        [<ffffffff8182da4f>] ret_from_fork+0x1f/0x40
>> [   16.957118]
>> [   16.957118] other info that might help us debug this:
>> [   16.957118]
>> [   16.957119]  Possible unsafe locking scenario:
>> [   16.957119]
>> [   16.957119]        CPU0                    CPU1
>> [   16.957120]        ----                    ----
>> [   16.957121]   lock((fb_notifier_list).rwsem);
>> [   16.957122]                                lock(&dev->mode_config.mut=
ex);
>> [   16.957123]                                lock((fb_notifier_list).rw=
sem);
>> [   16.957124]   lock(&dev->mode_config.mutex);
>> [   16.957124]
>> [   16.957124]  *** DEADLOCK ***
>> [   16.957124]
>> [   16.957125] 6 locks held by kworker/u16:1/79:
>> [   16.957129]  #0:  ("events_unbound"){.+.+.+}, at:
>> [<ffffffff810a2964>] process_one_work+0x154/0x690
>> [   16.957132]  #1:  ((&entry->work)){+.+.+.}, at:
>> [<ffffffff810a2964>] process_one_work+0x154/0x690
>> [   16.957135]  #2:  (registration_lock#2){+.+.+.}, at:
>> [<ffffffff814a36d7>] register_framebuffer+0x27/0x340
>> [   16.957138]  #3:  (console_lock){+.+.+.}, at: [<ffffffff814a3920>]
>> register_framebuffer+0x270/0x340
>> [   16.957140]  #4:  (&fb_info->lock){+.+.+.}, at:
>> [<ffffffff814a1c3d>] lock_fb_info+0x1d/0x40
>> [   16.957143]  #5:  ((fb_notifier_list).rwsem){++++.+}, at:
>> [<ffffffff810aae25>] __blocking_notifier_call_chain+0x35/0x70
>> [   16.957144]
>> [   16.957144] stack backtrace:
>> [   16.957146] CPU: 1 PID: 79 Comm: kworker/u16:1 Not tainted
>> 4.7.0-rc7-4-iniza-small #1
>> [   16.957146] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
>> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
>> [   16.957149] Workqueue: events_unbound async_run_entry_fn
>> [   16.957152]  0000000000000000 ffff8800d434b7e0 ffffffff814164f5
>> ffffffff828bcb40
>> [   16.957154]  ffffffff828bcb40 ffff8800d434b820 ffffffff811ab19f
>> ffff8800d434b890
>> [   16.957156]  ffff8800d4391400 0000000000000006 ffff8800d4391d60
>> c673b630397235fc
>> [   16.957156] Call Trace:
>> [   16.957160]  [<ffffffff814164f5>] dump_stack+0x85/0xc0
>> [   16.957163]  [<ffffffff811ab19f>] print_circular_bug+0x209/0x217
>> [   16.957166]  [<ffffffff810df7ad>] __lock_acquire+0x19ed/0x1aa0
>> [   16.957169]  [<ffffffff810dff49>] lock_acquire+0x119/0x220
>> [   16.957191]  [<ffffffffa00f2b30>] ? drm_modeset_lock_all+0x40/0x120 [=
drm]
>> [   16.957193]  [<ffffffff81829339>] mutex_lock_nested+0x69/0x3c0
>> [   16.957213]  [<ffffffffa00f2b30>] ? drm_modeset_lock_all+0x40/0x120 [=
drm]
>> [   16.957217]  [<ffffffff810fc29b>] ? rcu_read_lock_sched_held+0x8b/0xa0
>> [   16.957221]  [<ffffffff8121407e>] ? kmem_cache_alloc_trace+0x2de/0x360
>> [   16.957240]  [<ffffffffa00f2b30>] drm_modeset_lock_all+0x40/0x120 [dr=
m]
>> [   16.957250]  [<ffffffffa021afbb>]
>> drm_fb_helper_restore_fbdev_mode_unlocked+0x2b/0x80 [drm_kms_helper]
>> [   16.957259]  [<ffffffffa021b03d>] drm_fb_helper_set_par+0x2d/0x50
>> [drm_kms_helper]
>> [   16.957307]  [<ffffffffa0569d8a>] intel_fbdev_set_par+0x1a/0x60 [i915]
>> [   16.957311]  [<ffffffff8149e9ec>] fbcon_init+0x53c/0x5b0
>> [   16.957314]  [<ffffffff81526666>] visual_init+0xd6/0x130
>> [   16.957317]  [<ffffffff81528bb7>] do_bind_con_driver+0x167/0x3a0
>> [   16.957319]  [<ffffffff8152911f>] do_take_over_console+0x12f/0x1a0
>> [   16.957322]  [<ffffffff81499e67>] do_fbcon_takeover+0x57/0xb0
>> [   16.957325]  [<ffffffff8149f572>] fbcon_event_notify+0x752/0x860
>> [   16.957328]  [<ffffffff810aae25>] ? __blocking_notifier_call_chain+0x=
35/0x70
>> [   16.957330]  [<ffffffff810aac2d>] notifier_call_chain+0x5d/0x80
>> [   16.957333]  [<ffffffff810aae3d>] __blocking_notifier_call_chain+0x4d=
/0x70
>> [   16.957335]  [<ffffffff810aae76>] blocking_notifier_call_chain+0x16/0=
x20
>> [   16.957337]  [<ffffffff814a180b>] fb_notifier_call_chain+0x1b/0x20
>> [   16.957339]  [<ffffffff814a3903>] register_framebuffer+0x253/0x340
>> [   16.957341]  [<ffffffff8156a920>] ? vga_switcheroo_client_fb_set+0x60=
/0x70
>> [   16.957348]  [<ffffffffa021b29a>]
>> drm_fb_helper_initial_config+0x23a/0x3d0 [drm_kms_helper]
>> [   16.957382]  [<ffffffffa056b078>] intel_fbdev_initial_config+0x18/0x3=
0 [i915]
>> [   16.957385]  [<ffffffff810ac967>] async_run_entry_fn+0x37/0xe0
>> [   16.957386]  [<ffffffff810a29e2>] process_one_work+0x1d2/0x690
>> [   16.957388]  [<ffffffff810a2964>] ? process_one_work+0x154/0x690
>> [   16.957390]  [<ffffffff810a2f09>] worker_thread+0x69/0x4c0
>> [   16.957392]  [<ffffffff810a2ea0>] ? process_one_work+0x690/0x690
>> [   16.957394]  [<ffffffff810a983a>] kthread+0x10a/0x120
>> [   16.957396]  [<ffffffff8182da4f>] ret_from_fork+0x1f/0x40
>> [   16.957398]  [<ffffffff810a9730>] ? kthread_create_on_node+0x200/0x200
>>
>> - EOT -
>> [    0.000000] Linux version 4.7.0-rc7-4-iniza-small (sedat.dilek@gmail.=
com@fambox) (gcc version 4.9.2 (Ubuntu 4.9.2-0ubuntu1~12.04) ) #1 SMP Fri J=
ul 15 00:01:31 CEST 2016
>> [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-4.7.0-rc7-4-iniz=
a-small root=3DUUID=001AADA61AAD9964 loop=3D/ubuntu/disks/root.disk ro inte=
l_pstate=3Ddisable
>> [    0.000000] KERNEL supported cpus:
>> [    0.000000]   Intel GenuineIntel
>> [    0.000000]   AMD AuthenticAMD
>> [    0.000000]   Centaur CentaurHauls
>> [    0.000000] Disabled fast string operations
>> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating po=
int registers'
>> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
>> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
>> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832=
 bytes, using 'standard' format.
>> [    0.000000] x86/fpu: Using 'eager' FPU context switches.
>> [    0.000000] e820: BIOS-provided physical RAM map:
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] us=
able
>> [    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] us=
able
>> [    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] us=
able
>> [    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x0000000040200000-0x00000000d9c9efff] us=
able
>> [    0.000000] BIOS-e820: [mem 0x00000000d9c9f000-0x00000000dae7efff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x00000000dae7f000-0x00000000daf9efff] AC=
PI NVS
>> [    0.000000] BIOS-e820: [mem 0x00000000daf9f000-0x00000000daffefff] AC=
PI data
>> [    0.000000] BIOS-e820: [mem 0x00000000dafff000-0x00000000daffffff] us=
able
>> [    0.000000] BIOS-e820: [mem 0x00000000db000000-0x00000000df9fffff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x00000000ffd80000-0x00000000ffffffff] re=
served
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000011fdfffff] us=
able
>> [    0.000000] NX (Execute Disable) protection: active
>> [    0.000000] SMBIOS 2.6 present.
>> [    0.000000] DMI: SAMSUNG ELECTRONICS CO., LTD. 530U3BI/530U4BI/530U4B=
H/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
>> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D> rese=
rved
>> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
>> [    0.000000] e820: last_pfn =3D 0x11fe00 max_arch_pfn =3D 0x400000000
>> [    0.000000] MTRR default type: uncachable
>> [    0.000000] MTRR fixed ranges enabled:
>> [    0.000000]   00000-9FFFF write-back
>> [    0.000000]   A0000-BFFFF uncachable
>> [    0.000000]   C0000-FFFFF write-protect
>> [    0.000000] MTRR variable ranges enabled:
>> [    0.000000]   0 base 000000000 mask F80000000 write-back
>> [    0.000000]   1 base 080000000 mask FC0000000 write-back
>> [    0.000000]   2 base 0C0000000 mask FE0000000 write-back
>> [    0.000000]   3 base 0DC000000 mask FFC000000 uncachable
>> [    0.000000]   4 base 0DB000000 mask FFF000000 uncachable
>> [    0.000000]   5 base 100000000 mask FE0000000 write-back
>> [    0.000000]   6 base 11FE00000 mask FFFE00000 uncachable
>> [    0.000000]   7 base 0FFC00000 mask FFFC00000 write-protect
>> [    0.000000]   8 disabled
>> [    0.000000]   9 disabled
>> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC-=
 WT
>> [    0.000000] e820: last_pfn =3D 0xdb000 max_arch_pfn =3D 0x400000000
>> [    0.000000] found SMP MP-table at [mem 0x000f00e0-0x000f00ef] mapped =
at [ffff8800000f00e0]
>> [    0.000000] Scanning 1 areas for low memory corruption
>> [    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 2=
4576
>> [    0.000000] reserving inaccessible SNB gfx pages
>> [    0.000000] BRK [0x02ea3000, 0x02ea3fff] PGTABLE
>> [    0.000000] BRK [0x02ea4000, 0x02ea4fff] PGTABLE
>> [    0.000000] BRK [0x02ea5000, 0x02ea5fff] PGTABLE
>> [    0.000000] BRK [0x02ea6000, 0x02ea6fff] PGTABLE
>> [    0.000000] BRK [0x02ea7000, 0x02ea7fff] PGTABLE
>> [    0.000000] BRK [0x02ea8000, 0x02ea8fff] PGTABLE
>> [    0.000000] RAMDISK: [mem 0x378f4000-0x37c71fff]
>> [    0.000000] ACPI: Early table checksum verification disabled
>> [    0.000000] ACPI: RSDP 0x00000000000F0100 000024 (v02 SECCSD)
>> [    0.000000] ACPI: XSDT 0x00000000DAFFE170 00008C (v01 SECCSD LH43STAR=
 00000002 PTEC 00000002)
>> [    0.000000] ACPI: FACP 0x00000000DAFEF000 00010C (v05 SECCSD LH43STAR=
 00000002 PTL  00000002)
>> [    0.000000] ACPI: DSDT 0x00000000DAFF2000 0083AC (v02 SECCSD SNB-CPT =
 00000000 INTL 20061109)
>> [    0.000000] ACPI: FACS 0x00000000DAF47000 000040
>> [    0.000000] ACPI: SLIC 0x00000000DAFFD000 000176 (v01 SECCSD LH43STAR=
 00000002 PTEC 00000001)
>> [    0.000000] ACPI: SSDT 0x00000000DAFFB000 001068 (v01 SECCSD PtidDevc=
 00001000 INTL 20061109)
>> [    0.000000] ACPI: ASF! 0x00000000DAFF1000 0000A5 (v32 SECCSD LH43STAR=
 00000002 PTL  00000002)
>> [    0.000000] ACPI: HPET 0x00000000DAFEE000 000038 (v01 SECCSD LH43STAR=
 00000002 PTL  00000002)
>> [    0.000000] ACPI: APIC 0x00000000DAFED000 000098 (v03 SECCSD LH43STAR=
 00000002 PTL  00000002)
>> [    0.000000] ACPI: MCFG 0x00000000DAFEC000 00003C (v01 SECCSD LH43STAR=
 00000002 PTL  00000002)
>> [    0.000000] ACPI: SSDT 0x00000000DAFEB000 000804 (v01 PmRef  Cpu0Ist =
 00003000 INTL 20061109)
>> [    0.000000] ACPI: SSDT 0x00000000DAFEA000 000996 (v01 PmRef  CpuPm   =
 00003000 INTL 20061109)
>> [    0.000000] ACPI: UEFI 0x00000000DAFE9000 00003E (v01 SECCSD LH43STAR=
 00000002 PTL  00000002)
>> [    0.000000] ACPI: UEFI 0x00000000DAFE8000 000042 (v01 PTL    COMBUF  =
 00000001 PTL  00000001)
>> [    0.000000] ACPI: UEFI 0x00000000DAFE7000 00026A (v01 SECCSD LH43STAR=
 00000002 PTL  00000002)
>> [    0.000000] ACPI: SSDT 0x00000000DAFE6000 0000D0 (v01 Iffs   IffsAsl =
 00003000 INTL 20061109)
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] No NUMA configuration found
>> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000011fdfff=
ff]
>> [    0.000000] NODE_DATA(0) allocated [mem 0x11fdf8000-0x11fdfcfff]
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000011fdfffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
>> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
>> [    0.000000]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
>> [    0.000000]   node   0: [mem 0x0000000040200000-0x00000000d9c9efff]
>> [    0.000000]   node   0: [mem 0x00000000dafff000-0x00000000daffffff]
>> [    0.000000]   node   0: [mem 0x0000000100000000-0x000000011fdfffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000011f=
dfffff]
>> [    0.000000] On node 0 totalpages: 1021500
>> [    0.000000]   DMA zone: 64 pages used for memmap
>> [    0.000000]   DMA zone: 156 pages reserved
>> [    0.000000]   DMA zone: 3996 pages, LIFO batch:0
>> [    0.000000]   DMA32 zone: 13859 pages used for memmap
>> [    0.000000]   DMA32 zone: 886944 pages, LIFO batch:31
>> [    0.000000]   Normal zone: 2040 pages used for memmap
>> [    0.000000]   Normal zone: 130560 pages, LIFO batch:31
>> [    0.000000] Reserving Intel graphics memory at 0x00000000dba00000-0x0=
0000000df9fffff
>> [    0.000000] ACPI: PM-Timer IO Port: 0x408
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
>> [    0.000000] IOAPIC[0]: apic_id 14, version 32, address 0xfec00000, GS=
I 0-23
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high leve=
l)
>> [    0.000000] ACPI: IRQ0 used by override.
>> [    0.000000] ACPI: IRQ9 used by override.
>> [    0.000000] Using ACPI (MADT) for SMP configuration information
>> [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
>> [    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
>> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x40000000-0x401fffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xd9c9f000-0xdae7efff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xdae7f000-0xdaf9efff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xdaf9f000-0xdaffefff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xdb000000-0xdf9fffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xdfa00000-0xf7ffffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed07fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfed08000-0xfed08fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfed09000-0xfed0ffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfed1a000-0xfed1bfff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffd7ffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xffd80000-0xffffffff]
>> [    0.000000] e820: [mem 0xdfa00000-0xf7ffffff] available for PCI devic=
es
>> [    0.000000] Booting paravirtualized kernel on bare hardware
>> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles=
: 0xffffffff, max_idle_ns: 7645519600211568 ns
>> [    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:=
8 nr_node_ids:1
>> [    0.000000] percpu: Embedded 36 pages/cpu @ffff88011fa00000 s106632 r=
8192 d32632 u262144
>> [    0.000000] pcpu-alloc: s106632 r8192 d32632 u262144 alloc=3D1*2097152
>> [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
>> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.  T=
otal pages: 1005381
>> [    0.000000] Policy zone: Normal
>> [    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-4.7.0-rc7=
-4-iniza-small root=3DUUID=001AADA61AAD9964 loop=3D/ubuntu/disks/root.disk =
ro intel_pstate=3Ddisable
>> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
>> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
>> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bail=
ing!
>> [    0.000000] Memory: 3916804K/4086000K available (8394K kernel code, 1=
437K rwdata, 3344K rodata, 1476K init, 14080K bss, 169196K reserved, 0K cma=
-reserved)
>> [    0.000000] Running RCU self tests
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000]        RCU lockdep checking is enabled.
>> [    0.000000]        Build-time adjustment of leaf fanout to 64.
>> [    0.000000]        RCU restricting CPUs from NR_CPUS%6 to nr_cpu_ids=
=3D8.
>> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=
=3D8
>> [    0.000000] NR_IRQS:16640 nr_irqs:488 16
>> [    0.000000] Console: colour dummy device 80x25
>> [    0.000000] console [tty0] enabled
>> [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, In=
c., Ingo Molnar
>> [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
>> [    0.000000] ... MAX_LOCK_DEPTH:          48
>> [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
>> [    0.000000] ... CLASSHASH_SIZE:          4096
>> [    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
>> [    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
>> [    0.000000] ... CHAINHASH_SIZE:          32768
>> [    0.000000]  memory used by lock dependency info: 8159 kB
>> [    0.000000]  per task-struct memory footprint: 1920 bytes
>> [    0.000000] ------------------------
>> [    0.000000] | Locking API testsuite:
>> [    0.000000] ---------------------------------------------------------=
-------------------
>> [    0.000000]                                  | spin |wlock |rlock |mu=
tex | wsem | rsem |
>> [    0.000000]   -------------------------------------------------------=
-------------------
>> [    0.000000]                      A-A deadlock:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]                     double unlock:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]                   initialize held:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]                  bad unlock order:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |
>> [    0.000000]   -------------------------------------------------------=
-------------------
>> [    0.000000]               recursive read-lock:             |  ok  |  =
           |  ok  |
>> [    0.000000]            recursive read-lock #2:             |  ok  |  =
           |  ok  |
>> [    0.000000]             mixed read-write-lock:             |  ok  |  =
           |  ok  |
>> [    0.000000]             mixed write-read-lock:             |  ok  |  =
           |  ok  |
>> [    0.000000]   -------------------------------------------------------=
-------------------
>> [    0.000000]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
>> [    0.000000]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
>> [    0.000000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
>> [    0.000000]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
>> [    0.000000]        sirq-safe-A =3D> hirqs-on/12:  ok  |  ok  |  ok  |
>> [    0.000000]        sirq-safe-A =3D> hirqs-on/21:  ok  |  ok  |  ok  |
>> [    0.000000]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
>> [    0.000000]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
>> [    0.000000]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
>> [    0.000000]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
>> [    0.000000]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
>> [    0.000000]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
>> [    0.000000]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
>> [    0.000000]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
>> [    0.000000]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
>> [    0.000000]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
>> [    0.000000]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
>> [    0.000000]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
>> [    0.000000]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
>> [    0.000000]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
>> [    0.000000]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
>> [    0.000000]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
>> [    0.000000]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
>> [    0.000000]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
>> [    0.000000]       hard-irq read-recursion/123:  ok  |
>> [    0.000000]       soft-irq read-recursion/123:  ok  |
>> [    0.000000]       hard-irq read-recursion/132:  ok  |
>> [    0.000000]       soft-irq read-recursion/132:  ok  |
>> [    0.000000]       hard-irq read-recursion/213:  ok  |
>> [    0.000000]       soft-irq read-recursion/213:  ok  |
>> [    0.000000]       hard-irq read-recursion/231:  ok  |
>> [    0.000000]       soft-irq read-recursion/231:  ok  |
>> [    0.000000]       hard-irq read-recursion/312:  ok  |
>> [    0.000000]       soft-irq read-recursion/312:  ok  |
>> [    0.000000]       hard-irq read-recursion/321:  ok  |
>> [    0.000000]       soft-irq read-recursion/321:  ok  |
>> [    0.000000]   -------------------------------------------------------=
-------------------
>> [    0.000000]   | Wound/wait tests |
>> [    0.000000]   ---------------------
>> [    0.000000]                   ww api failures:  ok  |  ok  |  ok  |
>> [    0.000000]                ww contexts mixing:  ok  |  ok  |
>> [    0.000000]              finishing ww context:  ok  |  ok  |  ok  |  =
ok  |
>> [    0.000000]                locking mismatches:  ok  |  ok  |  ok  |
>> [    0.000000]                  EDEADLK handling:  ok  |  ok  |  ok  |  =
ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>> [    0.000000]            spinlock nest unlocked:  ok  |
>> [    0.000000]   -----------------------------------------------------
>> [    0.000000]                                  |block | try  |context|
>> [    0.000000]   -----------------------------------------------------
>> [    0.000000]                           context:  ok  |  ok  |  ok  |
>> [    0.000000]                               try:  ok  |  ok  |  ok  |
>> [    0.000000]                             block:  ok  |  ok  |  ok  |
>> [    0.000000]                          spinlock:  ok  |  ok  |  ok  |
>> [    0.000000] -------------------------------------------------------
>> [    0.000000] Good, all 253 testcases passed! |
>> [    0.000000] ---------------------------------
>> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 133484882848 ns
>> [    0.000000] hpet clockevent registered
>> [    0.000000] tsc: Fast TSC calibration using PIT
>> [    0.000000] tsc: Detected 1596.502 MHz processor
>> [    0.000083] Calibrating delay loop (skipped), value calculated using =
timer frequency.. 3193.00 BogoMIPS (lpjc86008)
>> [    0.000096] pid_max: default: 32768 minimum: 301
>> [    0.000139] ACPI: Core revision 20160422
>> [    0.022067] ACPI: 5 ACPI AML tables successfully acquired and loaded
>> [    0.022077]
>> [    0.022263] Security Framework initialized
>> [    0.022270] Yama: becoming mindful.
>> [    0.022303] AppArmor: AppArmor initialized
>> [    0.022745] Dentry cache hash table entries: 524288 (order: 10, 41943=
04 bytes)
>> [    0.023827] Inode-cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
>> [    0.024336] Mount-cache hash table entries: 8192 (order: 4, 65536 byt=
es)
>> [    0.024351] Mountpoint-cache hash table entries: 8192 (order: 4, 6553=
6 bytes)
>> [    0.025675] Disabled fast string operations
>> [    0.025684] CPU: Physical Processor ID: 0
>> [    0.025689] CPU: Processor Core ID: 0
>> [    0.025699] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
>> [    0.025705] ENERGY_PERF_BIAS: View and update with x86_energy_perf_po=
licy(8)
>> [    0.025713] mce: CPU supports 7 MCE banks
>> [    0.025745] CPU0: Thermal monitoring enabled (TM1)
>> [    0.025769] process: using mwait in idle threads
>> [    0.025778] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
>> [    0.025784] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
>> [    0.026448] Freeing SMP alternatives memory: 28K (ffffffff820da000 - =
ffffffff820e1000)
>> [    0.041804] ftrace: allocating 30339 entries in 119 pages
>> [    0.058873] smpboot: Max logical packages: 4
>> [    0.058884] smpboot: APIC(0) Converting physical 0 to logical package=
 0
>> [    0.058971] x2apic: IRQ remapping doesn't support X2APIC mode
>> [    0.059606] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
>> [    0.099303] TSC deadline timer enabled
>> [    0.099308] smpboot: CPU0: Intel(R) Core(TM) i5-2467M CPU @ 1.60GHz (=
family: 0x6, model: 0x2a, stepping: 0x7)
>> [    0.099323] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge =
events, full-width counters, Intel PMU driver.
>> [    0.099367] ... version:                3
>> [    0.099372] ... bit width:              48
>> [    0.099377] ... generic registers:      4
>> [    0.099382] ... value mask:             0000ffffffffffff
>> [    0.099388] ... max period:             0000ffffffffffff
>> [    0.099393] ... fixed-purpose events:   3
>> [    0.099398] ... event mask:             000000070000000f
>> [    0.101117] NMI watchdog: enabled on all CPUs, permanently consumes o=
ne hw-PMU counter.
>> [    0.102026] x86: Booting SMP configuration:
>> [    0.102033] .... node  #0, CPUs:      #1
>> [    0.102362] Disabled fast string operations
>> [    0.182416]  #2<6>[    0.182725] Disabled fast string operations
>> [    0.262776]  #3
>> [    0.262776] Disabled fast string operations
>> [    0.342019] x86: Booted up 1 node, 4 CPUs
>> [    0.342037] smpboot: Total of 4 processors activated (12789.95 BogoMI=
PS)
>> [    0.358576] devtmpfs: initialized
>> [    0.358926] x86/mm: Memory block size: 128MB
>> [    0.364175] evm: security.selinux
>> [    0.364181] evm: security.SMACK64
>> [    0.364186] evm: security.capability
>> [    0.374085] PM: Registering ACPI NVS region [mem 0xdae7f000-0xdaf9eff=
f] (1179648 bytes)
>> [    0.374481] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffff=
ffff, max_idle_ns: 7645041785100000 ns
>> [    0.402406] NET: Registered protocol family 16
>> [    0.414003] cpuidle: using governor ladder
>> [    0.426026] cpuidle: using governor menu
>> [    0.426170] ACPI: bus type PCI registered
>> [    0.426450] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000=
000-0xfbffffff] (base 0xf8000000)
>> [    0.426461] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in =
E820
>> [    0.426477] PCI: Using configuration type 1 for base access
>> [    0.426524] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is=
 on
>> [    0.442509] HugeTLB registered 2 MB page size, pre-allocated 0 pages
>> [    0.478453] ACPI: Added _OSI(Module Device)
>> [    0.478462] ACPI: Added _OSI(Processor Device)
>> [    0.478468] ACPI: Added _OSI(3.0 _SCP Extensions)
>> [    0.478474] ACPI: Added _OSI(Processor Aggregator Device)
>> [    0.479304] ACPI: Executed 1 blocks of module-level executable AML co=
de
>> [    0.498036] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>> [    0.500194] ACPI: Dynamic OEM Table Load:
>> [    0.500225] ACPI: SSDT 0xFFFF8800D58D7800 000688 (v01 PmRef  Cpu0Cst =
 00003001 INTL 20061109)
>> [    0.503068] ACPI: Dynamic OEM Table Load:
>> [    0.503097] ACPI: SSDT 0xFFFF8800D58D8C00 000303 (v01 PmRef  ApIst   =
 00003000 INTL 20061109)
>> [    0.505694] ACPI: Dynamic OEM Table Load:
>> [    0.505721] ACPI: SSDT 0xFFFF8800D5803200 000119 (v01 PmRef  ApCst   =
 00003000 INTL 20061109)
>> [    0.510184] ACPI : EC: EC started
>> [    0.578654] ACPI: Interpreter enabled
>> [    0.578731] ACPI: (supports S0 S1 S3 S4 S5)
>> [    0.578737] ACPI: Using IOAPIC for interrupt routing
>> [    0.578827] PCI: Using host bridge windows from ACPI; if necessary, u=
se "pci=3Dnocrs" and report a bug
>> [    0.607276] ACPI: Power Resource [FN00] (off)
>> [    0.607811] ACPI: Power Resource [FN01] (off)
>> [    0.608246] ACPI: Power Resource [FN02] (off)
>> [    0.608677] ACPI: Power Resource [FN03] (off)
>> [    0.609109] ACPI: Power Resource [FN04] (off)
>> [    0.612135] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
>> [    0.612150] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM C=
lockPM Segments MSI]
>> [    0.612949] \_SB_.PCI0 (33DB4D5B-1FF7-401C-9657-7441C03DD766): _OSC i=
nvalid UUID
>> [    0.612952] _OSC request data: 1 1f 0
>> [    0.612958] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
>> [    0.614102] PCI host bridge to bus 0000:00
>> [    0.614111] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 win=
dow]
>> [    0.614119] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff win=
dow]
>> [    0.614126] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000b=
ffff window]
>> [    0.614136] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfeaf=
ffff window]
>> [    0.614145] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4=
4fff window]
>> [    0.614156] pci_bus 0000:00: root bus resource [bus 00-3e]
>> [    0.614242] pci 0000:00:00.0: [8086:0104] type 00 class 0x060000
>> [    0.614746] pci 0000:00:02.0: [8086:0116] type 00 class 0x030000
>> [    0.614768] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf03fffff 64=
bit]
>> [    0.614781] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64=
bit pref]
>> [    0.614791] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
>> [    0.615319] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
>> [    0.615361] pci 0000:00:16.0: reg 0x10: [mem 0xf0705000-0xf070500f 64=
bit]
>> [    0.615521] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
>> [    0.615928] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
>> [    0.615963] pci 0000:00:1a.0: reg 0x10: [mem 0xf070a000-0xf070a3ff]
>> [    0.616144] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
>> [    0.616439] pci 0000:00:1a.0: System wakeup disabled by ACPI
>> [    0.616641] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
>> [    0.616680] pci 0000:00:1b.0: reg 0x10: [mem 0xf0700000-0xf0703fff 64=
bit]
>> [    0.616868] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
>> [    0.617083] pci 0000:00:1b.0: System wakeup disabled by ACPI
>> [    0.617277] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
>> [    0.617453] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
>> [    0.617663] pci 0000:00:1c.0: System wakeup disabled by ACPI
>> [    0.617862] pci 0000:00:1c.3: [8086:1c16] type 01 class 0x060400
>> [    0.618037] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
>> [    0.618248] pci 0000:00:1c.3: System wakeup disabled by ACPI
>> [    0.618451] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
>> [    0.618634] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
>> [    0.618846] pci 0000:00:1c.4: System wakeup disabled by ACPI
>> [    0.619048] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
>> [    0.619083] pci 0000:00:1d.0: reg 0x10: [mem 0xf0709000-0xf07093ff]
>> [    0.619264] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
>> [    0.619513] pci 0000:00:1d.0: System wakeup disabled by ACPI
>> [    0.619707] pci 0000:00:1f.0: [8086:1c49] type 00 class 0x060100
>> [    0.620235] pci 0000:00:1f.2: [8086:1c03] type 00 class 0x010601
>> [    0.620272] pci 0000:00:1f.2: reg 0x10: [io  0x3088-0x308f]
>> [    0.620291] pci 0000:00:1f.2: reg 0x14: [io  0x3094-0x3097]
>> [    0.620308] pci 0000:00:1f.2: reg 0x18: [io  0x3080-0x3087]
>> [    0.620326] pci 0000:00:1f.2: reg 0x1c: [io  0x3090-0x3093]
>> [    0.620344] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
>> [    0.620362] pci 0000:00:1f.2: reg 0x24: [mem 0xf0708000-0xf07087ff]
>> [    0.620474] pci 0000:00:1f.2: PME# supported from D3hot
>> [    0.620842] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
>> [    0.620877] pci 0000:00:1f.3: reg 0x10: [mem 0xf0704000-0xf07040ff 64=
bit]
>> [    0.620928] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
>> [    0.621699] pci 0000:01:00.0: [8086:0091] type 00 class 0x028000
>> [    0.622075] pci 0000:01:00.0: reg 0x10: [mem 0xf0600000-0xf0601fff 64=
bit]
>> [    0.623913] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>> [    0.624377] pci 0000:01:00.0: System wakeup disabled by ACPI
>> [    0.634626] pci 0000:00:1c.0: PCI bridge to [bus 01]
>> [    0.634645] pci 0000:00:1c.0:   bridge window [mem 0xf0600000-0xf06ff=
fff]
>> [    0.634883] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
>> [    0.634978] pci 0000:02:00.0: reg 0x10: [io  0x2000-0x20ff]
>> [    0.635118] pci 0000:02:00.0: reg 0x18: [mem 0xf0404000-0xf0404fff 64=
bit pref]
>> [    0.635205] pci 0000:02:00.0: reg 0x20: [mem 0xf0400000-0xf0403fff 64=
bit pref]
>> [    0.635680] pci 0000:02:00.0: supports D1 D2
>> [    0.635682] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3co=
ld
>> [    0.635895] pci 0000:02:00.0: System wakeup disabled by ACPI
>> [    0.646557] pci 0000:00:1c.3: PCI bridge to [bus 02]
>> [    0.646569] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
>> [    0.646585] pci 0000:00:1c.3:   bridge window [mem 0xf0400000-0xf04ff=
fff 64bit pref]
>> [    0.646773] pci 0000:03:00.0: [1b21:1042] type 00 class 0x0c0330
>> [    0.646825] pci 0000:03:00.0: reg 0x10: [mem 0xf0500000-0xf0507fff 64=
bit]
>> [    0.647091] pci 0000:03:00.0: PME# supported from D3hot D3cold
>> [    0.647186] pci 0000:03:00.0: System wakeup disabled by ACPI
>> [    0.647417] pci 0000:00:1c.4: PCI bridge to [bus 03]
>> [    0.647433] pci 0000:00:1c.4:   bridge window [mem 0xf0500000-0xf05ff=
fff]
>> [    0.649907] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11 12=
 14 15)
>> [    0.650142] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 11 12 =
14 15) *0, disabled.
>> [    0.650378] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *10 11 12=
 14 15)
>> [    0.650623] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11 12=
 14 15)
>> [    0.650865] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12 =
14 15) *9
>> [    0.651098] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12 =
14 15) *0, disabled.
>> [    0.651332] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 10 *11 12=
 14 15)
>> [    0.651562] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 11 12 =
14 15) *9
>> [    0.653226] ACPI: Enabled 4 GPEs in block 00 to 3F
>> [    0.653329] ACPI : EC: EC stopped
>> [    0.653572] ACPI : EC: GPE =3D 0x17, I/O: command/status =3D 0x66, da=
ta =3D 0x62
>> [    0.653580] ACPI : EC: EC started
>> [    0.711259] ACPI : EC: 0 stale EC events cleared
>> [    0.712042] vgaarb: setting as boot device: PCI:0000:00:02.0
>> [    0.712050] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,o=
wns=3Dio+mem,locks=3Dnone
>> [    0.712067] vgaarb: loaded
>> [    0.712072] vgaarb: bridge control possible 0000:00:02.0
>> [    0.712736] SCSI subsystem initialized
>> [    0.712906] libata version 3.00 loaded.
>> [    0.712999] ACPI: bus type USB registered
>> [    0.713128] usbcore: registered new interface driver usbfs
>> [    0.713176] usbcore: registered new interface driver hub
>> [    0.713264] usbcore: registered new device driver usb
>> [    0.713696] PCI: Using ACPI for IRQ routing
>> [    0.717428] PCI: pci_cache_line_size set to 64 bytes
>> [    0.717563] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
>> [    0.717572] e820: reserve RAM buffer [mem 0xd9c9f000-0xdbffffff]
>> [    0.717575] e820: reserve RAM buffer [mem 0xdb000000-0xdbffffff]
>> [    0.717578] e820: reserve RAM buffer [mem 0x11fe00000-0x11fffffff]
>> [    0.718389] NetLabel: Initializing
>> [    0.718395] NetLabel:  domain hash size =3D 128
>> [    0.718400] NetLabel:  protocols =3D UNLABELED CIPSOv4
>> [    0.718460] NetLabel:  unlabeled traffic allowed by default
>> [    0.718789] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
>> [    0.718805] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
>> [    0.720830] amd_nb: Cannot enumerate AMD northbridges
>> [    0.720903] clocksource: Switched to clocksource hpet
>> [    0.781128] VFS: Disk quotas dquot_6.6.0
>> [    0.792987] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 b=
ytes)
>> [    0.805386] AppArmor: AppArmor Filesystem Enabled
>> [    0.805630] pnp: PnP ACPI init
>> [    0.806326] system 00:00: [io  0x0680-0x069f] has been reserved
>> [    0.806336] system 00:00: [io  0x1000-0x100f] has been reserved
>> [    0.806345] system 00:00: [io  0x5000-0x5003] has been reserved
>> [    0.806353] system 00:00: [io  0xffff] has been reserved
>> [    0.806361] system 00:00: [io  0x0400-0x0453] has been reserved
>> [    0.806369] system 00:00: [io  0x0458-0x047f] has been reserved
>> [    0.806377] system 00:00: [io  0x0500-0x057f] has been reserved
>> [    0.806386] system 00:00: [io  0x0a00-0x0a0f] has been reserved
>> [    0.806393] system 00:00: [io  0x164e-0x164f] has been reserved
>> [    0.806402] system 00:00: [io  0x5000-0x500f] could not be reserved
>> [    0.806442] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (act=
ive)
>> [    0.806550] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
>> [    0.806753] system 00:02: [io  0x0454-0x0457] has been reserved
>> [    0.806766] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0=
c02 (active)
>> [    0.806888] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
>> [    0.807043] pnp 00:04: Plug and Play ACPI device, IDs ETD0b00 SYN0002=
 PNP0f13 (active)
>> [    0.807596] system 00:05: [mem 0xfed1c000-0xfed1ffff] has been reserv=
ed
>> [    0.807606] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserv=
ed
>> [    0.807614] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserv=
ed
>> [    0.807622] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserv=
ed
>> [    0.807631] system 00:05: [mem 0xf8000000-0xfbffffff] has been reserv=
ed
>> [    0.807639] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserv=
ed
>> [    0.807647] system 00:05: [mem 0xfed90000-0xfed93fff] has been reserv=
ed
>> [    0.807655] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserv=
ed
>> [    0.807664] system 00:05: [mem 0xff000000-0xffffffff] could not be re=
served
>> [    0.807673] system 00:05: [mem 0xfee00000-0xfeefffff] could not be re=
served
>> [    0.807682] system 00:05: [mem 0xfffff000-0xffffffff] has been reserv=
ed
>> [    0.807694] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (act=
ive)
>> [    0.808737] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (act=
ive)
>> [    0.808808] pnp: PnP ACPI: found 7 devices
>> [    0.820857] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff=
, max_idle_ns: 2085701024 ns
>> [    0.820935] pci 0000:00:1c.0: PCI bridge to [bus 01]
>> [    0.820950] pci 0000:00:1c.0:   bridge window [mem 0xf0600000-0xf06ff=
fff]
>> [    0.820971] pci 0000:00:1c.3: PCI bridge to [bus 02]
>> [    0.820979] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
>> [    0.820997] pci 0000:00:1c.3:   bridge window [mem 0xf0400000-0xf04ff=
fff 64bit pref]
>> [    0.821016] pci 0000:00:1c.4: PCI bridge to [bus 03]
>> [    0.821028] pci 0000:00:1c.4:   bridge window [mem 0xf0500000-0xf05ff=
fff]
>> [    0.821050] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
>> [    0.821052] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
>> [    0.821054] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff wi=
ndow]
>> [    0.821056] pci_bus 0000:00: resource 7 [mem 0xdfa00000-0xfeafffff wi=
ndow]
>> [    0.821058] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff wi=
ndow]
>> [    0.821060] pci_bus 0000:01: resource 1 [mem 0xf0600000-0xf06fffff]
>> [    0.821063] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
>> [    0.821065] pci_bus 0000:02: resource 2 [mem 0xf0400000-0xf04fffff 64=
bit pref]
>> [    0.821067] pci_bus 0000:03: resource 1 [mem 0xf0500000-0xf05fffff]
>> [    0.880949] NET: Registered protocol family 2
>> [    0.881576] TCP established hash table entries: 32768 (order: 6, 2621=
44 bytes)
>> [    0.881828] TCP bind hash table entries: 32768 (order: 9, 2097152 byt=
es)
>> [    0.884260] TCP: Hash tables configured (established 32768 bind 32768)
>> [    0.884387] UDP hash table entries: 2048 (order: 6, 327680 bytes)
>> [    0.884728] UDP-Lite hash table entries: 2048 (order: 6, 327680 bytes)
>> [    0.920928] NET: Registered protocol family 1
>> [    0.920999] pci 0000:00:02.0: Video device with shadowed ROM at [mem =
0x000c0000-0x000dffff]
>> [    0.923056] PCI: CLS 64 bytes, default 64
>> [    0.923381] Trying to unpack rootfs image as initramfs...
>> [    1.010709] Freeing initrd memory: 3576K (ffff8800378f4000 - ffff8800=
37c72000)
>> [    1.010725] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>> [    1.010732] software IO TLB [mem 0xd5c9f000-0xd9c9f000] (64MB) mapped=
 at [ffff8800d5c9f000-ffff8800d9c9efff]
>> [    1.010824] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163=
840 ms ovfl timer
>> [    1.010834] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
>> [    1.010839] RAPL PMU: hw unit of domain package 2^-16 Joules
>> [    1.010845] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
>> [    1.011201] Scanning for low memory corruption every 60 seconds
>> [    1.029880] futex hash table entries: 2048 (order: 6, 262144 bytes)
>> [    1.048954] audit: initializing netlink subsys (disabled)
>> [    1.049059] audit: type 00 audit(1468568707.032:1): initialized
>> [    1.050664] Initialise system trusted keyrings
>> [    1.051126] workingset: timestamp_bits8 max_order  bucket_order=3D0
>> [    1.313058] fuse init (API version 7.25)
>> [    1.339110] Key type asymmetric registered
>> [    1.339133] Asymmetric key parser 'x509' registered
>> [    1.348974] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 250)
>> [    1.349133] io scheduler noop registered
>> [    1.349142] io scheduler deadline registered (default)
>> [    1.372892] io scheduler cfq registered
>> [    1.372909] start plist test
>> [    1.374679] end plist test
>> [    1.376089] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>> [    1.376117] pciehp: PCI Express Hot Plug Controller Driver version: 0=
.4
>> [    1.376358] intel_idle: MWAIT substates: 0x21120
>> [    1.376361] intel_idle: v0.4.1 model 0x2A
>> [    1.377493] intel_idle: lapic_timer_reliable_states 0xffffffff
>> [    1.377962] ACPI: AC Adapter [ADP1] (on-line)
>> [    1.378267] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP=
0C0D:00/input/input0
>> [    1.378330] ACPI: Lid Switch [LID0]
>> [    1.378542] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/P=
NP0C0C:00/input/input1
>> [    1.378593] ACPI: Power Button [PWRB]
>> [    1.378785] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/i=
nput/input2
>> [    1.378798] ACPI: Power Button [PWRF]
>> [    1.383078] thermal LNXTHERM:00: registered as thermal_zone0
>> [    1.383087] ACPI: Thermal Zone [TZ00] (43 C)
>> [    1.384128] thermal LNXTHERM:01: registered as thermal_zone1
>> [    1.384135] ACPI: Thermal Zone [TZ01] (30 C)
>> [    1.384251] GHES: HEST is not enabled!
>> [    1.384532] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>> [    1.393366] ACPI: Battery Slot [BAT1] (battery present)
>> [    1.393635] Linux agpgart interface v0.103
>> [    1.406443] brd: module loaded
>> [    1.413197] loop: module loaded
>> [    1.417745] ahci 0000:00:1f.2: version 3.0
>> [    1.418304] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabl=
ed
>> [    1.428509] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps=
 0x1b impl SATA mode
>> [    1.428534] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led=
 clo pio slum part ems sxs apst
>> [    1.451979] scsi host0: ahci
>> [    1.452663] scsi host1: ahci
>> [    1.453203] scsi host2: ahci
>> [    1.453708] scsi host3: ahci
>> [    1.454132] scsi host4: ahci
>> [    1.454558] scsi host5: ahci
>> [    1.454824] ata1: SATA max UDMA/133 abar m2048@0xf0708000 port 0xf070=
8100 irq 25
>> [    1.454835] ata2: SATA max UDMA/133 abar m2048@0xf0708000 port 0xf070=
8180 irq 25
>> [    1.454844] ata3: DUMMY
>> [    1.454850] ata4: SATA max UDMA/133 abar m2048@0xf0708000 port 0xf070=
8280 irq 25
>> [    1.454860] ata5: SATA max UDMA/133 abar m2048@0xf0708000 port 0xf070=
8300 irq 25
>> [    1.454868] ata6: DUMMY
>> [    1.456662] libphy: Fixed MDIO Bus: probed
>> [    1.457130] tun: Universal TUN/TAP device driver, 1.6
>> [    1.457136] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
>> [    1.457383] PPP generic driver version 2.4.2
>> [    1.457551] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> [    1.457557] ehci-pci: EHCI PCI platform driver
>> [    1.458044] ehci-pci 0000:00:1a.0: EHCI Host Controller
>> [    1.458216] ehci-pci 0000:00:1a.0: new USB bus registered, assigned b=
us number 1
>> [    1.458287] ehci-pci 0000:00:1a.0: debug port 2
>> [    1.462248] ehci-pci 0000:00:1a.0: cache line size of 64 is not suppo=
rted
>> [    1.462314] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf070a000
>> [    1.472873] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
>> [    1.473205] usb usb1: New USB device found, idVendor=1D6b, idProduct=
=0002
>> [    1.473212] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
>> [    1.473220] usb usb1: Product: EHCI Host Controller
>> [    1.473225] usb usb1: Manufacturer: Linux 4.7.0-rc7-4-iniza-small ehc=
i_hcd
>> [    1.473231] usb usb1: SerialNumber: 0000:00:1a.0
>> [    1.474253] hub 1-0:1.0: USB hub found
>> [    1.474308] hub 1-0:1.0: 2 ports detected
>> [    1.475718] ehci-pci 0000:00:1d.0: EHCI Host Controller
>> [    1.475742] ehci-pci 0000:00:1d.0: new USB bus registered, assigned b=
us number 2
>> [    1.475778] ehci-pci 0000:00:1d.0: debug port 2
>> [    1.479703] ehci-pci 0000:00:1d.0: cache line size of 64 is not suppo=
rted
>> [    1.479747] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf0709000
>> [    1.488911] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
>> [    1.489079] usb usb2: New USB device found, idVendor=1D6b, idProduct=
=0002
>> [    1.489086] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
>> [    1.489094] usb usb2: Product: EHCI Host Controller
>> [    1.489099] usb usb2: Manufacturer: Linux 4.7.0-rc7-4-iniza-small ehc=
i_hcd
>> [    1.489104] usb usb2: SerialNumber: 0000:00:1d.0
>> [    1.489741] hub 2-0:1.0: USB hub found
>> [    1.489770] hub 2-0:1.0: 2 ports detected
>> [    1.490298] ehci-platform: EHCI generic platform driver
>> [    1.490344] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>> [    1.490359] ohci-pci: OHCI PCI platform driver
>> [    1.490397] ohci-platform: OHCI generic platform driver
>> [    1.490426] uhci_hcd: USB Universal Host Controller Interface driver
>> [    1.490661] xhci_hcd 0000:03:00.0: xHCI Host Controller
>> [    1.490689] xhci_hcd 0000:03:00.0: new USB bus registered, assigned b=
us number 3
>> [    1.500427] xhci_hcd 0000:03:00.0: hcc params 0x0200f180 hci version =
0x96 quirks 0x00080000
>> [    1.501073] usb usb3: New USB device found, idVendor=1D6b, idProduct=
=0002
>> [    1.501081] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
>> [    1.501090] usb usb3: Product: xHCI Host Controller
>> [    1.501095] usb usb3: Manufacturer: Linux 4.7.0-rc7-4-iniza-small xhc=
i-hcd
>> [    1.501102] usb usb3: SerialNumber: 0000:03:00.0
>> [    1.501748] hub 3-0:1.0: USB hub found
>> [    1.501827] hub 3-0:1.0: 2 ports detected
>> [    1.502294] xhci_hcd 0000:03:00.0: xHCI Host Controller
>> [    1.502312] xhci_hcd 0000:03:00.0: new USB bus registered, assigned b=
us number 4
>> [    1.502443] usb usb4: We don't know the algorithms for LPM for this h=
ost, disabling LPM.
>> [    1.502545] usb usb4: New USB device found, idVendor=1D6b, idProduct=
=0003
>> [    1.502552] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
>> [    1.502560] usb usb4: Product: xHCI Host Controller
>> [    1.502565] usb usb4: Manufacturer: Linux 4.7.0-rc7-4-iniza-small xhc=
i-hcd
>> [    1.502570] usb usb4: SerialNumber: 0000:03:00.0
>> [    1.503224] hub 4-0:1.0: USB hub found
>> [    1.503273] hub 4-0:1.0: 2 ports detected
>> [    1.503918] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:EPAD] a=
t 0x60,0x64 irq 1,12
>> [    1.509828] serio: i8042 KBD port at 0x60,0x64 irq 1
>> [    1.509878] serio: i8042 AUX port at 0x60,0x64 irq 12
>> [    1.510766] mousedev: PS/2 mouse device common for all mice
>> [    1.512233] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
>> [    1.512278] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nv=
ram, hpet irqs
>> [    1.519012] input: AT Translated Set 2 keyboard as /devices/platform/=
i8042/serio0/input/input3
>> [    1.537039] device-mapper: uevent: version 1.0.3
>> [    1.549317] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialis=
ed: dm-devel@redhat.com
>> [    1.549378] ledtrig-cpu: registered to indicate activity on CPUs
>> [    1.621021] NET: Registered protocol family 10
>> [    1.633711] NET: Registered protocol family 17
>> [    1.633741] Key type dns_resolver registered
>> [    1.634700] microcode: CPU0 sig=3D0x206a7, pf=3D0x10, revision=3D0x28
>> [    1.634750] microcode: CPU1 sig=3D0x206a7, pf=3D0x10, revision=3D0x28
>> [    1.634776] microcode: CPU2 sig=3D0x206a7, pf=3D0x10, revision=3D0x28
>> [    1.634816] microcode: CPU3 sig=3D0x206a7, pf=3D0x10, revision=3D0x28
>> [    1.635094] microcode: Microcode Update Driver: v2.01 <tigran@aivazia=
n.fsnet.co.uk>, Peter Oruba
>> [    1.636008] registered taskstats version 1
>> [    1.636018] Loading compiled-in X.509 certificates
>> [    1.643359] Loaded X.509 cert 'Build time autogenerated kernel key: 0=
0b89b0b54e2e50c779dcb6b1667e75e5be8f532'
>> [    1.648048] Key type trusted registered
>> [    1.656281] Key type encrypted registered
>> [    1.656299] AppArmor: AppArmor sha1 policy hashing enabled
>> [    1.656306] evm: HMAC attrs: 0x1
>> [    1.657482] rtc_cmos 00:01: setting system clock to 2016-07-15 07:45:=
08 UTC (1468568708)
>> [    1.657685] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
>> [    1.657691] EDD information not available.
>> [    1.765348] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    1.766773] ata1.00: ATA-8: Hitachi HTS545050A7E380, GG2OA6C0, max UD=
MA/133
>> [    1.766783] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31=
/32), AA
>> [    1.768393] ata1.00: configured for UDMA/133
>> [    1.769527] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54505=
 A6C0 PQ: 0 ANSI: 5
>> [    1.784971] usb 1-1: new high-speed USB device number 2 using ehci-pci
>> [    1.794097] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500=
 GB/466 GiB)
>> [    1.794112] sd 0:0:0:0: [sda] 4096-byte physical blocks
>> [    1.794381] sd 0:0:0:0: [sda] Write Protect is off
>> [    1.794390] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [    1.794485] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabl=
ed, doesn't support DPO or FUA
>> [    1.794537] sd 0:0:0:0: Attached scsi generic sg0 type 0
>> [    1.800850] usb 2-1: new high-speed USB device number 2 using ehci-pci
>> [    1.841517]  sda: sda1 sda2 sda3
>> [    1.843807] sd 0:0:0:0: [sda] Attached SCSI disk
>> [    1.868965] usb 3-1: new high-speed USB device number 2 using xhci_hcd
>> [    1.917564] usb 1-1: New USB device found, idVendor=8087, idProduct=
=0024
>> [    1.917596] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Se=
rialNumber=3D0
>> [    1.918418] hub 1-1:1.0: USB hub found
>> [    1.918612] hub 1-1:1.0: 6 ports detected
>> [    1.933704] usb 2-1: New USB device found, idVendor=8087, idProduct=
=0024
>> [    1.933716] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Se=
rialNumber=3D0
>> [    1.934479] hub 2-1:1.0: USB hub found
>> [    1.934676] hub 2-1:1.0: 6 ports detected
>> [    2.009045] tsc: Refined TSC clocksource calibration: 1596.374 MHz
>> [    2.009057] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x=
1702c3a922f, max_idle_ns: 440795242034 ns
>> [    2.053629] usb 3-1: New USB device found, idVendor=0781, idProductU7d
>> [    2.053642] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Se=
rialNumber=3D3
>> [    2.053649] usb 3-1: Product: Cruzer Force
>> [    2.053655] usb 3-1: Manufacturer: SanDisk
>> [    2.053668] usb 3-1: SerialNumber: 4C530012241124104292
>> [    2.105250] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    2.106151] ata2.00: ATA-8: SanDisk iSSD P4 16GB, SSD 9.14, max UDMA/=
133
>> [    2.106184] ata2.00: 31277232 sectors, multi 1: LBA48
>> [    2.107049] ata2.00: configured for UDMA/133
>> [    2.107653] scsi 1:0:0:0: Direct-Access     ATA      SanDisk iSSD P4 =
 9.14 PQ: 0 ANSI: 5
>> [    2.129640] sd 1:0:0:0: [sdb] 31277232 512-byte logical blocks: (16.0=
 GB/14.9 GiB)
>> [    2.129743] sd 1:0:0:0: Attached scsi generic sg1 type 0
>> [    2.130018] sd 1:0:0:0: [sdb] Write Protect is off
>> [    2.130029] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>> [    2.130149] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabl=
ed, doesn't support DPO or FUA
>> [    2.131231]  sdb: sdb1 sdb2
>> [    2.132189] sd 1:0:0:0: [sdb] Attached SCSI disk
>> [    2.188946] usb 1-1.4: new high-speed USB device number 3 using ehci-=
pci
>> [    2.208939] usb 2-1.4: new low-speed USB device number 3 using ehci-p=
ci
>> [    2.308220] usb 2-1.4: New USB device found, idVendor=046d, idProduct=
=C00e
>> [    2.308232] usb 2-1.4: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D0
>> [    2.308241] usb 2-1.4: Product: USB-PS/2 Optical Mouse
>> [    2.308247] usb 2-1.4: Manufacturer: Logitech
>> [    2.380913] usb 2-1.5: new full-speed USB device number 4 using ehci-=
pci
>> [    2.441457] usb 1-1.4: New USB device found, idVendor"32, idProduct=
=1018
>> [    2.441469] usb 1-1.4: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D0
>> [    2.441479] usb 1-1.4: Product: WebCam SC-13HDL11431N
>> [    2.441484] usb 1-1.4: Manufacturer: 123
>> [    2.441746] ata4: SATA link down (SStatus 0 SControl 300)
>> [    2.478093] usb 2-1.5: New USB device found, idVendor=8086, idProduct=
=0189
>> [    2.478105] usb 2-1.5: New USB device strings: Mfr=3D0, Product=3D0, =
SerialNumber=3D0
>> [    2.753858] ata5: SATA link down (SStatus 0 SControl 300)
>> [    2.755498] Freeing unused kernel memory: 1476K (ffffffff81f69000 - f=
fffffff820da000)
>> [    2.755509] Write protecting the kernel read-only data: 14336k
>> [    2.756953] Freeing unused kernel memory: 1828K (ffff880001837000 - f=
fff880001a00000)
>> [    2.759209] Freeing unused kernel memory: 752K (ffff880001d44000 - ff=
ff880001e00000)
>> [    2.797411] udevd[173]: starting version 175
>> [    3.010861] clocksource: Switched to clocksource tsc
>> [    3.064176] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
>> [    3.064212] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have A=
SPM control
>> [    3.067458] r8169 0000:02:00.0 eth0: RTL8168evl/8111evl at 0xffffc900=
009ae000, e8:03:9a:36:17:a9, XID 0c900800 IRQ 31
>> [    3.067473] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200 byt=
es, tx checksumming: ko]
>> [    3.105461] usb-storage 3-1:1.0: USB Mass Storage device detected
>> [    3.106039] scsi host6: usb-storage 3-1:1.0
>> [    3.108408] usbcore: registered new interface driver usb-storage
>> [    3.137466] usbcore: registered new interface driver usbhid
>> [    3.137481] usbhid: USB HID core driver
>> [    3.227228] input: Logitech USB-PS/2 Optical Mouse as /devices/pci000=
0:00/0000:00:1d.0/usb2/2-1/2-1.4/2-1.4:1.0/0003:046D:C00E.0001/input/input5
>> [    3.227722] hid-generic 0003:046D:C00E.0001: input: USB HID v1.10 Mou=
se [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-1.4/input0
>> [    4.017075] EXT4-fs (loop0): mounted filesystem with ordered data mod=
e. Opts: (null)
>> [    4.105962] scsi 6:0:0:0: Direct-Access     SanDisk  Cruzer Force    =
 1.27 PQ: 0 ANSI: 6
>> [    4.108554] sd 6:0:0:0: [sdc] 62530624 512-byte logical blocks: (32.0=
 GB/29.8 GiB)
>> [    4.108703] sd 6:0:0:0: Attached scsi generic sg2 type 0
>> [    4.111950] sd 6:0:0:0: [sdc] Write Protect is off
>> [    4.111967] sd 6:0:0:0: [sdc] Mode Sense: 43 00 00 00
>> [    4.112472] sd 6:0:0:0: [sdc] Write cache: disabled, read cache: enab=
led, doesn't support DPO or FUA
>> [    4.116266]  sdc: sdc1
>> [    4.118704] sd 6:0:0:0: [sdc] Attached SCSI removable disk
>> [    4.307637] random: nonblocking pool is initialized
>> [    6.014200] init: ureadahead main process (466) terminated with statu=
s 5
>> [   10.129205] Adding 262140k swap on /host/ubuntu/disks/swap.disk.  Pri=
ority:-1 extents:1 across:262140k FS
>> [   10.393601] EXT4-fs (loop0): re-mounted. Opts: errors=3Dremount-ro
>> [   10.541614] udevd[692]: starting version 175
>> [   11.806075] lp: driver loaded but no devices found
>> [   13.773763] wmi: Mapper loaded
>> [   13.933984] [drm] Initialized drm 1.1.0 20060810
>> [   13.998730] ACPI Warning: SystemIO range 0x0000000000000428-0x0000000=
00000042F conflicts with OpRegion 0x0000000000000400-0x000000000000047F (\P=
MIO) (20160422/utaddress-255)
>> [   13.998745] ACPI: If an ACPI driver is available for this device, you=
 should use it instead of the native driver
>> [   13.998755] ACPI Warning: SystemIO range 0x0000000000000540-0x0000000=
00000054F conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\G=
PIO) (20160422/utaddress-255)
>> [   13.998764] ACPI: If an ACPI driver is available for this device, you=
 should use it instead of the native driver
>> [   13.998769] ACPI Warning: SystemIO range 0x0000000000000530-0x0000000=
00000053F conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\G=
PIO) (20160422/utaddress-255)
>> [   13.998776] ACPI: If an ACPI driver is available for this device, you=
 should use it instead of the native driver
>> [   13.998781] ACPI Warning: SystemIO range 0x0000000000000500-0x0000000=
00000052F conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\G=
PIO) (20160422/utaddress-255)
>> [   13.998788] ACPI: If an ACPI driver is available for this device, you=
 should use it instead of the native driver
>> [   13.998790] lpc_ich: Resource conflict(s) found affecting gpio_ich
>> [   14.200142] samsung_laptop: detected SABI interface: SwSmi@
>> [   14.903945] Bluetooth: Core ver 2.21
>> [   14.904015] NET: Registered protocol family 31
>> [   14.904019] Bluetooth: HCI device and connection manager initialized
>> [   14.904117] Bluetooth: HCI socket layer initialized
>> [   14.904128] Bluetooth: L2CAP socket layer initialized
>> [   14.904216] Bluetooth: SCO socket layer initialized
>> [   15.444225] Intel(R) Wireless WiFi driver for Linux
>> [   15.444231] Copyright(c) 2003- 2015 Intel Corporation
>> [   15.444655] iwlwifi 0000:01:00.0: can't disable ASPM; OS doesn't have=
 ASPM control
>> [   15.558816] usbcore: registered new interface driver btusb
>> [   15.599588] psmouse serio1: elantech: assuming hardware version 3 (wi=
th firmware version 0x450f00)
>> [   15.615144] psmouse serio1: elantech: Synaptics capabilities query re=
sult 0x08, 0x17, 0x0c.
>> [   15.630778] psmouse serio1: elantech: Elan sample query result 03, 3f=
, 86
>> [   15.652278] ppdev: user-space parallel port driver
>> [   15.733952] Linux video capture interface: v2.00
>> [   15.736560] input: ETPS/2 Elantech Touchpad as /devices/platform/i804=
2/serio1/input/input6
>> [   16.329675] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269V=
C: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
>> [   16.329682] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0=
x0/0x0/0x0/0x0/0x0)
>> [   16.329684] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x15/0=
x0/0x0/0x0/0x0)
>> [   16.329686] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
>> [   16.329688] snd_hda_codec_realtek hdaudioC0D0:    inputs:
>> [   16.329692] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x=
19
>> [   16.329696] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x18
>> [   16.444311] iwlwifi 0000:01:00.0: loaded firmware version 18.168.6.1 =
op_mode iwldvm
>> [   16.647079] [drm] Memory usable by graphics device =3D 2048M
>> [   16.647128] [drm] Replacing VGA console driver
>> [   16.653221] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013=
).
>> [   16.653226] [drm] Driver supports precise vblank timestamp query.
>> [   16.657855] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecod=
es=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
>> [   16.727034] uvcvideo: Found UVC 1.00 device WebCam SC-13HDL11431N (22=
32:1018)
>> [   16.746786] input: WebCam SC-13HDL11431N as /devices/pci0000:00/0000:=
00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/input/input9
>> [   16.747288] usbcore: registered new interface driver uvcvideo
>> [   16.747292] USB Video Class driver (1.1.1)
>> [   16.817998] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post=
: no)
>> [   16.818994] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
A08:00/LNXVIDEO:00/input/input10
>> [   16.820143] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_=
audio_component_bind_ops [i915])
>> [   16.878519] Bluetooth: RFCOMM TTY layer initialized
>> [   16.878543] Bluetooth: RFCOMM socket layer initialized
>> [   16.878563] Bluetooth: RFCOMM ver 1.11
>> [   16.955703] fbcon: inteldrmfb (fb0) is primary device
>> [   16.956579]
>> [   16.956580] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> [   16.956581] [ INFO: possible circular locking dependency detected ]
>> [   16.956583] 4.7.0-rc7-4-iniza-small #1 Not tainted
>> [   16.956583] -------------------------------------------------------
>> [   16.956585] kworker/u16:1/79 is trying to acquire lock:
>> [   16.956618]  (&dev->mode_config.mutex){+.+.+.}, at: [<ffffffffa00f2b3=
0>] drm_modeset_lock_all+0x40/0x120 [drm]
>> [   16.956619]
>> [   16.956619] but task is already holding lock:
>> [   16.956626]  ((fb_notifier_list).rwsem){++++.+}, at: [<ffffffff810aae=
25>] __blocking_notifier_call_chain+0x35/0x70
>> [   16.956627]
>> [   16.956627] which lock already depends on the new lock.
>> [   16.956627]
>> [   16.956627]
>> [   16.956627] the existing dependency chain (in reverse order) is:
>> [   16.956631]
>> [   16.956631] -> #1 ((fb_notifier_list).rwsem){++++.+}:
>> [   16.956635]        [<ffffffff810dff49>] lock_acquire+0x119/0x220
>> [   16.956639]        [<ffffffff8182afd9>] down_write+0x49/0x80
>> [   16.956642]        [<ffffffff810aafb1>] blocking_notifier_chain_regis=
ter+0x21/0xb0
>> [   16.956646]        [<ffffffff814a17c8>] fb_register_client+0x18/0x20
>> [   16.956648]        [<ffffffff814a108b>] backlight_device_register+0x1=
2b/0x240
>> [   16.956710]        [<ffffffffa058b5f2>] intel_backlight_device_regist=
er+0xa2/0x170 [i915]
>> [   16.956764]        [<ffffffffa05591ee>] intel_connector_register+0xe/=
0x10 [i915]
>> [   16.956778]        [<ffffffffa00e14ba>] drm_connector_register+0x4a/0=
x80 [drm]
>> [   16.956792]        [<ffffffffa00e5903>] drm_modeset_register_all+0x16=
3/0x1c0 [drm]
>> [   16.956805]        [<ffffffffa00dcc52>] drm_dev_register+0xc2/0xd0 [d=
rm]
>> [   16.956848]        [<ffffffffa04c82f3>] i915_driver_load+0x753/0x13e0=
 [i915]
>> [   16.956892]        [<ffffffffa04d367f>] i915_pci_probe+0x4f/0x70 [i91=
5]
>> [   16.956896]        [<ffffffff8146e215>] local_pci_probe+0x45/0xa0
>> [   16.956899]        [<ffffffff8146f63d>] pci_device_probe+0xdd/0x130
>> [   16.956901]        [<ffffffff8157288e>] driver_probe_device+0x18e/0x2=
d0
>> [   16.956902]        [<ffffffff81572a67>] __driver_attach+0x97/0xa0
>> [   16.956905]        [<ffffffff815706a6>] bus_for_each_dev+0x66/0xa0
>> [   16.956908]        [<ffffffff8157220e>] driver_attach+0x1e/0x20
>> [   16.956910]        [<ffffffff81571de8>] bus_add_driver+0x1b8/0x230
>> [   16.956911]        [<ffffffff81573780>] driver_register+0x60/0xe0
>> [   16.956913]        [<ffffffff8146db80>] __pci_register_driver+0x60/0x=
70
>> [   16.956949]        [<ffffffffa061005d>] i915_init+0x5d/0x64 [i915]
>> [   16.956952]        [<ffffffff8100213d>] do_one_initcall+0x3d/0x160
>> [   16.956954]        [<ffffffff811abb85>] do_init_module+0x60/0x1dc
>> [   16.956957]        [<ffffffff81124f82>] load_module+0x2012/0x2610
>> [   16.956959]        [<ffffffff811256a6>] SYSC_init_module+0x126/0x140
>> [   16.956962]        [<ffffffff8112577e>] SyS_init_module+0xe/0x10
>> [   16.956964]        [<ffffffff8182d800>] entry_SYSCALL_64_fastpath+0x2=
3/0xc1
>> [   16.956966]
>> [   16.956966] -> #0 (&dev->mode_config.mutex){+.+.+.}:
>> [   16.956968]        [<ffffffff810df7ad>] __lock_acquire+0x19ed/0x1aa0
>> [   16.956970]        [<ffffffff810dff49>] lock_acquire+0x119/0x220
>> [   16.956971]        [<ffffffff81829339>] mutex_lock_nested+0x69/0x3c0
>> [   16.956988]        [<ffffffffa00f2b30>] drm_modeset_lock_all+0x40/0x1=
20 [drm]
>> [   16.956998]        [<ffffffffa021afbb>] drm_fb_helper_restore_fbdev_m=
ode_unlocked+0x2b/0x80 [drm_kms_helper]
>> [   16.957004]        [<ffffffffa021b03d>] drm_fb_helper_set_par+0x2d/0x=
50 [drm_kms_helper]
>> [   16.957043]        [<ffffffffa0569d8a>] intel_fbdev_set_par+0x1a/0x60=
 [i915]
>> [   16.957046]        [<ffffffff8149e9ec>] fbcon_init+0x53c/0x5b0
>> [   16.957048]        [<ffffffff81526666>] visual_init+0xd6/0x130
>> [   16.957050]        [<ffffffff81528bb7>] do_bind_con_driver+0x167/0x3a0
>> [   16.957052]        [<ffffffff8152911f>] do_take_over_console+0x12f/0x=
1a0
>> [   16.957054]        [<ffffffff81499e67>] do_fbcon_takeover+0x57/0xb0
>> [   16.957056]        [<ffffffff8149f572>] fbcon_event_notify+0x752/0x860
>> [   16.957058]        [<ffffffff810aac2d>] notifier_call_chain+0x5d/0x80
>> [   16.957060]        [<ffffffff810aae3d>] __blocking_notifier_call_chai=
n+0x4d/0x70
>> [   16.957062]        [<ffffffff810aae76>] blocking_notifier_call_chain+=
0x16/0x20
>> [   16.957064]        [<ffffffff814a180b>] fb_notifier_call_chain+0x1b/0=
x20
>> [   16.957065]        [<ffffffff814a3903>] register_framebuffer+0x253/0x=
340
>> [   16.957072]        [<ffffffffa021b29a>] drm_fb_helper_initial_config+=
0x23a/0x3d0 [drm_kms_helper]
>> [   16.957108]        [<ffffffffa056b078>] intel_fbdev_initial_config+0x=
18/0x30 [i915]
>> [   16.957110]        [<ffffffff810ac967>] async_run_entry_fn+0x37/0xe0
>> [   16.957113]        [<ffffffff810a29e2>] process_one_work+0x1d2/0x690
>> [   16.957115]        [<ffffffff810a2f09>] worker_thread+0x69/0x4c0
>> [   16.957116]        [<ffffffff810a983a>] kthread+0x10a/0x120
>> [   16.957118]        [<ffffffff8182da4f>] ret_from_fork+0x1f/0x40
>> [   16.957118]
>> [   16.957118] other info that might help us debug this:
>> [   16.957118]
>> [   16.957119]  Possible unsafe locking scenario:
>> [   16.957119]
>> [   16.957119]        CPU0                    CPU1
>> [   16.957120]        ----                    ----
>> [   16.957121]   lock((fb_notifier_list).rwsem);
>> [   16.957122]                                lock(&dev->mode_config.mut=
ex);
>> [   16.957123]                                lock((fb_notifier_list).rw=
sem);
>> [   16.957124]   lock(&dev->mode_config.mutex);
>> [   16.957124]
>> [   16.957124]  *** DEADLOCK ***
>> [   16.957124]
>> [   16.957125] 6 locks held by kworker/u16:1/79:
>> [   16.957129]  #0:  ("events_unbound"){.+.+.+}, at: [<ffffffff810a2964>=
] process_one_work+0x154/0x690
>> [   16.957132]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff810a2964>] =
process_one_work+0x154/0x690
>> [   16.957135]  #2:  (registration_lock#2){+.+.+.}, at: [<ffffffff814a36=
d7>] register_framebuffer+0x27/0x340
>> [   16.957138]  #3:  (console_lock){+.+.+.}, at: [<ffffffff814a3920>] re=
gister_framebuffer+0x270/0x340
>> [   16.957140]  #4:  (&fb_info->lock){+.+.+.}, at: [<ffffffff814a1c3d>] =
lock_fb_info+0x1d/0x40
>> [   16.957143]  #5:  ((fb_notifier_list).rwsem){++++.+}, at: [<ffffffff8=
10aae25>] __blocking_notifier_call_chain+0x35/0x70
>> [   16.957144]
>> [   16.957144] stack backtrace:
>> [   16.957146] CPU: 1 PID: 79 Comm: kworker/u16:1 Not tainted 4.7.0-rc7-=
4-iniza-small #1
>> [   16.957146] Hardware name: SAMSUNG ELECTRONICS CO., LTD. 530U3BI/530U=
4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
>> [   16.957149] Workqueue: events_unbound async_run_entry_fn
>> [   16.957152]  0000000000000000 ffff8800d434b7e0 ffffffff814164f5 fffff=
fff828bcb40
>> [   16.957154]  ffffffff828bcb40 ffff8800d434b820 ffffffff811ab19f ffff8=
800d434b890
>> [   16.957156]  ffff8800d4391400 0000000000000006 ffff8800d4391d60 c673b=
630397235fc
>> [   16.957156] Call Trace:
>> [   16.957160]  [<ffffffff814164f5>] dump_stack+0x85/0xc0
>> [   16.957163]  [<ffffffff811ab19f>] print_circular_bug+0x209/0x217
>> [   16.957166]  [<ffffffff810df7ad>] __lock_acquire+0x19ed/0x1aa0
>> [   16.957169]  [<ffffffff810dff49>] lock_acquire+0x119/0x220
>> [   16.957191]  [<ffffffffa00f2b30>] ? drm_modeset_lock_all+0x40/0x120 [=
drm]
>> [   16.957193]  [<ffffffff81829339>] mutex_lock_nested+0x69/0x3c0
>> [   16.957213]  [<ffffffffa00f2b30>] ? drm_modeset_lock_all+0x40/0x120 [=
drm]
>> [   16.957217]  [<ffffffff810fc29b>] ? rcu_read_lock_sched_held+0x8b/0xa0
>> [   16.957221]  [<ffffffff8121407e>] ? kmem_cache_alloc_trace+0x2de/0x360
>> [   16.957240]  [<ffffffffa00f2b30>] drm_modeset_lock_all+0x40/0x120 [dr=
m]
>> [   16.957250]  [<ffffffffa021afbb>] drm_fb_helper_restore_fbdev_mode_un=
locked+0x2b/0x80 [drm_kms_helper]
>> [   16.957259]  [<ffffffffa021b03d>] drm_fb_helper_set_par+0x2d/0x50 [dr=
m_kms_helper]
>> [   16.957307]  [<ffffffffa0569d8a>] intel_fbdev_set_par+0x1a/0x60 [i915]
>> [   16.957311]  [<ffffffff8149e9ec>] fbcon_init+0x53c/0x5b0
>> [   16.957314]  [<ffffffff81526666>] visual_init+0xd6/0x130
>> [   16.957317]  [<ffffffff81528bb7>] do_bind_con_driver+0x167/0x3a0
>> [   16.957319]  [<ffffffff8152911f>] do_take_over_console+0x12f/0x1a0
>> [   16.957322]  [<ffffffff81499e67>] do_fbcon_takeover+0x57/0xb0
>> [   16.957325]  [<ffffffff8149f572>] fbcon_event_notify+0x752/0x860
>> [   16.957328]  [<ffffffff810aae25>] ? __blocking_notifier_call_chain+0x=
35/0x70
>> [   16.957330]  [<ffffffff810aac2d>] notifier_call_chain+0x5d/0x80
>> [   16.957333]  [<ffffffff810aae3d>] __blocking_notifier_call_chain+0x4d=
/0x70
>> [   16.957335]  [<ffffffff810aae76>] blocking_notifier_call_chain+0x16/0=
x20
>> [   16.957337]  [<ffffffff814a180b>] fb_notifier_call_chain+0x1b/0x20
>> [   16.957339]  [<ffffffff814a3903>] register_framebuffer+0x253/0x340
>> [   16.957341]  [<ffffffff8156a920>] ? vga_switcheroo_client_fb_set+0x60=
/0x70
>> [   16.957348]  [<ffffffffa021b29a>] drm_fb_helper_initial_config+0x23a/=
0x3d0 [drm_kms_helper]
>> [   16.957382]  [<ffffffffa056b078>] intel_fbdev_initial_config+0x18/0x3=
0 [i915]
>> [   16.957385]  [<ffffffff810ac967>] async_run_entry_fn+0x37/0xe0
>> [   16.957386]  [<ffffffff810a29e2>] process_one_work+0x1d2/0x690
>> [   16.957388]  [<ffffffff810a2964>] ? process_one_work+0x154/0x690
>> [   16.957390]  [<ffffffff810a2f09>] worker_thread+0x69/0x4c0
>> [   16.957392]  [<ffffffff810a2ea0>] ? process_one_work+0x690/0x690
>> [   16.957394]  [<ffffffff810a983a>] kthread+0x10a/0x120
>> [   16.957396]  [<ffffffff8182da4f>] ret_from_fork+0x1f/0x40
>> [   16.957398]  [<ffffffff810a9730>] ? kthread_create_on_node+0x200/0x200
>> [   17.087267] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> [   17.087268] Bluetooth: BNEP filters: protocol multicast
>> [   17.087275] Bluetooth: BNEP socket layer initialized
>> [   17.179371] iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEBUG disabled
>> [   17.179372] iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEBUGFS enabled
>> [   17.179373] iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEVICE_TRACING enabl=
ed
>> [   17.179376] iwlwifi 0000:01:00.0: Detected Intel(R) Centrino(R) Advan=
ced-N 6230 AGN, REV=3D0xB0
>> [   17.181465] iwlwifi 0000:01:00.0: L1 Enabled - LTR Disabled
>> [   17.298596] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-=
rs'
>> [   17.528840] audit: type=1400 audit(1468561524.368:2): apparmor=3D"STA=
TUS" operation=3D"profile_load" name=3D"/sbin/dhclient" pid=1097 comm=3D"ap=
parmor_parser"
>> [   17.528845] audit: type=1400 audit(1468561524.368:3): apparmor=3D"STA=
TUS" operation=3D"profile_load" name=3D"/usr/lib/NetworkManager/nm-dhcp-cli=
ent.action" pid=1097 comm=3D"apparmor_parser"
>> [   17.528849] audit: type=1400 audit(1468561524.368:4): apparmor=3D"STA=
TUS" operation=3D"profile_load" name=3D"/usr/lib/connman/scripts/dhclient-s=
cript" pid=1097 comm=3D"apparmor_parser"
>> [   17.529054] audit: type=1400 audit(1468561524.368:5): apparmor=3D"STA=
TUS" operation=3D"profile_replace" name=3D"/sbin/dhclient" pid=1095 comm=3D=
"apparmor_parser"
>> [   17.529062] audit: type=1400 audit(1468561524.368:6): apparmor=3D"STA=
TUS" operation=3D"profile_replace" name=3D"/usr/lib/NetworkManager/nm-dhcp-=
client.action" pid=1095 comm=3D"apparmor_parser"
>> [   17.529068] audit: type=1400 audit(1468561524.368:7): apparmor=3D"STA=
TUS" operation=3D"profile_replace" name=3D"/usr/lib/connman/scripts/dhclien=
t-script" pid=1095 comm=3D"apparmor_parser"
>> [   17.529088] audit: type=1400 audit(1468561524.368:8): apparmor=3D"STA=
TUS" operation=3D"profile_replace" name=3D"/sbin/dhclient" pid=1186 comm=3D=
"apparmor_parser"
>> [   17.529094] audit: type=1400 audit(1468561524.368:9): apparmor=3D"STA=
TUS" operation=3D"profile_replace" name=3D"/usr/lib/NetworkManager/nm-dhcp-=
client.action" pid=1186 comm=3D"apparmor_parser"
>> [   17.529100] audit: type=1400 audit(1468561524.368:10): apparmor=3D"ST=
ATUS" operation=3D"profile_replace" name=3D"/usr/lib/connman/scripts/dhclie=
nt-script" pid=1186 comm=3D"apparmor_parser"
>> [   17.529419] audit: type=1400 audit(1468561524.368:11): apparmor=3D"ST=
ATUS" operation=3D"profile_replace" name=3D"/usr/lib/NetworkManager/nm-dhcp=
-client.action" pid=1097 comm=3D"apparmor_parser"
>> [   18.053583] [drm:intel_cpu_fifo_underrun_irq_handler [i915]] *ERROR* =
CPU pipe A FIFO underrun
>> [   18.054397] [drm:intel_set_pch_fifo_underrun_reporting [i915]] *ERROR=
* uncleared pch fifo underrun on pch transcoder A
>> [   18.054429] [drm:intel_pch_fifo_underrun_irq_handler [i915]] *ERROR* =
PCH transcoder A FIFO underrun
>> [   18.086472] Console: switching to colour frame buffer device 170x48
>> [   18.281135] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
>> [   18.302541] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1=
b.0/sound/card0/input7
>> [   18.305782] input: HDA Intel PCH Headphone as /devices/pci0000:00/000=
0:00:1b.0/sound/card0/input8
>> [   18.307708] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:1b.0/sound/card0/input11
>> [   18.972109] init: failsafe main process (1206) killed by TERM signal
>> [   23.786524] iwlwifi 0000:01:00.0: L1 Enabled - LTR Disabled
>> [   23.793122] iwlwifi 0000:01:00.0: L1 Enabled - LTR Disabled
>> [   23.793210] iwlwifi 0000:01:00.0: Radio type=3D0x1-0x2-0x0
>> [   24.069290] iwlwifi 0000:01:00.0: L1 Enabled - LTR Disabled
>> [   24.075944] iwlwifi 0000:01:00.0: L1 Enabled - LTR Disabled
>> [   24.076035] iwlwifi 0000:01:00.0: Radio type=3D0x1-0x2-0x0
>> [   24.156976] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
>> [   24.573127] r8169 0000:02:00.0 eth0: link down
>> [   24.573205] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [   31.040375] wlan0: authenticate with 02:1a:11:fe:b7:68
>> [   31.044965] wlan0: send auth to 02:1a:11:fe:b7:68 (try 1/3)
>> [   31.047056] wlan0: authenticated
>> [   31.050527] wlan0: associate with 02:1a:11:fe:b7:68 (try 1/3)
>> [   31.061051] wlan0: RX AssocResp from 02:1a:11:fe:b7:68 (capab=3D0x431=
 status=3D0 aid=3D2)
>> [   31.063664] wlan0: associated
>> [   31.063697] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
>
> --
> Jani Nikula, Intel Open Source Technology Center
