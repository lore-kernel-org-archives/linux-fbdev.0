From: Tushar Behera <tushar.behera@linaro.org>
Date: Thu, 22 Nov 2012 06:54:07 +0000
Subject: [PATCH 0/4] video: vt8500: cleanup and use of devm_ apis
Message-Id: <1353566531-31251-1-git-send-email-tushar.behera@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: FlorianSchandinat@gmx.de, linux@prisktech.co.nz, patches@linaro.org

Patch 1 fixes a possible memory leak in the driver.
Rest 3 patches add/update usage of devm_ apis.

These patches are only build-tested.

Tushar Behera (4):
  video: vt8500: Fix memory leak in probe function
  video: vt8500: Fix invalid free of devm_ allocated data
  video: vt8500: Convert to use devm_request_mem_region()
  video: vt8500: Convert to use devm_ioremap()

 drivers/video/vt8500lcdfb.c |   47 +++++++++++++++---------------------------
 1 files changed, 17 insertions(+), 30 deletions(-)

-- 
1.7.4.1

