From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Thu, 26 Mar 2020 21:09:58 +0000
Subject: [PATCH 0/1] video: convert to use new I2C API
Message-Id: <20200326210959.13111-1-wsa+renesas@sang-engineering.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (1):
  video: backlight: tosa_lcd: convert to use i2c_new_client_device()

 drivers/video/backlight/tosa_lcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1
