From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Wed, 08 May 2019 11:28:27 +0000
Subject: [PATCH 01/16] lib: fix match_string() helper when array size is positive
Message-Id: <20190508112842.11654-3-alexandru.ardelean@analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190508112842.11654-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-mtd@lists.infradead.org, cgroups@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, alsa-devel@alsa-project.org
Cc: gregkh@linuxfoundation.org, Alexandru Ardelean <alexandru.ardelean@analog.com>, andriy.shevchenko@linux.intel.com

The documentation the `_match_string()` helper mentions that `n`
(size of the given array) should be:
 * @n: number of strings in the array or -1 for NULL terminated arrays

The behavior of the function is different, in the sense that it exits on
the first NULL element in the array, regardless of whether `n` is -1 or a
positive number.

This patch changes the behavior, to exit the loop when a NULL element is
found and n = -1. Essentially, this aligns the behavior with the
doc-string.

There are currently many users of `match_string()`, and so, in order to go
through them, the next patches in the series will focus on doing some
cosmetic changes, which are aimed at grouping the users of
`match_string()`.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 lib/string.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 3ab861c1a857..76edb7bf76cb 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -648,8 +648,11 @@ int match_string(const char * const *array, size_t n, const char *string)
 
 	for (index = 0; index < n; index++) {
 		item = array[index];
-		if (!item)
+		if (!item) {
+			if (n != (size_t)-1)
+				continue;
 			break;
+		}
 		if (!strcmp(item, string))
 			return index;
 	}
-- 
2.17.1
