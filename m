From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 08 Aug 2012 03:54:14 +0000
Subject: [PATCH 00/10] Upstream patches from chromium os tree
Message-Id: <1344398064-13563-1-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The following patch set includes changes that have been applied to the chromium
os kernel, but have not been sent upstream.

Sean Paul (10):
  video: exynos_dp: Change aux transaction failures
  video: exynos_dp: Check DPCD return codes
  video: exynos_dp: Clean up SW link training
  video: exynos_dp: Get pll lock before pattern set
  video: exynos_dp: Remove sink control to D0
  video: exynos_dp: Fix get_pll_lock_status return value
  video: exynos_dp: Improve EDID error handling
  video: exynos_dp: Move hotplug into a workqueue
  video: exynos_dp: Fix bug when checking dp->irq
  video: exynos_dp: Enable hotplug interrupts

 drivers/video/exynos/exynos_dp_core.c |  373 +++++++++++++++++----------------
 drivers/video/exynos/exynos_dp_core.h |   12 +-
 drivers/video/exynos/exynos_dp_reg.c  |   67 +++++--
 3 files changed, 256 insertions(+), 196 deletions(-)

-- 
1.7.7.3

