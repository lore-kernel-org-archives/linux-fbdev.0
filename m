From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 18 Oct 2014 22:14:56 +0000
Subject: [PATCH 3/5] video: fbdev: uvesafb.c:  Cleaning up missing null-terminate by switching from strncpy t
Message-Id: <1413670496-6387-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, Grant Likely <grant.likely@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Ensures that the string is null-terminate in connection with the
use of strncpy, by switching from strncpy to strzcpy.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/uvesafb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 509d452..3383b34 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1892,7 +1892,7 @@ static ssize_t show_v86d(struct device_driver *dev, char *buf)
 static ssize_t store_v86d(struct device_driver *dev, const char *buf,
 		size_t count)
 {
-	strncpy(v86d_path, buf, PATH_MAX);
+	strzcpy(v86d_path, buf, sizeof(v86d_path));
 	return count;
 }
 
-- 
1.7.10.4

