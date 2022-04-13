Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3785CC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Apr 2022 10:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiDMKxR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Apr 2022 06:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiDMKxQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Apr 2022 06:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26126C51
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Apr 2022 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649847054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8f/PwshmkguRT4VixsIFRRZxWGHz2g1FKjPSgvCys1U=;
        b=YvWwsX42oWJbar3pG2gGY6mBxHDHtTLTuDYGUjDDjmLlUpUs614PFbTHJEsHtV1lAYyvnj
        vk3zTUN8KrpLj9zBM7mb6fm6EGmeEooGpDuoSVj+IOEL2KiGwfIN6695wsgpTZX1jVgp4/
        qXB8rZiu8oWoiK7Wc5xcMWP0bZzkb3I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-xfBIsP5MMoyCxVoCT05ITQ-1; Wed, 13 Apr 2022 06:50:53 -0400
X-MC-Unique: xfBIsP5MMoyCxVoCT05ITQ-1
Received: by mail-wr1-f70.google.com with SMTP id j67-20020adf9149000000b00203e6b7d151so254509wrj.13
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Apr 2022 03:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8f/PwshmkguRT4VixsIFRRZxWGHz2g1FKjPSgvCys1U=;
        b=psAwmPRllaCsYOtSIVELvVie1/tM+Zn82+7WxqsbDCT0J9Pyn0l644Xvg+ulBVhmm3
         w6PbULIrCZLXHBCBIBiMMu8X0mJW7WZerw/XDtzAfMNOFBDHHS/kS5vn+UvQ9AUo7Nlx
         N4/YtQP1aNSLyWfvJuoaSUM6gfTZZMeOXfOJptj9ie4eNy8V9//2DqUH0/gPZRoNar7O
         q0+3KcJId32xgmr6ghNsEYIyj06/ackp4b6ShoRz6jJ8XquvpzAL7NJkCmYIdZ8MmF0k
         lLcfHNhAQTCsUuDl+VKS5tT16btK6MPvSr3rf7ysgS4Vgjw5weJ1HZHeXW8P3kmrEaQh
         J9JA==
X-Gm-Message-State: AOAM530c5cEkRztrxpqGuDH0DESClkdCmEp+Q8TnQ06Jss1tH7UXw/Xd
        Nlc4B4eqySTIVIiXP1Y/ZjDE0p+cOzKcNibtQdCucPhqQ/5BwjdvKQ4IpA/+OHfpm9o7VBBm0Su
        NP4A+4EeM/XG3vWrcCGtrMAM=
X-Received: by 2002:adf:e2cb:0:b0:203:7564:1076 with SMTP id d11-20020adfe2cb000000b0020375641076mr32602167wrj.199.1649847052082;
        Wed, 13 Apr 2022 03:50:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRxfN1JAPTNpXMTTDU9DhECg4cctSX/rrDt8wkv7XgQMTGGJbHn9zb6tPrmr8j280opAJ2Jg==
X-Received: by 2002:adf:e2cb:0:b0:203:7564:1076 with SMTP id d11-20020adfe2cb000000b0020375641076mr32602150wrj.199.1649847051871;
        Wed, 13 Apr 2022 03:50:51 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c2b04000000b0038a0e15ee13sm2157211wmr.8.2022.04.13.03.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:50:51 -0700 (PDT)
Message-ID: <2e183cc9-603d-f038-54aa-5601f11b0484@redhat.com>
Date:   Wed, 13 Apr 2022 12:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] fbdev: Remove hot-unplug workaround for framebuffers
 without device
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, robh+dt@kernel.org,
        frowand.list@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        sam@ravnborg.org, linux@roeck-us.net, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
References: <20220413092454.1073-1-tzimmermann@suse.de>
 <20220413092454.1073-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220413092454.1073-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 4/13/22 11:24, Thomas Zimmermann wrote:
> A workaround makes fbdev hot-unplugging work for framebuffers without
> device. The only user for this feature was offb. As each OF framebuffer
> now has an associated platform device, the workaround is no longer
> needed. Remove it. Effectively reverts commit 0f525289ff0d ("fbdev: Fix
> unregistering of framebuffers without device").
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/fbmem.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index bc6ed750e915..bdd00d381bbc 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1579,14 +1579,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
>  			 * If it's not a platform device, at least print a warning. A
>  			 * fix would add code to remove the device from the system.
>  			 */
> -			if (!device) {
> -				/* TODO: Represent each OF framebuffer as its own
> -				 * device in the device hierarchy. For now, offb
> -				 * doesn't have such a device, so unregister the
> -				 * framebuffer as before without warning.
> -				 */
> -				do_unregister_framebuffer(registered_fb[i]);

Maybe we could still keep this for a couple of releases but with a big
warning that's not supported in case there are out-of-tree drivers out
there that still do this ?

Or at least a warning if the do_unregister_framebuffer() call is removed.

Regardless of what you chose to do, the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

