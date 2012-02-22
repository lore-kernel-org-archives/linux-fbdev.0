From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 18:10:56 +0000
Subject: Re: [PATCH 13/16] OMAP1: pass LCD config with omapfb_set_lcd_config()
Message-Id: <20120222181056.GE18185@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-14-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-14-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> LCD config for old omapfb driver is passed with OMAP_TAG_LCD from board
> files or from the bootloader. In an effort to remove OMAP_TAG_LCD, this
> patch adds omapfb_set_lcd_config() function that the board files can
> call to set the LCD config.
> 
> This has the drawback that configuration can no longer come from the
> bootloader. Of the boards supported by the kernel, this should only
> affect N770 which depends on the data from the bootloader. This patch
> adds an LCD config for N770 to its board files, but that is most
> probably broken. Fixing this would need information about the HW setup
> in N770 boards.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
