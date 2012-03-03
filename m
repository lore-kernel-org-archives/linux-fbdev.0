From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Sat, 03 Mar 2012 15:46:18 +0000
Subject: [PATCH 0/3] video: s3c-fb: Rearrange the elements in platform data
Message-Id: <1330789808-8253-1-git-send-email-thomas.abraham@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: FlorianSchandinat@gmx.de, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, jg1.han@samsung.com, ben-linux@fluff.org, patches@linaro.org

This patchset rearranges the elements in the platform data of the s3c-fb
driver with the intent of adding device tree support to the driver in
subsequent patches.

The first patch moves the video timing information from the individual window
setup data into the platform specific configuration section in the platform
data. The video timing is independent of the window setup. The resolution of
the window could be smaller than that of the lcd panel attached. So the video
timing data is removed from window configuration data.

The second patch removes the need for the 'default_win' element in the
platform data. This element was used to decide whether the video data
output from the controller should be enabled or disabled when the window
specified by 'default_win' is enabled or disabled. With the first patch
removing the need for atleast one window to be of the same resolution as
that of the lcd panel, it is now possible to decide when to enable/disable
the video data output based on the state of each window. If any of the
window is active, the lcd data output is enabled. Otherwise, the lcd data
output is disabled. Hence, the 'default_win' parameter from the platform
data can be removed, which anyways cannot be specified when using
device tree.

The third patch reworks the platform data of the display controller based
on the changes introduced in the first two patches.

The patchset does not include the rework of platform data of all the other
boards which have platform data for the s3c-fb driver. I am posting this
patchset to know if the the changes are conceptually correct. If the first
two patches are acceptable, I will resubmit this patchset with changes to
the platform data for all boards which have s3c-fb platform data.

Thomas Abraham (3):
  video: s3c-fb: move video interface timing out of window setup data
  video: s3c-fb: remove 'default_win' element from platform data
  ARM: Exynos: Rework platform data for lcd controller for Origen board

 arch/arm/mach-exynos/mach-origen.c      |   24 ++++---
 arch/arm/plat-samsung/include/plat/fb.h |   11 ++-
 drivers/video/s3c-fb.c                  |  128 ++++++++++++++----------------
 3 files changed, 80 insertions(+), 83 deletions(-)

