From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [announce 0/7] fbsplash - The Framebuffer Splash
Date: Fri, 11 Mar 2005 13:13:37 -0500
Message-ID: <9e473391050311101356536667@mail.gmail.com>
References: <20050308015731.GA26249@spock.one.pl>
	 <200503091301.15832.adaplas@hotpop.com>
	 <9e473391050308220218cc26a3@mail.gmail.com>
	 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
	 <1110392212.3116.215.camel@localhost.localdomain>
	 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
	 <1110408049.9942.275.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
	 <20050310145419.GD632@openzaurus.ucw.cz>
	 <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9odn-0004Xd-He
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 10:13:39 -0800
Received: from rproxy.gmail.com ([64.233.170.206])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9odm-0007AO-4V
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 10:13:39 -0800
Received: by rproxy.gmail.com with SMTP id i8so923865rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Mar 2005 10:13:37 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Simmons <jsimmons@pentafluge.infradead.org>, Michal Januszewski <spock@gentoo.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Fri, 11 Mar 2005 18:03:20 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> > > > Thats why moving the eye candy console into user space is such a good
> > > > idea. You don't have to run it 8) It also means that the console
> > > > development is accessible to all the crazy rasterman types.
> > >
> > > Yep. The basic console we already have. Everyone who wants eye candy can switch
> > > from basic console to user space console in early userspace.
> > >
> >
> > Heh, I'm afraid it does not work like that. Anyone who wants eye-candy
> > simply applies broken patch to their kernel... unless their distribution applied one
> > already.
> >
> > Situation where we have one working eye-candy patch would certainly
> > be an improvement.
> 
> Why do we need patches in the kernel. Just set you config to
> CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or
> vgacon. Then have a userspace app using /dev/fb and /dev/input create a
> userland console. There is no need to do special hacks in the kernel.

/dev/fb is not accelerated, if you want full acceleration use
/dev/dri. Using /dev/dri you can write a fully composited console that
displays dengavi in realtime. This is also a path to getting multiuser
working without a lot of kernel patches.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
