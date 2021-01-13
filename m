Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B0FC433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5BE2251F
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 15:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbhAMPen (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:34:43 -0500
Received: from vps46799.freepascal.org ([85.222.228.11]:39928 "EHLO
        mail.freepascal.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbhAMPen (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 10:34:43 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 10:34:42 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.freepascal.org (Postfix) with ESMTP id B85798003C;
        Wed, 13 Jan 2021 16:24:22 +0100 (CET)
Received: from mail.freepascal.org ([127.0.0.1])
        by localhost (idefix.freepascal.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pCnIbHmj9EZy; Wed, 13 Jan 2021 16:24:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.freepascal.org (Postfix) with ESMTPS id 8FE9480030;
        Wed, 13 Jan 2021 16:24:22 +0100 (CET)
Date:   Wed, 13 Jan 2021 16:24:22 +0100 (CET)
From:   =?ISO-8859-15?Q?Dani=EBl_Mantione?= 
        <daniel.mantione@freepascal.org>
X-X-Sender: daniel@idefix.freepascal.org
To:     Lee Jones <lee.jones@linaro.org>
cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 14/31] video: fbdev: aty: mach64_ct: Remove some set but
 unused variables
In-Reply-To: <20210113145009.1272040-15-lee.jones@linaro.org>
Message-ID: <alpine.DEB.2.21.2101131618160.8079@idefix.freepascal.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org> <20210113145009.1272040-15-lee.jones@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-564851740-754536928-1610551462=:8079"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---564851740-754536928-1610551462=:8079
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

If I remember well, the removed lines have to do with the VGA/accelerator 
mode of the chip. The current driver always runs the chip in accelerator 
mode. Suppose you would want to support high resolution hardware text 
modes with the driver (fbdev bpp=0), then you would need to switch the 
chip into VGA mode mode and then the removed lines become relevant.

I did some experiments with this when I was working on the driver, but 
because the documentation was silent about the behaviour of extended 
CRTC registers in VGA mode, I failed to make hardware text modes to work 
properly.

The #if 0 was there so code was already there in case me or someone else 
would pick it up again.

Best regards,

Daniël Mantione

Op Wed, 13 Jan 2021, schreef Lee Jones:

> Fixes the following W=1 kernel build warning(s):
>
> drivers/video/fbdev/aty/mach64_ct.c: In function ‘aty_init_pll_ct’:
> drivers/video/fbdev/aty/mach64_ct.c:405:46: warning: variable ‘vga_dsp_on_off’ set but not used [-Wunused-but-set-variable]
> drivers/video/fbdev/aty/mach64_ct.c:405:30: warning: variable ‘vga_dsp_config’ set but not used [-Wunused-but-set-variable]
> drivers/video/fbdev/aty/mach64_ct.c:405:18: warning: variable ‘dsp_on_off’ set but not used [-Wunused-but-set-variable]
>
> Cc: daniel.mantione@freepascal.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> drivers/video/fbdev/aty/mach64_ct.c | 19 ++-----------------
> 1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/video/fbdev/aty/mach64_ct.c b/drivers/video/fbdev/aty/mach64_ct.c
> index f87cc81f4fa2b..23eececa1e9d7 100644
> --- a/drivers/video/fbdev/aty/mach64_ct.c
> +++ b/drivers/video/fbdev/aty/mach64_ct.c
> @@ -402,7 +402,7 @@ static int aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)
> 	struct atyfb_par *par = (struct atyfb_par *) info->par;
> 	u8 mpost_div, xpost_div, sclk_post_div_real;
> 	u32 q, memcntl, trp;
> -	u32 dsp_config, dsp_on_off, vga_dsp_config, vga_dsp_on_off;
> +	u32 dsp_config;
> #ifdef DEBUG
> 	int pllmclk, pllsclk;
> #endif
> @@ -488,25 +488,10 @@ static int aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)
>
> 	/* Allow BIOS to override */
> 	dsp_config = aty_ld_le32(DSP_CONFIG, par);
> -	dsp_on_off = aty_ld_le32(DSP_ON_OFF, par);
> -	vga_dsp_config = aty_ld_le32(VGA_DSP_CONFIG, par);
> -	vga_dsp_on_off = aty_ld_le32(VGA_DSP_ON_OFF, par);
>
> 	if (dsp_config)
> 		pll->ct.dsp_loop_latency = (dsp_config & DSP_LOOP_LATENCY) >> 16;
> -#if 0
> -	FIXME: is it relevant for us?
> -	if ((!dsp_on_off && !M64_HAS(RESET_3D)) ||
> -		((dsp_on_off == vga_dsp_on_off) &&
> -		(!dsp_config || !((dsp_config ^ vga_dsp_config) & DSP_XCLKS_PER_QW)))) {
> -		vga_dsp_on_off &= VGA_DSP_OFF;
> -		vga_dsp_config &= VGA_DSP_XCLKS_PER_QW;
> -		if (ATIDivide(vga_dsp_on_off, vga_dsp_config, 5, 1) > 24)
> -			pll->ct.fifo_size = 32;
> -		else
> -			pll->ct.fifo_size = 24;
> -	}
> -#endif
> +
> 	/* Exit if the user does not want us to tamper with the clock
> 	rates of her chip. */
> 	if (par->mclk_per == 0) {
> -- 
> 2.25.1
>
---564851740-754536928-1610551462=:8079--
