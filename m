From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 15 Mar 2020 04:09:56 +0000
Subject: fbdev: fix -Wextra build warnings
Message-Id: <20200315041002.24473-1-rdunlap@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This patch series fixes warnings in fbdev that are found when
-Wextra is used. In fixing these, there were a few other build
errors discovered (mostly caused by bitrot) and fixed.

[PATCH 1/6] fbdev: fbmon: fix -Wextra build warnings
[PATCH 2/6] fbdev: aty: fix -Wextra build warning
[PATCH 3/6] fbdev: matrox: fix -Wextra build warnings
[PATCH 4/6] fbdev: savage: fix -Wextra build warning
[PATCH 5/6] fbdev: pm[23]fb.c: fix -Wextra build warnings and errors
[PATCH 6/6] fbdev: via: fix -Wextra build warning and format warning

 drivers/video/fbdev/aty/atyfb_base.c       |    2 +-
 drivers/video/fbdev/core/fbmon.c           |    2 +-
 drivers/video/fbdev/matrox/matroxfb_base.h |    2 +-
 drivers/video/fbdev/pm2fb.c                |    2 +-
 drivers/video/fbdev/pm3fb.c                |    8 ++++----
 drivers/video/fbdev/savage/savagefb.h      |    2 +-
 drivers/video/fbdev/via/debug.h            |    6 ++++--
 drivers/video/fbdev/via/viafbdev.c         |    2 +-
 8 files changed, 14 insertions(+), 12 deletions(-)
