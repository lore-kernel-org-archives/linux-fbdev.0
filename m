From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Mar 2013 22:27:25 +0000
Subject: Re: [PATCH v3 2/3] regulator: as3711: add OF support
Message-Id: <Pine.LNX.4.64.1303222326430.22486@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363968949-12151-1-git-send-email-g.liakhovetski@gmx.de>
 <1363968949-12151-3-git-send-email-g.liakhovetski@gmx.de>
 <20130322185333.GN22890@opensource.wolfsonmicro.com>
In-Reply-To: <20130322185333.GN22890-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Fri, 22 Mar 2013, Mark Brown wrote:

> On Fri, Mar 22, 2013 at 05:15:48PM +0100, Guennadi Liakhovetski wrote:
> > AS3711 regulator OF support only evaluates standard regulator DT
> > properties.
> 
> It looks like this has no dependencies on the MFD patch, is that
> correct?

Yes, that's correct. That was the purpose of this split - to pull the 
patches via respective trees.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
