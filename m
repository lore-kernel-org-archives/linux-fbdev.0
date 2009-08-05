From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/15] OMAP: Overo: Enable DSS2 for Overo
Date: Wed, 5 Aug 2009 17:44:36 +0300
Message-ID: <20090805144436.GO7374@atomide.com>
References: <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-8-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-9-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-11-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-12-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-13-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-14-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-15-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-16-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249481741-14008-16-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [090805 17:19]:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  arch/arm/configs/overo_defconfig  |  265 ++++++++-----------------------------
>  arch/arm/mach-omap2/board-overo.c |  149 +++++++++++++++++++--
>  2 files changed, 196 insertions(+), 218 deletions(-)
> 

<snip snip>

> +static struct omap_dss_device overo_dvi_device = {
> +	.type = OMAP_DISPLAY_TYPE_DPI,
> +	.name = "dvi",
> +	.driver_name = "generic_panel",
> +	.phy.dpi.data_lines = 24,
> +	.platform_enable = overo_panel_enable_dvi,
> +	.platform_disable = overo_panel_disable_dvi,
> +};
...

Please check the tabbing here too. Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
