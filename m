From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 18:08:06 +0000
Subject: Re: [PATCH 06/16] OMAP: N770: remove HWA742 platform data
Message-Id: <20120222180806.GA18185@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-7-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-7-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> In an effort to clean up the old omapfb driver, this patch removes
> HWA742 (the display chip used in N770) platform data. This can be done
> as N770 is the only user of HWA742, and the platform data contains only
> one field, te_connected, which we can just presume to be true in the
> HWA742 driver.
> 
> This allows us to remove omapfb_set_ctrl_platform_data(), and the
> mechanism to pass the platform data, in a later patch.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
