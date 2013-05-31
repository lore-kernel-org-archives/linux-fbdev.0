From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2013 14:56:44 +0000
Subject: Re: [PATCH v3 7/8] video: xilinxfb: Fix sparse warnings
Message-Id: <1466524.sgAzczhnBg@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com> <51A8A89C.8030404@tabi.org> <51A8B220.6070308@monstr.eu>
In-Reply-To: <51A8B220.6070308@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu
Cc: Timur Tabi <timur@tabi.org>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On Friday 31 May 2013 16:22:24 Michal Simek wrote:
> @@ -307,7 +319,11 @@ static int xilinxfb_assign(struct platform_device *pdev,
> 
>         /* Fill struct fb_info */
>         drvdata->info.device = dev;
> -       drvdata->info.screen_base = (void __iomem *)drvdata->fb_virt;
> +       if (drvdata->fb_virt)
> +               drvdata->info.screen_base = (__force void __iomem *)
> +                                                       drvdata->fb_virt;
> +       else
> +               drvdata->info.screen_base = drvdata->fb_virt_io;

Yes, unfortunately, this is what all other frame buffer drivers do
at the moment. It is technically not correct, but most architectures
are able to call readl/writel on regular memory, or dereference
__iomem tokens, so we often get away with it. It's probably not
worth fixing it in the fbdev code base as that would be a huge
change, and people are migrating to DRM/KMS.

	Arnd
