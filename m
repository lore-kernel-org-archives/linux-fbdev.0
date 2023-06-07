Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D09C77B7A
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjFGJDK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbjFGJCs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E122114
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ha3iiTWVECujH5I3jqgNS4AW7y6robxFbsBFSl574Yk=;
        b=aXSayM6ds2nRrTCS+Qcapo0hKe5xZcRkKIHsMW37HxsvqTFTnOaP5WEfUGSBIZzdIkPjlt
        9rLkbOfIAJzHzgOkZD4+AOEyUvO2djlHS2jt1vpj/oju5fNURqeU014t5/EPdXId48NiEj
        dTn5ytekCwdAMqymS9twHpBMLw9aU3Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-GZZ8_mHbNNeoUNo-Z1NRRA-1; Wed, 07 Jun 2023 05:00:21 -0400
X-MC-Unique: GZZ8_mHbNNeoUNo-Z1NRRA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30af00323b0so3227123f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128420; x=1688720420;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha3iiTWVECujH5I3jqgNS4AW7y6robxFbsBFSl574Yk=;
        b=iN+RBYqVBGschPGMP7Lj6xv1aJ4DC9IysiprMkKhgPgWxLQ6UrpbxhtlmpVAz55gW9
         oD5zg3UaB6Vv2dc07k9q6th1jm03wNHxG0FuPcsx8gBQOiaNZ3R2b/+URe9szZiRpIwg
         RPvHh2IUOer/xf7EiSxqCiO7yXUl8txKfOjV/8p+rQeR9830vSGvnx8ISs5SFxXo9ugl
         Df16KbYSAUiUNgL/VKI2BJ9CQ3sp2yAHhVYHUyR/lu9mCRY2FYeFcVfmRXko/yjv03rZ
         ZKZZJRqb6dAbThoRHB0AE9I/PswlxKAMka0n2gDRuvFNLoeDUWK6AYvrxcD5Wc1+DNIA
         WU+g==
X-Gm-Message-State: AC+VfDxcB4W/8rOt+3YGqJeKQ0xXobILlaD/b3z2OC1QqSCniy8Kiq/S
        o0zMb/2TCyc5qKmISlfVvf8QAnXAUPcfg8imLBBI9IsDe8BUM6HN2zcfmRU2U8uXke6AqmIRk32
        JonKJyBGeF9PXFNPYAD/GYB4=
X-Received: by 2002:a05:6000:503:b0:2ef:ba4f:c821 with SMTP id a3-20020a056000050300b002efba4fc821mr3492631wrf.36.1686128420034;
        Wed, 07 Jun 2023 02:00:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6K7G3bt0VUByq7FRT2lQ5ZRsRDVTyfbQ/GNM/0/foGN7SQ7frEuHnXH19X2JYBcLKX3c3pJQ==
X-Received: by 2002:a05:6000:503:b0:2ef:ba4f:c821 with SMTP id a3-20020a056000050300b002efba4fc821mr3492608wrf.36.1686128419772;
        Wed, 07 Jun 2023 02:00:19 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d594c000000b0030ae16132besm14801751wri.12.2023.06.07.02.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:00:19 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 11/30] fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
In-Reply-To: <20230605144812.15241-12-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-12-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:00:18 +0200
Message-ID: <87ilbzfxzx.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Do not assing the Linux device to struct fb_info.dev. The call to
> register_framebuffer() initializes the field to the fbdev device.
> Drivers should not override its value.
>
> Fixes a bug where the driver incorrectly decreases the hardware
> device's reference counter and leaks the fbdev device.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

