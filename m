From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: fb layer & ioremap_wc
Date: Mon, 5 May 2008 12:04:48 -0700
Message-ID: <200805051204.49135.jesse.barnes@intel.com>
References: <200805022122.03576.elendil@planet.nl> <200805051045.31026.jesse.barnes@intel.com> <200805052059.01535.elendil@planet.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763942AbYEETGa@vger.kernel.org>
In-Reply-To: <200805052059.01535.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Frans Pop <elendil@planet.nl>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, "Packard, Keith" <keith.packard@intel.com>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On Monday, May 05, 2008 11:59 am Frans Pop wrote:
> On Monday 05 May 2008, you wrote:
> > On Monday, May 05, 2008 10:32 am Frans Pop wrote:
> > > I suspect it could be vesafb/fbcon related instead. Normally I boot my
> > > system with 'quiet vga=791', i.e. with vesafb. I then see the
> > > artifacts.
> > >
> > > When I boot without 'vga=791', I hit another, unrelated regression
> > > (which I'll report separately) [1].
> > >
> > > When I boot with 'video=vfb:off', I do _not_ get the artifacts when X
> > > exits.
> >
> > Ahhh, I missed that part of your config.  That could definitely have an
> > effect on things...  You'll probably want something like the attached
>
> Not sure what to make of this.
> With your patch I still get the artifacts, but they are displayed a lot
> shorter. I get only a flash instead of a-2 seconds.

Hm, so I guess some other user is still using UC on the region.  [Note to fb 
list:  the patch just made vesafb use ioremap_wc instead of ioremap).

> > (there are other places in the fb layer that want similar treatment,
> > iirc, maybe fb_pgprotect?).
>
> Do you want to try a more complete review/patch or should this be punted
> over to the framebuffer folks?

Yeah, those bits have changed since I last looked at them, hopefully the fb 
guys can help.

Jesse
