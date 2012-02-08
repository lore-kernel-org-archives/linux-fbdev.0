From: Tony Lindgren <tony@atomide.com>
Date: Wed, 08 Feb 2012 19:06:01 +0000
Subject: Re: [PATCH 00/16] rmk's patch series for fixing OMAP
Message-Id: <20120208190601.GQ29796@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:05]:
> This is my set of patches for fixing OMAP for v3.3.
> 
> This is the complete series of patches I'm currently applying to _my_
> tree to get v3.3-rc2 into a usable and sane state.

I've acked all but two. The if (1) hack must have some better
solution, then I'd like to see Paul's ack on the error formatting
patch.

Other than that go for it. Thanks for the nice series, too bad
these were not found earlier.

> I want to see most of the problems uncovered in this series fixed sooner
> rather than later, and certainly not taking three plus weeks to get into
> mainline like this rather serious looking commit did:
> 
> commit c49d005b6cc8491fad5b24f82805be2d6bcbd3dd
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Tue Jan 17 11:09:57 2012 +0200
> 
>     OMAPDSS: HDMI: PHY burnout fix
>     
>     A hardware bug in the OMAP4 HDMI PHY causes physical damage to the board
>     if the HDMI PHY is kept powered on when the cable is not connected.
> 
> which now has me wondering if, by trying to boot v3.3-rc2 on this board
> during the past week, I have a destroyed HDMI interface on it.
> 
> So, a big thanks for sitting on that fix and exposing peoples hardware
> to damage, that shows real professionalism.

Not good.

Tony
