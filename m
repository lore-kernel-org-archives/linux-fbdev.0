From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 20 Nov 2019 09:57:13 +0000
Subject: [PATCH v1 2/5] fbtft: Describe function parameters in kernel-doc
Message-Id: <20191120095716.26628-2-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, linux-fbdev@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Kernel documentation script complains that some of the function parameters
are not described:

drivers/staging/fbtft/fbtft-core.c:543: warning: Function parameter or member 'pdata' not described in 'fbtft_framebuffer_alloc'

Describe function parameters where it's appropriate.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/fbtft-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 61f0286fb157..2122c4407bdb 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -529,6 +529,7 @@ static void fbtft_merge_fbtftops(struct fbtft_ops *dst, struct fbtft_ops *src)
  *
  * @display: pointer to structure describing the display
  * @dev: pointer to the device for this fb, this can be NULL
+ * @pdata: platform data for the display in use
  *
  * Creates a new frame buffer info structure.
  *
-- 
2.24.0
