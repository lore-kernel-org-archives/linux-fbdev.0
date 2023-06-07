Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1793EC7EE29
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 22:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjFGW0d (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjFGW0Y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 18:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B12709
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686176567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67Wr4HmC8kXtCL1x0dOeckxppNMmBntLK5uulGf1sqg=;
        b=K9VAbmiHShuwfsyDQrJvd+WZHm1rDaFrCct+LFfVotFYKW8e5kujZTVjxIuq7hkvPNgEOx
        ZEsfpCix2dyS3LvdpesA1MARhlEB8q5erMjOYYKjLjpam2FOOzXbQ7puVqSkOcu43yigVP
        aIHoP91l4IdrkC1Mjo4A3ShqyziWkQ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-1fK_LWzpPvKjIXT-qqcTSg-1; Wed, 07 Jun 2023 18:22:46 -0400
X-MC-Unique: 1fK_LWzpPvKjIXT-qqcTSg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7678c74beso25521015e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 15:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176565; x=1688768565;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67Wr4HmC8kXtCL1x0dOeckxppNMmBntLK5uulGf1sqg=;
        b=kvHTfNyUHTqSaq89hvEMy7fkcS0TYFuWcWv7FcXIY4Aa5NIY0OU+Mf9HW2X26nqs35
         YrbfVAbSqQUjzX10VMdIXlvrVdrJYff08nZ+q2q/WT8++I7DS4hsSuf4b/akbLh/wpzO
         qSGDPIJJ+9K8JiSKB0zMbHf3d41gHeCeWPaquK9zuyZg/99foT+ns+wTG9WBOGNMpw5Q
         ENu/oQ1Ns17B73tMCrXQ3aMOP+eYFaLtI+9AFKb1RDGnDXCpcCkY4SzggSfALzm7UsAk
         XYM0jKpO37MyADB2NLe3TJ80SDey2UIjJYhwtL6zee08wWqKuZfvNZ5OUrWFr+u6P6hP
         cW+A==
X-Gm-Message-State: AC+VfDz+QxckeA887f85n8JBvNT+nSm/aD+vEBbK3kqje7XZ1iOfS7yY
        zXUumdV/xcIv6HAcmQ30MG0nSQ+cnHlcXrhOre4gq4iz66J7+STC7Qq5C2Kggs4h8yBdSOc7c5X
        t9YT5ITw/eU7g9Y49i+AHrp0=
X-Received: by 2002:a1c:4c11:0:b0:3f7:26f8:4cd0 with SMTP id z17-20020a1c4c11000000b003f726f84cd0mr5570484wmf.16.1686176564940;
        Wed, 07 Jun 2023 15:22:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74+KkyeYoTNHdtFgdPjs/ko5gB/9QwThWFkjR0/oU0p3+M7MfNC36MRsPeTiM50kMg9GLwXA==
X-Received: by 2002:a1c:4c11:0:b0:3f7:26f8:4cd0 with SMTP id z17-20020a1c4c11000000b003f726f84cd0mr5570479wmf.16.1686176564616;
        Wed, 07 Jun 2023 15:22:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v6-20020a7bcb46000000b003f6028a4c85sm3342086wmj.16.2023.06.07.15.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:22:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Steve Glendinning <steve.glendinning@shawell.net>
Subject: Re: [PATCH 22/30] fbdev/smscufx: Detect registered fb_info from
 refcount
In-Reply-To: <20230605144812.15241-23-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-23-tzimmermann@suse.de>
Date:   Thu, 08 Jun 2023 00:22:43 +0200
Message-ID: <87edmmewuk.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Detect registered instances of fb_info by reading the reference
> counter from struct fb_info.read. Avoids looking at the dev field
> and prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Steve Glendinning <steve.glendinning@shawell.net>
> ---
>  drivers/video/fbdev/smscufx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
> index 17cec62cc65d..adb2b1fe8383 100644
> --- a/drivers/video/fbdev/smscufx.c
> +++ b/drivers/video/fbdev/smscufx.c
> @@ -1496,7 +1496,7 @@ static int ufx_setup_modes(struct ufx_data *dev, struct fb_info *info,
>  	u8 *edid;
>  	int i, result = 0, tries = 3;
>  
> -	if (info->dev) /* only use mutex if info has been registered */
> +	if (refcount_read(&info->count)) /* only use mutex if info has been registered */

The struct fb_info .count refcount is protected by the registration_lock
mutex in register_framebuffer(). I think this operation isn't thread safe ?

But that was also the case for info->dev check, so I guess is OK and this
change is for an old fbdev driver anyways.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

