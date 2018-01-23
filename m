From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Tue, 23 Jan 2018 12:50:39 +0000
Subject: [RFC PATCH 0/2] clk: new APIs to handle all available clocks
Message-Id: <1516711841-25234-1-git-send-email-aisheng.dong@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This RFC patch series is a continue of discussion from here,
https://patchwork.kernel.org/patch/9986293/
that some users may want to handle all available clocks from device
tree without need to know the detailed clock information likes clock
numbers and names. This is useful in writing some generic drivers to
handle clock part.

Dong Aisheng (2):
  clk: add new APIs to operate on all available clocks
  video: simplefb: switch to use clk_bulk API to simplify clock
    operations

 drivers/clk/clk-bulk.c         | 64 ++++++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/simplefb.c | 70 ++++++++----------------------------------
 include/linux/clk.h            | 61 +++++++++++++++++++++++++++++++++++-
 3 files changed, 137 insertions(+), 58 deletions(-)

-- 
2.7.4

