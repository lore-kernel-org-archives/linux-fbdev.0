From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
	Splash
Date: Wed, 09 Mar 2005 18:16:53 +0000
Message-ID: <1110392212.3116.215.camel@localhost.localdomain>
References: <20050308015731.GA26249@spock.one.pl>
	 <200503091301.15832.adaplas@hotpop.com>
	 <9e473391050308220218cc26a3@mail.gmail.com>
	 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Michal Januszewski <spock@gentoo.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Mer, 2005-03-09 at 09:34, Geert Uytterhoeven wrote:
> On Wed, 9 Mar 2005, Jon Smirl wrote:
> > Another idea would be to build a console is user space. Think of it as
> > a full screen xterm. A user space console has access to full hardware
> > acceleration using the DRM interface.
> 
> Yep. And that's what Alan Cox wanted to do. Console in userspace, eye candy
> (using Porter-Duff blending) as much as you want, full UTF-8 support, ...

Jon is the origin of those ideas not me, I'm merely supporting them
providing there is still a basic kernel side console.

Alan
