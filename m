From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: fbdev sysfs support.
Date: Sat, 7 Feb 2004 01:24:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040207012402.GT21151@parcelfarce.linux.theplanet.co.uk>
References: <20040207005954.GB4492@kroah.com> <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org> <20040207011544.GC4492@kroah.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040207011544.GC4492@kroah.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: James Simmons <jsimmons@infradead.org>, Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Feb 06, 2004 at 05:15:44PM -0800, Greg KH wrote:
> On Sat, Feb 07, 2004 at 01:01:35AM +0000, James Simmons wrote:
> > diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
> > --- linus-2.6/drivers/video/fbmem.c	2004-01-27 19:48:11.000000000 -0800
> > +++ fbdev-2.6/drivers/video/fbmem.c	2004-02-06 03:45:53.000000000 -0800
> > @@ -1228,6 +1228,9 @@
> >  			break;
> >  	fb_info->node = i;
> >  	
> > +	if (fb_add_class_device(fb_info))
> > +		return -EINVAL;
> > +	
> 
> Woah, what about all of the fb drivers that statically allocate their
> fb_info structure?  This will die a horrible death for them when they
> try to unload themselves.
> 
> Are you going to fix up every fb driver to call framebuffer_alloc() to
> fix this problem?  That's quite a task...

Netdev mess, mk.II...
