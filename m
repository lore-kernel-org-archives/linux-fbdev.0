From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Thu, 04 Feb 2010 09:58:12 +0000
Subject: Re: [RFC] [PATCH] omapfb: Fix 12-bit display (RGB444 color mode)
Message-Id: <1265277492.17836.16.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001142125.45468.jkrzyszt@tis.icnet.pl>
	 <1264670684.2701.216.camel@tubuntu.research.nokia.com>
	 <4B69A292.5050304@tis.icnet.pl>
In-Reply-To: <4B69A292.5050304@tis.icnet.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

On Wed, 2010-02-03 at 17:21 +0100, ext Janusz Krzysztofik wrote:
> Tomi Valkeinen wrote:
> > On Thu, 2010-01-14 at 21:25 +0100, ext Janusz Krzysztofik wrote:
> >> Support for RGB444 (12-bit) pixel format has been introduced into omapfb/lcdc 
> >> by Mark Underwood on 2006-05-26 (commit 
> >> f74edb6668aad9fc8e81585861b18f996c78a574) in preparation for Amstrad Delta 
> >> (E3) videophone LCD display support.
> > 
> > I haven't seen any comments on this. Shall I apply it to my tree?
> > 
> >  Tomi
> 
> Tomi,
> 
> I'm not sure if I am the right person to decide whether my patch should 
> be accepted or not and what tree it should be applied to, but if you are 
> willing to take it than I'm happy.
> 
> BTW, could you also consider taking my other long waiting patch that 
> touches drivers/video/omap: http://patchwork.kernel.org/patch/66649/ ?

Your patch was marked as RFC, so I thought it wasn't the final version.
Both patches seem to apply cleanly to my tree, and look fine to me, so
I'll take them both.

 Tomi


