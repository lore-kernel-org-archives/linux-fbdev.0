From: Greg KH <greg@kroah.com>
Subject: Re: FBDEV updates.
Date: Thu, 14 Aug 2003 16:16:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030814231620.GA4632@kroah.com>
References: <Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org> <20030814203658.GE7862@guug.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20030814203658.GE7862@guug.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Otto Solares <solca@guug.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Aug 14, 2003 at 02:36:58PM -0600, Otto Solares wrote:
> 
> Is there an API (or lib) to use framebuffers devices without
> worring about differents visuals?, to quering, setting or
> disabling EDID support? will these drivers export sysfs
> entries instead of control via ioctl's?

I have some initial sysfs patches for the fb code that I've been sitting
on in my trees.  I was waiting for these patches to hit the mainline
before bothering James and the rest of the world with them.

But they don't export any of the ioctl stuff through the sysfs
interface, but that would not be very hard to do at all if you want to.
They just basically show the major/minor of the fb device, and point
back to the proper place in the device tree where the fb device lives,
which is all udev really needs right now.

thanks,

greg k-h
