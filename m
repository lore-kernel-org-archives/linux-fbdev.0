From: Alistair Popple <alistair@popple.id.au>
Date: Sat, 03 Oct 2015 01:38:35 +0000
Subject: [BUG] RCU stall in cursor_timer_handler
Message-Id: <2505354.BllTl4uaOg@new-mexico>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org, Scot Doyle <lkml14@scotdoyle.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org, airlied@redhat.com, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi,

We have been intermittently seeing the below RCU stall at boot on a PPC64LE=
 4.2.1 kernel which has been preventing the system from booting. Further in=
vestigation indicates that  ops->cur_blink_jiffies is potentially being use=
d uninitialised in cursor_timer_handler():

static void cursor_timer_handler(unsigned long dev_addr)
{
	struct fb_info *info =3D (struct fb_info *) dev_addr;
	struct fbcon_ops *ops =3D info->fbcon_par;

	queue_work(system_power_efficient_wq, &info->queue);
	mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
}

Adding WARN_ON(ops->cur_blink_jiffies < 1) to the above occasionally trigge=
rs and further testing shows ops->cur_blink_jiffies =3D 0, therefore I susp=
ect cur_blink_jiffies is being used uninitialised. This patch seems to work=
 around the problem:

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 1aaf893..45d2a0a 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -416,6 +416,8 @@ static void fbcon_add_cursor_timer(struct fb_info *info)
                        INIT_WORK(&info->queue, fb_flashcursor);
=20
                init_timer(&ops->cursor_timer);
+               if (ops->cur_blink_jiffies < 1)
+                       ops->cur_blink_jiffies =3D msecs_to_jiffies(200);
                ops->cursor_timer.function =3D cursor_timer_handler;
                ops->cursor_timer.expires =3D jiffies + ops->cur_blink_jiff=
ies;
                ops->cursor_timer.data =3D (unsigned long ) info;

It looks like the issue was introduced by:

commit 27a4c827c34ac4256a190cc9d24607f953c1c459
Author: Scot Doyle <lkml14@scotdoyle.com>                                  =
                                                                           =
                               =20
Date:   Thu Mar 26 13:56:38 2015 +0000                                     =
                                                                           =
                               =20
                                                                           =
                                                                           =
                               =20
    fbcon: use the cursor blink interval provided by vt                    =
                                                                           =
                               =20
                                                                           =
                                                                           =
                               =20
    vt now provides a cursor blink interval via vc_data. Use this          =
                                                                           =
                               =20
    interval instead of the currently hardcoded 200 msecs. Store it in     =
                                                                           =
                               =20
    fbcon_ops to avoid locking the console in cursor_timer_handler().      =
                                                                           =
                               =20
                                                                           =
                                                                           =
                               =20
    Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>                       =
                                                                           =
                               =20
    Acked-by: Pavel Machek <pavel@ucw.cz>                                  =
                                                                           =
                               =20
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>         =
                                                                           =
                               =20

Regards,

Alistair

[0000006280989170] Generic RTC Driver v1.07
[0000006281152624] powernv_rng: Registered powernv hwrng.
[0000006281250526] [drm] Initialized drm 1.1.0 20060810
[0000006281323420] [drm] radeon kernel modesetting enabled.
[0000006281570416] ast 0001:10:00.0: enabling device (0140 -> 0142)
[0000006281932424] [drm] platform has no IO space, trying MMIO
[0000006281978870] [drm] AST 2400 detected
[0000006282070130] [drm] VGA not enabled on entry, requesting chip POST
[0000006282131234] [drm] Analog VGA only
[0000006282174414] [drm] dram 1632000000 7 16 00c00000
[0000006282324794] [TTM] Zone  kernel: Available graphics memory: 66806240 =
kiB
[0000006282376184] [TTM] Zone   dma32: Available graphics memory: 2097152 k=
iB
[0000006282551070] [TTM] Initializing pool allocator
[0000027281989546] INFO: rcu_sched self-detected stall on CPU
[0000027281996420] 	154: (2100 ticks this GP) idle=E25/140000000000002/0 so=
ftirq23/326 fqs 99=20
[0000027282010008] 	 (t!00 jiffies g=3D-260 c=3D-261 qC21)
[0000027282013264] Task dump for CPU 154:
[0000027282017276] swapper/136     R  running task        0     1      0 0x=
00000804
[0000027282018170] Call Trace:
[0000027282023368] [c000001fe0301c50] [c00000000007fe98] sched_show_task+0x=
178/0x184 (unreliable)
[0000027282027166] [c000001fe0301cc0] [c0000000000a7150] rcu_dump_cpu_stack=
s+0xa0/0xd0
[0000027282030432] [c000001fe0301d10] [c0000000000a9ff8] rcu_check_callback=
s+0x294/0x734
[0000027282032980] [c000001fe0301e30] [c0000000000ac2c4] update_process_tim=
es+0x3c/0x74
[0000027282036196] [c000001fe0301e60] [c0000000000bb864] tick_sched_handle.=
isra.16+0x60/0x6c
[0000027282038920] [c000001fe0301e90] [c0000000000bb8bc] tick_sched_timer+0=
x4c/0x84
[0000027282041588] [c000001fe0301ed0] [c0000000000acee4] __hrtimer_run_queu=
es+0xf8/0x1ac
[0000027282044084] [c000001fe0301f60] [c0000000000ad1b0] hrtimer_interrupt+=
0xac/0x1d8
[0000027282047074] [c000001fe0302010] [c000000000017150] __timer_interrupt+=
0x7c/0xe0
[0000027282049460] [c000001fe0302050] [c000000000017314] timer_interrupt+0x=
ac/0xc4
[0000027282052522] [c000001fe0302080] [c000000000002328] decrementer_common=
+0x128/0x180
[0000027282057424] --- interrupt: 901 at _restgpr0_29+0x8/0x18
    LR =3D call_timer_fn+0x98/0xf4
[0000027282061014] [c000001fe0302370] [c0000000000ab5fc] run_timer_softirq+=
0x1dc/0x208 (unreliable)
[0000027282064008] [c000001fe0302400] [c000000000059df0] __do_softirq+0x158=
/0x2b4
[0000027282066428] [c000001fe03024f0] [c00000000005a1fc] irq_exit+0x74/0xcc
[0000027282068796] [c000001fe0302510] [c000000000017318] timer_interrupt+0x=
b0/0xc4
[0000027282071316] [c000001fe0302540] [c000000000002328] decrementer_common=
+0x128/0x180
[0000027282075708] --- interrupt: 901 at _memset_io+0x5c/0x98
    LR =3D ttm_bo_move_memcpy+0xb8/0x46c
[0000027282078796] [c000001fe0302830] [c000000000496140] ttm_bo_move_memcpy=
+0x68/0x46c (unreliable)
[0000027282082222] [c000001fe0302970] [c0000000005b4338] ast_bo_move+0x20/0=
x34
[0000027282085106] [c000001fe0302990] [c000000000494520] ttm_bo_handle_move=
_mem+0x230/0x3d8
[0000027282087558] [c000001fe0302ab0] [c000000000495454] ttm_bo_validate+0x=
20c/0x28c
[0000027282090390] [c000001fe0302b60] [c0000000005b4a58] ast_bo_pin+0x90/0x=
bc
[0000027282093668] [c000001fe0302b90] [c0000000005b276c] ast_crtc_do_set_ba=
se.isra.8.constprop.13+0x120/0x298
[0000027282096382] [c000001fe0302c40] [c0000000005b354c] ast_crtc_mode_set+=
0xc68/0xc74
[0000027282099952] [c000001fe0302cf0] [c00000000045faa4] drm_crtc_helper_se=
t_mode+0x348/0x4d8
[0000027282103026] [c000001fe0302f80] [c000000000460420] drm_crtc_helper_se=
t_config+0x6c4/0x944
[0000027282106578] [c000001fe03030a0] [c00000000047bbc0] drm_mode_set_confi=
g_internal+0x68/0xf0
[0000027282109416] [c000001fe03030e0] [c00000000046aa40] restore_fbdev_mode=
+0xe8/0x110
[0000027282112658] [c000001fe0303120] [c00000000046c7a4] drm_fb_helper_rest=
ore_fbdev_mode_unlocked+0x38/0x7c
[0000027282115350] [c000001fe0303160] [c00000000046c82c] drm_fb_helper_set_=
par+0x44/0x58
[0000027282118480] [c000001fe03031c0] [c000000000402af0] fbcon_init+0x360/0=
x474
[0000027282121374] [c000001fe03032b0] [c000000000443850] visual_init+0xec/0=
x13c
[0000027282123870] [c000001fe03032f0] [c00000000044551c] do_bind_con_driver=
+0x280/0x398
[0000027282126484] [c000001fe03033b0] [c000000000445a38] do_take_over_conso=
le+0x1dc/0x1ec
[0000027282129536] [c000001fe0303460] [c000000000402c98] do_fbcon_takeover+=
0x94/0x114
[0000027282132768] [c000001fe0303480] [c0000000000754dc] notifier_call_chai=
n+0x6c/0xa8
[0000027282135978] [c000001fe03034d0] [c0000000000758c4] __blocking_notifie=
r_call_chain+0x58/0x74
[0000027282138972] [c000001fe0303520] [c0000000004088e4] fb_notifier_call_c=
hain+0x2c/0x40
[0000027282142054] [c000001fe0303540] [c00000000040b0f0] register_framebuff=
er+0x298/0x2d8
[0000027282144998] [c000001fe0303630] [c00000000046cb88] drm_fb_helper_init=
ial_config+0x348/0x3f8
[0000027282147988] [c000001fe03036d0] [c0000000005b4108] ast_fbdev_init+0xc=
8/0x100
[0000027282150858] [c000001fe0303710] [c0000000005b1468] ast_driver_load+0x=
778/0x7b4
[0000027282153364] [c000001fe03037a0] [c000000000475dac] drm_dev_register+0=
xb0/0x14c
[0000027282155930] [c000001fe03037f0] [c000000000477f74] drm_get_pci_dev+0x=
114/0x1bc
[0000027282158636] [c000001fe0303880] [c0000000005b08b0] ast_pci_probe+0x20=
/0x34
[0000027282161526] [c000001fe03038a0] [c0000000003f3160] pci_device_probe+0=
x78/0xdc
[0000027282164264] [c000001fe0303920] [c0000000005bfc20] driver_probe_devic=
e+0x128/0x2b0
[0000027282166980] [c000001fe03039b0] [c0000000005bfe40] __driver_attach+0x=
98/0xc8
[0000027282169602] [c000001fe03039f0] [c0000000005bdbcc] bus_for_each_dev+0=
xa4/0xb8
[0000027282172304] [c000001fe0303a40] [c0000000005bf6e0] driver_attach+0x2c=
/0x40
[0000027282174942] [c000001fe0303a60] [c0000000005bf1b8] bus_add_driver+0x1=
00/0x240
[0000027282177590] [c000001fe0303af0] [c0000000005c06cc] driver_register+0x=
c0/0x110
[0000027282180170] [c000001fe0303b70] [c0000000003f2d40] __pci_register_dri=
ver+0x68/0x74
[0000027282182632] [c000001fe0303ba0] [c000000000478084] drm_pci_init+0x68/=
0x10c
[0000027282185604] [c000001fe0303c30] [c0000000010977fc] ast_init+0x3c/0x50
[0000027282188640] [c000001fe0303c50] [c00000000000ade4] do_one_initcall+0x=
134/0x1d0
[0000027282191604] [c000001fe0303d20] [c000000001073cac] kernel_init_freeab=
le+0x198/0x254
[0000027282194406] [c000001fe0303dc0] [c00000000000b578] kernel_init+0x24/0=
x114
[0000027282197296] [c000001fe0303e30] [c0000000000094ac] ret_from_kernel_th=
read+0x5c/0xb0
[0000033872001022] NMI watchdog: BUG: soft lockup - CPU#154 stuck for 22s! =
[swapper/136:1]
[0000033872003536] Modules linked in:
[0000033872007714] CPU: 154 PID: 1 Comm: swapper/136 Not tainted 4.2.0-open=
power1 #60
[0000033872010008] task: c000001fe0280000 ti: c000001fe0300000 task.ti: c00=
0001fe0300000
[0000033872011464] NIP: c00000000000dca8 LR: c00000000000dca8 CTR: c0000000=
00400c6c
[0000033872012960] REGS: c000001fe03020a0 TRAP: 0901   Not tainted  (4.2.0-=
openpower1)
[0000033872018728] MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 440=
08024  XER: 20000000
[0000033872028578] CFAR: c000000000093994 SOFTE: 1=20
GPR00: c000000000b73384 c000001fe0302320 c000000001776800 0000000000000900 =

GPR04: 00000000000001ce c000001fe0280958 c000001fe0280958 0000000000000001 =

GPR08: 0000000000000000 000000000000013f 0000000000000000 0000000000005bd0 =

GPR12: 0000000000008800 c00000000fe9ce00=20
[0000033872031252] NIP [c00000000000dca8] arch_local_irq_restore+0x5c/0x80
[0000033872033570] LR [c00000000000dca8] arch_local_irq_restore+0x5c/0x80
[0000033872034104] Call Trace:
[0000033872036578] [c000001fe0302320] [c000001fddc920d8] 0xc000001fddc920d8=
 (unreliable)
[0000033872039890] [c000001fe0302340] [c000000000b73384] _raw_spin_unlock_i=
rq+0x44/0x6c
[0000033872042698] [c000001fe0302370] [c0000000000ab5e8] run_timer_softirq+=
0x1c8/0x208
[0000033872045086] [c000001fe0302400] [c000000000059df0] __do_softirq+0x158=
/0x2b4
[0000033872047264] [c000001fe03024f0] [c00000000005a1fc] irq_exit+0x74/0xcc
[0000033872049056] [c000001fe0302510] [c000000000017318] timer_interrupt+0x=
b0/0xc4
[0000033872050982] [c000001fe0302540] [c000000000002328] decrementer_common=
+0x128/0x180
[0000033872053750] --- interrupt: 901 at _memset_io+0x5c/0x98
    LR =3D ttm_bo_move_memcpy+0xb8/0x46c
[0000033872056014] [c000001fe0302830] [c000000000496140] ttm_bo_move_memcpy=
+0x68/0x46c (unreliable)
[0000033872058166] [c000001fe0302970] [c0000000005b4338] ast_bo_move+0x20/0=
x34
[0000033872060102] [c000001fe0302990] [c000000000494520] ttm_bo_handle_move=
_mem+0x230/0x3d8
[0000033872061828] [c000001fe0302ab0] [c000000000495454] ttm_bo_validate+0x=
20c/0x28c
[0000033872063952] [c000001fe0302b60] [c0000000005b4a58] ast_bo_pin+0x90/0x=
bc
[0000033872066264] [c000001fe0302b90] [c0000000005b276c] ast_crtc_do_set_ba=
se.isra.8.constprop.13+0x120/0x298
[0000033872068250] [c000001fe0302c40] [c0000000005b354c] ast_crtc_mode_set+=
0xc68/0xc74
[0000033872070578] [c000001fe0302cf0] [c00000000045faa4] drm_crtc_helper_se=
t_mode+0x348/0x4d8
[0000033872072840] [c000001fe0302f80] [c000000000460420] drm_crtc_helper_se=
t_config+0x6c4/0x944
[0000033872075094] [c000001fe03030a0] [c00000000047bbc0] drm_mode_set_confi=
g_internal+0x68/0xf0
[0000033872077068] [c000001fe03030e0] [c00000000046aa40] restore_fbdev_mode=
+0xe8/0x110
[0000033872079358] [c000001fe0303120] [c00000000046c7a4] drm_fb_helper_rest=
ore_fbdev_mode_unlocked+0x38/0x7c
[0000033872081366] [c000001fe0303160] [c00000000046c82c] drm_fb_helper_set_=
par+0x44/0x58
[0000033872083428] [c000001fe03031c0] [c000000000402af0] fbcon_init+0x360/0=
x474
[0000033872085142] [c000001fe03032b0] [c000000000443850] visual_init+0xec/0=
x13c
[0000033872086958] [c000001fe03032f0] [c00000000044551c] do_bind_con_driver=
+0x280/0x398
[0000033872088796] [c000001fe03033b0] [c000000000445a38] do_take_over_conso=
le+0x1dc/0x1ec
[0000033872090818] [c000001fe0303460] [c000000000402c98] do_fbcon_takeover+=
0x94/0x114
[0000033872093108] [c000001fe0303480] [c0000000000754dc] notifier_call_chai=
n+0x6c/0xa8
[0000033872095484] [c000001fe03034d0] [c0000000000758c4] __blocking_notifie=
r_call_chain+0x58/0x74
[0000033872097708] [c000001fe0303520] [c0000000004088e4] fb_notifier_call_c=
hain+0x2c/0x40
[0000033872099958] [c000001fe0303540] [c00000000040b0f0] register_framebuff=
er+0x298/0x2d8
[0000033872102108] [c000001fe0303630] [c00000000046cb88] drm_fb_helper_init=
ial_config+0x348/0x3f8
[0000033872104178] [c000001fe03036d0] [c0000000005b4108] ast_fbdev_init+0xc=
8/0x100
[0000033872106108] [c000001fe0303710] [c0000000005b1468] ast_driver_load+0x=
778/0x7b4
[0000033872107796] [c000001fe03037a0] [c000000000475dac] drm_dev_register+0=
xb0/0x14c
[0000033872109608] [c000001fe03037f0] [c000000000477f74] drm_get_pci_dev+0x=
114/0x1bc
[0000033872111488] [c000001fe0303880] [c0000000005b08b0] ast_pci_probe+0x20=
/0x34
[0000033872113446] [c000001fe03038a0] [c0000000003f3160] pci_device_probe+0=
x78/0xdc
[0000033872115484] [c000001fe0303920] [c0000000005bfc20] driver_probe_devic=
e+0x128/0x2b0
[0000033872117444] [c000001fe03039b0] [c0000000005bfe40] __driver_attach+0x=
98/0xc8
[0000033872119284] [c000001fe03039f0] [c0000000005bdbcc] bus_for_each_dev+0=
xa4/0xb8
[0000033872121194] [c000001fe0303a40] [c0000000005bf6e0] driver_attach+0x2c=
/0x40
[0000033872123082] [c000001fe0303a60] [c0000000005bf1b8] bus_add_driver+0x1=
00/0x240
[0000033872125046] [c000001fe0303af0] [c0000000005c06cc] driver_register+0x=
c0/0x110
[0000033872126934] [c000001fe0303b70] [c0000000003f2d40] __pci_register_dri=
ver+0x68/0x74
[0000033872128750] [c000001fe0303ba0] [c000000000478084] drm_pci_init+0x68/=
0x10c
[0000033872131108] [c000001fe0303c30] [c0000000010977fc] ast_init+0x3c/0x50
[0000033872133328] [c000001fe0303c50] [c00000000000ade4] do_one_initcall+0x=
134/0x1d0
[0000033872135374] [c000001fe0303d20] [c000000001073cac] kernel_init_freeab=
le+0x198/0x254
[0000033872137484] [c000001fe0303dc0] [c00000000000b578] kernel_init+0x24/0=
x114
[0000033872139614] [c000001fe0303e30] [c0000000000094ac] ret_from_kernel_th=
read+0x5c/0xb0
[0000033872140422] Instruction dump:
[0000033872143730] f821ffe1 419e000c e92d0020 7d210164 39200000 992d0252 4b=
ffff11 39400001=20
[0000033872146660] 994d0252 2fa30000 419e0010 4bff41c5 <60000000> 48000010 =
e92d0020 61298000=20
[0000090311985354] INFO: rcu_sched self-detected stall on CPU
[0000090311992284] 	154: (8403 ticks this GP) idle=E25/140000000000002/0 so=
ftirq23/326 fqs=8402=20
[0000090312003940] 	 (t=8403 jiffies g=3D-260 c=3D-261 qC21)
[0000090312007380] Task dump for CPU 154:
[0000090312011140] swapper/136     R  running task        0     1      0 0x=
00000804
[0000090312011742] Call Trace:
[0000090312015782] [c000001fe0301ac0] [c00000000007fe98] sched_show_task+0x=
178/0x184 (unreliable)
[0000090312019000] [c000001fe0301b30] [c0000000000a7150] rcu_dump_cpu_stack=
s+0xa0/0xd0
[0000090312022140] [c000001fe0301b80] [c0000000000a9ff8] rcu_check_callback=
s+0x294/0x734
[0000090312024654] [c000001fe0301ca0] [c0000000000ac2c4] update_process_tim=
es+0x3c/0x74
[0000090312027530] [c000001fe0301cd0] [c0000000000bb864] tick_sched_handle.=
isra.16+0x60/0x6c
[0000090312030168] [c000001fe0301d00] [c0000000000bb8bc] tick_sched_timer+0=
x4c/0x84
[0000090312032744] [c000001fe0301d40] [c0000000000acee4] __hrtimer_run_queu=
es+0xf8/0x1ac
[0000090312035308] [c000001fe0301dd0] [c0000000000ad1b0] hrtimer_interrupt+=
0xac/0x1d8
[0000090312037774] [c000001fe0301e80] [c000000000017150] __timer_interrupt+=
0x7c/0xe0
[0000090312040240] [c000001fe0301ec0] [c000000000017314] timer_interrupt+0x=
ac/0xc4
[0000090312042900] [c000001fe0301ef0] [c000000000002328] decrementer_common=
+0x128/0x180
[0000090312047390] --- interrupt: 901 at arch_local_irq_restore+0x5c/0x80
    LR =3D arch_local_irq_restore+0x5c/0x80
[0000090312049800] [c000001fe03021e0] [0000000000000001] 0x1 (unreliable)
[0000090312053164] [c000001fe0302200] [c000000000b73314] _raw_spin_unlock_i=
rqrestore+0x4c/0x78
[0000090312056214] [c000001fe0302230] [c0000000000abb84] mod_timer+0x174/0x=
184
[0000090312059170] [c000001fe0302290] [c000000000400cc4] cursor_timer_handl=
er+0x58/0x64
[0000090312062098] [c000001fe03022c0] [c0000000000ab380] call_timer_fn+0x80=
/0xf4
[0000090312065090] [c000001fe0302370] [c0000000000ab5fc] run_timer_softirq+=
0x1dc/0x208
[0000090312067768] [c000001fe0302400] [c000000000059df0] __do_softirq+0x158=
/0x2b4
[0000090312070292] [c000001fe03024f0] [c00000000005a1fc] irq_exit+0x74/0xcc
[0000090312072792] [c000001fe0302510] [c000000000017318] timer_interrupt+0x=
b0/0xc4
[0000090312075484] [c000001fe0302540] [c000000000002328] decrementer_common=
+0x128/0x180
[0000090312079112] --- interrupt: 901 at _memset_io+0x5c/0x98
    LR =3D ttm_bo_move_memcpy+0xb8/0x46c
[0000090312082140] [c000001fe0302830] [c000000000496140] ttm_bo_move_memcpy=
+0x68/0x46c (unreliable)
[0000090312085032] [c000001fe0302970] [c0000000005b4338] ast_bo_move+0x20/0=
x34
[0000090312087760] [c000001fe0302990] [c000000000494520] ttm_bo_handle_move=
_mem+0x230/0x3d8
[0000090312090228] [c000001fe0302ab0] [c000000000495454] ttm_bo_validate+0x=
20c/0x28c
[0000090312093072] [c000001fe0302b60] [c0000000005b4a58] ast_bo_pin+0x90/0x=
bc
[0000090312096396] [c000001fe0302b90] [c0000000005b276c] ast_crtc_do_set_ba=
se.isra.8.constprop.13+0x120/0x298
[0000090312099130] [c000001fe0302c40] [c0000000005b354c] ast_crtc_mode_set+=
0xc68/0xc74
[0000090312102302] [c000001fe0302cf0] [c00000000045faa4] drm_crtc_helper_se=
t_mode+0x348/0x4d8
[0000090312105422] [c000001fe0302f80] [c000000000460420] drm_crtc_helper_se=
t_config+0x6c4/0x944
[0000090312108648] [c000001fe03030a0] [c00000000047bbc0] drm_mode_set_confi=
g_internal+0x68/0xf0
[0000090312111410] [c000001fe03030e0] [c00000000046aa40] restore_fbdev_mode=
+0xe8/0x110
[0000090312114648] [c000001fe0303120] [c00000000046c7a4] drm_fb_helper_rest=
ore_fbdev_mode_unlocked+0x38/0x7c
[0000090312117378] [c000001fe0303160] [c00000000046c82c] drm_fb_helper_set_=
par+0x44/0x58
[0000090312120182] [c000001fe03031c0] [c000000000402af0] fbcon_init+0x360/0=
x474
[0000090312122640] [c000001fe03032b0] [c000000000443850] visual_init+0xec/0=
x13c
[0000090312125264] [c000001fe03032f0] [c00000000044551c] do_bind_con_driver=
+0x280/0x398
[0000090312127952] [c000001fe03033b0] [c000000000445a38] do_take_over_conso=
le+0x1dc/0x1ec
[0000090312130728] [c000001fe0303460] [c000000000402c98] do_fbcon_takeover+=
0x94/0x114
[0000090312133790] [c000001fe0303480] [c0000000000754dc] notifier_call_chai=
n+0x6c/0xa8
[0000090312137046] [c000001fe03034d0] [c0000000000758c4] __blocking_notifie=
r_call_chain+0x58/0x74
[0000090312140108] [c000001fe0303520] [c0000000004088e4] fb_notifier_call_c=
hain+0x2c/0x40
[0000090312143188] [c000001fe0303540] [c00000000040b0f0] register_framebuff=
er+0x298/0x2d8
[0000090312146234] [c000001fe0303630] [c00000000046cb88] drm_fb_helper_init=
ial_config+0x348/0x3f8
[0000090312149108] [c000001fe03036d0] [c0000000005b4108] ast_fbdev_init+0xc=
8/0x100
[0000090312151764] [c000001fe0303710] [c0000000005b1468] ast_driver_load+0x=
778/0x7b4
[0000090312154236] [c000001fe03037a0] [c000000000475dac] drm_dev_register+0=
xb0/0x14c
[0000090312156834] [c000001fe03037f0] [c000000000477f74] drm_get_pci_dev+0x=
114/0x1bc
[0000090312159422] [c000001fe0303880] [c0000000005b08b0] ast_pci_probe+0x20=
/0x34
[0000090312162084] [c000001fe03038a0] [c0000000003f3160] pci_device_probe+0=
x78/0xdc
[0000090312164940] [c000001fe0303920] [c0000000005bfc20] driver_probe_devic=
e+0x128/0x2b0
[0000090312167796] [c000001fe03039b0] [c0000000005bfe40] __driver_attach+0x=
98/0xc8
[0000090312170448] [c000001fe03039f0] [c0000000005bdbcc] bus_for_each_dev+0=
xa4/0xb8
[0000090312173108] [c000001fe0303a40] [c0000000005bf6e0] driver_attach+0x2c=
/0x40
[0000090312175774] [c000001fe0303a60] [c0000000005bf1b8] bus_add_driver+0x1=
00/0x240
[0000090312178492] [c000001fe0303af0] [c0000000005c06cc] driver_register+0x=
c0/0x110
[0000090312181166] [c000001fe0303b70] [c0000000003f2d40] __pci_register_dri=
ver+0x68/0x74
[0000090312183802] [c000001fe0303ba0] [c000000000478084] drm_pci_init+0x68/=
0x10c
[0000090312186740] [c000001fe0303c30] [c0000000010977fc] ast_init+0x3c/0x50
[0000090312189740] [c000001fe0303c50] [c00000000000ade4] do_one_initcall+0x=
134/0x1d0
[0000090312192534] [c000001fe0303d20] [c000000001073cac] kernel_init_freeab=
le+0x198/0x254
[0000090312195434] [c000001fe0303dc0] [c00000000000b578] kernel_init+0x24/0=
x114
[0000090312198324] [c000001fe0303e30] [c0000000000094ac] ret_from_kernel_th=
read+0x5c/0xb0
[0000153341979290] INFO: rcu_sched self-detected stall on CPU
[0000153341986890] 	154: (14706 ticks this GP) idle=E25/140000000000002/0 s=
oftirq23/326 fqs=14705=20
[0000153341998800] 	 (t=14706 jiffies g=3D-260 c=3D-261 qC21)
[0000153342001640] Task dump for CPU 154:
[0000153342005166] swapper/136     R  running task        0     1      0 0x=
00000804
[0000153342005750] Call Trace:
[0000153342009706] [c000001fe0301ac0] [c00000000007fe98] sched_show_task+0x=
178/0x184 (unreliable)
[0000153342012772] [c000001fe0301b30] [c0000000000a7150] rcu_dump_cpu_stack=
s+0xa0/0xd0
[0000153342015820] [c000001fe0301b80] [c0000000000a9ff8] rcu_check_callback=
s+0x294/0x734
[0000153342018586] [c000001fe0301ca0] [c0000000000ac2c4] update_process_tim=
es+0x3c/0x74
[0000153342021430] [c000001fe0301cd0] [c0000000000bb864] tick_sched_handle.=
isra.16+0x60/0x6c
[0000153342024078] [c000001fe0301d00] [c0000000000bb8bc] tick_sched_timer+0=
x4c/0x84
[0000153342026578] [c000001fe0301d40] [c0000000000acee4] __hrtimer_run_queu=
es+0xf8/0x1ac
[0000153342029166] [c000001fe0301dd0] [c0000000000ad1b0] hrtimer_interrupt+=
0xac/0x1d8
[0000153342031606] [c000001fe0301e80] [c000000000017150] __timer_interrupt+=
0x7c/0xe0
[0000153342034098] [c000001fe0301ec0] [c000000000017314] timer_interrupt+0x=
ac/0xc4
[0000153342036692] [c000001fe0301ef0] [c000000000002328] decrementer_common=
+0x128/0x180
[0000153342041096] --- interrupt: 901 at arch_local_irq_restore+0x5c/0x80
    LR =3D arch_local_irq_restore+0x5c/0x80
[0000153342043432] [c000001fe03021e0] [0000000000000001] 0x1 (unreliable)
[0000153342046750] [c000001fe0302200] [c000000000b73314] _raw_spin_unlock_i=
rqrestore+0x4c/0x78
[0000153342049764] [c000001fe0302230] [c0000000000abb84] mod_timer+0x174/0x=
184
[0000153342052754] [c000001fe0302290] [c000000000400cc4] cursor_timer_handl=
er+0x58/0x64
[0000153342055840] [c000001fe03022c0] [c0000000000ab380] call_timer_fn+0x80=
/0xf4
[0000153342058916] [c000001fe0302370] [c0000000000ab5fc] run_timer_softirq+=
0x1dc/0x208
[0000153342061538] [c000001fe0302400] [c000000000059df0] __do_softirq+0x158=
/0x2b4
[0000153342064102] [c000001fe03024f0] [c00000000005a1fc] irq_exit+0x74/0xcc
[0000153342066602] [c000001fe0302510] [c000000000017318] timer_interrupt+0x=
b0/0xc4
[0000153342069238] [c000001fe0302540] [c000000000002328] decrementer_common=
+0x128/0x180
[0000153342072780] --- interrupt: 901 at _memset_io+0x5c/0x98
    LR =3D ttm_bo_move_memcpy+0xb8/0x46c
[0000153342075870] [c000001fe0302830] [c000000000496140] ttm_bo_move_memcpy=
+0x68/0x46c (unreliable)
[0000153342078764] [c000001fe0302970] [c0000000005b4338] ast_bo_move+0x20/0=
x34
[0000153342081394] [c000001fe0302990] [c000000000494520] ttm_bo_handle_move=
_mem+0x230/0x3d8
[0000153342083828] [c000001fe0302ab0] [c000000000495454] ttm_bo_validate+0x=
20c/0x28c
[0000153342086694] [c000001fe0302b60] [c0000000005b4a58] ast_bo_pin+0x90/0x=
bc
[0000153342090058] [c000001fe0302b90] [c0000000005b276c] ast_crtc_do_set_ba=
se.isra.8.constprop.13+0x120/0x298
[0000153342092796] [c000001fe0302c40] [c0000000005b354c] ast_crtc_mode_set+=
0xc68/0xc74
[0000153342095946] [c000001fe0302cf0] [c00000000045faa4] drm_crtc_helper_se=
t_mode+0x348/0x4d8
[0000153342098984] [c000001fe0302f80] [c000000000460420] drm_crtc_helper_se=
t_config+0x6c4/0x944
[0000153342102108] [c000001fe03030a0] [c00000000047bbc0] drm_mode_set_confi=
g_internal+0x68/0xf0
[0000153342104910] [c000001fe03030e0] [c00000000046aa40] restore_fbdev_mode=
+0xe8/0x110
[0000153342108082] [c000001fe0303120] [c00000000046c7a4] drm_fb_helper_rest=
ore_fbdev_mode_unlocked+0x38/0x7c
[0000153342110756] [c000001fe0303160] [c00000000046c82c] drm_fb_helper_set_=
par+0x44/0x58
[0000153342113452] [c000001fe03031c0] [c000000000402af0] fbcon_init+0x360/0=
x474
[0000153342115912] [c000001fe03032b0] [c000000000443850] visual_init+0xec/0=
x13c
[0000153342118484] [c000001fe03032f0] [c00000000044551c] do_bind_con_driver=
+0x280/0x398
[0000153342121128] [c000001fe03033b0] [c000000000445a38] do_take_over_conso=
le+0x1dc/0x1ec
[0000153342124048] [c000001fe0303460] [c000000000402c98] do_fbcon_takeover+=
0x94/0x114
[0000153342127104] [c000001fe0303480] [c0000000000754dc] notifier_call_chai=
n+0x6c/0xa8
[0000153342130412] [c000001fe03034d0] [c0000000000758c4] __blocking_notifie=
r_call_chain+0x58/0x74
[0000153342133426] [c000001fe0303520] [c0000000004088e4] fb_notifier_call_c=
hain+0x2c/0x40
[0000153342136474] [c000001fe0303540] [c00000000040b0f0] register_framebuff=
er+0x298/0x2d8
[0000153342139420] [c000001fe0303630] [c00000000046cb88] drm_fb_helper_init=
ial_config+0x348/0x3f8
[0000153342142264] [c000001fe03036d0] [c0000000005b4108] ast_fbdev_init+0xc=
8/0x100
[0000153342145022] [c000001fe0303710] [c0000000005b1468] ast_driver_load+0x=
778/0x7b4
[0000153342147432] [c000001fe03037a0] [c000000000475dac] drm_dev_register+0=
xb0/0x14c
[0000153342150016] [c000001fe03037f0] [c000000000477f74] drm_get_pci_dev+0x=
114/0x1bc
[0000153342152666] [c000001fe0303880] [c0000000005b08b0] ast_pci_probe+0x20=
/0x34
[0000153342155376] [c000001fe03038a0] [c0000000003f3160] pci_device_probe+0=
x78/0xdc
[0000153342158140] [c000001fe0303920] [c0000000005bfc20] driver_probe_devic=
e+0x128/0x2b0
[0000153342160858] [c000001fe03039b0] [c0000000005bfe40] __driver_attach+0x=
98/0xc8
[0000153342163488] [c000001fe03039f0] [c0000000005bdbcc] bus_for_each_dev+0=
xa4/0xb8
[0000153342166180] [c000001fe0303a40] [c0000000005bf6e0] driver_attach+0x2c=
/0x40
[0000153342168832] [c000001fe0303a60] [c0000000005bf1b8] bus_add_driver+0x1=
00/0x240
[0000153342171524] [c000001fe0303af0] [c0000000005c06cc] driver_register+0x=
c0/0x110
[0000153342174164] [c000001fe0303b70] [c0000000003f2d40] __pci_register_dri=
ver+0x68/0x74
[0000153342176734] [c000001fe0303ba0] [c000000000478084] drm_pci_init+0x68/=
0x10c

