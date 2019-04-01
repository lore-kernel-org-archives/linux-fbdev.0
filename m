From: Tom Li <tomli@tomli.me>
Date: Mon, 01 Apr 2019 16:41:58 +0000
Subject: Re: [PATCH v2 4/7] fbdev: sm712fb: add 32-bit color modes, drops some other modes.
Message-Id: <20190401164158.GC15736@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-5-tomli@tomli.me>
 <20190331183333.kpyt2hm5iy6m5u34@debian>
In-Reply-To: <20190331183333.kpyt2hm5iy6m5u34@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sun, Mar 31, 2019 at 07:33:33PM +0100, Sudip Mukherjee wrote:
> Why are you removing existing functionality from the driver? These are
> supported but were never listed so could not be used. I think you can
> just add these to vesa_mode_table[] and they can be used.

If there are some "functionalities" in a system, but they are never used,
even worse, they are programmed in a way that they cannot be used by any
user no matter what, meanwhile not a single user had filed a bug report
in the entire lifecycle of the program, then I'd call them "dead code",
that serves no useful purposes, rather than "functionalities". I think
most kernel developers can agree on this.

> I have an old CRT in India which supports 320x240 mode and can test there
> when I am there next.

Well... If someone (e.g. you) do see a need of this feature, then fixing
them (instead of removing them) becomes a reasonable choice.

Coincidentally, I've also purchased a video converter a few days ago. Please
allow some time for me to testing it, so I can see if they're working. If so,
I'll add them to the vesa_mode_table[] in PATCH v3.

> >  /**********************************************************************
> >  			 SM712 Mode table.
> > - **********************************************************************/
> > +
> > + The modesetting in sm712fb is an ugly hack. First, all the registers
> > + are programmed by hardcoded register arrays, which makes it difficult
> > + to support different variations of color depths, refresh rates, CRT/LCD
> > + panel, etc of the same resolution. Second, it means the standard
> > + fb_find_mode() cannot be used and a confusing non-standard "vga="
> > + parameter is needed. Third, there's only minimum differences between
> > + some modes, yet around 70 lines of code and 100 registers are needed to
> > + be indepentently specified for each mode. Fourth, the register between
> > + some modes are inconsistent: the register configuration of different
> > + color depths in 640 x 480 modes are identical, but for 800 x 600 modes
> > + it's completely different. Also, some modes can drive the LCD panel
> > + properly yet some other modes will only show a white screen of death on
> > + the LCD panel. Fifth, there is a specific hack for Lemote Loongson 8089D
> > + laptop, the 1024x768, 16-bit color mode was modified to drive its LCD panel
> > + and changed to 1024x600, but the original mode was not preserved, so
> > + 1024x768 16-bit color mode is completely unsupported. And previously,
> > + some modes are listed, such as 1280x1024 modes, but never supported by
> > + the register configuration arrays, so they are now removed. And some modes
> > + are partially implemented but neither listed nor supported, i.e. the 8-bit
> > + color modes, so they have been removed from vesa_mode_table, too.
> 
> I think this comment sounds more like a commit message instead of a
> code comment. Does this improve readability?

Will remove, thanks.

> 
> > +
> > + I'm not the original author of the code, fixing these problems requires a
> > + complete rewrite of modesetting code, which is well-beyond my motivation.
> > +
> > + See Documentation/fb/sm712fb.txt for more information.
> > +**********************************************************************/
> 
> Is this needed? Many of the commits of the driver are done by people who
> are not the original author.

I'll reword it.

Thanks,
Tom Li
