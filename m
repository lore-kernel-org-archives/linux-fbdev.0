From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Apr 2020 14:08:05 +0000
Subject: Re: [PATCH -next] omapfb/dss: remove unused varible 'venc_config_pal_bdghi'
Message-Id: <ef8cf200-4bcd-1a53-abcc-65feba6c11fa@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200415132418eucas1p2249e350241cee81ce200565455c31f98@eucas1p2.samsung.com>
 <20200415132350.33088-1-yuehaibing@huawei.com>
In-Reply-To: <20200415132350.33088-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, allison@lohutok.net, linux-kernel@vger.kernel.org


On 4/15/20 3:23 PM, YueHaibing wrote:
> drivers/video/fbdev/omap2/omapfb/dss/venc.c:212:33:
>  warning: ‘venc_config_pal_bdghi’ defined but not used [-Wunused-const-variable=]
>  static const struct venc_config venc_config_pal_bdghi = {
>                                  ^~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch queued for v5.8 (w/ typo in the patch summary fixed), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/venc.c | 43 ---------------------
>  1 file changed, 43 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/venc.c b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> index f81e2a46366d..d5404d56c922 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> @@ -209,49 +209,6 @@ static const struct venc_config venc_config_ntsc_trm = {
>  	.gen_ctrl				= 0x00F90000,
>  };
>  
> -static const struct venc_config venc_config_pal_bdghi = {
> -	.f_control				= 0,
> -	.vidout_ctrl				= 0,
> -	.sync_ctrl				= 0,
> -	.hfltr_ctrl				= 0,
> -	.x_color				= 0,
> -	.line21					= 0,
> -	.ln_sel					= 21,
> -	.htrigger_vtrigger			= 0,
> -	.tvdetgp_int_start_stop_x		= 0x00140001,
> -	.tvdetgp_int_start_stop_y		= 0x00010001,
> -	.gen_ctrl				= 0x00FB0000,
> -
> -	.llen					= 864-1,
> -	.flens					= 625-1,
> -	.cc_carr_wss_carr			= 0x2F7625ED,
> -	.c_phase				= 0xDF,
> -	.gain_u					= 0x111,
> -	.gain_v					= 0x181,
> -	.gain_y					= 0x140,
> -	.black_level				= 0x3e,
> -	.blank_level				= 0x3e,
> -	.m_control				= 0<<2 | 1<<1,
> -	.bstamp_wss_data			= 0x42,
> -	.s_carr					= 0x2a098acb,
> -	.l21__wc_ctl				= 0<<13 | 0x16<<8 | 0<<0,
> -	.savid__eavid				= 0x06A70108,
> -	.flen__fal				= 23<<16 | 624<<0,
> -	.lal__phase_reset			= 2<<17 | 310<<0,
> -	.hs_int_start_stop_x			= 0x00920358,
> -	.hs_ext_start_stop_x			= 0x000F035F,
> -	.vs_int_start_x				= 0x1a7<<16,
> -	.vs_int_stop_x__vs_int_start_y		= 0x000601A7,
> -	.vs_int_stop_y__vs_ext_start_x		= 0x01AF0036,
> -	.vs_ext_stop_x__vs_ext_start_y		= 0x27101af,
> -	.vs_ext_stop_y				= 0x05,
> -	.avid_start_stop_x			= 0x03530082,
> -	.avid_start_stop_y			= 0x0270002E,
> -	.fid_int_start_x__fid_int_start_y	= 0x0005008A,
> -	.fid_int_offset_y__fid_ext_start_x	= 0x002E0138,
> -	.fid_ext_start_y__fid_ext_offset_y	= 0x01380005,
> -};
> -
>  const struct omap_video_timings omap_dss_pal_timings = {
>  	.x_res		= 720,
>  	.y_res		= 574,
> 
