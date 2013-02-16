From: Simon Horman <horms@verge.net.au>
Date: Sat, 16 Feb 2013 06:13:13 +0000
Subject: Re: [PATCH/RFC] mfd: as3711: add OF support
Message-Id: <20130216061312.GA19142@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1302151101140.7446@axis700.grange>
 <20130216022630.GA11628@verge.net.au>
In-Reply-To: <20130216022630.GA11628-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>

On Sat, Feb 16, 2013 at 11:26:30AM +0900, Simon Horman wrote:
> On Fri, Feb 15, 2013 at 11:07:16AM +0100, Guennadi Liakhovetski wrote:
> > Add device-tree bindings to the AS3711 regulator and backlight drivers.
> 
> Hi,
> 
> at this stage I do not expect this code to go through the renesas tree.
> However, in order to provide a basis for work on renesas SoCs I have added
> this patch to the topic/backlight topic branch in the reneas tree on
> kernel.org and merged it into topic/all+next.
> 
> In other words, I am not picking this patch up to merge it or add it to
> linux-next, rather I am storing it for reference.

I have dropped this patch due to the of_device_is_available build error
reported by kbuild and reported in another sub-thread.
