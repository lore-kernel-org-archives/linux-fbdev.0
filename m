From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:07 +0000
Subject: [PATCH v1 17/47] video: fbdev: vesafb: only support MTRR_TYPE_WRCOMB
Message-Id: <1426893517-2511-18-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

No other video driver uses MTRR types except for MTRR_TYPE_WRCOMB,
the other MTRR types were implemented and supported here but with
no real good reason. The ioremap() APIs are architecture agnostic and
at least on x86 PAT is a new design that extends MTRRs and
can replace it in a much cleaner way, where so long as the
proper ioremap_wc() or variant API is used the right thing will
be done behind the scenes. This is the only driver left using the
other MTRR types -- and since there is no good reason for it now
rip them out.

Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/vesafb.c | 62 ++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index d79a0ac..191156b 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -404,60 +404,30 @@ static int vesafb_probe(struct platform_device *dev)
 	 * region already (FIXME) */
 	request_region(0x3c0, 32, "vesafb");
 
+	if (mtrr = 3) {
 #ifdef CONFIG_MTRR
-	if (mtrr) {
 		unsigned int temp_size = size_total;
-		unsigned int type = 0;
+		int rc;
 
-		switch (mtrr) {
-		case 1:
-			type = MTRR_TYPE_UNCACHABLE;
-			break;
-		case 2:
-			type = MTRR_TYPE_WRBACK;
-			break;
-		case 3:
-			type = MTRR_TYPE_WRCOMB;
-			break;
-		case 4:
-			type = MTRR_TYPE_WRTHROUGH;
-			break;
-		default:
-			type = 0;
-			break;
-		}
-
-		if (type) {
-			int rc;
-
-			/* Find the largest power-of-two */
-			temp_size = roundup_pow_of_two(temp_size);
+		/* Find the largest power-of-two */
+		temp_size = roundup_pow_of_two(temp_size);
 
-			/* Try and find a power of two to add */
-			do {
-				rc = mtrr_add(vesafb_fix.smem_start, temp_size,
-					      type, 1);
-				temp_size >>= 1;
-			} while (temp_size >= PAGE_SIZE && rc = -EINVAL);
-		}
-	}
+		/* Try and find a power of two to add */
+		do {
+			rc = mtrr_add(vesafb_fix.smem_start, temp_size,
+				      MTRR_TYPE_WRCOMB, 1);
+			temp_size >>= 1;
+		} while (temp_size >= PAGE_SIZE && rc = -EINVAL);
 #endif
-	
-	switch (mtrr) {
-	case 1: /* uncachable */
-		info->screen_base = ioremap_nocache(vesafb_fix.smem_start, vesafb_fix.smem_len);
-		break;
-	case 2: /* write-back */
-		info->screen_base = ioremap_cache(vesafb_fix.smem_start, vesafb_fix.smem_len);
-		break;
-	case 3: /* write-combining */
 		info->screen_base = ioremap_wc(vesafb_fix.smem_start, vesafb_fix.smem_len);
-		break;
-	case 4: /* write-through */
-	default:
+	} else {
+#ifdef CONFIG_MTRR
+		if (mtrr && mtrr != 3)
+			WARN_ONCE(1, "Only MTRR_TYPE_WRCOMB (3) make sense\n");
+#endif
 		info->screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
-		break;
 	}
+
 	if (!info->screen_base) {
 		printk(KERN_ERR
 		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
-- 
2.3.2.209.gd67f9d5.dirty

