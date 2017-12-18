From: Ivan Kozik <ivan@ludios.org>
Date: Mon, 18 Dec 2017 14:35:11 +0000
Subject: page allocation failure: order:5 in fbcon_init
Message-Id: <87shc8gl40.fsf@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

I observed this page allocation failure in fbcon, while copying files
from one XFS filesystem to another.  As far as I know, there wasn't
anything else unusual going on at the time.  The system uptime was about
a day.  After the allocation failure, I could not allocate any more
ttys, and killed processes remained defunct.  Existing processes
remained running and I could ssh in with -T.  I have only seen this
once and I do not know how to reproduce it, and I am not sure if this
is an actual bug because I had some out-of-tree modules loaded.
Searching all of the mailing lists, I found a possibly-related thread:

[PATCH] mm: memcontrol: use vmalloc fallback for large kmem memcg arrays

that changed some functions in mm to not require physically contiguous
allocation, but I do not know if that is relevant here.

Thanks,

Ivan

dmesg:

[124047.663552] (agetty): page allocation failure: order:5, mode:0x16040c0(GFP_KERNEL|__GFP_COMP|__GFP_NOTRACK), nodemask=(null)
[124047.663556] (agetty) cpuset=/ mems_allowed=0
[124047.663559] CPU: 4 PID: 3901 Comm: (agetty) Tainted: P           O    4.14.0-15-amd64 #1 Debian 4.14.6-1
[124047.663559] Hardware name: ASUS All Series/Z97-A, BIOS 2801 11/11/2015
[124047.663560] Call Trace:
[124047.663565]  dump_stack+0x63/0x8b
[124047.663567]  warn_alloc+0x114/0x1b0
[124047.663569]  ? __alloc_pages_direct_compact+0x51/0x100
[124047.663570]  __alloc_pages_slowpath+0xf35/0xf50
[124047.663572]  __alloc_pages_nodemask+0x230/0x250
[124047.663574]  cache_grow_begin+0x86/0x540
[124047.663575]  fallback_alloc+0x164/0x210
[124047.663576]  ____cache_alloc_node+0x1e0/0x1f0
[124047.663577]  ? vc_allocate+0x123/0x1d0
[124047.663578]  __kmalloc+0x1e5/0x5b0
[124047.663580]  ? fbcon_init+0x1b5/0x610
[124047.663581]  vc_allocate+0x123/0x1d0
[124047.663582]  con_install+0x27/0xe0
[124047.663583]  tty_init_dev+0x72/0x1b0
[124047.663584]  tty_open+0x423/0x480
[124047.663587]  chrdev_open+0xbc/0x1d0
[124047.663589]  do_dentry_open+0x1fc/0x300
[124047.663590]  ? cdev_put+0x30/0x30
[124047.663591]  vfs_open+0x4f/0x70
[124047.663593]  path_openat+0x614/0x1490
[124047.663594]  ? alloc_set_pte+0x3b7/0x550
[124047.663596]  do_filp_open+0x99/0x110
[124047.663598]  ? __check_object_size+0xb3/0x190
[124047.663600]  ? __alloc_fd+0x46/0x170
[124047.663601]  do_sys_open+0x130/0x220
[124047.663602]  ? do_sys_open+0x130/0x220
[124047.663603]  SyS_open+0x1e/0x20
[124047.663605]  system_call_fast_compare_end+0xc/0x97
[124047.663606] RIP: 0033:0x7f4116b8983d
[124047.663607] RSP: 002b:00007ffd9bac89d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
[124047.663608] RAX: ffffffffffffffda RBX: 00005564fe7454d8 RCX: 00007f4116b8983d
[124047.663608] RDX: 0000000000000000 RSI: 0000000000080902 RDI: 00005564fe88fbd0
[124047.663609] RBP: 00005564fe88fbd0 R08: 00005564fe8679c6 R09: 0000000000000000
[124047.663610] R10: 0000000000000000 R11: 0000000000000293 R12: 00005564fe7454d8
[124047.663610] R13: 00007ffd9bac8a20 R14: 00005564fe7450b0 R15: 00007ffd9bac8ca0
[124047.663611] Mem-Info:
[124047.663615] active_anon:1138556 inactive_anon:226680 isolated_anon:0
[124047.663615]  active_file:552670 inactive_file:5813273 isolated_file:0
[124047.663615]  unevictable:16 dirty:61485 writeback:16384 unstable:0
[124047.663615]  slab_reclaimable:238301 slab_unreclaimable:52455
[124047.663615]  mapped:639379 shmem:231625 pagetables:32876 bounce:0
[124047.663615]  free:69446 free_pcp:101 free_cma:0
[124047.663617] Node 0 active_anon:4554224kB inactive_anon:906720kB active_file:2210680kB inactive_file:23253092kB unevictable:64kB isolated(anon):0kB isolated(file):0kB mapped:2557516kB dirty:245940kB writeback:65536kB shmem:926500kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 555008kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[124047.663618] Node 0 DMA free:15884kB min:32kB low:44kB high:56kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15980kB managed:15884kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[124047.663620] lowmem_reserve[]: 0 2503 32170 32170 32170
[124047.663622] Node 0 DMA32 free:128140kB min:5092kB low:7568kB high:10044kB active_anon:278020kB inactive_anon:35900kB active_file:88232kB inactive_file:1891216kB unevictable:0kB writepending:2932kB present:2563348kB managed:2563348kB mlocked:0kB kernel_stack:1344kB pagetables:5344kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[124047.663624] lowmem_reserve[]: 0 0 29667 29667 29667
[124047.663626] Node 0 Normal free:133760kB min:62456kB low:92828kB high:123200kB active_anon:4276204kB inactive_anon:870820kB active_file:2122448kB inactive_file:21361832kB unevictable:64kB writepending:309120kB present:30916608kB managed:30379076kB mlocked:64kB kernel_stack:27024kB pagetables:126160kB bounce:0kB free_pcp:520kB local_pcp:0kB free_cma:0kB
[124047.663628] lowmem_reserve[]: 0 0 0 0 0
[124047.663630] Node 0 DMA: 3*4kB (U) 2*8kB (U) 3*16kB (U) 2*32kB (U) 2*64kB (U) 2*128kB (U) 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15884kB
[124047.663635] Node 0 DMA32: 630*4kB (UME) 405*8kB (UME) 6140*16kB (UME) 768*32kB (UE) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 128576kB
[124047.663640] Node 0 Normal: 116*4kB (UME) 16596*8kB (UME) 17*16kB (UE) 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 133504kB
[124047.663644] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size48576kB
[124047.663645] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size 48kB
[124047.663645] 6597550 total pagecache pages
[124047.663646] 0 pages in swap cache
[124047.663647] Swap cache stats: add 0, delete 0, find 0/0
[124047.663647] Free swap  = 0kB
[124047.663647] Total swap = 0kB
[124047.663648] 8373984 pages RAM
[124047.663648] 0 pages HighMem/MovableOnly
[124047.663648] 134407 pages reserved
[124047.663649] 0 pages hwpoisoned
[124047.663670] divide error: 0000 [#1] SMP
[124047.663671] Modules linked in: cpuid binfmt_misc bridge stp llc veth vmnet(O) parport_pc parport vmw_vsock_vmci_transport vsock vmw_vmci vmmon(O) loop fuse wireguard ip6_udp_tunnel udp_tunnel tun nf_log_ipv4 nf_log_common xt_LOG xt_multiport ipt_REJECT nf_reject_ipv4 xt_owner xt_tcpudp snd_hda_codec_hdmi xt_conntrack intel_rapl nls_ascii nls_cp437 eeepc_wmi asus_wmi sparse_keymap iTCO_wdt vfat iTCO_vendor_support rfkill wmi_bmof mxm_wmi fat x86_pkg_temp_thermal intel_powerclamp coretemp tcp_bbr sch_fq kvm_intel kvm irqbypass intel_cstate intel_uncore efi_pstore iptable_filter snd_usb_audio intel_rapl_perf serio_raw efivars joydev snd_usbmidi_lib snd_hda_intel snd_rawmidi evdev snd_seq_device snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd soundcore sg lpc_ich shpchp mfd_core battery tpm_infineon
[124047.663697]  wmi video acpi_pad button nvidia_drm(PO) drm_kms_helper drm iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nvidia_modeset(PO) nf_conntrack nvidia(PO) efivarfs ip_tables x_tables autofs4 xfs libcrc32c crc32c_generic algif_skcipher af_alg hid_generic usbhid hid ses enclosure scsi_transport_sas dm_crypt dm_mod sd_mod uas usb_storage crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd glue_helper cryptd xhci_pci ahci libahci ehci_pci xhci_hcd ehci_hcd libata i2c_i801 e1000e ptp usbcore pps_core scsi_mod usb_common fan thermal [last unloaded: vmnet]
[124047.663719] CPU: 4 PID: 3901 Comm: (agetty) Tainted: P           O    4.14.0-15-amd64 #1 Debian 4.14.6-1
[124047.663719] Hardware name: ASUS All Series/Z97-A, BIOS 2801 11/11/2015
[124047.663720] task: ffff9217da986040 task.stack: ffffaa99cdaac000
[124047.663722] RIP: 0010:fbcon_init+0x1e3/0x610
[124047.663722] RSP: 0018:ffffaa99cdaafa60 EFLAGS: 00010246
[124047.663723] RAX: 0000000000000f00 RBX: 0000000000000002 RCX: 0000000000000000
[124047.663724] RDX: 0000000000000000 RSI: ffff921bf5665e00 RDI: ffff921bf5665e00
[124047.663724] RBP: ffffaa99cdaafaa8 R08: 0000000000000001 R09: 0000000000000870
[124047.663725] R10: 0000000000000000 R11: 0000000000000010 R12: ffff921bf5665e00
[124047.663725] R13: ffff921bfe100c00 R14: ffff921904787000 R15: ffff921bf565f800
[124047.663727] FS:  00007f41182cd940(0000) GS:ffff921c1ed00000(0000) knlGS:0000000000000000
[124047.663727] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[124047.663728] CR2: 00007f4117fa2e50 CR3: 00000001c3bc4006 CR4: 00000000001626e0
[124047.663728] Call Trace:
[124047.663731]  visual_init+0xd6/0x130
[124047.663732]  vc_allocate+0xf9/0x1d0
[124047.663734]  con_install+0x27/0xe0
[124047.663735]  tty_init_dev+0x72/0x1b0
[124047.663736]  tty_open+0x423/0x480
[124047.663738]  chrdev_open+0xbc/0x1d0
[124047.663739]  do_dentry_open+0x1fc/0x300
[124047.663740]  ? cdev_put+0x30/0x30
[124047.663741]  vfs_open+0x4f/0x70
[124047.663742]  path_openat+0x614/0x1490
[124047.663743]  ? alloc_set_pte+0x3b7/0x550
[124047.663745]  do_filp_open+0x99/0x110
[124047.663747]  ? __check_object_size+0xb3/0x190
[124047.663748]  ? __alloc_fd+0x46/0x170
[124047.663749]  do_sys_open+0x130/0x220
[124047.663750]  ? do_sys_open+0x130/0x220
[124047.663751]  SyS_open+0x1e/0x20
[124047.663752]  system_call_fast_compare_end+0xc/0x97
[124047.663753] RIP: 0033:0x7f4116b8983d
[124047.663753] RSP: 002b:00007ffd9bac89d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
[124047.663754] RAX: ffffffffffffffda RBX: 00005564fe7454d8 RCX: 00007f4116b8983d
[124047.663755] RDX: 0000000000000000 RSI: 0000000000080902 RDI: 00005564fe88fbd0
[124047.663755] RBP: 00005564fe88fbd0 R08: 00005564fe8679c6 R09: 0000000000000000
[124047.663756] R10: 0000000000000000 R11: 0000000000000293 R12: 00005564fe7454d8
[124047.663756] R13: 00007ffd9bac8a20 R14: 00005564fe7450b0 R15: 00007ffd9bac8ca0
[124047.663757] Code: 24 98 01 00 00 fd ff ff ff 45 8b 96 64 01 00 00 41 8b 8e 68 01 00 00 41 8b 47 50 45 8b 4f 54 74 08 44 89 ca 41 89 c1 89 d0 31 d2 <41> f7 b6 e0 01 00 00 31 d2 41 89 c0 44 89 c8 41 f7 b6 e4 01 00 
[124047.663776] ---[ end trace ec1a56a19ae6dc5f ]---

# sysctl -a | grep vm\.
vm.admin_reserve_kbytes = 8192
vm.block_dump = 0
vm.compact_unevictable_allowed = 1
vm.dirty_background_bytes = 314572800
vm.dirty_background_ratio = 0
vm.dirty_bytes = 629145600
vm.dirty_expire_centisecs = 3000
vm.dirty_ratio = 0
vm.dirty_writeback_centisecs = 500
vm.dirtytime_expire_seconds = 43200
vm.drop_caches = 0
vm.extfrag_threshold = 500
vm.hugepages_treat_as_movable = 0
vm.hugetlb_shm_group = 0
vm.laptop_mode = 0
vm.legacy_va_layout = 0
vm.lowmem_reserve_ratio = 256   256     32      1
vm.max_map_count = 65530
vm.memory_failure_early_kill = 0
vm.memory_failure_recovery = 1
vm.min_free_kbytes = 67584
vm.min_slab_ratio = 5
vm.min_unmapped_ratio = 1
vm.mmap_min_addr = 65536
vm.mmap_rnd_bits = 28
vm.mmap_rnd_compat_bits = 8
vm.nr_hugepages = 0
vm.nr_hugepages_mempolicy = 0
vm.nr_overcommit_hugepages = 0
vm.nr_pdflush_threads = 0
vm.numa_zonelist_order = Node
vm.oom_dump_tasks = 1
vm.oom_kill_allocating_task = 0
vm.overcommit_kbytes = 0
vm.overcommit_memory = 0
vm.overcommit_ratio = 50
vm.page-cluster = 3
vm.panic_on_oom = 0
vm.percpu_pagelist_fraction = 0
vm.stat_interval = 1
vm.swappiness = 60
vm.user_reserve_kbytes = 131072
vm.vfs_cache_pressure = 50
vm.watermark_scale_factor = 10
vm.zone_reclaim_mode = 0

/etc/sysctl.conf:

fs.inotify.max_user_instances      = 8192
fs.inotify.max_user_watches        = 1029947
kernel.dmesg_restrict              = 1
kernel.kptr_restrict               = 1
kernel.perf_event_paranoid         = 3
kernel.printk                      = 4 4 1 7
kernel.sysrq                       = 0
kernel.unprivileged_bpf_disabled   = 1
kernel.unprivileged_userns_clone   = 1
net.core.default_qdisc             = fq
net.ipv4.conf.all.rp_filter        = 1
net.ipv4.conf.default.rp_filter    = 1
net.ipv4.tcp_congestion_control    = bbr
net.ipv6.conf.all.disable_ipv6     = 1
net.ipv6.conf.all.use_tempaddr     = 0
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.default.use_tempaddr = 0
vm.dirty_background_bytes          = 314572800
vm.dirty_bytes                     = 629145600
vm.dirty_expire_centisecs          = 3000
vm.vfs_cache_pressure              = 50

cmdline:

consoleblank=0 scsi_mod.use_blk_mq=n dm_mod.use_blk_mq=n apparmor=1 security=apparmor efi_no_storage_paranoia intel_iommu=on
