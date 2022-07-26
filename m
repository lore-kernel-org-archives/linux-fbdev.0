Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A5CC43334
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jul 2022 13:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiGZNR7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiGZNR7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jul 2022 09:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA7FF2C65B
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658841477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZLeEqH10vqusPd0IzJaPflqD8TZSc6CiZ1X6z5OlBM=;
        b=HSfqyXYdHevA2+OgqBazOdPIgplEEwj7BSW5BDYRp8hLk5OzNH5dP2QKg0x20xh813Xlm0
        hAGJKhulx6tQAyIbhR1XEF+i1lSF7jB/3wrOar57IuhfhHwlmJGtX10h3c0rgFN6Zhhrki
        x/sHq0DpKH9AWmBTLQQkIflcgNa4c7I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-CsDg1zGjMEexeDbePfTLbw-1; Tue, 26 Jul 2022 09:17:56 -0400
X-MC-Unique: CsDg1zGjMEexeDbePfTLbw-1
Received: by mail-wm1-f69.google.com with SMTP id z20-20020a1c4c14000000b003a3020da654so5395282wmf.5
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 06:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QZLeEqH10vqusPd0IzJaPflqD8TZSc6CiZ1X6z5OlBM=;
        b=HWuE4246J8nVkb6/wtgBmaOcdftMKZ3vR9AVG4T4jnmPfWy+uDI5IUgLSfgYzHR5yx
         IibcVWy0IymQYwpP9NwRUOwtiVaUX4s4n0eAd+U83/VldXyMZg87i4sI71rRq1ft8Hkj
         vFQ/HPxBJMKjg1BE8hT6EZIwn4K5Ba/7OztHUPPDA3wlkE2bNfX8zZms/HYwkO9vO0y4
         Ryhb09L+iycUEd9aaahiaN6OC6blIioDzx45f2bDs77+CHnRgLmzPjkvOZZ0gRdB+b1r
         wnzk5nF2H852wNdEje/cKEQjkIxIxylLk+aDSY2lzJZTNj+MFzH1P2oepjSn6Lg0YkJO
         Gj9g==
X-Gm-Message-State: AJIora9Qki/V7iNqfyv4fEP+6HmRyOvy6B85Cs9FyAn6GqNgrIHX8GX3
        ch1Id4INpNxq0cqfwjxXSvbJ180i+AB1w6wDmlOHUTnxtdfDoqgQR8qQYokvK4ln0Mzd9TQLhaS
        FII7pVdARpNQre/oDV+jSfdM=
X-Received: by 2002:a5d:58c9:0:b0:21d:9374:1373 with SMTP id o9-20020a5d58c9000000b0021d93741373mr10809113wrf.20.1658841475079;
        Tue, 26 Jul 2022 06:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uwK0jaZriyb3HLzd94qTq2w3igX18xuKp7Xs7KKT1Eo3AyBh6uAmDSNtcGDrxJn9ORe+mJkw==
X-Received: by 2002:a5d:58c9:0:b0:21d:9374:1373 with SMTP id o9-20020a5d58c9000000b0021d93741373mr10809097wrf.20.1658841474813;
        Tue, 26 Jul 2022 06:17:54 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg17-20020a05600c3c9100b003a04d19dab3sm3251267wmb.3.2022.07.26.06.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:17:54 -0700 (PDT)
Message-ID: <c08842d4-f01e-8d75-2b1d-01cf36b55a10@redhat.com>
Date:   Tue, 26 Jul 2022 15:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 07/10] drm/ofdrm: Add ofdrm for Open Firmware
 framebuffers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-8-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220720142732.32041-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 7/20/22 16:27, Thomas Zimmermann wrote:
> Open Firmware provides basic display output via the 'display' node.
> DT platform code already provides a device that represents the node's
> framebuffer. Add a DRM driver for the device. The display mode and
> color format is pre-initialized by the system's firmware. Runtime
> modesetting via DRM is not possible. The display is useful during
> early boot stages or as error fallback.
> 

I'm not familiar with OF display but the driver looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I just have a few questions below.

[...]

> +static int ofdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
> +						   struct drm_atomic_state *new_state)
> +{
> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
> +	struct drm_crtc_state *new_crtc_state;
> +	int ret;
> +
> +	if (!new_plane_state->fb)
> +		return 0;
> +
> +	new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_plane_state->crtc);
> +
> +	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
> +						  DRM_PLANE_HELPER_NO_SCALING,
> +						  DRM_PLANE_HELPER_NO_SCALING,
> +						  false, false);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

This seems to be exactly the same check than used in the simpledrm driver.
Maybe could be moved to the fwfb helper library too ?

[...]

> +
> +static void ofdrm_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +					     struct drm_atomic_state *old_state)
> +{
> +	/*
> +	 * Always enabled; disabling clears the screen in the
> +	 * primary plane's atomic_disable function.
> +	 */
> +}
> +

Same comment than for simpledrm, are these no-op helpers really needed ?

[...]

> +static const struct of_device_id ofdrm_of_match_display[] = {
> +	{ .compatible = "display", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ofdrm_of_match_display);
> +

I don't see a binding for this in Documentation/devicetree/bindings/display.
Do we need one or it's that only required for FDT and not Open Firmware DT ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

