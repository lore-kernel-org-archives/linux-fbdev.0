From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 26 Feb 2014 08:39:03 +0000
Subject: Re: [RFC PATCH 0/5] Move IPUv3 core out of staging, add CSI support
Message-Id: <20140226083903.GM26722@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387561966-31758-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1387561966-31758-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org


Please fix the following static checker complaints before moving out of
staging:

drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c:164 ipu_dmfc_setup_channel() warn: variable dereferenced before check 'dmfc' (see line 157)
drivers/staging/imx-drm/imx-ldb.c:109 imx_ldb_connector_get_modes() error: potential null dereference 'mode'.  (drm_mode_create returns null)
drivers/staging/imx-drm/imx-ldb.c:340 imx_ldb_get_clk() error: format string overflow. buf_size: 16 length: 18
	probably 18 is theory and not real life, but 16 is based on
	theory as well.
drivers/staging/imx-drm/parallel-display.c:64 imx_pd_connector_get_modes() error: potential null dereference 'mode'.  (drm_mode_create returns null)
drivers/staging/imx-drm/parallel-display.c:73 imx_pd_connector_get_modes() error: potential null dereference 'mode'.  (drm_mode_create returns null)

drivers/staging/imx-drm/ipuv3-plane.c: In function ‘ipu_plane_set_base’:
drivers/staging/imx-drm/ipuv3-plane.c:75:2: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘dma_addr_t’ [-Wformat]
	cast it to u64 and use %llx
drivers/staging/imx-drm/imx-drm-core.c:89:21: warning: symbol 'imx_drm_find_crtc' was not declared. Should it be static?

regards,
dan carpenter
