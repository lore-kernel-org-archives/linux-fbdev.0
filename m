From: Donghwa Lee <dh09.lee@samsung.com>
Date: Wed, 09 May 2012 05:49:44 +0000
Subject: [PATCH 0/5] video: exynos mipi dsi: fixes some bugs and clean the codes
Message-Id: <4FAA0578.3060509@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

These patches fix some bugs and clean the codes for exynos mipi dsi
display driver.

video: exynos mipi dsi: enable interrupt again after sw reset
	:I resend this patch by including this series.
	You can refer the original patch by below url.
	http://marc.info/?l=linux-fbdev&m3610770329570&w=2
video: exynos mipi dsi: Do not use deprecated suspend/resume callbacks
video: exynos mipi dsi: Avoid races in probe()
video: exynos mipi dsi: Properly interpret the interrupt source flags
video: exynos mipi dsi: support reverse panel type

Thank you,
Donghwa Lee
