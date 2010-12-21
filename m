From: Dave Airlie <airlied@gmail.com>
Date: Tue, 21 Dec 2010 01:41:15 +0000
Subject: [PATCH 1/3] fb: fix overlapping test off-by-one.
Message-Id: <1292895677-4242-2-git-send-email-airlied@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292895677-4242-1-git-send-email-airlied@gmail.com>
In-Reply-To: <1292895677-4242-1-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>

From: Dave Airlie <airlied@redhat.com>

On my system with a radeon x2, the first GPU was not overlapping vesa
but the test decided it was.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/video/fbmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 0e6aa3d..4ac1201 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1458,7 +1458,7 @@ static bool apertures_overlap(struct aperture *gen, struct aperture *hw)
 	if (gen->base = hw->base)
 		return true;
 	/* is the generic aperture base inside the hw base->hw base+size */
-	if (gen->base > hw->base && gen->base <= hw->base + hw->size)
+	if (gen->base > hw->base && gen->base < hw->base + hw->size)
 		return true;
 	return false;
 }
-- 
1.7.1

