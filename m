From: Florian Vaussard <florian.vaussard@epfl.ch>
Date: Fri, 06 Dec 2013 10:18:58 +0000
Subject: Re: [PATCH 17/26] ARM: omap3-tobi.dts: add lcd (TEST)
Message-Id: <52A1A492.8090205@epfl.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-18-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1386160133-24026-18-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

Hello Tomi,

On 12/04/2013 01:28 PM, Tomi Valkeinen wrote:
> This is a test for Overo with Palo43 expansion, _not_ Tobi. Palo43
> doesn't have a dts, but seems to work ok with omap3-tobi.dts, so I used
> it as a test.
> 

Looking at the schematics, both seem pretty similar indeed. The main
difference seems to be the LCD on the palo43, and the HDMI on the Tobi
(TFP410, as in your patch 21).

I only have a Tobi on my desk, so this is the reason for not supporting
other boards... We could make a .dtsi with common stuff, then add the
LCD to the Palo43 and HDMI to the Tobi. I was going to add some more
support to these boards in the coming days, so I can add this too, at
least for testing purpose.

Cheers,

Florian
