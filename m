From: Kronos <kronos@people.it>
Subject: Re: Framebuffer and non-PCI devices
Date: Sun, 20 Feb 2005 01:05:19 +0100
Message-ID: <20050220000519.GA7543@dreamland.darkstar.lan>
References: <9e47339105021910257461d4cc@mail.gmail.com> <Pine.LNX.4.62.0502191937500.3355@numbat.sonytel.be> <9e473391050219135923cc6455@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2ebL-0005zU-TA
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 16:05:31 -0800
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2ebI-0005AM-6m
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 16:05:31 -0800
Received: from dreamland.darkstar.lan (84.222.35.59) by mail-relay-1.tiscali.it (7.1.021.3)
        id 4202030C00296A3B for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Feb 2005 01:05:16 +0100
Content-Disposition: inline
In-Reply-To: <9e473391050219135923cc6455@mail.gmail.com>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Il Sat, Feb 19, 2005 at 04:59:46PM -0500, Jon Smirl ha scritto: 
> I started editing all of the drivers to make assigning fb_info->device
> explicit.  Does this look like it is useful?

Look at framebuffer_alloc ;)

Luca
-- 
Home: http://kronoz.cjb.net
Windows NT: Designed for the Internet. The Internet: Designed for Unix.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
