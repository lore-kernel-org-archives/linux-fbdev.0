From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 18 Oct 2019 22:30:12 +0000
Subject: Re: [PATCH] omapfb: reduce stack usage
Message-Id: <20191018223012.tkpwbo3mg5mthlnz@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018163004.23498-1-sudipm.mukherjee@gmail.com>
 <20191018172728.GA11857@lenoch>
In-Reply-To: <20191018172728.GA11857@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Oct 18, 2019 at 07:27:28PM +0200, Ladislav Michl wrote:
> On Fri, Oct 18, 2019 at 05:30:04PM +0100, Sudip Mukherjee wrote:
> > The build of xtensa allmodconfig is giving a warning of:
> > In function 'dsi_dump_dsidev_irqs':
> > warning: the frame size of 1120 bytes is larger than 1024 bytes
> > 
> > Allocate the memory for 'struct dsi_irq_stats' dynamically instead
> > of assigning it in stack.
> 
> So now function can fail silently, executes longer, code is sligthly
> bigger... And all that to silent warning about exceeding frame size.
> Is it really worth "fixing"?

The only point of failure is if kmalloc() fails and if kmalloc() fails then
there will be error prints in dmesg to tell the user that there is no
memory left in the system. About the size bigger, it seems
the drivers/video/fbdev/omap2/omapfb/dss/dsi.o file is smaller with the
patch.
This is without the patch:
-rw-r--r-- 1 sudip sudip 316856 Oct 18 22:27 drivers/video/fbdev/omap2/omapfb/dss/dsi.o
And this is with the patch:
-rw-r--r-- 1 sudip sudip 316436 Oct 18 20:09 drivers/video/fbdev/omap2/omapfb/dss/dsi.o

And also, objdump shows me that <dsi_dump_dsidev_irqs> was taking up 0xD7D
bytes, and now with the patch it is taking up 0xBED bytes, thats a saving
of 400 bytes. If it has 400 bytes of less code to execute will it not be
faster now?

But, I may be totally wrong in my thinking, and in that case, please feel
free to reject the patch.

--
Regards
Sudip
