From: Carl Vanderlip <carlv@codeaurora.org>
Date: Wed, 02 Mar 2011 21:15:42 +0000
Subject: [PATCH 0/4] Initial patches for MSM display update
Message-Id: <1299100542-11120-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

These are the first series of a set of patches to update the MSM display
drivers to support newer MDP versions and display modes (while also providing
a base for future display development). The original source for these patches
is the Google Android kernel tree located here:
http://android.git.kernel.org/kernel/msm.git

Arve Hjønnevåg (1):
  [ARM] msm_fb: Fix framebuffer console

Dima Zavin (3):
  video: msmfb: Put the partial update magic value into the fix_screen
    struct.
  [ARM] msm: mdp: Add support for RGBX 8888 image format.
  [ARM] msm: mdp: Set the correct pack pattern for XRGB/ARGB

 drivers/video/msm/mdp_hw.h  |   11 +++++++++--
 drivers/video/msm/mdp_ppp.c |    1 +
 drivers/video/msm/msm_fb.c  |   16 ++++++++++++++--
 include/linux/msm_mdp.h     |    1 +
 4 files changed, 25 insertions(+), 4 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

