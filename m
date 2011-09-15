From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Sep 2011 09:18:05 +0000
Subject: Re: How to use backlight device with fb device
Message-Id: <1316078285.1880.55.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316072820.1880.51.camel@deskari>
In-Reply-To: <1316072820.1880.51.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 2011-09-15 at 08:58 +0000, Florian Tobias Schandinat wrote:
> Hi Tomi,
> 
> On 09/15/2011 07:47 AM, Tomi Valkeinen wrote:
> > Hi,
> > 
> > I'm a bit confused how a backlight device and a fb device should be
> > "connected".
> > 
> > In this particular case the OMAP 4430SDP board has an LCD panel
> > controlled by omapfb (and omapdss on the lower level) with a backlight
> > controlled by pwm_backlight (and twl6030-pwm on the lower level).
> > 
> > Both omapfb and pwm_backlight work fine, but they don't know anything
> > about each other, so, for example, blanking the fb via omapfb leaves the
> > backlight on.
> > 
> > Is there something I'm missing, or is the only solution to have some
> > custom code to connect the fb and the bl, and handle it that way?
> 
> I don't know anything about backlight but recently there was a patch that
> affected the same area you mention so it might give an idea
> "[PATCH] FB: add early fb blank feature."
> http://marc.info/?l=linux-fbdev&m1554458720940&w=2

Ah, thanks for pointing that out.

I seem to have dropped from linux-fbdev list and hadn't received that
post. For some reason I seem to get dropped from linux mailing lists,
this is getting a bit frustrating...

 Tomi


