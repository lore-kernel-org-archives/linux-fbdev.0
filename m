Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D00FC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Jul 2022 15:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiGYPqi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Jul 2022 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiGYPqh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Jul 2022 11:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 265ED10A6
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658763996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ885KKzcUvf1e2EVl4lSKhnhoxNx06B5g4T95NscQU=;
        b=QLlTi3+7VQ8ttDQ+z/lEH46mQLREKPXKjdbuOXDlwL00BoY7FbexOw7tfIPaev70CToVlX
        SJpaFbwnWYonm7PI24VszSpPZwSp+cjDP51Xvwa32DwXk5/tasERcWZIdrID5cEBObbJf/
        byIKxQT9WUj+Twz7EmxThDqG+vRDMf4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-7udltpbjPwyDPZe58BMFyA-1; Mon, 25 Jul 2022 11:46:35 -0400
X-MC-Unique: 7udltpbjPwyDPZe58BMFyA-1
Received: by mail-wr1-f70.google.com with SMTP id q9-20020adfb189000000b0021e3e7d3242so1674970wra.19
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 08:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZJ885KKzcUvf1e2EVl4lSKhnhoxNx06B5g4T95NscQU=;
        b=YVFaftzSAYoBhqcpN8QXgxvRM82RMPeJz840RTeJYOu6dHnMDAuX6qoQ0i5wxX2D5C
         JTNp9IZ7jxHygfayqhbnALkkkVLPEQo/FN4i3U7+hPKghkC9+9KWzroZHos8ty3ihy7x
         6/2btCnhgirgFhlZ3wvC9RX6kOZT6MaH3bJ6gFV9D6z1xr1UH/aW3Kl0N6mYwBPFQ2gW
         OqEAEVnIWdhAy8a77zigWStGm3mPqRsJeL+fuF4gdq1ceTrmP81G5U5Az/kVLrTyj19Z
         3cxVTHWWEFhvrIzFBGAr4n5ou6t+VoD/USSMvg5qgF08XSzMD7wALxx1Jl/tGJD+mLfi
         KDvA==
X-Gm-Message-State: AJIora+z54aaPw8msWGr0YrouDOfZ2n0LzkKx8tBFiAG6TxSt8mJm4Rk
        VnBS1u2HRkVbuh7HS0tKde37O884C6ZC8oXyfWV033hreiR0+9ZDhLXj1StEh8Z1XrRcuaR1nxk
        LIvhfKIdmvNfPDs8rym1ebOI=
X-Received: by 2002:a05:6000:79b:b0:21e:9709:2c28 with SMTP id bu27-20020a056000079b00b0021e97092c28mr1207790wrb.539.1658763993863;
        Mon, 25 Jul 2022 08:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sef1GCaKVbSp+vxG6KoAAfgr161OZAbpd5DTP5j+7q2VRX59IcIlySPt3xxwReMmx+Yu5DCg==
X-Received: by 2002:a05:6000:79b:b0:21e:9709:2c28 with SMTP id bu27-20020a056000079b00b0021e97092c28mr1207777wrb.539.1658763993587;
        Mon, 25 Jul 2022 08:46:33 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d65cd000000b0021e47386eb8sm12290743wrw.2.2022.07.25.08.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 08:46:33 -0700 (PDT)
Message-ID: <3d2de29a-2a96-867d-907f-6b85573586ab@redhat.com>
Date:   Mon, 25 Jul 2022 17:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 05/10] drm/simpledrm: Convert to atomic helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-6-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220720142732.32041-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/20/22 16:27, Thomas Zimmermann wrote:
> Replace the simple-KMS helpers with the regular atomic helpers. The
> regular helpers are better architectured and therefore allow for easier
> code sharing among drivers. No functional changes.
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

But I've a question below...
 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/tiny/simpledrm.c | 283 ++++++++++++++++++++-----------
>  1 file changed, 180 insertions(+), 103 deletions(-)

[...]

> +static void simpledrm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +						struct drm_atomic_state *old_state)
> +{
> +	/*
> +	 * Always enabled; screen updates are performed by
> +	 * the primary plane's atomic_update function.
> +	 */
> +}
> +
> +static void simpledrm_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +						 struct drm_atomic_state *old_state)
> +{
> +	/*
> +	 * Always enabled; disabling clears the screen in the
> +	 * primary plane's atomic_disable function.
> +	 */
> +}

...do we really need to have these ? Can't we just not set them ?

> +
> +static const struct drm_crtc_helper_funcs simpledrm_crtc_helper_funcs = {
> +	.mode_valid = simpledrm_crtc_helper_mode_valid,
> +	.atomic_check = simpledrm_crtc_helper_atomic_check,
> +	.atomic_enable = simpledrm_crtc_helper_atomic_enable,
> +	.atomic_disable = simpledrm_crtc_helper_atomic_disable,
> +};
> +
looking at https://elixir.bootlin.com/linux/latest/source/include/drm/drm_modeset_helper_vtables.h#L703
that says the .atomic_{en,dis}able handlers are optional.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

