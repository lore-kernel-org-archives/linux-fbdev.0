From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Feb 2014 08:56:40 +0000
Subject: [PATCH 0/4] hyperv-fb: add support for generation 2 virtual machines
Message-Id: <1392973004-28215-1-git-send-email-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kys@microsoft.com, haiyangz@microsoft.com, jasowang@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

This patch series adds support for uefi-based gen2 virtual machines to
the hyperv-fb driver.

First patch is included just for completeness.  Greg picked it up
already and it is in -next, but it isn't in master yet.

Second patch is a bugfix for the first patch.

Third patch changes vmbus to properly hook the hyperv mmio area into
the linux resource management.

Final patch actually implements gen2 vm support for hyperv-fb, building
on the hyperv mmio support added by the other patches.

Known issue: There is a long delay when loading the hyperv-fb driver on
gen2 virtual machines which isn't present on gen1 virtual machines.

Gerd Hoffmann (3):
  vmbus: add missing breaks
  vmbus: use resource for hyperv mmio region
  hyperv-fb: add support for generation 2 virtual machines.

K. Y. Srinivasan (1):
  Drivers: hv: vmbus: Extract the mmio information from DSDT

 drivers/hv/vmbus_drv.c    | 51 +++++++++++++++++++++-------
 drivers/video/hyperv_fb.c | 86 +++++++++++++++++++++++++++++++++--------------
 include/linux/hyperv.h    |  2 ++
 3 files changed, 100 insertions(+), 39 deletions(-)

-- 
1.8.3.1

