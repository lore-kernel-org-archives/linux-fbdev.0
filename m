From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Feb 2019 13:28:33 +0000
Subject: fbdev: don't pass a NULL struct device to DMA API functions v2
Message-Id: <20190211132836.29594-1-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

We still have a few drivers which pass a NULL struct device pointer
to DMA API functions, which generally is a bad idea as the API
implementations rely on the device not only for ops selection, but
also the dma mask and various other attributes.

This series contains all easy conversions to pass a struct device,
besides that there also is some arch code that needs separate handling,
a driver that should not use the DMA API at all, and one that is
a complete basket case to be deal with separately.

Changes since v1:
 - split the series, this only contains the fbdev patches
