From: Hendrik Sattler <post@hendrik-sattler.de>
Date: Sun, 27 Nov 2011 14:15:52 +0000
Subject: Problems with radeon driver under KDE-4.7.2
Message-Id: <201111271515.53077.post@hendrik-sattler.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I just upgraded to KDE-4.7.2 and Linux-3.1 and mostly when using Firefox, I 
get issues like a stall screen, then a short blank screen and then it works 
some time until that happens again.

The kernel log then shows something like:
WARNING: at drivers/gpu/drm/radeon/radeon_fence.c:267 
radeon_fence_wait+0x215/0x292()
Hardware name: TravelMate 6592
GPU lockup (waiting for 0x00158B0E last fence id 0x00158B0C)
Modules linked in: [...]
Pid: 12672, comm: Xorg Not tainted 3.1.0 #2
Call Trace:
[<ffffffff8105c51d>] warn_slowpath_common+0x7e/0x96
[<ffffffff8105c5c9>] warn_slowpath_fmt+0x41/0x43
[<ffffffff8128bdad>] radeon_fence_wait+0x215/0x292
[<ffffffff810730fc>] ? abort_exclusive_wait+0x89/0x89
[<ffffffff8128c30c>] radeon_sync_obj_wait+0xc/0xe
[<ffffffff8125f56e>] ttm_bo_wait+0xb8/0x174
[<ffffffff8125ffdb>] ? ttm_bo_list_ref_sub+0x24/0x26
[<ffffffff812a03c0>] radeon_gem_wait_idle_ioctl+0x7c/0xec
[<ffffffff8124d2dd>] drm_ioctl+0x290/0x368
[<ffffffff812a0344>] ? radeon_gem_busy_ioctl+0x112/0x112
[<ffffffff8106993e>] ? set_current_blocked+0x44/0x49
[<ffffffff81028fe8>] ? do_signal+0x554/0x62a
[<ffffffff810e7bf4>] do_vfs_ioctl+0x40d/0x44e
[<ffffffff810293a5>] ? sys_rt_sigreturn+0x1b4/0x1e3
[<ffffffff810e7c77>] sys_ioctl+0x42/0x67
[<ffffffff81513dbb>] system_call_fastpath+0x16/0x1b
---[ end trace ac77b0f03ca6a6bd ]---
radeon 0000:01:00.0: GPU softreset 
radeon 0000:01:00.0:   R_008010_GRBM_STATUS=0xA40034E0
radeon 0000:01:00.0:   R_008014_GRBM_STATUS2=0x00010003
radeon 0000:01:00.0:   R_000E50_SRBM_STATUS=0x200000C0
radeon 0000:01:00.0:   R_008020_GRBM_SOFT_RESET=0x00007FEE
radeon 0000:01:00.0: R_008020_GRBM_SOFT_RESET=0x00000001
radeon 0000:01:00.0:   R_008010_GRBM_STATUS=0xA0003030
radeon 0000:01:00.0:   R_008014_GRBM_STATUS2=0x00000003
radeon 0000:01:00.0:   R_000E50_SRBM_STATUS=0x200080C0
radeon 0000:01:00.0: GPU reset succeed
radeon 0000:01:00.0: WB enabled
[drm] ring test succeeded in 1 usecs
[drm] ib test succeeded in 2 usecs
radeon 0000:01:00.0: GPU lockup CP stall for more than 10000msec


So far, I think it's great that it can recover pretty fine most of the time 
:-)
I now upgraded to Linux-3.1.3 and looked at the KDE setting about the possible
cause for this. New to me was the desktop effect setting about using 
"OpenGL-2-Shader". I deactivated it and its stable so far. Is this a know 
issue?

Note: I also have the some effects disabled that are very slow when scrolling 
windows. My hardware: "ATI Mobility Radeon HD 2400 XT" (ChipID = 0x94c8)



One other question: I saw that vdpau seems to be supported:
[    24.226] (II) RADEON(0): [DRI2]   VDPAU driver: r600
What exactly is needed to use this? I tried "mplayer -vo vdpau" but that only 
gives me:
Failed to open VDPAU backend libvdpau_r600.so: cannot open shared object file: 
No such file or directory
[vdpau] Error when calling vdp_device_create_x11: 1
Error opening/initializing the selected video_out (-vo) device.

Where can I get this file. Latest Debian does not seem to have it...

Regards...

HS

