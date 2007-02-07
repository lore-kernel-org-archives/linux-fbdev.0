From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] mfd: SM501 core driver
Date: Wed, 7 Feb 2007 06:24:15 -0800
Message-ID: <20070207142415.GE1712@kroah.com>
References: <20070206192628.GA13644@fluff.org.uk> <20070206210930.fc814bf6.akpm@linux-foundation.org> <20070207114825.GA21120@fluff.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161334AbXBGOZ3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070207114825.GA21120@fluff.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-linux@fluff.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, Feb 07, 2007 at 11:48:25AM +0000, Ben Dooks wrote:
> On Tue, Feb 06, 2007 at 09:09:30PM -0800, Andrew Morton wrote:
> > On Tue, 6 Feb 2007 19:26:28 +0000 Ben Dooks <ben-linux@fluff.org> wrote:
> > > +/* sm501_null_release
> > > + *
> > > + * A release function for the platform devices we create to keep the
> > > + * driver core happy, and stop any crashed when the devices are removed
> > > +*/
> > > +
> > > +static void sm501_null_release(struct device *dev)
> > > +{
> > > +}
> > 
> > Greg might have an opinion on that ;)
> 
> Without this the system OOPses when the driver is removed.

Are you sure about that?  And it's not just an error message being
printed out telling you that you must provide a release function?

And BIG hint, providing an empty release function just to shut up the
kernel is NOT a fix.  You really need to free your memory here, not just
ignore it.

thanks,

greg k-h
