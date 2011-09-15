From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 15 Sep 2011 08:58:20 +0000
Subject: Re: How to use backlight device with fb device
Message-Id: <4E71BE2C.4020807@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316072820.1880.51.camel@deskari>
In-Reply-To: <1316072820.1880.51.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

On 09/15/2011 07:47 AM, Tomi Valkeinen wrote:
> Hi,
> 
> I'm a bit confused how a backlight device and a fb device should be
> "connected".
> 
> In this particular case the OMAP 4430SDP board has an LCD panel
> controlled by omapfb (and omapdss on the lower level) with a backlight
> controlled by pwm_backlight (and twl6030-pwm on the lower level).
> 
> Both omapfb and pwm_backlight work fine, but they don't know anything
> about each other, so, for example, blanking the fb via omapfb leaves the
> backlight on.
> 
> Is there something I'm missing, or is the only solution to have some
> custom code to connect the fb and the bl, and handle it that way?

I don't know anything about backlight but recently there was a patch that
affected the same area you mention so it might give an idea
"[PATCH] FB: add early fb blank feature."
http://marc.info/?l=linux-fbdev&m1554458720940&w=2


Best regards,

Florian Tobias Schandinat

> 
>  Tomi
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

