From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Date: Wed, 9 Mar 2005 12:38:42 +0100
Message-ID: <20050309113842.GB30119@elf.ucw.cz>
References: <20050308015731.GA26249@spock.one.pl> <Pine.LNX.4.56.0503081945510.15646@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0503081945510.15646@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi!

> > Fbsplash - The Framebuffer Splash - is a feature that allows displaying
> > images in the background of consoles that use fbcon. The project is
> > partially descended from bootsplash. 
> 
> What are you trying to do exactly? I really don't see the point of this 
> patch.

At least some Debians, Gentoo and SUSE each use some variant of this
eye candy; each one with different bugs. It would be nice to at least
do the splash right (so that it does not require vesafb and therefore
allows working with suspend-to-RAM).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
