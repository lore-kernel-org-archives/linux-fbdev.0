From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdev sysfs support.
Date: Sat, 7 Feb 2004 01:23:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
References: <20040207011916.GD4492@kroah.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040207011916.GD4492@kroah.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> This function will not get called until the sysfs node stops being busy,
> so it should all work properly.  But only if that fb_info structure was
> allocated dynamically, unlike all of the current fb drivers (see my
> other comment about this patch.)
> 
> So in that case, this will cause us to try to call kfree on a static
> structure :(

I plan to move every driver to framebuffer_alloc. 
