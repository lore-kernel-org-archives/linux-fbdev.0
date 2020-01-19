From: yu kuai <yukuai3@huawei.com>
Date: Sun, 19 Jan 2020 12:17:26 +0000
Subject: [PATCH 0/4] cleanup patches for unused variables
Message-Id: <20200119121730.10701-1-yukuai3@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, zhengbin13@huawei.com, yukuai3@huawei.com

yu kuai (4):
  video: fbdev: remove set but not used variable 'hSyncPol'
  video: fbdev: remove set but not used variable 'vSyncPol'
  video: fbdev: remove set but not used variable 'vSyncPol'
  video: fbdev: remove set but not used variable 'bytpp'

 drivers/video/fbdev/aty/radeon_base.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.17.2
