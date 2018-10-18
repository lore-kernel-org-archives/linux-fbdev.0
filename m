From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Thu, 18 Oct 2018 11:59:27 +0000
Subject: Re: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to dma_alloc_wc
Message-Id: <CA+M3ks5WW9WviTNr3VLHc-ijYLu-fp8XMtAbr3p9cFe3J+n39Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-7-hch@lst.de>
 <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com>
 <CA+M3ks6a-D4j425JGBof+ma3NX5Fo52k5fadRNRauexOBXuaaw@mail.gmail.com>
 <20181017071958.GC23407@lst.de>
In-Reply-To: <20181017071958.GC23407@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-media@vger.kernel.org

Le mer. 17 oct. 2018 à 09:19, Christoph Hellwig <hch@lst.de> a écrit :
>
> On Tue, Oct 16, 2018 at 02:41:23PM +0200, Benjamin Gaignard wrote:
> > Le lun. 15 oct. 2018 à 11:12, Benjamin Gaignard
> > <benjamin.gaignard@linaro.org> a écrit :
> > >
> > > Le sam. 13 oct. 2018 à 17:17, Christoph Hellwig <hch@lst.de> a écrit :
> > > >
> > > > The DMA API does its own zone decisions based on the coherent_dma_mask.
> > > >
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >
> > > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> >
> > Christoph do you plan to merge this patch on your own tree ? or would
> > like I put it directly in drm-misc-next branch ?
>
> Please pull it in through drm-misc-next, thanks!

Applied on drm-misc-next,
Thanks,
Benjamin
