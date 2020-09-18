From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Sep 2020 10:08:10 +0000
Subject: [PATCH 0/3] fbdev: stop using compat_alloc_user_space
Message-Id: <20200918100812.1447443-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "David S . Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, hch@lst.de, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

The fbdev code uses compat_alloc_user_space in a few of its
compat_ioctl handlers, which tends to be a bit more complicated
and error-prone than calling the underlying handlers directly,
so I would like to remove it completely.

This modifies two such functions in fbdev, and removes another
one that is completely unused.

    Arnd

Arnd Bergmann (3):
  fbdev: simplify fb_getput_cmap()
  fbdev: sbuslib: remove unused FBIOSCURSOR32 helper
  fbdev: sbuslib: remove compat_alloc_user_space usage

 drivers/video/fbdev/core/fbmem.c |  44 +++++------
 drivers/video/fbdev/sbuslib.c    | 124 ++++++++++++++++++-------------
 2 files changed, 90 insertions(+), 78 deletions(-)

-- 
2.27.0
