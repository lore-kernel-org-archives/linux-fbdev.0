From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: XGL/mesa-solo and fbdev
Date: Tue, 22 Feb 2005 17:31:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502221723230.30102@pentafluge.infradead.org>
References: <9e47339105022111483136bd56@mail.gmail.com> <1109056956.5412.107.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3dt8-0000EF-NV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 09:31:58 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3dt8-0000Vq-0W
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 09:31:58 -0800
In-Reply-To: <1109056956.5412.107.camel@gaston>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Jon Smirl <jonsmirl@gmail.com>


> Finishing that in the next month or so is extremely optimist :)

Try 5 to 10 years with us working in our spare time. It toke the input api 
years to go in. The new fbdev system I worked on is the same way. I 
started that code in 1999. 6 years and it still is not finished !!!!!! 
Writing code in your spare time for free just doesn't work.

> The first step is putting fbdev's and DRM driver together. I think it's
> worth doing a stub right now rather than hacking radeonfb and the radeon
> DRM together, because all other PCI card drivers at least will have the
> same issues, and for various reasons, you may wnat to only use "half" of
> it (that is not use the fbdev side or not use the DRM side), at least
> for a while. (radeonfb doesn't always work 100% on all x86's)
> 
> The second step is to add video memory management & arbitration.
> 
> The third step is to add missing "features" like dual head etc.... and
> the appropriate fbdev API changes to do it properly.

Forget it. Lets just work around the problems we have now. Attempting to 
solve these kinds of problems will take so many years it is not worth it.
I personally realized it is not the worth the effort to do this. Just make 
it work!!!



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
