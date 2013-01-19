From: Tony Prisk <linux@prisktech.co.nz>
Date: Sat, 19 Jan 2013 06:02:53 +0000
Subject: [GIT PULL] video: vt8500: Cleanup for 3.9
Message-Id: <1358575377-26364-1-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Florian,

This is a series of patches for the vt8500 framebuffer driver. Mostly
cleanup stuff.

Non-cleanup:
video: vt8500: Make wmt_ge_rops optional - This patch makes hardware accelerated
raster ops optional as it doesn't work on the newly added WM8850 (yet).

Regards
Tony Prisk


The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://server.prisktech.co.nz/git/linuxwmt.git tags/vt8500/video-3.9

for you to fetch changes up to 9167fe967de331a9457e1b4d4fc211857ba3b6ab:

  video: vt8500: Update descriptions in video/Kconfig (2013-01-19 18:52:28 +1300)

----------------------------------------------------------------
video: vt8500: Cleanup for 3.9

----------------------------------------------------------------
Julia Lawall (1):
      drivers/video/wm8505fb.c: use devm_ functions

Tony Prisk (3):
      video: vt8500: Make wmt_ge_rops optional
      video: vt8500: Remove unused platform_data/video-vt8500lcdfb.h
      video: vt8500: Update descriptions in video/Kconfig

 drivers/video/Kconfig                           |   32 ++++----
 drivers/video/vt8500lcdfb.c                     |   17 +++-
 drivers/video/wm8505fb.c                        |   95 ++++++++---------------
 include/linux/platform_data/video-vt8500lcdfb.h |   31 --------
 4 files changed, 67 insertions(+), 108 deletions(-)
 delete mode 100644 include/linux/platform_data/video-vt8500lcdfb.h
