From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 May 2011 06:32:33 +0000
Subject: linux-next: build failure after merge of the final tree
Message-Id: <20110520163233.abcabd67.sfr@canb.auug.org.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus <torvalds@linux-foundation.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

Hi all,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/video/udlfb.c: In function 'dlfb_compress_hline':
drivers/video/udlfb.c:421: error: implicit declaration of function 'prefetch_range'

Presumably caused by commit e66eed651fd1 ("list: remove prefetching from
regular list iterators").  We need to include preempt.h explictly, now.

I have included this patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 May 2011 16:29:01 +1000
Subject: [PATCH] udlfb: include prefetch.h explicitly

Commit e66eed651fd1 ("list: remove prefetching from
regular list iterators") removed the include of prefetch.h from list.h,
so we need to include it explicitly, now.

fixes this build error on powerpc:

drivers/video/udlfb.c: In function 'dlfb_compress_hline':
drivers/video/udlfb.c:421: error: implicit declaration of function 'prefetch_range'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/video/udlfb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 68041d9..4c299cc 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -28,6 +28,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/prefetch.h>
 #include <video/udlfb.h>
 #include "edid.h"
 
-- 
1.7.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
