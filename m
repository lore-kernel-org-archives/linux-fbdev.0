From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 23 Dec 2010 00:08:34 +0000
Subject: Re: [PATCH 1/2] fbdev: sh-mobile: implement MIPI DSI runtime PM
Message-Id: <Pine.LNX.4.64.1012230107400.19497@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1012221050400.14483@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1012221050400.14483@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 23 Dec 2010, Paul Mundt wrote:

> On Wed, Dec 22, 2010 at 10:52:18AM +0100, Guennadi Liakhovetski wrote:
> > @@ -356,7 +360,9 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
> >  		goto emap;
> >  	}
> >  
> > -	mipi->dsit_clk = clk_get(&pdev->dev, "dsit_clk");
> > +	mipi->dev = &pdev->dev;
> > +
> > +	mipi->dsit_clk = clk_get(NULL, "dsit_clk");
> 
> Why did you drop &pdev->dev from clk_get()?

Because that clock is not associated with that device, it sisn't work 
correctly until now. You also cannot associate it with that device 
exclusively, because it serves two devices...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
