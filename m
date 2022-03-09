Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB59C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Mar 2022 13:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiCINLU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiCINLU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Mar 2022 08:11:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFFFA1052B0
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Mar 2022 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646831419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAU44weXti04FLi2etjzVw+K+va7nBLkmB5FdNWAcI0=;
        b=Ciuwj6fWM1jqbyzxXo1RPRtJ0/v2aReVAEb140djTOujZbHUmvBy1uJAIkllfzh0GLWEcs
        PV6aR0BW0fgLGBSs/sjUwSVPw79JF3t5i0WhCWuxwWGON0yrTAUnK3TH1qp5O6nE2Mxsw9
        7RjZ44cdsetl7AUqT+yLvxetOpDt28o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-nf4AnmnzM8ulv-HYTQs4NQ-1; Wed, 09 Mar 2022 08:10:18 -0500
X-MC-Unique: nf4AnmnzM8ulv-HYTQs4NQ-1
Received: by mail-wm1-f72.google.com with SMTP id z9-20020a7bc7c9000000b00389bd375677so948109wmk.4
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Mar 2022 05:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iAU44weXti04FLi2etjzVw+K+va7nBLkmB5FdNWAcI0=;
        b=MwupWYOAKQYoTuXMsf7RVthfnumijWhd9mn3k66rmxVu8mcKJghmdlMvdrgGCrHgxF
         yvG/jeLgSMxyVmtmwNOFC7srJ8F2Gjy4svUo1aeeFLspqlkAhfPwa2qDSoM2sVLyJKXD
         Q5aC65EhN/cofBVXDCQTqxC26UcpaI6Uplb8QITwOpMYlShJYhoh6m062SUBpilIlUaC
         DXOFADCbNJ9wLoe0YipprJww5Po3JdhuT1iGu+zLD3Wg8BE3RC4bdbLHw5HHdhfiox9J
         G6AollgAi3qGeiRWy70n4AJw3/hrCz0hCbEQLJ2RnE9CJf1eevraPXB8ThQZgwcpH65v
         2D6A==
X-Gm-Message-State: AOAM532i076df6cwVy1ElWiuxv68jTJqE2N4CLBgYPn5KSmZNn5D+ypK
        ve4YO7tKPUBsqIItsTqJ48mDnus5of0XOqfaLrkbdCEgm0MXNiRSlTddORM2brJDuNYn6XJulOz
        FB8FaAo3s1AjyTNxebmCoxe8=
X-Received: by 2002:a5d:4dc5:0:b0:1f0:73e4:2cd9 with SMTP id f5-20020a5d4dc5000000b001f073e42cd9mr15765169wru.212.1646831417441;
        Wed, 09 Mar 2022 05:10:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvX2Au00DweT17gWXJkTfHnd/3tQIRGysI0fVMgShhCARC1khCEjjWT3sGgGyIigEkQZnnNQ==
X-Received: by 2002:a5d:4dc5:0:b0:1f0:73e4:2cd9 with SMTP id f5-20020a5d4dc5000000b001f073e42cd9mr15765152wru.212.1646831417244;
        Wed, 09 Mar 2022 05:10:17 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm422698wry.78.2022.03.09.05.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:10:16 -0800 (PST)
Message-ID: <355f94c7-fc8a-7d92-5979-5b1b49c1d738@redhat.com>
Date:   Wed, 9 Mar 2022 14:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 06/10] drm/fb-helper: Add support for DRM_FORMAT_C[124]
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1646683502.git.geert@linux-m68k.org>
 <c665d6ba072f3debb3fa0a139454fefef6a55011.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c665d6ba072f3debb3fa0a139454fefef6a55011.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> Add support for color-indexed frame buffer formats with two, four, and
> sixteen colors to the DRM framebuffer helper functions:
>   1. Add support for 1, 2, and 4 bits per pixel to the damage helper,
>   2. For color-indexed modes, the length of the color bitfields must be
>      set to the color depth, else the logo code may pick a logo with too
>      many colors.  Drop the incorrect DAC width comment, which
>      originates from the i915 driver.
>   3. Accept C[124] modes when validating or filling in struct
>      fb_var_screeninfo, and use the correct number of bits per pixel.
>   4. Set the visual to FB_VISUAL_PSEUDOCOLOR for all color-indexed
>      modes.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

[snip]

>  static void drm_fb_helper_fill_fix(struct fb_info *info, uint32_t pitch,
> -				   uint32_t depth)
> +				   bool is_color_indexed)
>  {
>  	info->fix.type = FB_TYPE_PACKED_PIXELS;
> -	info->fix.visual = depth == 8 ? FB_VISUAL_PSEUDOCOLOR :
> -		FB_VISUAL_TRUECOLOR;
> +	info->fix.visual = is_color_indexed ? FB_VISUAL_PSEUDOCOLOR
> +					    : info->fix.visual;

Shouldn't this be the following instead ?

  +	info->fix.visual = is_color_indexed ? FB_VISUAL_PSEUDOCOLOR
  +					    : FB_VISUAL_TRUECOLOR;

Other than that the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

