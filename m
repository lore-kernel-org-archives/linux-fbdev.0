From: Yifeng Li <tomli@tomli.me>
Date: Sat, 16 Mar 2019 22:24:56 +0000
Subject: [PATCH 0/8] fbdev: sm712fb: fix a series of lockups, crashes and gliches.
Message-Id: <20190316222504.27170-1-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>

Hi all,

This patchset contains a series of important fixes to various problems,
including lockups, crashes, screen gliches, and missing video modes.
These patches are crucial to the correct operation to the hardware,
especially Lynx3DM+ (SM720). I have tested and verified them on x86.

Please review and queue them for linux-stable.

Thanks,

Yifeng Li (8):
  fbdev: sm712fb: fix white screen of death on reboot, don't set
    CR3B-CR3F.
  fbdev: sm712fb: fix brightness control on reboot, don't set SR30.
  fbdev: sm712fb: fix VRAM detection, don't set SR70/71/74/75.
  fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA.
  fbdev: sm712fb: fix crashes during framebuffer writes by correctly
    mapping VRAM.
  fbdev: sm712fb: fix crashes and garbled display during DPMS
    modesetting.
  fbdev: sm712fb: fix support for 1024x768-16 mode.
  fbdev: sm712fb: use 1024x768 by default on non-MIPS, fix garbled
    display.

 drivers/video/fbdev/sm712.h   |  12 +-
 drivers/video/fbdev/sm712fb.c | 244 +++++++++++++++++++++++++++-------
 2 files changed, 200 insertions(+), 56 deletions(-)

-- 
2.20.1
