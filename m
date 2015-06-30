From: "K. Y. Srinivasan" <kys@microsoft.com>
Date: Tue, 30 Jun 2015 21:19:01 +0000
Subject: [PATCH 0/2] Drivers: hv: vmbus: Change memory-mapped I/O management for Hyper-V paravirt
Message-Id: <1435703668-23486-1-git-send-email-kys@microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com, jasowang@redhat.com, hdegoede@redhat.com, linux-fbdev@vger.kernel.org, haiyangz@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>

This patch series changes the way that hv_vmbus searches for ranges of 
memory-mapped I/O space (MMIO) which can be used by its children.  The old
way just found the one and only range above 4GB.  This one makes all ranges
exposed in the VM's firmware potential candidates.  It also moves the code
which chooses ranges from hyperv_fb (the video front-end driver for Hyper-V)
to hv_vmbus.


jakeo@microsoft.com (2):
  drivers:hv: Modify hv_vmbus to search for all MMIO ranges available.
  drivers:hv: Move MMIO range picking from hyper_fb to hv_vmbus

 drivers/hv/vmbus_drv.c          |  204 +++++++++++++++++++++++++++++++++------
 drivers/video/fbdev/hyperv_fb.c |   46 ++++-----
 include/linux/hyperv.h          |    7 +-
 3 files changed, 200 insertions(+), 57 deletions(-)

-- 
1.7.4.1

