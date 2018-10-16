From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 16 Oct 2018 12:41:23 +0000
Subject: Re: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to dma_alloc_wc
Message-Id: <CA+M3ks6a-D4j425JGBof+ma3NX5Fo52k5fadRNRauexOBXuaaw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-7-hch@lst.de>
 <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com>
In-Reply-To: <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-media@vger.kernel.org

Le lun. 15 oct. 2018 à 11:12, Benjamin Gaignard
<benjamin.gaignard@linaro.org> a écrit :
>
> Le sam. 13 oct. 2018 à 17:17, Christoph Hellwig <hch@lst.de> a écrit :
> >
> > The DMA API does its own zone decisions based on the coherent_dma_mask.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Christoph do you plan to merge this patch on your own tree ? or would
like I put it directly in drm-misc-next branch ?

Regards,
Benjamin
>
> > ---
> >  drivers/gpu/drm/sti/sti_gdp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
> > index c32de6cbf061..cdf0a1396e00 100644
> > --- a/drivers/gpu/drm/sti/sti_gdp.c
> > +++ b/drivers/gpu/drm/sti/sti_gdp.c
> > @@ -517,7 +517,7 @@ static void sti_gdp_init(struct sti_gdp *gdp)
> >         /* Allocate all the nodes within a single memory page */
> >         size = sizeof(struct sti_gdp_node) *
> >             GDP_NODE_PER_FIELD * GDP_NODE_NB_BANK;
> > -       base = dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL | GFP_DMA);
> > +       base = dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL);
> >
> >         if (!base) {
> >                 DRM_ERROR("Failed to allocate memory for GDP node\n");
> > --
> > 2.19.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> --
> Benjamin Gaignard
>
> Graphic Study Group
>
> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro: Facebook | Twitter | Blog



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org │ Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
