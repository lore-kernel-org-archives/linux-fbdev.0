From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 2/7] fbdev: Make fb_find_mode() return failure if modular
Date: Fri, 18 Feb 2005 07:38:31 +0800
Message-ID: <200502180738.31709.adaplas@hotpop.com>
References: <200502172045.16677.adaplas@hotpop.com> <200502180507.32473.adaplas@hotpop.com> <Pine.LNX.4.56.0502172203260.10099@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1vEP-000704-OW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 15:38:49 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1vEP-0003Mc-Bo
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 15:38:49 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8B088E53278
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 23:38:35 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.56.0502172203260.10099@pentafluge.infradead.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@www.infradead.org>
Cc: David Vrabel <dvrabel@arcom.com>

On Friday 18 February 2005 06:09, James Simmons wrote:
> > On Thursday 17 February 2005 22:29, David Vrabel wrote:
> > > Antonino A. Daplas wrote:
> > > > A few drivers call fb_find_mode() even if compiled as a module.  If
> > > > the modedb parameter is NULL, the function will use default modedb
> > > > array which is marked __init. This will cause a crash.  To avoid
> > > > this, check if the driver is compiled as a module, and if it is,
> > > > fail.
> > >
> > > Why limit the default mode DB to built-in drivers only?
> >
> > The default db is used by drivers only once.  After that, it just
> > consumes memory.
>
> For modules it wouldn't be that hard to add the modedb from userland after
> loading. First insmod your module. Normally modular fbdev driver don't set
> the hardware explictly. Once we have sysfs it will be easy. Next send the
> new modes to the db. Next select the mode you want.
>

Yes, also, modedb contains modes from different displays most of which
are unusable.  If you want, you can create a private mode database for your
driver. See how rivafb, savagefb and radeonfb do it.  In fact, all drivers
already have a private modelist, but if not explicitly created, will contain
only one entry, coming from info->var.  Each time you use fbset, the 
mode is automatically added to the modelist.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
