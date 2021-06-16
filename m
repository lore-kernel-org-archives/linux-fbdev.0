Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D556C48BE6
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Jun 2021 19:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A8E600D1
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Jun 2021 19:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhFPTYg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 16 Jun 2021 15:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232447AbhFPTYg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 16 Jun 2021 15:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623871349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfPQRSykQydOulCcQ49aAeUEKKM3a3d6+BzEEPE5SV4=;
        b=SsXCmPSDHH+IE6d4v6/huWFI/fel+BRzkTvOXH3rMpKsOA8ft9nRpZdVx5/gu05dzGFKJm
        PViptE/SD8lN6aMyoQhm7wmXDXZLzARVIVk49PvJPqTmEVtQIxSqHzrp87yF8qtGQyXkAb
        MlfDI/oAVP/Kw5XLUO8U1qh/afFir7k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-r-qjxoReNue1PdEPq78krg-1; Wed, 16 Jun 2021 15:22:28 -0400
X-MC-Unique: r-qjxoReNue1PdEPq78krg-1
Received: by mail-qv1-f69.google.com with SMTP id bt11-20020ad455cb0000b0290258c7c1acd0so370445qvb.5
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Jun 2021 12:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=cfPQRSykQydOulCcQ49aAeUEKKM3a3d6+BzEEPE5SV4=;
        b=lvna+KqLPDKqlMFg4McLTznkngL+ralFhiuCMF9ZZ+oBEtM0Dac0yH7dbQ0G9eF7QY
         KhEB4te+tx3PkWNQyro9WoC0jQVs7TFCvHE9lHkGPWhytJBxc5XlhM+4mT1O1eoKNHL+
         WSLpQyvC7YMJ/tM0T4W0gzKXCGRVBQx0sXGhssPGWSbtlGZfN91g4cwZXHK7yd5qSK3p
         k+6SSzy7cEG/e6RXeuZAQtsGCcto6uxfgMERUxDFqyoPUsCqDYafqEafCpdpO+6pFZ6e
         SS2uKTJb7XVi60ZEOWwHy/0yjhK8zxCNET55+DwHPumoHC+ZMUFjIup35OP6Hcai3DIQ
         6hiQ==
X-Gm-Message-State: AOAM530J551TO9TYo0Y+QqeuyHesnq2yr2eGnPZqh6MzDixgIt94t2f9
        8JUGUDGEO/7tl33EBFNVsGj3C7TaB0F/7Fv2mS1sZTTUKesWyxMRmZJK5WlfVz2vSWPnJdsNYZ6
        N+jPDpLTEENqxNcPo5XjULkY=
X-Received: by 2002:a05:620a:1129:: with SMTP id p9mr1743843qkk.163.1623871347721;
        Wed, 16 Jun 2021 12:22:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8h8pJ527wXO5YR0w/WfuqqYYEriH77nlHFOVvL9eWL0AJ7EELuOrCm3wyxVLlnNbjvIgaNQ==
X-Received: by 2002:a05:620a:1129:: with SMTP id p9mr1743811qkk.163.1623871347486;
        Wed, 16 Jun 2021 12:22:27 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id s22sm1708411qtx.32.2021.06.16.12.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:22:27 -0700 (PDT)
Message-ID: <31f31a0d37e05f71ade68b3452ef471c0c681302.camel@redhat.com>
Subject: Re: [v6 1/5] drm/panel: add basic DP AUX backlight support
From:   Lyude Paul <lyude@redhat.com>
To:     Rajeev Nandan <rajeevny@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        sam@ravnborg.org, robdclark@gmail.com, dianders@chromium.org,
        jani.nikula@intel.com, robh@kernel.org,
        laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        daniel.thompson@linaro.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, mkrishn@codeaurora.org,
        lee.jones@linaro.org, jingoohan1@gmail.com,
        linux-fbdev@vger.kernel.org
Date:   Wed, 16 Jun 2021 15:22:25 -0400
In-Reply-To: <1623499682-2140-2-git-send-email-rajeevny@codeaurora.org>
References: <1623499682-2140-1-git-send-email-rajeevny@codeaurora.org>
         <1623499682-2140-2-git-send-email-rajeevny@codeaurora.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sat, 2021-06-12 at 17:37 +0530, Rajeev Nandan wrote:
> Some panels support backlight control over DP AUX channel using
> VESA's standard backlight control interface.
> Using new DRM eDP backlight helpers, add support to create and
> register a backlight for those panels in drm_panel to simplify
> the panel drivers.
> 
> The panel driver with access to "struct drm_dp_aux" can create and
> register a backlight device using following code snippet in its
> probe() function:
> 
>         err = drm_panel_dp_aux_backlight(panel, aux);
>         if (err)
>                 return err;
> 
> Then drm_panel will handle backlight_(enable|disable) calls
> similar to the case when drm_panel_of_backlight() is used.
> 
> Currently, we are not supporting one feature where the source
> device can combine the backlight brightness levels set through
> DP AUX and the BL_PWM_DIM eDP connector pin. Since it's not
> required for the basic backlight controls, it can be added later.
> 
> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v5:
> - New
> 
> Changes in v6:
> - Fixed ordering of memory allocation (Douglas)
> - Updated word wrapping in a comment (Douglas)
> 
>  drivers/gpu/drm/drm_panel.c | 108
> ++++++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_panel.h     |  15 ++++--
>  2 files changed, 119 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f634371..9e65342 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -26,12 +26,20 @@
>  #include <linux/module.h>
>  
>  #include <drm/drm_crtc.h>
> +#include <drm/drm_dp_helper.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  
>  static DEFINE_MUTEX(panel_lock);
>  static LIST_HEAD(panel_list);
>  
> +struct dp_aux_backlight {
> +       struct backlight_device *base;
> +       struct drm_dp_aux *aux;
> +       struct drm_edp_backlight_info info;
> +       bool enabled;
> +};
> +
>  /**
>   * DOC: drm panel
>   *
> @@ -342,6 +350,106 @@ int drm_panel_of_backlight(struct drm_panel *panel)
>         return 0;
>  }
>  EXPORT_SYMBOL(drm_panel_of_backlight);
> +
> +static int dp_aux_backlight_update_status(struct backlight_device *bd)
> +{
> +       struct dp_aux_backlight *bl = bl_get_data(bd);
> +       u16 brightness = backlight_get_brightness(bd);
> +       int ret = 0;
> +
> +       if (brightness > 0) {
> +               if (!bl->enabled) {
> +                       drm_edp_backlight_enable(bl->aux, &bl->info,
> brightness);
> +                       bl->enabled = true;
> +                       return 0;
> +               }
> +               ret = drm_edp_backlight_set_level(bl->aux, &bl->info,
> brightness);
> +       } else {
> +               if (bl->enabled) {
> +                       drm_edp_backlight_disable(bl->aux, &bl->info);
> +                       bl->enabled = false;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct backlight_ops dp_aux_bl_ops = {
> +       .update_status = dp_aux_backlight_update_status,
> +};
> +
> +/**
> + * drm_panel_dp_aux_backlight - create and use DP AUX backlight
> + * @panel: DRM panel
> + * @aux: The DP AUX channel to use
> + *
> + * Use this function to create and handle backlight if your panel
> + * supports backlight control over DP AUX channel using DPCD
> + * registers as per VESA's standard backlight control interface.
> + *
> + * When the panel is enabled backlight will be enabled after a
> + * successful call to &drm_panel_funcs.enable()
> + *
> + * When the panel is disabled backlight will be disabled before the
> + * call to &drm_panel_funcs.disable().
> + *
> + * A typical implementation for a panel driver supporting backlight
> + * control over DP AUX will call this function at probe time.
> + * Backlight will then be handled transparently without requiring
> + * any intervention from the driver.
> + *
> + * drm_panel_dp_aux_backlight() must be called after the call to
> drm_panel_init().
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux
> *aux)
> +{
> +       struct dp_aux_backlight *bl;
> +       struct backlight_properties props = { 0 };
> +       u16 current_level;
> +       u8 current_mode;
> +       u8 edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE];
> +       int ret;
> +
> +       if (!panel || !panel->dev || !aux)
> +               return -EINVAL;
> +
> +       ret = drm_dp_dpcd_read(aux, DP_EDP_DPCD_REV, edp_dpcd,
> +                              EDP_DISPLAY_CTL_CAP_SIZE);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!drm_edp_backlight_supported(edp_dpcd)) {
> +               DRM_DEV_INFO(panel->dev, "DP AUX backlight is not
> supported\n");
> +               return 0;
> +       }
> +
> +       bl = devm_kzalloc(panel->dev, sizeof(*bl), GFP_KERNEL);
> +       if (!bl)
> +               return -ENOMEM;
> +
> +       bl->aux = aux;
> +
> +       ret = drm_edp_backlight_init(aux, &bl->info, 0, edp_dpcd,
> +                                    &current_level, &current_mode);
> +       if (ret < 0)
> +               return ret;
> +
> +       props.type = BACKLIGHT_RAW;
> +       props.brightness = current_level;
> +       props.max_brightness = bl->info.max;
> +
> +       bl->base = devm_backlight_device_register(panel->dev,
> "dp_aux_backlight",
> +                                                 panel->dev, bl,
> +                                                 &dp_aux_bl_ops, &props);
> +       if (IS_ERR(bl->base))
> +               return PTR_ERR(bl->base);
> +
> +       panel->backlight = bl->base;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(drm_panel_dp_aux_backlight);
>  #endif
>  
>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 33605c3..3ebfaa6 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -32,6 +32,7 @@ struct backlight_device;
>  struct device_node;
>  struct drm_connector;
>  struct drm_device;
> +struct drm_dp_aux;
>  struct drm_panel;
>  struct display_timing;
>  
> @@ -64,8 +65,8 @@ enum drm_panel_orientation;
>   * the panel. This is the job of the .unprepare() function.
>   *
>   * Backlight can be handled automatically if configured using
> - * drm_panel_of_backlight(). Then the driver does not need to implement the
> - * functionality to enable/disable backlight.
> + * drm_panel_of_backlight() or drm_panel_dp_aux_backlight(). Then the
> driver
> + * does not need to implement the functionality to enable/disable
> backlight.
>   */
>  struct drm_panel_funcs {
>         /**
> @@ -144,8 +145,8 @@ struct drm_panel {
>          * Backlight device, used to turn on backlight after the call
>          * to enable(), and to turn off backlight before the call to
>          * disable().
> -        * backlight is set by drm_panel_of_backlight() and drivers
> -        * shall not assign it.
> +        * backlight is set by drm_panel_of_backlight() or
> +        * drm_panel_dp_aux_backlight() and drivers shall not assign it.
>          */
>         struct backlight_device *backlight;
>  
> @@ -208,11 +209,17 @@ static inline int of_drm_get_panel_orientation(const
> struct device_node *np,
>  #if IS_ENABLED(CONFIG_DRM_PANEL) &&
> (IS_BUILTIN(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
>         (IS_MODULE(CONFIG_DRM) && IS_MODULE(CONFIG_BACKLIGHT_CLASS_DEVICE)))
>  int drm_panel_of_backlight(struct drm_panel *panel);
> +int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux
> *aux);
>  #else
>  static inline int drm_panel_of_backlight(struct drm_panel *panel)
>  {
>         return 0;
>  }
> +static inline int drm_panel_dp_aux_backlight(struct drm_panel *panel,
> +                                            struct drm_dp_aux *aux)
> +{
> +       return 0;
> +}
>  #endif
>  
>  #endif

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

