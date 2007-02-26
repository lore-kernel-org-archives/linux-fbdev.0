From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Tue, 27 Feb 2007 01:24:14 +0800
Message-ID: <1172510654.7101.11.camel@daplas>
References: <20070226144744.GA3615@DervishD>
	 <1172503471.20842.14.camel@daplas>  <20070226171334.GB13496@DervishD>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030353AbXBZRWH@vger.kernel.org>
In-Reply-To: <20070226171334.GB13496@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: DervishD <lkml@dervishd.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2007-02-26 at 18:13 +0100, DervishD wrote:
>     Hi Antonino :)
> 
>  * Antonino A. Daplas <adaplas@gmail.com> dixit:
> > On Mon, 2007-02-26 at 15:47 +0100, DervishD wrote:
> > >     From time to time, the tdfxfb driver from 2.6.19.5 (sorry, I cannot
> > > test in 2.6.20.x because it doesn't compile, the infamous BDF negative
> > > offset problem) garbles the display, leaving only a lot of thin lines,
> > > just like sync was lost. The display can be repaired by switching to
> > > another console, but this is annoying. This happens with a Voodoo 3
> > > 3000, using 800x600x8@100 mode.
> > 
> > Try fbset -a -vyres 600 first and let us know of the result.
> 
>     After doing this, I no longer can garble the display (before, just a
> "ls -lR /" was enough to do it, in fact, any big output garbled the
> display). The only problem with this solution is that the scroll speed
> has decreased a bit. In fact, the scroll speed is affected by the vyres
> parameter a lot! The highter the vyres, the faster the scroll, and I
> cannot reproduce the problem anymore after changing it once!

Display panning is what makes scrolling fast which is the default scroll
method if vyres > yres.  Unfortunately, tdfxfb occasionally have
problems with this method, the higher the vyres, the greater the
likelihood of screen corruption. That's why tdfxb limits the vyres to a
maximum of 4096. As to why the problem disappeared just by changing this
parameter, that I too don't know.

Tony
