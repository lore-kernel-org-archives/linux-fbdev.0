From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] add class/video to fb drivers - Take 2
Date: Wed, 20 Aug 2003 14:26:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030820212626.GA4854@kroah.com>
References: <20030820191001.GA4185@kroah.com> <Pine.LNX.4.44.0308202044280.9662-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308202044280.9662-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Aug 20, 2003 at 10:16:13PM +0100, James Simmons wrote:
> 
> > Ok, here's a smaller version of the patch, that doesn't break any fb
> > drivers.  Only those that have a struct device associated with them
> > should be changed (and that's just a 1 line addition).  I think it's
> > much better because of this.
> 
> Nice :-) Will apply tonight. Do you have any issues still with this 
> approach. You talked about the issue of dynamically creating the data. Is 
> this probnlem still present in this patch.

Well, it's not "ideal" but it will do for 2.6 to use this patch.  If you
look at the tty core, it's the same way that currently works.

Ideally in 2.7 I'd like to convert to have all fb drivers create the
fb_info structure dynamically, but that's much to big of a change to do
this late in the 2.6 development cycle.

thanks,

greg k-h
