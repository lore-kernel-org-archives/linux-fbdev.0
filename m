From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] add class/video to fb drivers - Take 2
Date: Wed, 20 Aug 2003 14:33:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030820213331.GA4894@kroah.com>
References: <20030820212626.GA4854@kroah.com> <Pine.LNX.4.44.0308202227490.9662-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308202227490.9662-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Aug 20, 2003 at 10:28:28PM +0100, James Simmons wrote:
> 
> > Well, it's not "ideal" but it will do for 2.6 to use this patch.  If you
> > look at the tty core, it's the same way that currently works.
> > 
> > Ideally in 2.7 I'd like to convert to have all fb drivers create the
> > fb_info structure dynamically, but that's much to big of a change to do
> > this late in the 2.6 development cycle.
> 
> What is the advantage of creating every fb_info dynamically?

Then we can add a struct class_device into fb_info, which will allow us
to export sysfs attributes for each fb_info device to userspace.  It
will provide the proper lifetime rules for such structures, and allow
the individual drivers a place within sysfs to export different things
they might want to export.  Any /proc files you currently have could
then be removed.

For an example of what needs to be done, see the recent v4l core changes
that were just introduced into the kernel tree.

Again, this is a 2.7 thing (which could easily be backported to 2.6.late
afterwards), nothing I want to attempt to do at this time.

thanks,

greg k-h
