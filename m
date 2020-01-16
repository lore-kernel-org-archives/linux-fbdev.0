From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 16 Jan 2020 14:08:54 +0000
Subject: [PATCH 0/6] video: fbdev: controlfb: small cleanup
Message-Id: <20200116140900.26363-1-b.zolnierkie@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116140914eucas1p1a62794ad40589e818614176ea8e817ff@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: b.zolnierkie@samsung.com

Hi,

Small cleanup for controlfb driver:

- fix sparse warnings
- remove not working module support
- add COMPILE_TEST support
- remove redundant function prototypes

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (6):
  video: fbdev: controlfb: fix sparse warning about using incorrect type
  video: fbdev: controlfb: remove obsolete module support
  video: fbdev: controlfb: add COMPILE_TEST support
  video: fbdev: controlfb: remove function prototypes part #1
  video: fbdev: controlfb: remove function prototypes part #2
  video: fbdev: controlfb: remove function prototypes part #3

 drivers/video/fbdev/Kconfig     |   2 +-
 drivers/video/fbdev/controlfb.c | 810 +++++++++++++++-----------------
 2 files changed, 383 insertions(+), 429 deletions(-)

-- 
2.24.1
