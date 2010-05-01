From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 01 May 2010 12:15:56 +0000
Subject: Re: [PATCH 2/2] sh: make interrupt resource optional in SH  framebuffer
Message-Id: <Pine.LNX.4.64.1005011414120.4336@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1004301805371.4055@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1004301805371.4055@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, 1 May 2010, Magnus Damm wrote:

> On Sat, May 1, 2010 at 1:07 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > The SH LCDC driver can also function without the IRQ, in which case the
> > FBIO_WAITFORVSYNC ioctl() cannot be supported. Enable such a mode.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Why? Doesn't the LCDC hardware block always come with an IRQ line?

Because on AP4 intcs is not supported in the mainline yet. And because we 
can?;) Some code paths in the driver already care for the case, when no 
IRQ is configured, so, we can just use it.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
