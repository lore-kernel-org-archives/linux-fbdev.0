From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 01 Feb 2019 16:18:21 +0000
Subject: Re: [alsa-devel] don't pass a NULL struct device to DMA API functions
Message-Id: <s5hwomj7a9e.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
        <s5ho97v8x9j.wl-tiwai@suse.de>
        <20190201160957.GD6532@lst.de>
In-Reply-To: <20190201160957.GD6532@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org

On Fri, 01 Feb 2019 17:09:57 +0100,
Christoph Hellwig wrote:
> 
> On Fri, Feb 01, 2019 at 02:16:08PM +0100, Takashi Iwai wrote:
> > Actually there are a bunch of ISA sound drivers that still call
> > allocators with NULL device.
> > 
> > The patch below should address it, although it's only compile-tested.
> 
> Oh, I missed these "indirect" calls.  This looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

OK, merged this one to for-next branch now as well.


thanks,

Takashi
