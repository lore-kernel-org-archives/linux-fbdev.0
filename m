From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 02 Mar 2011 07:58:49 +0000
Subject: Re: [PATCH] omapfb: Fix linker error in
Message-Id: <1299052729.2226.44.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298905757.9809.135.camel@deskari>
	 <1298968837-13584-1-git-send-email-jhnikula@gmail.com>
In-Reply-To: <1298968837-13584-1-git-send-email-jhnikula@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-01 at 02:40 -0600, Jarkko Nikula wrote:
> There is a linker error from lcd_2430sdp.c if CONFIG_TWL4030_CORE is not
> set. This can be triggered on OMAP2 builds when OMAP3 or OMAP4 are not set.
> 
> drivers/built-in.o: In function `sdp2430_panel_disable':
> drivers/video/omap/lcd_2430sdp.c:123: undefined reference to `twl_i2c_write_u8'
> drivers/video/omap/lcd_2430sdp.c:124: undefined reference to `twl_i2c_write_u8'
> drivers/built-in.o: In function `sdp2430_panel_enable':
> drivers/video/omap/lcd_2430sdp.c:110: undefined reference to `twl_i2c_write_u8'
> drivers/video/omap/lcd_2430sdp.c:112: undefined reference to `twl_i2c_write_u8'
> 
> Fix this by selecting the TWL4030_CORE for MACH_OMAP_2430SDP when building
> with CONFIG_FB_OMAP as there is no own Kconfig entry for lcd_2430 and it is
> compiled always when both MACH_OMAP_2430SDP and FB_OMAP are set.

Thanks, applied.

 Tomi


