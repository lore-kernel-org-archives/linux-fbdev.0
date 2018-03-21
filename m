From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Wed, 21 Mar 2018 03:19:47 +0000
Subject: [PATCH V2 0/4] clk: new APIs to handle all available clocks
Message-Id: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch series is a continue of discussion from here,
https://patchwork.kernel.org/patch/9986293/
that some users may want to handle all available clocks from device
tree without need to know the detailed clock information likes clock
numbers and names. This is useful in writing some generic drivers to
handle clock part.

Note:
This patch series is tested on MX6Q SDB cpufreq driver with a minor change
to switch to use clk_bulk_get_all.
But patch 4 only test compiling. Hopefully someone could help test
the function.

v1->v2:
 * add clk_bulk_{get|put}_all() which only supports DT platform currently
 * remove _all variants and the wrapper struct clk_bulk
 * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
   proves they need it because they don't have a struct device pointer.

Dong Aisheng (4):
  clk: bulk: add of_clk_bulk_get()
  clk: add new APIs to operate on all available clocks
  clk: add managed version of clk_bulk_get_all
  video: simplefb: switch to use clk_bulk API to simplify clock
    operations

 drivers/clk/clk-bulk.c         | 89 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-devres.c       | 24 ++++++++++++
 drivers/video/fbdev/simplefb.c | 69 ++++++--------------------------
 include/linux/clk.h            | 65 +++++++++++++++++++++++++++++-
 4 files changed, 190 insertions(+), 57 deletions(-)

-- 
2.7.4

