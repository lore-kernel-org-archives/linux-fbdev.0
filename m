From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Dec 2010 01:34:41 +0000
Subject: Re: [PATCH 1/2] fbdev: sh-mobile: implement MIPI DSI runtime PM support
Message-Id: <20101224013440.GF28151@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1012221050400.14483@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1012221050400.14483@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Dec 23, 2010 at 01:08:34AM +0100, Guennadi Liakhovetski wrote:
> On Thu, 23 Dec 2010, Paul Mundt wrote:
> 
> > On Wed, Dec 22, 2010 at 10:52:18AM +0100, Guennadi Liakhovetski wrote:
> > > @@ -356,7 +360,9 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
> > >  		goto emap;
> > >  	}
> > >  
> > > -	mipi->dsit_clk = clk_get(&pdev->dev, "dsit_clk");
> > > +	mipi->dev = &pdev->dev;
> > > +
> > > +	mipi->dsit_clk = clk_get(NULL, "dsit_clk");
> > 
> > Why did you drop &pdev->dev from clk_get()?
> 
> Because that clock is not associated with that device, it sisn't work 
> correctly until now. You also cannot associate it with that device 
> exclusively, because it serves two devices...
> 
I'm not sure I see what the problem is. If there is no special lookup
matching this clock to the device pointer then the lookup will resolve to
whatever generically provides that clock. There is also nothing that
stops someone from providing the same clock to multiple devices via the
same lookup string, this is largely what clock lookups are for in the
first place. Any move away from a device pointer to clk_get() is a step
in the wrong direction.
