Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ECDC43334
	for <linux-fbdev@archiver.kernel.org>; Fri,  8 Jul 2022 13:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiGHNRC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 8 Jul 2022 09:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiGHNRC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 8 Jul 2022 09:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D96BE17
        for <linux-fbdev@vger.kernel.org>; Fri,  8 Jul 2022 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657286220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taWGRykRcCXffB4wtdvVAvKsI7Nlq7FpgHnPYTf/ge4=;
        b=E/7MEP0CbOh995/qS/q1sEST3WuZr7MFdr/2/miHt2x4xh7lDLEZzU37kaBptkVRMnRwh1
        O9SPT87zWuTgr9WFzV8MO8CIfsY9pK5d0boTAfYKJLKFAuq6QblN2XKcc/w3oSBdo6UqkJ
        HymjCkvkKLInKDiUdPp0iivsDDKli3U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-yszqdoU_NvyuAo3UHnf6yg-1; Fri, 08 Jul 2022 09:16:59 -0400
X-MC-Unique: yszqdoU_NvyuAo3UHnf6yg-1
Received: by mail-wr1-f70.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so3843305wrg.14
        for <linux-fbdev@vger.kernel.org>; Fri, 08 Jul 2022 06:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=taWGRykRcCXffB4wtdvVAvKsI7Nlq7FpgHnPYTf/ge4=;
        b=n1s5LdWpu5vAUkfxPcCMCJosBPCO9fp1fWw9oyighMeoOq6d6TFxnJnHzif3Zuq4dZ
         +EjDb30RSYH24ouBgMil9+eyddtzACUAFtXNQMDS3Y4vaMI3u3h5QS8vS2c+bUXpULd1
         PaXRvRR6IbrEr1A4x2fkqmxpFpgulR5w61xxHPpXtiB1VIDrcgrC0IJ7H4geKvJsXMeh
         GDLwiDkwNfnOr+yUpkYYMzkoRFukpQQFePinVQplkxCP43HktVziaVsabMdnwYenaZDJ
         qdEb1Kl3dABtX+b9hRc8VwmAYWOMCUZRw+A9sEA6gN9+cSAJea/odCmNqK9gzNr4plVX
         q6BQ==
X-Gm-Message-State: AJIora/IPptA/82Yg3MpAsAPhIhtVdUtTfkCJgU5XK1ExcIWMwin0Czr
        wXW+WPN5KA/+FUrxDgz+ZQ8P7mslRoE89XIulpTeaTOPbcdJ8GBVW+hZAKP3BjoyLJnldrcMRTP
        XrV4GwzRAh7+5sAzsv6wwglg=
X-Received: by 2002:a05:600c:22d3:b0:3a2:d8e2:8f15 with SMTP id 19-20020a05600c22d300b003a2d8e28f15mr3947723wmg.177.1657286217989;
        Fri, 08 Jul 2022 06:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uaoPGchnKEAsNWt5YtjhCVNIm3fZ6cMPpN4DNnBgujYqJtYRT2Th3du9stdFVi0zaNnRMlBg==
X-Received: by 2002:a05:600c:22d3:b0:3a2:d8e2:8f15 with SMTP id 19-20020a05600c22d300b003a2d8e28f15mr3947696wmg.177.1657286217740;
        Fri, 08 Jul 2022 06:16:57 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p8-20020a056000018800b0021d7f032022sm6638044wrx.17.2022.07.08.06.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 06:16:57 -0700 (PDT)
Message-ID: <4eb5b59f-2cce-e9d2-a244-4cbe7686fa47@redhat.com>
Date:   Fri, 8 Jul 2022 15:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/11] fbdev/vga16fb: Auto-generate module init/exit code
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-4-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/7/22 17:39, Thomas Zimmermann wrote:
> Move vgag16fb's option parsing into the driver's probe function and
> generate the rest of the module's init/exit functions from macros.
> Keep the options code, although there are no options defined.
>

Ah, I see now why you wanted to move the check to the probe function. If
is to allow this cleanup then discard that comment from previous patch
and I'm OK with the move.

Maybe you could comment in patch 02/11 commit message that the check is
moved to the probe handler to allow this cleanup as a follow-up patch ?

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/vga16fb.c | 35 ++++++++++-------------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index f7c1bb018843..e7767ed50c5b 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -1321,12 +1321,21 @@ static int __init vga16fb_setup(char *options)
>  
>  static int vga16fb_probe(struct platform_device *dev)
>  {
> +#ifndef MODULE
> +	char *option = NULL;
> +#endif
>  	struct screen_info *si;
>  	struct fb_info *info;
>  	struct vga16fb_par *par;
>  	int i;
>  	int ret = 0;
>  
> +#ifndef MODULE
> +	if (fb_get_options("vga16fb", &option))
> +		return -ENODEV;
> +	vga16fb_setup(option);
> +#endif
> +

I would just drop these ifdefery and have the option unconditionally.
It seems that's what most fbdev drivers do AFAICT.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

