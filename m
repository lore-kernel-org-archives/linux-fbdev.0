From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [BK updates] fbdev changes updates.
Date: Tue, 29 Oct 2002 21:18:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021029211800.A2806@infradead.org>
References: <20021029205529.A2145@infradead.org> <Pine.LNX.4.33.0210291408110.1363-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210291408110.1363-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Tue, Oct 29, 2002 at 02:08:37PM -0800
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@transmeta.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Oct 29, 2002 at 02:08:37PM -0800, James Simmons wrote:
> 
> > On Tue, Oct 29, 2002 at 12:46:16PM -0800, James Simmons wrote:
> > >
> > > OOps. Forgot the link.
> > >
> > > bk://fbdev.bkbits.net/fbdev-2.5
> >
> > Does it still contain the random file movearounds?
> 
> The reason I did this was to prevent adding another chuck of agp code. The
> current work around for AGP fbdev drivers to have there OWN AGP code. So
> we can leave the agp drivers where they are at or the framebuffer layer
> can have its own AGP code for itself. Which way do you think it should be
> done?
> 
> 1) Fbdev layer has it own AGP layer
> 
> 2) Use already existing AGP layer code.

Well, I'd be very happy if you could separate different things abit.
Everyone wants the console fixes in, but code placement is a bit more of a
policy issue and wants more discussion..  Even when they are in different
directories the drm drivers can always call into the fbdev drivers as "base
modules", like sis currently does.
