From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 19 Oct 2019 09:11:54 +0000
Subject: Re: [PATCH] omapfb: reduce stack usage
Message-Id: <20191019091154.qlmb7abqoqdmtz7f@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018163004.23498-1-sudipm.mukherjee@gmail.com>
 <20191018172728.GA11857@lenoch>
 <20191018223012.tkpwbo3mg5mthlnz@debian>
 <184cdd47d4064420b05c16f10588595c65f789e5.camel@perches.com>
In-Reply-To: <184cdd47d4064420b05c16f10588595c65f789e5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

On Fri, Oct 18, 2019 at 06:19:15PM -0700, Joe Perches wrote:
> On Fri, 2019-10-18 at 23:30 +0100, Sudip Mukherjee wrote:
> > On Fri, Oct 18, 2019 at 07:27:28PM +0200, Ladislav Michl wrote:
> > > On Fri, Oct 18, 2019 at 05:30:04PM +0100, Sudip Mukherjee wrote:
> > > > The build of xtensa allmodconfig is giving a warning of:
> > > > In function 'dsi_dump_dsidev_irqs':
> > > > warning: the frame size of 1120 bytes is larger than 1024 bytes
<snip>
> 
> Without your patch:
> 
> $ objdump -x drivers/video/fbdev/omap2/omapfb/dss/dsi.o | grep dsi_dump_dsidev_irqs
> 00000d20 l     F .text	0000061c dsi_dump_dsidev_irqs
> 
> With your patch:
> 
> $ objdump -x drivers/video/fbdev/omap2/omapfb/dss/dsi.o | grep dsi_dump_dsidev_irqs
> 00000d20 l     F .text	00000638 dsi_dump_dsidev_irqs

I did objdump -d and then compared where it started and where it ended.

But, in anycase, this driver is framebuffer driver for omap2 and in
reality, can only be used on arm platform and when I build the driver
with arm compiler I am not getting this warning. This is not a valid
concern, please reject this patch.

--
Regards
Sudip
