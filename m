From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Sep 2011 21:25:47 +0000
Subject: Re: [PATCH 1/4] fbdev: sh_mobile_meram: Replace hardcoded register values with macros
Message-Id: <201109202325.47612.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Damien,

On Tuesday 02 August 2011 10:43:51 Damian Hobson-Garcia wrote:

Oops, late reply :-/

> > -#define MExxCTL 0x0
> > -#define MExxBSIZE 0x4
> > -#define MExxMNCF 0x8
> > -#define MExxSARA 0x10
> > -#define MExxSARB 0x14
> > -#define MExxSBSIZE 0x18
> 
> [snip]
> 
> > +#define MExxCTL			0x400
> > +#define MExxBSIZE		0x404
> > +#define MExxMNCF		0x408
> > +#define MExxSARA		0x410
> > +#define MExxSARB		0x414
> > +#define MExxSBSIZE		0x418
> 
> One small comment on the definition of these register offsets and
> explanation of what I was originally thinking.  Since each of these
> actually reprents a series of registers, one per ICB, (i.e. ME00CTL,
> ME01CTL, etc.) it makes sense to me to represent them as an offset from
> the base address (0x400) + the start of each ICB address (0x20 * index).
> 
> Other than that, looks great.

Thanks. I've sent a v2.

-- 
Regards,

Laurent Pinchart
