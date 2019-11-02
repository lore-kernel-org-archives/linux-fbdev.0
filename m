From: Dexuan Cui <decui@microsoft.com>
Date: Sat, 02 Nov 2019 06:17:21 +0000
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Message-Id: <PU1P153MB01690579FA52DCDF964AE179BF7D0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191022110905.4032-1-weh@microsoft.com>
In-Reply-To: <20191022110905.4032-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "sam@ravnborg.org" <sam@ravnborg.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kerne>

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Wei Hu
> Sent: Tuesday, October 22, 2019 4:11 AM
> ... 
> +	/* Allocate from CMA */
> +	// request_pages = (request_size >> PAGE_SHIFT) + 1;

"//" seems rare in Linux kernel code.
IMO "/* */" is more common.

> +			pr_info("Unable to allocate enough contiguous physical memory
> on Gen 1 VM. Use MMIO instead.\n");

The line exceeds 80 chars.
 
> @@ -1060,6 +1168,7 @@ static int hvfb_probe(struct hv_device *hdev,
>  	par = info->par;
>  	par->info = info;
>  	par->fb_ready = false;
> +	par->need_docopy = false;

Maybe it's better if we set the default value to true? This way we can save
the "	par->need_docopy = true;" in hvfb_getmem().

Thanks,
-- Dexuan
