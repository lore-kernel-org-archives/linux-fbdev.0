From: Johan Hovold <johan@kernel.org>
Date: Mon, 20 Nov 2017 10:45:43 +0000
Subject: [PATCH v2 0/4] backlight: fix device-tree node lookups
Message-Id: <20171120104547.2639-1-johan@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>

A number of drivers have been using the wrong OF helper when doing child-node
lookups during probe. This meant that they were doing tree-wide searches rather
than matching on child nodes and that the parent node could end up being
prematurely freed.

Johan

v2
 - add patch 4/4 which fixes two node leaks in as3711_bl instead of marking
   the leaks using FIXMEs in patch 1/4


Johan Hovold (4):
  backlight: as3711_bl: fix device-tree node lookup
  backlight: max8925_bl: fix device-tree node lookup
  backlight: tps65217_bl: fix device-tree node lookup
  backlight: as3711_bl: fix device-tree node leaks

 drivers/video/backlight/as3711_bl.c   | 45 ++++++++++++++++++++++-------------
 drivers/video/backlight/max8925_bl.c  |  4 +++-
 drivers/video/backlight/tps65217_bl.c |  4 ++--
 include/linux/mfd/as3711.h            |  4 ++--
 4 files changed, 36 insertions(+), 21 deletions(-)

-- 
2.15.0

