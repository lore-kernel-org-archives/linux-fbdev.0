From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:32:53 +0000
Subject: [PATCH 00/26] Staging: fbtft: Switch to the gpio descriptor interface
Message-Id: <cover.1543142440.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fbtft driver to use GPIO descriptors
rather than numerical gpios.

Nishad Kamdar (26):
  Staging: fbtft: fbtft-core: Switch to the gpio descriptor interface
  Staging: fbtft: fbtft-bus: Switch to the gpio descriptor interface
  Staging: fbtft: fbtft-io: Switch to the gpio descriptor interface
  Staging: fbtft: flexfb: Switch to the gpio descriptor interface
  Staging: fbtft: fbtft-device: Switch to the gpio descriptor interface
  Staging: fbtft: fb_upd161704: Switch to the gpio descriptor interface
  Staging: fbtft: fb_sh1106: Switch to the gpio descriptor interface
  Staging: fbtft: fb_uc1611: Switch to the gpio descriptor interface
  Staging: fbtft: fb_s6d1211: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ili9320: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ili9340: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1325: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ili9325: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1289: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1351: Switch to the gpio descriptor interface
  Staging: fbtft: fb_uc1701: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1306: Switch to the gpio descriptor interface
  Staging: fbtft: fb_bd663474: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1331: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ili9163: Switch to the gpio descriptor interface
  Staging: fbtft: fb_agm1264k-fl: Switch to the gpio descriptor
    interface
  Staging: fbtft: fb_pcd8544: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1305: Switch to the gpio descriptor interface
  Staging: fbtft: fb_tls8204: Switch to the gpio descriptor interface
  Staging: fbtft: fb_watterott: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ra8875: Switch to the gpio descriptor interface

 drivers/staging/fbtft/fb_agm1264k-fl.c |  52 ++--
 drivers/staging/fbtft/fb_bd663474.c    |   6 +-
 drivers/staging/fbtft/fb_ili9163.c     |   6 +-
 drivers/staging/fbtft/fb_ili9320.c     |   2 +-
 drivers/staging/fbtft/fb_ili9325.c     |   6 +-
 drivers/staging/fbtft/fb_ili9340.c     |   2 +-
 drivers/staging/fbtft/fb_pcd8544.c     |   4 +-
 drivers/staging/fbtft/fb_ra8875.c      |   4 +-
 drivers/staging/fbtft/fb_s6d1121.c     |   6 +-
 drivers/staging/fbtft/fb_sh1106.c      |   2 +-
 drivers/staging/fbtft/fb_ssd1289.c     |   6 +-
 drivers/staging/fbtft/fb_ssd1305.c     |   4 +-
 drivers/staging/fbtft/fb_ssd1306.c     |   4 +-
 drivers/staging/fbtft/fb_ssd1325.c     |   6 +-
 drivers/staging/fbtft/fb_ssd1331.c     |  10 +-
 drivers/staging/fbtft/fb_ssd1351.c     |   2 +-
 drivers/staging/fbtft/fb_tls8204.c     |   6 +-
 drivers/staging/fbtft/fb_uc1611.c      |   4 +-
 drivers/staging/fbtft/fb_uc1701.c      |   6 +-
 drivers/staging/fbtft/fb_upd161704.c   |   6 +-
 drivers/staging/fbtft/fb_watterott.c   |   4 +-
 drivers/staging/fbtft/fbtft-bus.c      |   6 +-
 drivers/staging/fbtft/fbtft-core.c     | 170 ++----------
 drivers/staging/fbtft/fbtft-io.c       |  26 +-
 drivers/staging/fbtft/fbtft.h          |  21 +-
 drivers/staging/fbtft/fbtft_device.c   | 344 +------------------------
 drivers/staging/fbtft/flexfb.c         |  12 +-
 27 files changed, 142 insertions(+), 585 deletions(-)

-- 
2.17.1
