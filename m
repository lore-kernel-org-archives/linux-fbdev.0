From: Christoph Hellwig <hch@lst.de>
Date: Sat, 13 Oct 2018 15:16:59 +0000
Subject: remove bogus GFP_DMA32 flags for dma allocations
Message-Id: <20181013151707.32210-1-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

dma_alloc_* internally selects the zone to allocate from based on the
DMA mask.  Remove all explicit uses of GFP_DMA32 with dma_alloc_*.
