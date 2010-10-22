From: Nicolas Kaiser <nikai@nikai.net>
Date: Fri, 22 Oct 2010 11:31:30 +0000
Subject: [PATCH] rivafb: dubious assignment
Message-Id: <20101022133130.4cb2cb96@absol.kitzblitz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

A duplicated assignment unconditionally changes max_gfsize to
GFIFO_SIZE.

It looks to me like this might not be intended, or is it?

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 drivers/video/riva/riva_hw.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
index 78fdbf5..936abfa 100644
--- a/drivers/video/riva/riva_hw.c
+++ b/drivers/video/riva/riva_hw.c
@@ -263,7 +263,6 @@ static int nv3_iterate(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_arb_i
     vmisses = 2;
     if (ainfo->gburst_size = 128) max_gfsize = GFIFO_SIZE_128;
     else  max_gfsize = GFIFO_SIZE;
-    max_gfsize = GFIFO_SIZE;
     while (1)
     {
         if (ainfo->vid_en)
-- 
1.7.2.2
