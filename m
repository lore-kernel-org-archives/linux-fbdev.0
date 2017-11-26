From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 10:16:01 +0000
Subject: [PATCH 0/4] video: sm501fb: Adjustments for seven function implementations
Message-Id: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 11:10:01 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete error messages for a failed memory allocation in two functions
  Improve a size determination in sm501fb_probe()
  Combine substrings for four messages
  Adjust 15 checks for null pointers

 drivers/video/fbdev/sm501fb.c | 66 ++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

-- 
2.15.0

