From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [announce 0/7] fbsplash - The Framebuffer
 Splash
Date: Wed, 9 Mar 2005 20:45:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
References: <20050308015731.GA26249@spock.one.pl>  <200503091301.15832.adaplas@hotpop.com>
  <9e473391050308220218cc26a3@mail.gmail.com>  <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
 <1110392212.3116.215.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D983i-0000JA-Qb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 12:45:34 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D983h-00064L-DA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 12:45:34 -0800
In-Reply-To: <1110392212.3116.215.camel@localhost.localdomain>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Michal Januszewski <spock@gentoo.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>


> On Mer, 2005-03-09 at 09:34, Geert Uytterhoeven wrote:
> > On Wed, 9 Mar 2005, Jon Smirl wrote:
> > > Another idea would be to build a console is user space. Think of it as
> > > a full screen xterm. A user space console has access to full hardware
> > > acceleration using the DRM interface.
> > 
> > Yep. And that's what Alan Cox wanted to do. Console in userspace, eye candy
> > (using Porter-Duff blending) as much as you want, full UTF-8 support, ...
> 
> Jon is the origin of those ideas not me, I'm merely supporting them
> providing there is still a basic kernel side console.

Thank you. We need some kind of basic console in the kernel. I'm not the 
biggest fan of eye candy. So moving the console to userspace for eye candy 
is a dumb idea.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
