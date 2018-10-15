From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Oct 2018 07:43:04 +0000
Subject: Re: [PATCH 1/8] cpufreq: tegra186: don't pass GFP_DMA32 to dma_alloc_coherent
Message-Id: <CAJZ5v0ju2Y=yQn9uz6HpYGw5BZovxYh2YbYD7Ujq8kajJfvLSQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-2-hch@lst.de>
In-Reply-To: <20181013151707.32210-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-tegra@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, linux-media@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Oct 13, 2018 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The DMA API does its own zone decisions based on the coherent_dma_mask.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> index 1f59966573aa..f1e09022b819 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -121,7 +121,7 @@ static struct cpufreq_frequency_table *init_vhint_table(
>         void *virt;
>
>         virt = dma_alloc_coherent(bpmp->dev, sizeof(*data), &phys,
> -                                 GFP_KERNEL | GFP_DMA32);
> +                                 GFP_KERNEL);
>         if (!virt)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.19.1
>
