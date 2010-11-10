From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Nov 2010 12:08:42 +0000
Subject: Re: [PATCH 1/3] OMAP: VRAM: improve VRAM error prints
Message-Id: <20101110120842.GB2120@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com> <20101110115148.GA2120@linux-sh.org> <1289390654.3297.202.camel@tubuntu>
In-Reply-To: <1289390654.3297.202.camel@tubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wed, Nov 10, 2010 at 02:04:14PM +0200, Tomi Valkeinen wrote:
> On Wed, 2010-11-10 at 12:51 +0100, ext Paul Mundt wrote:
> > On Wed, Nov 10, 2010 at 11:45:18AM +0200, Tomi Valkeinen wrote:
> > > Improve the error prints to give more information about the offending
> > > address & size.
> > > 
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > 
> > 1-3 queued for .37, thanks.
> 
> They were just for review =).
> 
> If it's ok to you, I'll pick all OMAP display related patches to my
> tree, and send you a pull request when I think they are ready.
> 
I wasn't sure what your intentions were, but that's of course fine, too!

Please keep an eye on the -rc timing however, so we don't end up with
bigger things piling up in the later -rc stages and then have to start
cherry-picking the urgent bits.

> But for these three patches it's ok if you already queued them: they are
> quite high priority, as the OMAP framebuffer doesn't work at all without
> the second patch.
> 
Right. I looked through the OMAP list archives for some context on these
first and since the second one was at least a build fix I assumed you
wanted to get them merged sooner rather than later.
