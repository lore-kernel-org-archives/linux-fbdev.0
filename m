From: Dominik 'disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Date: Mon, 09 Mar 2020 12:49:46 +0000
Subject: [PATCH] Fix off by one in nvidia driver strncpy size arg
Message-Id: <20200309124947.4502-1-dominik.b.czarnota@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dominik.b.czarnota@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

From: disconnect3d <dominik.b.czarnota@gmail.com>

This patch fixes an off-by-one error in strncpy size argument in
drivers/video/fbdev/nvidia/nvidia.c. The issue is that in:

        strncmp(this_opt, "noaccel", 6)

the passed string literal: "noaccel" has 7 bytes (without the NULL byte)
and the passed size argument is 6. As a result, the logic will also
match/accept string "noacce" or "noacceX".

This bug doesn't seem to have any security impact since its present in
the driver's setup and just accepts slighty changed string to enable the
`noaccel` flag.

Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>
---

Notes:
    The bug could also be fixed by changing the size argument to
    `sizeof("string literal")-1` but I am not proposing this change as that
    would have to be changed in other places.
    
    There are also more cases like this in kernel sources which I
    reported/will report soon.
    
    This bug has been found by running a massive grep-like search using
    Google's BigQuery on GitHub repositories data. I am also going to work
    on a CodeQL/Semmle query to be able to find more sophisticated cases
    like this that can't be found via grepping.

 drivers/video/fbdev/nvidia/nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index c583c018304d..b77efeb33477 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1470,7 +1470,7 @@ static int nvidiafb_setup(char *options)
 			flatpanel = 1;
 		} else if (!strncmp(this_opt, "hwcur", 5)) {
 			hwcur = 1;
-		} else if (!strncmp(this_opt, "noaccel", 6)) {
+		} else if (!strncmp(this_opt, "noaccel", 7)) {
 			noaccel = 1;
 		} else if (!strncmp(this_opt, "noscale", 7)) {
 			noscale = 1;
-- 
2.25.1
