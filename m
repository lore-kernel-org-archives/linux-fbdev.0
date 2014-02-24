From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Feb 2014 13:17:07 +0000
Subject: [PATCH v3 0/4] hyperv-fb: add support for generation 2 virtual machines.
Message-Id: <1393247831-5271-1-git-send-email-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kys@microsoft.com, abgupta@microsoft.com, haiyangz@microsoft.com, jasowang@redhat.com, tomi.valkeinen@ti.com, devel@linuxdriverproject.org, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

This patch series adds support for uefi-based gen2 virtual machines to
the hyperv-fb driver.  It depends on -next commit
90f3453585479d5beb75058da46eb573ced0e6ac

Patch #1 is a bugfix for 90f3453585479d5beb75058da46eb573ced0e6ac.

Patch #2 changes vmbus to properly hook the hyperv mmio area into
the linux resource management.

Patch #3 actually implements gen2 vm support for hyperv-fb, building
on the hyperv mmio support added by the other patches.

Patch #4 unregisters efifb early to make sure the framebuffer isn't used
any more while hyperv-fb initialization is in progress.  This patch is
new in v2 and it fixes the hang listed as "known issue" in v1 of this
patch series.

v3 changes:
 - fix a error handling bug in patch #3.
 - don't include 90f3453585479d5beb75058da46eb573ced0e6ac
   to avoid confusion

please apply,
  Gerd

Gerd Hoffmann (4):
  vmbus: add missing breaks
  vmbus: use resource for hyperv mmio region
  hyperv-fb: add support for generation 2 virtual machines.
  hyperv-fb: kick off efifb early

K. Y. Srinivasan (1):
  Drivers: hv: vmbus: Extract the mmio information from DSDT

 drivers/hv/vmbus_drv.c    | 51 ++++++++++++++++++++-------
 drivers/video/hyperv_fb.c | 87 +++++++++++++++++++++++++++++++++--------------
 include/linux/hyperv.h    |  2 ++
 3 files changed, 101 insertions(+), 39 deletions(-)

-- 
1.8.3.1


Gerd Hoffmann (4):
  vmbus: add missing breaks
  vmbus: use resource for hyperv mmio region
  hyperv-fb: add support for generation 2 virtual machines.
  hyperv-fb: kick off efifb early

 drivers/hv/vmbus_drv.c    | 18 ++++++----
 drivers/video/hyperv_fb.c | 87 +++++++++++++++++++++++++++++++++--------------
 include/linux/hyperv.h    |  3 +-
 3 files changed, 74 insertions(+), 34 deletions(-)

-- 
1.8.3.1

