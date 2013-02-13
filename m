From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Wed, 13 Feb 2013 17:29:13 +0000
Subject: Re: [PATCH 16/33] OMAPDSS: acx565akm panel: handle gpios in panel driver
Message-Id: <20130213172913.GD21750@blackmetal.musicnaut.iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
 <1360765345-19312-17-git-send-email-archit@ti.com>
In-Reply-To: <1360765345-19312-17-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Wed, Feb 13, 2013 at 07:52:08PM +0530, Archit Taneja wrote:
> +static struct panel_acx565akm_data *get_panel_data(struct omap_dss_device *dssdev)
> +{
> +	return (struct panel_acx565akm_data *) dssdev->data;
> +}
> +
>  static int acx_panel_probe(struct omap_dss_device *dssdev)
>  {
>  	int r;
>  	struct acx565akm_device *md = &acx_dev;
> +	struct panel_acx565akm_data *panel_data = get_panel_data(dssdev);

Why the get_panel_data function is needed, isn't the cast unnecessary?

A.
