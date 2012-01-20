From: Tony Lindgren <tony@atomide.com>
Date: Fri, 20 Jan 2012 14:49:18 +0000
Subject: Re: [PATCH 0/6] OMAPDSS: HDMI PHY burnout fix
Message-Id: <20120120144918.GM22818@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com, archit@ti.com, x0132446@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120117 04:16]:
> The main patch in this set is the last one, which implements a fix for the HW
> bug on OMAP4 which causes physical damage to the board if the HDMI cable is not
> connected but HDMI output is enabled.
> 
> The preceding patches are small cleanups/fixes for HDMI GPIOs so that the fix
> can be implemented.
> 
> Note that I haven't gotten a confirmation that using LDO_ON for the HDMI PHY
> power fixes the issue. So whether the fix works or not is unclear.

Feel free to merge via fb tree. For the arch/arm/*omap*/* parts:

Acked-by: Tony Lindgren <tony@atomide.com>
