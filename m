From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [announce 0/7] fbsplash - The Framebuffer
 Splash
Date: Tue, 15 Mar 2005 18:58:08 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503151855430.5506@pentafluge.infradead.org>
References: <20050308015731.GA26249@spock.one.pl>  <200503091301.15832.adaplas@hotpop.com>
  <9e473391050308220218cc26a3@mail.gmail.com>  <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
  <1110392212.3116.215.camel@localhost.localdomain> 
 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org> 
 <1110408049.9942.275.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>  <20050310145419.GD632@openzaurus.ucw.cz>
  <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
 <9e473391050311101356536667@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBHFD-0002Pu-Nv
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 10:58:19 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DBHFB-0006Rq-0D
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 10:58:19 -0800
In-Reply-To: <9e473391050311101356536667@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Simmons <jsimmons@pentafluge.infradead.org>, Michal Januszewski <spock@gentoo.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>


> > Why do we need patches in the kernel. Just set you config to
> > CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or
> > vgacon. Then have a userspace app using /dev/fb and /dev/input create a
> > userland console. There is no need to do special hacks in the kernel.
> 
> /dev/fb is not accelerated, if you want full acceleration use
> /dev/dri. Using /dev/dri you can write a fully composited console that
> displays dengavi in realtime. This is also a path to getting multiuser
> working without a lot of kernel patches.

Not every device has a 3D core!!! DRM is not the answer for the entire graphics
world. Its only for 3D functionality. If you want eye candy without 3D on small
devices use fbdev. 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
