From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 16:35:16 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409101635.16803.adaplas@hotpop.com>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com> <1094796002.14398.118.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267248AbUIJIeI@vger.kernel.org>
In-Reply-To: <1094796002.14398.118.camel@gaston>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Friday 10 September 2004 14:00, Benjamin Herrenschmidt wrote:
> On Fri, 2004-09-10 at 15:28, Antonino A. Daplas wrote:
> > If fb_get_options returns an error, drivers will not proceed with their
> > initialization. The second method is more compatible with the
> > previous setup semantics.
> >
> > I told Geert that if the changes did bite us, then I have no choice
> > but to add support for the second method.
> >
> > So, if you think that the first method is not enough, then I will add the
> > second method. Let me know.
>
> I submited a patch moving offb to the bottom of the Makefile to at
> least restore normal drivers. For ofonly, a bit more hackish, but
> what about failing register_framebuffer for anything but offb ?

Yes, that should solve the ofonly problem, with the offb in the very last of 
the Makefile, though as you said, it's a little hackish, but very simple to 
implement.  This will work for ofonly though, since 
info->fix.name is not necessarily equal to "xxxfb".  For instance, offb set 
"OFfb" in info->fix.name, but the boot option is "offb".

After giving it some thought, I think method 2 might be the best since it 
provides compatibility with the old syntax.  Especially if users expect 
video=xxxfb:off to work.  Also, this brings more flexibility in the offchance 
we decide to add more options to "video=".

I'm willing to work on this, but if you don't like it, then I'll do the 'fail 
at register_framebuffer".

Tony
