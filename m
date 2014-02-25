From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 25 Feb 2014 12:28:38 +0000
Subject: [PATCH v4 0/2] hyperv-fb: add support for generation 2 virtual machines.
Message-Id: <1393331320-18147-1-git-send-email-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kys@microsoft.com, abgupta@microsoft.com, haiyangz@microsoft.com, jasowang@redhat.com, tomi.valkeinen@ti.com, devel@linuxdriverproject.org, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

This patch series adds support for uefi-based gen2 virtual machines
to the hyperv-fb driver.  It depends on a few vmbus changes which are
staged in Greg's char-misc tree (and linux-next).

Patch #1 implements gen2 vm support for hyperv-fb.

Patch #2 unregisters efifb early to make sure the framebuffer isn't used
any more while hyperv-fb initialization is in progress.

v4 changes:
 - use KBUILD_MODNAME everywhere for consistent naming.
 - drop the two patches which Greg has staged in char-misc.

please apply,
  Gerd

Gerd Hoffmann (2):
  hyperv-fb: add support for generation 2 virtual machines.
  hyperv-fb: kick off efifb early

 drivers/video/hyperv_fb.c | 87 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 26 deletions(-)

-- 
1.8.3.1

