From: James Simmons <jsimmons@infradead.org>
Date: Tue, 06 Jul 2010 15:28:59 +0000
Subject: Re: Re: [PATCH v1 2/2] S5PV210: Add MIPI-DSI Driver.
Message-Id: <alpine.LFD.2.00.1007061628270.3285@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1007061627350.3285@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1007061627350.3285@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi, Guennadi,

You mean is that it uses include/video/mipi_display.h file instead of plat/dsim.h?
I cann't find mipi_display.h in mainline kernel.

otherwise, it creates generic parts of my dsim.h header file as mipi_display.h and
use that header file?

Please, give me more detailed.

Thank you.

------- Original Message -------
Sender : Guennadi Liakhovetski<g.liakhovetski@gmx.de> 
Date   : 2010-07-05 04:33 (GMT+09:00)
Title  : Re: [PATCH v1 2/2] S5PV210: Add MIPI-DSI Driver.

On Sat, 3 Jul 2010, InKi Dae wrote:

> this patch addes MIPI-DSI Driver.
> 
> to use this driver, some structures below should be added to machine
> specific file.
> 
> struct dsim_config
> - define clock info, data lane count and video mode info for MIPI-DSI
> Controller.
> 
> struct dsim_lcd_config
> - define interface mode, channel ID, Pixel format and so on.
> 
> struct s5p_platform_dsim
> - define callbacks for initializing D-PHY, MIPI reset and trigger
> releated interfaces of s3c-fb.c file.
> 
> struct mipi_ddi_platform_data
> - define following callbacks.
> - a function for transferring and receiving command data to mipi based
> lcd panel.
> - a function for getting framedone status of mipi-dsi controller.
> - a function for clearing framedone interrupt of mipi-dsi controller.
> - a function for checking i80 framedone status of display controller.(fimd)
> - a function for triggering to display controller.(fimd)
> 
> Signed-off-by: InKi Dae <inki.dae@samsung.com <mailto:p.osciak@samsung.com>>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com
> <mailto:kyungmin.park@samsung.com>>
> ---
> 
> diff --git a/arch/arm/plat-samsung/include/plat/dsim.h b/arch/arm/plat-samsung/include/plat/dsim.h
> new file mode 100644
> index 0000000..49d8946
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/dsim.h
> @@ -0,0 +1,493 @@

[snip]

> +enum dsim_fifo_state {
> +	DSIM_RX_DATA_FULL = (1 << 25),
> +	DSIM_RX_DATA_EMPTY = (1 << 24),
> +	SFR_HEADER_FULL = (1 << 23),
> +	SFR_HEADER_EMPTY = (1 << 22),
> +	SFR_PAYLOAD_FULL = (1 << 21),
> +	SFR_PAYLOAD_EMPTY = (1 << 20),
> +	I80_HEADER_FULL = (1 << 19),
> +	I80_HEADER_EMPTY = (1 << 18),
> +	I80_PALOAD_FULL = (1 << 17),
> +	I80_PALOAD_EMPTY = (1 << 16),
> +	SUB_DISP_HEADER_FULL = (1 << 15),
> +	SUB_DISP_HEADER_EMPTY = (1 << 14),
> +	SUB_DISP_PAYLOAD_FULL = (1 << 13),
> +	SUB_DISP_PAYLOAD_EMPTY = (1 << 12),
> +	MAIN_DISP_HEADER_FULL = (1 << 11),
> +	MAIN_DISP_HEADER_EMPTY = (1 << 10),
> +	MAIN_DISP_PAYLOAD_FULL = (1 << 9),
> +	MAIN_DISP_PAYLOAD_EMPTY = (1 << 8),
> +};

Please use include/video/mipi_display.h for these transaction types and, 
possibly, for other generic MIPI DSI defines.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

