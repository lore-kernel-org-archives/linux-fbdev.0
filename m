From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: fbdev sysfs support.
Date: Sat, 7 Feb 2004 01:22:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040207012250.GS21151@parcelfarce.linux.theplanet.co.uk>
References: <20040207005954.GB4492@kroah.com> <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org> <20040207011047.GR21151@parcelfarce.linux.theplanet.co.uk> <20040207011916.GD4492@kroah.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040207011916.GD4492@kroah.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: James Simmons <jsimmons@infradead.org>, Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Feb 06, 2004 at 05:19:16PM -0800, Greg KH wrote:
> On Sat, Feb 07, 2004 at 01:10:48AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Sat, Feb 07, 2004 at 01:01:35AM +0000, James Simmons wrote:
> > > +static void release_fb_info(struct class_device *class_dev)
> > > +{
> > > +	struct fb_info *info = to_fb_info(class_dev);
> > > +
> > > +	/* This doesn't harm */
> > > +	fb_dealloc_cmap(&info->cmap);
> > > +
> > > +	kfree(info);
> > > +}
> > 
> > So what has happens when we hit existing kfree() on fb_info while sysfs
> > node is busy?
> 
> This function will not get called until the sysfs node stops being busy,
> so it should all work properly.  But only if that fb_info structure was
> allocated dynamically, unlike all of the current fb drivers (see my
> other comment about this patch.)

This function will not.  Already existing kfree() in the drivers, OTOH, will. 
