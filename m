From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:09 +0000
Subject: [PATCH 00/15] video: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Sachin Kamat (15):
  video: atmel_lcdfb: Remove redundant dev_set_drvdata
  video: grvga: Remove redundant dev_set_drvdata
  video: leo: Remove redundant dev_set_drvdata
  video: mb862xx: Remove redundant dev_set_drvdata
  video: amifb: Remove redundant dev_set_drvdata
  video: bw2: Remove redundant dev_set_drvdata
  video: cg14: Remove redundant dev_set_drvdata
  video: cg3: Remove redundant dev_set_drvdata
  video: cg6: Remove redundant dev_set_drvdata
  video: ffb: Remove redundant dev_set_drvdata
  video: p9100: Remove redundant dev_set_drvdata
  video: platinumfb: Remove redundant dev_set_drvdata
  video: sunxvr1000: Remove redundant dev_set_drvdata
  video: tcx: Remove redundant dev_set_drvdata
  video: xilinxfb: Remove redundant dev_set_drvdata

 drivers/video/amifb.c                |    2 --
 drivers/video/atmel_lcdfb.c          |    2 --
 drivers/video/bw2.c                  |    2 --
 drivers/video/cg14.c                 |    2 --
 drivers/video/cg3.c                  |    2 --
 drivers/video/cg6.c                  |    2 --
 drivers/video/ffb.c                  |    2 --
 drivers/video/grvga.c                |    2 --
 drivers/video/leo.c                  |    2 --
 drivers/video/mb862xx/mb862xxfbdrv.c |    2 --
 drivers/video/p9100.c                |    2 --
 drivers/video/platinumfb.c           |    1 -
 drivers/video/sunxvr1000.c           |    2 --
 drivers/video/tcx.c                  |    2 --
 drivers/video/xilinxfb.c             |    2 --
 15 files changed, 29 deletions(-)

-- 
1.7.9.5

