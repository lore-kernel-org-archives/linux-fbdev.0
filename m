Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917F0C43334
	for <linux-fbdev@archiver.kernel.org>; Fri,  8 Jul 2022 13:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiGHNKF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 8 Jul 2022 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbiGHNKE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 8 Jul 2022 09:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD66826AD7
        for <linux-fbdev@vger.kernel.org>; Fri,  8 Jul 2022 06:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657285798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OVPiBMOBBSXkPqruxKFJK+BcZztxHLHpW2iVwBrwzko=;
        b=TbRW+cu0WoTda7KVBiBp4410VW2ePqGwjLr8FjL7/xZqEvopKZEOrKWtGLRE5v3rTn7FW8
        nmT1eSqpaiIEedt9HCZ1uLv+dmOfofbodXtt8r0g04+orXQMPgNqL6A32Ukb90CPD+zOds
        ksanZBG1H+EoBtC+Oe0YBtEuHLCmJg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-IRHMmXqYMnSzMieERQEL6Q-1; Fri, 08 Jul 2022 09:09:57 -0400
X-MC-Unique: IRHMmXqYMnSzMieERQEL6Q-1
Received: by mail-wm1-f69.google.com with SMTP id h133-20020a1c218b000000b003a2cf5b5aabso288735wmh.8
        for <linux-fbdev@vger.kernel.org>; Fri, 08 Jul 2022 06:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OVPiBMOBBSXkPqruxKFJK+BcZztxHLHpW2iVwBrwzko=;
        b=VhvuV9zDsiPq5HibGuuJ5+s8lo28LEU91QzXQwyn+He6tx5xvIgFlm0zqpi4/lmnT4
         1kjeDJzh7eITmkb0BgGJT9kBqek/PU5vHnI81VuaoylfikArDrm2QwrXncUdbkqbcDdy
         vW6CgpPgeMmY3N8c/IAxsBpMrotA5YVRPvKpSsjArm5O2K+rBQAbfGxKN2oIKjKGtCNU
         X4L/hUsq25wMBWvjRbLSbRrC0kvna1nPyc1oBhQF8yilZotflL+6H85doSLJ7bGyDXd5
         VP0wMg4F7cNckNhkaHyHZXzZdVFexeQl0jGkaiqdYVCDQQGcfjguzHWkpD0fbGOHsW3f
         P0DQ==
X-Gm-Message-State: AJIora9u0W74YqpEfIdG+4f1qDi5eHLe7z2XTMyhI9+ZGk3pBPejL2hy
        znXJCHuxQDc6CgfYmjUOVIk7/1YxbYkSfA5k6m+nk37fwcoD6K+Vx2T47ib6rDuZNkssaYp1X3k
        IM5e7NMOVlj+Scx+mh/DKBho=
X-Received: by 2002:adf:f345:0:b0:21d:6a26:6d8f with SMTP id e5-20020adff345000000b0021d6a266d8fmr3451707wrp.538.1657285796009;
        Fri, 08 Jul 2022 06:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u2AkhDh8jVofFJeW+pVfKMxA/4qF0VmyXq6YR/ruIAcicMbW6v2Dejdz7JIXrgYmL0cSbUkA==
X-Received: by 2002:adf:f345:0:b0:21d:6a26:6d8f with SMTP id e5-20020adff345000000b0021d6a266d8fmr3451691wrp.538.1657285795802;
        Fri, 08 Jul 2022 06:09:55 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0039c4f53c4fdsm2618097wmq.45.2022.07.08.06.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 06:09:55 -0700 (PDT)
Message-ID: <fec8dcc1-c490-3bb6-2d2f-805d690d3f95@redhat.com>
Date:   Fri, 8 Jul 2022 15:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/11] fbdev/vga16fb: Create EGA/VGA devices in sysfb code
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 7/7/22 17:39, Thomas Zimmermann wrote:
> Move the device-creation from vga16fb to sysfb code. Move the few
> extra videomode checks into vga16fb's probe function.
> 
> The vga16fb driver requires a screen_info for type VIDEO_TYPE_VGAC
> or VIDEO_TYPE_EGAC. Such code is nowhere present in the kernel, except
> for some MIPS systems. It's not clear if the vga16fb driver actually
> works in practice.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/sysfb.c      |  4 +++
>  drivers/video/fbdev/vga16fb.c | 59 +++++++++++++++++------------------
>  2 files changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 1f276f108cc9..3fd3563d962b 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -94,6 +94,10 @@ static __init int sysfb_init(void)
>  		name = "efi-framebuffer";
>  	else if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
>  		name = "vesa-framebuffer";
> +	else if (si->orig_video_isVGA == VIDEO_TYPE_VGAC)
> +		name = "vga-framebuffer";
> +	else if (si->orig_video_isVGA == VIDEO_TYPE_EGAC)
> +

I wonder if we really need to do this distinction or could just have a single
platform device for both VIDEO_TYPE_VGAC and VIDEO_TYPE_EGAC. After all, the
same fbdev driver is bound against both platform devices.

[...]

>  static int vga16fb_probe(struct platform_device *dev)
>  {
> +	struct screen_info *si;
>  	struct fb_info *info;
>  	struct vga16fb_par *par;
>  	int i;
>  	int ret = 0;
>  
> +	si = dev_get_platdata(&dev->dev);
> +	if (!si)
> +		return -ENODEV;
> +
> +	ret = check_mode_supported(si);
> +	if (ret)
> +		return ret;
> +

What do you see as the advantage of moving the check to the driver's probe?

Because after this change the platform driver will be registered but for no
reason, since can't even probe if orig_video_isVGA is neither VGAC nor EGAC.

[...]

> +static const struct platform_device_id vga16fb_driver_id_table[] = {
> +	{"ega-framebuffer", 0},
> +	{"vga-framebuffer", 0},
> +	{ }
> +};
> +

The fact that the two entries don't have a platform data is an indication for
me that we could just consolidate in a single "vga16-framebuffer" or smt. I
know that this won't be consistent with efi, vesa, etc but I don't think is
that important and also quite likely we will get rid of this driver and the
platform device registration soon. Since as you said, it's unclear that is
even used.

>  static struct platform_driver vga16fb_driver = {
>  	.probe = vga16fb_probe,
>  	.remove = vga16fb_remove,
>  	.driver = {
> -		.name = "vga16fb",
> +		.name = "vga-framebuffer",
>  	},

Maybe "vga16-framebuffer" instead? Since for example VESA is also VGA AFAIK.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

