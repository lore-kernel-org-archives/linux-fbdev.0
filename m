From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH 2/7] fbdev: Make fb_find_mode() return
 failure if modular
Date: Thu, 17 Feb 2005 22:09:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502172203260.10099@pentafluge.infradead.org>
References: <200502172045.16677.adaplas@hotpop.com> <4214AA55.3000006@arcom.com>
 <200502180507.32473.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1tpv-0001J1-R5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 14:09:27 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1tpv-0005gK-66
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 14:09:27 -0800
In-Reply-To: <200502180507.32473.adaplas@hotpop.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: David Vrabel <dvrabel@arcom.com>


> On Thursday 17 February 2005 22:29, David Vrabel wrote:
> > Antonino A. Daplas wrote:
> > > A few drivers call fb_find_mode() even if compiled as a module.  If the
> > > modedb parameter is NULL, the function will use default modedb array
> > > which is marked __init. This will cause a crash.  To avoid this, check if
> > > the driver is compiled as a module, and if it is, fail.
> >
> > Why limit the default mode DB to built-in drivers only?
> 
> The default db is used by drivers only once.  After that, it just consumes
> memory.

For modules it wouldn't be that hard to add the modedb from userland after 
loading. First insmod your module. Normally modular fbdev driver don't set 
the hardware explictly. Once we have sysfs it will be easy. Next send the 
new modes to the db. Next select the mode you want. 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
