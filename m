From: Wolfram Sang <wsa-dev@sang-engineering.com>
Date: Tue, 09 Aug 2016 11:27:38 +0000
Subject: [PATCH] video: don't print error when adding adapter fails
Message-Id: <1470742059-12341-1-git-send-email-wsa-dev@sang-engineering.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, linux-fbdev@vger.kernel.org

Since v4.8-rc1, the I2C core will print detailed information when adding an I2C
adapter fails. So, drivers can skip this now.

Should go via subsystem tree, I'd think.

Wolfram Sang (1):
  video: fbdev: mb862xx: mb862xx-i2c: don't print error when adding
    adapter fails

 drivers/video/fbdev/mb862xx/mb862xx-i2c.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

-- 
2.8.1

