From: Christoph Hellwig <hch@lst.de>
Date: Thu, 21 Mar 2019 22:52:28 +0000
Subject: remove NULL struct device support in the DMA API
Message-Id: <20190321225235.30648-1-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>, x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

We still have a few drivers which pass a NULL struct device pointer
to DMA API functions, which generally is a bad idea as the API
implementations rely on the device not only for ops selection, but
also the dma mask and various other attributes, and many implementations
have been broken for NULL device support for a while.

This series removes the few remaning users that weren't picked up in
the last merge window and then removes core support for this "feature".

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git dma-remove-NULL-dev-support

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-remove-NULL-dev-support
