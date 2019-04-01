From: Tom Li <tomli@tomli.me>
Date: Mon, 01 Apr 2019 17:33:14 +0000
Subject: Re: [PATCH v2 6/7] fbdev: sm712fb: Kconfig: add information about docs.
Message-Id: <20190401173314.GE15736@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-7-tomli@tomli.me>
 <20190331190118.3kaf7erdbk25yd5n@debian>
In-Reply-To: <20190331190118.3kaf7erdbk25yd5n@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sun, Mar 31, 2019 at 08:01:18PM +0100, Sudip Mukherjee wrote:
> On Fri, Mar 22, 2019 at 01:17:58PM +0800, Yifeng Li wrote:
> > @@ -18,9 +18,10 @@ and it was also an inexpensive platform for non-x86 hobbyists to explore.
> >  How to use it?
> >  =======
> >  
> > -You should not compile-in vesafb, since SM7xx can be used in a VGA
> > -compatible mode, resulting conflicts with this driver. In addition,
> > -the VGA compatible mode was never tested by the maintainers.
> > +SM7xx can be used in a VGA compatible mode and a native framebuffer mode,
> > +this driver is a native driver. By default, it has no problem taking over
> > +the VGA driver automatically, but you should not attempt to use both at
> > +the same time.
> 
> You added this in the documentation with just the previous patch.

Oops, this mistake was introduced during "git rebase", it should have been
squashed into the previous patch, not this one. Thanks for spotting it.

> > -	* 2D acceleration on SM720 and Big-Endian CPUs.
> > +	* 2D acceleration on Big-Endian CPUs.
> >  	* More VGA modes.
> >  	* dual-head support
> >  	* hardware cursor support
> 
> You might want to squash the two patches for documentation instead of
> having a separate patch to fix what you added in a previous patch.

Same as above, it will be fixed in PATCH v3.

Thanks,
Tom Li
