From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 28 Aug 2017 14:41:49 +0000
Subject: Re: [PATCH] fbdev: uvesafb: remove DRIVER_ATTR() usage
Message-Id: <20170828144149.GA28860@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170719125131epcas5p4fed9dd550f3b19744e793831a9a2b1db@epcas5p4.samsung.com>
 <20170719125119.GB17776@kroah.com>
 <3613878.J9SAsAfrTp@amdc3058>
In-Reply-To: <3613878.J9SAsAfrTp@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 01, 2017 at 03:36:01PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, July 19, 2017 02:51:19 PM Greg KH wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > It's better to be explicit and use the DRIVER_ATTR_RW() macro when
> > defining a driver's sysfs file.  Bonus is this fixes up a checkpatch.pl
> > warning.
> > 
> > This is part of a series to drop DRIVER_ATTR() from the tree entirely.
> > 
> > Cc: Michal Januszewski <spock@gentoo.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> I assume that this will go through your tree with other DRIVER_ATTR()
> removal patches (please ping me if you want me to merge this patch
> through fbdev tree).

I'll take it through mine, thanks.

greg k-h
