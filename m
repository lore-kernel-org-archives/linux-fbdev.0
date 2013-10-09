From: Joe Perches <joe@perches.com>
Date: Wed, 09 Oct 2013 15:13:03 +0000
Subject: Re: [PATCH v2 2/3] video: xilinxfb: Use devm_kzalloc instead of kzalloc
Message-Id: <1381331583.2050.11.camel@joe-AO722>
List-Id: <linux-fbdev.vger.kernel.org>
References: <631df9a44b366af4129d00f1d4e1d3baad7d4903.1381315928.git.michal.simek@xilinx.com>
	 <748c16093663172918a90a53dc472cb8beb584ca.1381315928.git.michal.simek@xilinx.com>
In-Reply-To: <748c16093663172918a90a53dc472cb8beb584ca.1381315928.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On Wed, 2013-10-09 at 12:52 +0200, Michal Simek wrote:
> Simplify driver probe and release function.
[]
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
[]
> @@ -423,7 +419,7 @@ static int xilinxfb_of_probe(struct platform_device *pdev)
>  	pdata = xilinx_fb_default_pdata;
> 
>  	/* Allocate the driver data region */
> -	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata) {
>  		dev_err(&pdev->dev, "Couldn't allocate device private record\n");

Be nice to remove the unnecessary OOM message.
There's already a generic dump_stack on OOM.


