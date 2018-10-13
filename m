From: Takashi Iwai <tiwai@suse.de>
Date: Sat, 13 Oct 2018 16:20:35 +0000
Subject: Re: [alsa-devel] [PATCH 5/8] sound: intel/sst: don't pass GFP_DMA32 to dma_alloc_coherent
Message-Id: <s5ho9bxn7ho.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-6-hch@lst.de>
In-Reply-To: <20181013151707.32210-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-media@vger.kernel.org

On Sat, 13 Oct 2018 17:17:04 +0200,
Christoph Hellwig wrote:
> 
> The DMA API does its own zone decisions based on the coherent_dma_mask.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

> ---
>  sound/soc/intel/common/sst-firmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
> index 11041aedea31..1e067504b604 100644
> --- a/sound/soc/intel/common/sst-firmware.c
> +++ b/sound/soc/intel/common/sst-firmware.c
> @@ -355,7 +355,7 @@ struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
>  
>  	/* allocate DMA buffer to store FW data */
>  	sst_fw->dma_buf = dma_alloc_coherent(dsp->dma_dev, sst_fw->size,
> -				&sst_fw->dmable_fw_paddr, GFP_DMA | GFP_KERNEL);
> +				&sst_fw->dmable_fw_paddr, GFP_KERNEL);
>  	if (!sst_fw->dma_buf) {
>  		dev_err(dsp->dev, "error: DMA alloc failed\n");
>  		kfree(sst_fw);
> -- 
> 2.19.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
