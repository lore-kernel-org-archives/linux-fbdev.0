From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Dec 2010 23:24:38 +0000
Subject: Re: [PATCH 1/2] fbdev: sh-mobile: implement MIPI DSI runtime PM support
Message-Id: <20101222232438.GC28151@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1012221050400.14483@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1012221050400.14483@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Dec 22, 2010 at 10:52:18AM +0100, Guennadi Liakhovetski wrote:
> @@ -356,7 +360,9 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
>  		goto emap;
>  	}
>  
> -	mipi->dsit_clk = clk_get(&pdev->dev, "dsit_clk");
> +	mipi->dev = &pdev->dev;
> +
> +	mipi->dsit_clk = clk_get(NULL, "dsit_clk");

Why did you drop &pdev->dev from clk_get()?
