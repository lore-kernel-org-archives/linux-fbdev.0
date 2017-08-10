From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 10 Aug 2017 09:28:43 +0000
Subject: [PATCH 0/2] fbdev: make fb_ops const
Message-Id: <1502356605-20801-1-git-send-email-bhumirks@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, adaplas@gmail.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make these const.

Bhumika Goyal (2):
  fbdev: matrox: make fb_ops const
  fbdev: i810: make fb_ops const

 drivers/video/fbdev/i810/i810_main.c       | 2 +-
 drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

