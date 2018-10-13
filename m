From: Takashi Iwai <tiwai@suse.de>
Date: Sat, 13 Oct 2018 18:10:04 +0000
Subject: Re: [alsa-devel] [PATCH 4/8] sound: hpios: don't pass GFP_DMA32 to dma_alloc_coherent
Message-Id: <s5hk1mln2f7.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-5-hch@lst.de> <s5hpnwdn7l7.wl-tiwai@suse.de>
 <20181013163540.GA2947@lst.de>
In-Reply-To: <20181013163540.GA2947@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-media@vger.kernel.org

On Sat, 13 Oct 2018 18:35:40 +0200,
Christoph Hellwig wrote:
> 
> On Sat, Oct 13, 2018 at 06:18:28PM +0200, Takashi Iwai wrote:
> > On Sat, 13 Oct 2018 17:17:03 +0200,
> > Christoph Hellwig wrote:
> > > 
> > > The DMA API does its own zone decisions based on the coherent_dma_mask.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > 
> > 
> > Would you like to take this as a series, or shall I take individually
> > through sound tree?
> 
> There is nothing that depends on this, so feel free to apply the
> two sound patches to your tree.

OK, thanks.


Takashi
