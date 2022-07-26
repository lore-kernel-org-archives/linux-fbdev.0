Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01622C25B08
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jul 2022 13:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbiGZNt2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiGZNt1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jul 2022 09:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A58291FCFD
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658843365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yx+6GZt1MNJVcGz7GTKwesVhWHXoxflnw9Q7t0FYoHA=;
        b=RIJKrKbOcPKEmzHrB0+llonv03A9LXiZvbdBJNS60d0m190iuYHH5zjIq8xjRD9/fylott
        2uMgrQviMT5wqVLN+YaOQoqa2jCJTVubvhd9Y1qKe2n/oSu2aboAN0NLxqtThhZodeq7WX
        ax/DrGJzPOD85c/wrjaf2REKsnSfkA8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-wk4PCNUXOd6O-MYvLyjFdQ-1; Tue, 26 Jul 2022 09:49:24 -0400
X-MC-Unique: wk4PCNUXOd6O-MYvLyjFdQ-1
Received: by mail-wm1-f70.google.com with SMTP id r10-20020a05600c284a00b003a2ff6c9d6aso10295661wmb.4
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 06:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yx+6GZt1MNJVcGz7GTKwesVhWHXoxflnw9Q7t0FYoHA=;
        b=A+PvnOE4zFQHKjXIg8uDh1yxXJ7YC8Jx6/BN7YlQRkbBMEATX22YgVlCI2O7q9IIsa
         Xq5+xBSCCoOZmAdM8FX/oRIP3JoxpsXtCKVsFy9gpkspiT2W3X3JqIbiEeZQ5s6dHORS
         95nciVkRtPzZk2GVkN46xxgn2l/gW499VWGzVcWEvTnkuHdTHCMDgmjEZerchtjVfKth
         ByEUfA+E8CMuGzhKJMS8XEUibo6Rn7R1BS6jAh2ZLUkbrcm0ugbWIdTijciYP0IE7RHN
         +cjYqcVCEUdlF1sI41kMt0m8Y/HQnzPAxjZt6BEZVpUyjH7ilfL1cUFvUTdjgkQx+MwX
         fnDg==
X-Gm-Message-State: AJIora8aODwh1Vfz8Aczrsf1dlgxGUVcJZHsMXOhcVtPJ3wD6tdScBZZ
        RLeMfFGmM4M6jRzOSsjKxD0OClC5c+pUjSnB2xJlncfWFumuSIQqSBrCzKrD7KMeFtmKgr6zvjm
        oBFNXk2pbQSoGSG3ohFYAahE=
X-Received: by 2002:adf:e19b:0:b0:21e:4bb9:9a14 with SMTP id az27-20020adfe19b000000b0021e4bb99a14mr11108328wrb.354.1658843363204;
        Tue, 26 Jul 2022 06:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t08UKa6vLvAxqYUWQY3Aj3EC9x4jPF2Jb9qsrCmz2vWnABUqOa3+dDEQyXjEVoWWkYL7yAlA==
X-Received: by 2002:adf:e19b:0:b0:21e:4bb9:9a14 with SMTP id az27-20020adfe19b000000b0021e4bb99a14mr11108315wrb.354.1658843362891;
        Tue, 26 Jul 2022 06:49:22 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c00d000b003a31c4f6f74sm25502543wmm.32.2022.07.26.06.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:49:22 -0700 (PDT)
Message-ID: <abe3fa95-942b-6d2f-7167-83d0cea59444@redhat.com>
Date:   Tue, 26 Jul 2022 15:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 10/10] drm/ofdrm: Support color management
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-11-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220720142732.32041-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/20/22 16:27, Thomas Zimmermann wrote:
> Support the CRTC's color-management property and implement each model's
> palette support.
> 
> The OF hardware has different methods of setting the palette. The
> respective code has been taken from fbdev's offb and refactored into
> per-model device functions. The device functions integrate this
> functionality into the overall modesetting.
> 
> As palette handling is a CRTC property that depends on the primary
> plane's color format, the plane's atomic_check helper now updates the
> format field in ofdrm's custom CRTC state. The CRTC's atomic_flush
> helper updates the palette for the format as needed.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

[...]

> +static void __iomem *ofdrm_mach64_cmap_ioremap(struct ofdrm_device *odev,
> +					       struct device_node *of_node,
> +					       u64 fb_base)
> +{
> +	struct drm_device *dev = &odev->dev;
> +	u64 address;
> +	void __iomem *cmap_base;
> +
> +	address = fb_base & 0xff000000ul;
> +	address += 0x7ff000;
> +

It would be good to know where these addresses are coming from. Maybe some
constant macros or a comment ? Same for the other places where addresses
and offsets are used.

[...]

>  static struct ofdrm_crtc_state *to_ofdrm_crtc_state(struct drm_crtc_state *base)
> @@ -376,10 +735,12 @@ static int ofdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
>  						   struct drm_atomic_state *new_state)
>  {
>  	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
> +	struct drm_framebuffer *new_fb = new_plane_state->fb;
>  	struct drm_crtc_state *new_crtc_state;
> +	struct ofdrm_crtc_state *new_ofdrm_crtc_state;
>  	int ret;
>  
> -	if (!new_plane_state->fb)
> +	if (!new_fb)
>  		return 0;
>  
>  	new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_plane_state->crtc);
> @@ -391,6 +752,14 @@ static int ofdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
>  	if (ret)
>  		return ret;
>  
> +	if (!new_plane_state->visible)
> +		return 0;
> +
> +	new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_plane_state->crtc);
> +
> +	new_ofdrm_crtc_state = to_ofdrm_crtc_state(new_crtc_state);
> +	new_ofdrm_crtc_state->format = new_fb->format;
> +

Ah, I understand now why you didn't factor out the .atomic_check callbacks
for the two drivers in a fwfb helper. Maybe you can also add a comment to
mention that this updates the format so the CRTC palette can be applied in
the .atomic_flush callback ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

