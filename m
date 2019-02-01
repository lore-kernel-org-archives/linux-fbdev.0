From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 16:10:26 +0000
Subject: Re: [PATCH 12/18] fotg210-udc: remove a bogus dma_sync_single_for_device call
Message-Id: <20190201161026.GE6532@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-13-hch@lst.de> <87d0obodci.fsf@linux.intel.com>
In-Reply-To: <87d0obodci.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Felipe Balbi <balbi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 03:19:41PM +0200, Felipe Balbi wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > dma_map_single already transfers ownership to the device.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Do you want me to take the USB bits or will you take the entire series?
> In case you're taking the entire series:

If you want to take the USB feel free.  I just want most of this in
this merge window if possible.
