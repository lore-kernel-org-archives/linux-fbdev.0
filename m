From: Witold Baryluk <baryluk@smp.if.uj.edu.pl>
Date: Mon, 04 Jun 2012 17:37:02 +0000
Subject: Circular locking (and possible deadlock), when exiting from mplayer -vo fbdev2
Message-Id: <20120604173702.GZ16584@smp.if.uj.edu.pl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello,

When watching movie using mplayer -quiet -vo fbdev2 somefile.flv when
being on console, with 6 virtual terminals, and no other program using
fbdev, after pressing key Q (quit), kernel throws this in my face:


[ 3288.708198]=20
[ 3288.711153] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[ 3288.712015] [ INFO: possible circular locking dependency detected ]
[ 3288.712015] 3.4.0-t43-devel-smp-10118-g233e562-dirty #12 Tainted: G     =
      O
[ 3288.712015] -------------------------------------------------------
[ 3288.712015] mplayer/11769 is trying to acquire lock:
[ 3288.712015]  (&fb_info->lock){+.+.+.}, at: [<c137789c>] fb_release+0x1c/=
0x60
[ 3288.712015]=20
[ 3288.712015] but task is already holding lock:
[ 3288.712015]  (&mm->mmap_sem){++++++}, at: [<c1160a8f>] vm_munmap+0x2f/0x=
60
[ 3288.712015]=20
[ 3288.712015] which lock already depends on the new lock.
[ 3288.712015]=20
[ 3288.712015]=20
[ 3288.712015] the existing dependency chain (in reverse order) is:
[ 3288.712015]=20
[ 3288.712015] -> #2 (&mm->mmap_sem){++++++}:
[ 3288.712015]        [<c10b9719>] lock_acquire+0x89/0x1b0
[ 3288.712015]        [<c11580c7>] might_fault+0x87/0xb0
[ 3288.712015]        [<f8e2c498>] drm_mode_getresources+0x188/0x5b0 [drm]
[ 3288.712015]        [<f8e1e582>] drm_ioctl+0x482/0x590 [drm]
[ 3288.712015]        [<c119ea2b>] do_vfs_ioctl+0x7b/0x5c0
[ 3288.712015]        [<c119efa2>] sys_ioctl+0x32/0x60
[ 3288.712015]        [<c17d5158>] sysenter_do_call+0x12/0x38
[ 3288.712015]=20
[ 3288.712015] -> #1 (&dev->mode_config.mutex){+.+.+.}:
[ 3288.712015]        [<c10b9719>] lock_acquire+0x89/0x1b0
[ 3288.712015]        [<c17c9a50>] mutex_lock_nested+0x70/0x300
[ 3288.712015]        [<f8f2fd9c>] drm_fb_helper_set_par+0x3c/0xd0 [drm_kms=
_helper]
[ 3288.712015]        [<c137757f>] fb_set_var+0x1ef/0x4c0
[ 3288.712015]        [<c137866a>] do_fb_ioctl+0x34a/0x510
[ 3288.712015]        [<c137887b>] fb_ioctl+0x4b/0x60
[ 3288.712015]        [<c119ea2b>] do_vfs_ioctl+0x7b/0x5c0
[ 3288.712015]        [<c119efa2>] sys_ioctl+0x32/0x60
[ 3288.712015]        [<c17d5158>] sysenter_do_call+0x12/0x38
[ 3288.712015]=20
[ 3288.712015] -> #0 (&fb_info->lock){+.+.+.}:
[ 3288.712015]        [<c10b8be5>] __lock_acquire+0x1265/0x1760
[ 3288.712015]        [<c10b9719>] lock_acquire+0x89/0x1b0
[ 3288.712015]        [<c17c9a50>] mutex_lock_nested+0x70/0x300
[ 3288.712015]        [<c137789c>] fb_release+0x1c/0x60
[ 3288.712015]        [<c118e5ec>] fput+0xfc/0x230
[ 3288.712015]        [<c115efa3>] remove_vma+0x43/0x70
[ 3288.712015]        [<c116097c>] do_munmap+0x23c/0x320
[ 3288.712015]        [<c1160a9d>] vm_munmap+0x3d/0x60
[ 3288.712015]        [<c116174d>] sys_munmap+0x1d/0x20
[ 3288.712015]        [<c17d5158>] sysenter_do_call+0x12/0x38
[ 3288.712015]=20
[ 3288.712015] other info that might help us debug this:
[ 3288.712015]=20
[ 3288.712015] Chain exists of:
[ 3288.712015]   &fb_info->lock --> &dev->mode_config.mutex --> &mm->mmap_s=
em
[ 3288.712015]=20
[ 3288.712015]  Possible unsafe locking scenario:
[ 3288.712015]=20
[ 3288.712015]        CPU0                    CPU1
[ 3288.712015]        ----                    ----
[ 3288.712015]   lock(&mm->mmap_sem);
[ 3288.712015]                                lock(&dev->mode_config.mutex);
[ 3288.712015]                                lock(&mm->mmap_sem);
[ 3288.712015]   lock(&fb_info->lock);
[ 3288.712015]=20
[ 3288.712015]  *** DEADLOCK ***
[ 3288.712015]=20
[ 3288.712015] 1 lock held by mplayer/11769:
[ 3288.712015]  #0:  (&mm->mmap_sem){++++++}, at: [<c1160a8f>] vm_munmap+0x=
2f/0x60
[ 3288.712015]=20
[ 3288.712015] stack backtrace:
[ 3288.712015] Pid: 11769, comm: mplayer Tainted: G           O 3.4.0-t43-d=
evel-smp-10118-g233e562-dirty #12
[ 3288.712015] Call Trace:
[ 3288.712015]  [<c17c0c53>] print_circular_bug+0x1af/0x1b9
[ 3288.712015]  [<c10b8be5>] __lock_acquire+0x1265/0x1760
[ 3288.712015]  [<c10b604d>] ? mark_held_locks+0x8d/0xf0
[ 3288.712015]  [<c113c895>] ? free_hot_cold_page+0xe5/0x180
[ 3288.712015]  [<c116b512>] ? free_page_and_swap_cache+0x22/0x50
[ 3288.712015]  [<c10b9719>] lock_acquire+0x89/0x1b0
[ 3288.712015]  [<c137789c>] ? fb_release+0x1c/0x60
[ 3288.712015]  [<c17c9a50>] mutex_lock_nested+0x70/0x300
[ 3288.712015]  [<c137789c>] ? fb_release+0x1c/0x60
[ 3288.712015]  [<c137789c>] ? fb_release+0x1c/0x60
[ 3288.712015]  [<c137789c>] fb_release+0x1c/0x60
[ 3288.712015]  [<c118e5ec>] fput+0xfc/0x230
[ 3288.712015]  [<c115efa3>] remove_vma+0x43/0x70
[ 3288.712015]  [<c116097c>] do_munmap+0x23c/0x320
[ 3288.712015]  [<c1160a9d>] vm_munmap+0x3d/0x60
[ 3288.712015]  [<c116174d>] sys_munmap+0x1d/0x20
[ 3288.712015]  [<c17d5158>] sysenter_do_call+0x12/0x38

There was Xorg server running on tty7 (but nobody logged in), and it is
using open source radeon driver.

I sometimes use fbterm on console (to have full UTF-8, better speed, or
just larger fonts changed dynamically), and it works without any similar pr=
oblems.

This possible deadlock message shows up only on first mplayer start/stop
cycle. Next ones doesn't trigger displaying this warning, but I belive
this is only due lockdep disabling checking, not solving any problem.

I reproduced it on two kernel builds already.

Machine is single CPU, but kernel is SMP. (Compiling and running kernel wit=
hout SMP
support gives exactly same dmesg INFO about deadlock when quiting
mplayer).


$ egrep 'SMP|LOCK|RCU' /boot/config-`uname -r`
CONFIG_LOCKDEP_SUPPORT=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_X86_32_SMP=3Dy
CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
# RCU Subsystem
CONFIG_TREE_RCU=3Dy
# CONFIG_PREEMPT_RCU is not set
CONFIG_RCU_FANOUT2
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_RCU_FAST_NO_HZ is not set
CONFIG_TREE_RCU_TRACE=3Dy
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
CONFIG_USE_GENERIC_SMP_HELPERS=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
# CONFIG_INLINE_SPIN_TRYLOCK is not set
# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK is not set
# CONFIG_INLINE_SPIN_LOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_READ_TRYLOCK is not set
# CONFIG_INLINE_READ_LOCK is not set
# CONFIG_INLINE_READ_LOCK_BH is not set
# CONFIG_INLINE_READ_LOCK_IRQ is not set
# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
# CONFIG_INLINE_READ_UNLOCK is not set
# CONFIG_INLINE_READ_UNLOCK_BH is not set
# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_WRITE_TRYLOCK is not set
# CONFIG_INLINE_WRITE_LOCK is not set
# CONFIG_INLINE_WRITE_LOCK_BH is not set
# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
# CONFIG_INLINE_WRITE_UNLOCK is not set
# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
CONFIG_SMP=3Dy
# CONFIG_X86_BIGSMP is not set
# CONFIG_KVM_CLOCK is not set
CONFIG_PARAVIRT_SPINLOCKS=3Dy
CONFIG_PARAVIRT_CLOCK=3Dy
CONFIG_HAVE_MEMBLOCK=3Dy
CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
CONFIG_ARCH_DISCARD_MEMBLOCK=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=999999
CONFIG_PM_SLEEP_SMP=3Dy
CONFIG_PM_WAKELOCKS=3Dy
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=3Dy
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_HAVE_TEXT_POKE_SMP=3Dy
CONFIG_DM_DEBUG_BLOCK_STACK_TRACING=3Dy
CONFIG_TCM_IBLOCK=3Dm
# CONFIG_TELCLOCK is not set
CONFIG_I8253_LOCK=3Dy
CONFIG_FILE_LOCKING=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_LOCKUP_DETECTOR=3Dy
CONFIG_HARDLOCKUP_DETECTOR=3Dy
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D1
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3Dy
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D1
CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy
CONFIG_DEBUG_SPINLOCK=3Dy
CONFIG_DEBUG_LOCK_ALLOC=3Dy
CONFIG_PROVE_LOCKING=3Dy
CONFIG_PROVE_RCU=3Dy
CONFIG_PROVE_RCU_REPEATEDLY=3Dy
CONFIG_SPARSE_RCU_POINTER=3Dy
CONFIG_LOCKDEP=3Dy
CONFIG_LOCK_STAT=3Dy
CONFIG_DEBUG_LOCKDEP=3Dy
CONFIG_DEBUG_LOCKING_API_SELFTESTS=3Dy
CONFIG_RCU_TORTURE_TEST=3Dm
CONFIG_RCU_CPU_STALL_TIMEOUT`
CONFIG_RCU_CPU_STALL_INFO=3Dy
CONFIG_RCU_TRACE=3Dy
CONFIG_DEBUG_BLOCK_EXT_DEVT=3Dy
CONFIG_XOR_BLOCKS=3Dm





Commit g233e562 (a kernel which I was running - Linus' main tree) is
after

commit 804ce9866d56130032c9c8afc90a1297b7deed56
Merge: f5e7e84 c895305
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Jun 1 16:57:51 2012 -0700

    Merge tag 'fbdev-updates-for-3.5' of git://github.com/schandinat/linu
   =20
    Pull fbdev updates from Florian Tobias Schandinat:
     - driver for AUO-K1900 and AUO-K1901 epaper controller
     - large updates for OMAP (e.g. decouple HDMI audio and video)
     - some updates for Exynos and SH Mobile
     - various other small fixes and cleanups
   =20
    * tag 'fbdev-updates-for-3.5' of git://github.com/schandinat/linux-2.
      ...
      fb: handle NULL pointers in framebuffer release
      ...

....

commit cc4401142c1cbc63b01d6024cbc7a9f804cb3143
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon May 14 23:58:37 2012 +0300

    fb: handle NULL pointers in framebuffer release
   =20
    This function is called with a potential NULL pointer in
    picolcd_init_framebuffer() and it causes a static checker warning.  T
    used to handle NULL pointers when the picolcd code was written, but a
    couple months later we added the "info->apertures" dereference.
   =20
    Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
    Reviewed-by: Marcin Slusarz <marcin.slusarz@gmail.com>
    Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>



so this may be a regression, should I try bissecting, or at least
reverting commit cc4401142c1c ?


Regards,
Witek

--=20
Witold Baryluk
