From: Zac Storer <zac.3.14159@gmail.com>
Date: Fri, 18 Nov 2011 04:38:58 +0000
Subject: [PATCH 4/4] Drivers: video: sbuslib: fixed a brace coding style issue
Message-Id: <1321591138-8334-1-git-send-email-zac.3.14159@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>

Fixed a brace coding style issue.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/video/sbuslib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sbuslib.c b/drivers/video/sbuslib.c
index 37d764a..3c1de98 100644
--- a/drivers/video/sbuslib.c
+++ b/drivers/video/sbuslib.c
@@ -76,7 +76,7 @@ int sbusfb_mmap_helper(struct sbus_mmap_map *map,
 				map_offset = (physbase + map[i].poff) & POFF_MASK;
 				break;
 			}
-		if (!map_size){
+		if (!map_size) {
 			page += PAGE_SIZE;
 			continue;
 		}
-- 
1.7.7.3

