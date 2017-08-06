From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Sun, 06 Aug 2017 07:21:26 +0000
Subject: [PATCH 0/2] constify usb_device_id.
Message-Id: <1502003368-12355-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: steve.glendinning@shawell.net, b.zolnierkie@samsung.com, bernie@plugable.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Arvind Yadav (2):
  [PATCH 1/2] video: fbdev: smscufx: constify usb_device_id.
  [PATCH 2/2] video: fbdev: udlfb: constify usb_device_id.

 drivers/video/fbdev/smscufx.c | 2 +-
 drivers/video/fbdev/udlfb.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4

