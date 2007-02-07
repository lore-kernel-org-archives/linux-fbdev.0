From: Ben Dooks <ben@fluff.org>
Subject: Re: [PATCH] mfd: SM501 core driver
Date: Wed, 7 Feb 2007 15:29:47 +0000
Message-ID: <20070207152947.GB21120@fluff.org.uk>
References: <20070206192628.GA13644@fluff.org.uk> <20070206210930.fc814bf6.akpm@linux-foundation.org> <20070207114825.GA21120@fluff.org.uk> <20070207142415.GE1712@kroah.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030630AbXBGPaH@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070207142415.GE1712@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, Feb 07, 2007 at 06:24:15AM -0800, Greg KH wrote:
> On Wed, Feb 07, 2007 at 11:48:25AM +0000, Ben Dooks wrote:
> > On Tue, Feb 06, 2007 at 09:09:30PM -0800, Andrew Morton wrote:
> > > On Tue, 6 Feb 2007 19:26:28 +0000 Ben Dooks <ben-linux@fluff.org> wrote:
> > > > +/* sm501_null_release
> > > > + *
> > > > + * A release function for the platform devices we create to keep the
> > > > + * driver core happy, and stop any crashed when the devices are removed
> > > > +*/
> > > > +
> > > > +static void sm501_null_release(struct device *dev)
> > > > +{
> > > > +}
> > > 
> > > Greg might have an opinion on that ;)
> > 
> > Without this the system OOPses when the driver is removed.
> 
> Are you sure about that?  And it's not just an error message being
> printed out telling you that you must provide a release function?
> 
> And BIG hint, providing an empty release function just to shut up the
> kernel is NOT a fix.  You really need to free your memory here, not just
> ignore it.

Sorry, you where right, confused OOPS and backtrace from call to
BUG(). I also realise that having earlier changed from carrying
the devices pre-allocated in the per-device data, to kmalloc pool
that we do need to free the device data on release. I will fix for
the next release.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
