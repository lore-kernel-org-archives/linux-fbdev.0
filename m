From: Greg KH <greg@kroah.com>
Subject: Re: fbdev sysfs support.
Date: Fri, 6 Feb 2004 17:28:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040207012841.GG4492@kroah.com>
References: <20040207011916.GD4492@kroah.com> <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Feb 07, 2004 at 01:23:29AM +0000, James Simmons wrote:
> 
> > This function will not get called until the sysfs node stops being busy,
> > so it should all work properly.  But only if that fb_info structure was
> > allocated dynamically, unlike all of the current fb drivers (see my
> > other comment about this patch.)
> > 
> > So in that case, this will cause us to try to call kfree on a static
> > structure :(
> 
> I plan to move every driver to framebuffer_alloc. 

When?  With this patchset?  Or at a later time?  It all needs to be done
at the same time to prevent easy kernel oopses.

thanks,

greg k-h
