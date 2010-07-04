From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v1 2/2] S5PV210: Add MIPI-DSI Driver.
Date: Sun, 4 Jul 2010 21:33:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1007042128390.1131@axis700.grange>
References: <4C29AF72.6090200@samsung.com> <4C29C766.7010901@samsung.com>
	<4C2DA889.5010809@samsung.com> <4C2EF7F1.7010309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C2EF7F1.7010309@samsung.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: InKi Dae <inki.dae@samsung.com>
Cc: kmpark@infradead.org, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org

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
