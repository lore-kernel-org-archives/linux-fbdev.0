From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 03 Jan 2020 17:11:26 +0000
Subject: [PATCH 14/19] video: exynos: Rename Exynos to lowercase
Message-Id: <20200103171131.9900-15-krzk@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Fix up inconsistent usage of upper and lowercase letters in "Exynos"
name.

"EXYNOS" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/video/samsung_fimd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index b6571c3cfa31..c4a93ce1de48 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -10,7 +10,7 @@
  *
  * This is the register set for the fimd and new style framebuffer interface
  * found from the S3C2443 onwards into the S3C2416, S3C2450, the
- * S3C64XX series such as the S3C6400 and S3C6410, and EXYNOS series.
+ * S3C64XX series such as the S3C6400 and S3C6410, and Exynos series.
 */
 
 /* VIDCON0 */
-- 
2.17.1
