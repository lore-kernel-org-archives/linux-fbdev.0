Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF0BC4708F
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Jun 2021 00:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D19A613E4
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Jun 2021 00:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhFCAPM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCAPM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Jun 2021 20:15:12 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40106C06174A
        for <linux-fbdev@vger.kernel.org>; Wed,  2 Jun 2021 17:13:19 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z4so177696qts.4
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Jun 2021 17:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/S09SjWkbFDCEaJs+p92hKplyZX7wJr8pT0fXmAavLU=;
        b=M9UiPZp7z27WpewzmJpqzUxEphr7Hh3R7nkxwCntEL95T/9SH+uqkQrAzeIl9+TXSq
         5DCP3ouiaYNxK58m3THItcbNOB1I1ZNR3mtUEfESoIQntmI9VHv5DPAsdgI4+2Xu314z
         EwQjVuhSKB1/odasvdcpz4E+a277SB3T1Vhr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/S09SjWkbFDCEaJs+p92hKplyZX7wJr8pT0fXmAavLU=;
        b=A1vGhpFWTG4b7P5DWbwuO0htPkXXzkmj9PqPbH0gSUEzfZfo5ZECYVhOcId0T4lNaW
         SOlTGNJVNW5vb76Zmu1GVgbLVdLKNbd9T+l6rPTRQOrKP2/dWbNHs/SD3GcjFhf82Scf
         WG4P3k4sN6etbu3Daru0zTLoHUE4AK41S+z9St/glxHmJQYC1WFekh84k+v65gDNa57a
         gGXFawzzrE2yfb0GvkE5qbUZXju26Ck32Fs0ElZSBDertUQIKzbTrXopegx0H6ozLgvF
         RJzm4wxJ5u+4A+8W4KG/oCsSGwq8xsvug5Ed2GZnvU7jKlKwHJviZjXdBykN9GPSeVJE
         HQ+g==
X-Gm-Message-State: AOAM530XEA97OPPmS/gjL25e0IgNv204sPC1/UaNRtbY5cICINJUOWBV
        CO9vq46mP/DtV1NOIlHn+zT8Iijm/xMe4w==
X-Google-Smtp-Source: ABdhPJz60hlOSMNDHdRr9xqdf7bWOlURVS7wZpYnXfEOfl58tBx4ueGzmCpiFJS7duGEQK+UKQ3STQ==
X-Received: by 2002:aed:30e6:: with SMTP id 93mr26734042qtf.41.1622679198181;
        Wed, 02 Jun 2021 17:13:18 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id g6sm878839qkm.120.2021.06.02.17.13.17
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 17:13:18 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 207so6348380ybd.1
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Jun 2021 17:13:17 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr50138961ybm.345.1622678718994;
 Wed, 02 Jun 2021 17:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <1622390172-31368-1-git-send-email-rajeevny@codeaurora.org> <1622390172-31368-2-git-send-email-rajeevny@codeaurora.org>
In-Reply-To: <1622390172-31368-2-git-send-email-rajeevny@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Jun 2021 17:05:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMVKP=nK+-eTpxNK-AQ66rqvfMj_Q0TZrsG-CEWtbw8Q@mail.gmail.com>
Message-ID: <CAD=FV=XMVKP=nK+-eTpxNK-AQ66rqvfMj_Q0TZrsG-CEWtbw8Q@mail.gmail.com>
Subject: Re: [v5 1/5] drm/panel: add basic DP AUX backlight support
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On Sun, May 30, 2021 at 8:57 AM Rajeev Nandan <rajeevny@codeaurora.org> wrote:
>
> +static int dp_aux_backlight_update_status(struct backlight_device *bd)
> +{
> +       struct dp_aux_backlight *bl = bl_get_data(bd);
> +       u16 brightness = backlight_get_brightness(bd);
> +       int ret = 0;
> +
> +       if (brightness > 0) {
> +               if (!bl->enabled) {
> +                       drm_edp_backlight_enable(bl->aux, &bl->info, brightness);
> +                       bl->enabled = true;
> +                       return 0;
> +               }
> +               ret = drm_edp_backlight_set_level(bl->aux, &bl->info, brightness);
> +       } else {
> +               if (bl->enabled) {
> +                       drm_edp_backlight_disable(bl->aux, &bl->info);
> +                       bl->enabled = false;
> +               }
> +       }

I was trying to figure out if there are any races / locking problems /
problems trying to tweak the backlight when the panel is off. I don't
_think_ there are. Specifically:

1. Before turning the panel off, drm_panel will call
backlight_disable(). That will set BL_CORE_FBBLANK which is not set by
any other calls. Then it will call your
dp_aux_backlight_update_status().

2. Once BL_CORE_FBBLANK is set then backlight_get_brightness() will
always return 0.

This means that a transition from 0 -> non-zero (and enable) will
always only happen when the panel is on, which is good. It also means
that we'll always transition to 0 (disable the backlight) when the
panel turns off.

In terms of other races, it looks like the AUX transfer code handles
grabbing a mutex around transfers so we should be safe there.

So I guess the above is just a long-winded way of saying that this
looks right to me. :-)

BTW: we should probably make sure that the full set of people
identified by `./scripts/get_maintainer.pl -f
./drivers/video/backlight` are CCed on your series. I see Daniel
already and I've added the rest.


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
> + * drm_panel_dp_aux_backlight() must be called after the call to drm_panel_init().
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux *aux)
> +{
> +       struct dp_aux_backlight *bl;
> +       struct backlight_properties props = { 0 };
> +       u16 current_level;
> +       u8 current_mode;
> +       u8 edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE];
> +       int ret;
> +
> +       if (!panel || !panel->dev || !aux)
> +               return -EINVAL;
> +
> +       bl = devm_kzalloc(panel->dev, sizeof(*bl), GFP_KERNEL);
> +       if (!bl)
> +               return -ENOMEM;
> +
> +       bl->aux = aux;
> +
> +       ret = drm_dp_dpcd_read(aux, DP_EDP_DPCD_REV, edp_dpcd,
> +                              EDP_DISPLAY_CTL_CAP_SIZE);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!drm_edp_backlight_supported(edp_dpcd)) {
> +               DRM_DEV_INFO(panel->dev, "DP AUX backlight is not supported\n");
> +               return 0;
> +       }

nit: move this part up above the memory allocation. There's no reason
to allocate memory for "bl" if the backlight isn't supported.


> @@ -64,8 +65,8 @@ enum drm_panel_orientation;
>   * the panel. This is the job of the .unprepare() function.
>   *
>   * Backlight can be handled automatically if configured using
> - * drm_panel_of_backlight(). Then the driver does not need to implement the
> - * functionality to enable/disable backlight.
> + * drm_panel_of_backlight() or drm_panel_dp_aux_backlight(). Then the driver
> + * does not need to implement the functionality to enable/disable backlight.
>   */
>  struct drm_panel_funcs {
>         /**
> @@ -144,8 +145,8 @@ struct drm_panel {
>          * Backlight device, used to turn on backlight after the call
>          * to enable(), and to turn off backlight before the call to
>          * disable().
> -        * backlight is set by drm_panel_of_backlight() and drivers
> -        * shall not assign it.
> +        * backlight is set by drm_panel_of_backlight()/drm_panel_dp_aux_backlight()
> +        * and drivers shall not assign it.

Slight nit that I would have wrapped the drm_panel_dp_aux_backlight()
to the next line just to avoid one really long line followed by a
short one.

Other than the two nits (ordering of memory allocation and word
wrapping in a comment), this looks good to me. Feel free to add my
Reviewed-by tag when you fix the nits.

NOTE: Even though I have commit access to drm-misc now, I wouldn't
feel comfortable merging this to drm-misc myself without review
feedback from someone more senior. Obviously we're still blocked on my
and Lyude's series landing first, but even assuming those just land
as-is we'll need some more adult supervision before this can land. ;-)
That being said, I personally think this looks pretty nice now.


-Doug



>          */
>         struct backlight_device *backlight;
>
> @@ -208,11 +209,17 @@ static inline int of_drm_get_panel_orientation(const struct device_node *np,
>  #if IS_ENABLED(CONFIG_DRM_PANEL) && (IS_BUILTIN(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
>         (IS_MODULE(CONFIG_DRM) && IS_MODULE(CONFIG_BACKLIGHT_CLASS_DEVICE)))
>  int drm_panel_of_backlight(struct drm_panel *panel);
> +int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux *aux);
>  #else
>  static inline int drm_panel_of_backlight(struct drm_panel *panel)
>  {
>         return 0;
>  }
> +static inline int drm_panel_dp_aux_backlight(struct drm_panel *panel,
> +                                            struct drm_dp_aux *aux)
> +{
> +       return 0;
> +}
>  #endif
>
>  #endif
> --
> 2.7.4
>
