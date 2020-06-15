From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 15 Jun 2020 07:58:09 +0000
Subject: [PATCH 0/6] remove deprecated i2c_new_device API
Message-Id: <20200615075816.2848-1-wsa+renesas@sang-engineering.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-media@vger.kernel.org

I want to remove the above API this cycle, and just a few patches have
not made it into 5.8-rc1. They have been reviewed and most had been
promised to get into linux-next, but well, things happen. So, I hope it
is okay for everyone to collect them like this and push them via I2C for
5.8-rc2.

One minor exception is the media documentation patch which I simply have
missed so far, but it is trivial.

And then, finally, there is the removal of the old API as the final
patch. Phew, that's been a long ride.

I am open for comments, of course.

Happy hacking,

   Wolfram


Wolfram Sang (6):
  drm: encoder_slave: fix refcouting error for modules
  drm: encoder_slave: use new I2C API
  x86/platform/intel-mid: convert to use i2c_new_client_device()
  video: backlight: tosa_lcd: convert to use i2c_new_client_device()
  Documentation: media: convert to use i2c_new_client_device()
  i2c: remove deprecated i2c_new_device API

 .../driver-api/media/v4l2-subdev.rst          |  2 +-
 .../userspace-api/media/conf_nitpick.py       |  2 +-
 arch/x86/platform/intel-mid/sfi.c             |  4 +--
 drivers/gpu/drm/drm_encoder_slave.c           | 15 ++++-------
 drivers/i2c/i2c-core-base.c                   | 25 -------------------
 drivers/video/backlight/tosa_lcd.c            |  4 +--
 include/linux/i2c.h                           |  8 +++---
 7 files changed, 14 insertions(+), 46 deletions(-)

-- 
2.27.0
