Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87847C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Mar 2022 12:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiCIMvK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiCIMvJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Mar 2022 07:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82064517E6
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Mar 2022 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646830209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qK37FEIB2OXNuraDrBny1GHU3Ir9ESnwpP2fxsHmqQE=;
        b=ZWE9qO8QJkiVeecH7hjQDAkoveP4D7RMaUXKw6gkIbq9B9nlUKg6kZNCePH8N/wWfwCoTx
        6S5uhF0RL77ZYLFDKEI6lfLkd24xYy0EaIPtQFaO5MW61Jhoacdmej5G3XDOyHHdN1OIFF
        XeUT0mUs2qmAPNAlyIG8Yv/r9K2Eiqo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-i903WFFiMBOaVPsva9gZlg-1; Wed, 09 Mar 2022 07:50:08 -0500
X-MC-Unique: i903WFFiMBOaVPsva9gZlg-1
Received: by mail-wr1-f71.google.com with SMTP id h11-20020a5d430b000000b001f01a35a86fso728535wrq.4
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Mar 2022 04:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qK37FEIB2OXNuraDrBny1GHU3Ir9ESnwpP2fxsHmqQE=;
        b=2PZ9ePrpSMsyj5qdDxrKRRAr5FxIpwEBp4FzrJ2nZW4NfPRIl1S2xaAcH4j4zZ5Rm3
         5++I87Pkp2IUEp676C9lzu+stb5Q7u4h+BxvUVHSZy9kF5y0r1OzQ0hiacDTHfGr3sZ9
         DjziC1NDqiL1wWT496TYHL0e86Qr/PpwhyL9l6O87dsYjt13bdiArVOCJblzT5LS4wOY
         +jMJ4fwmuHbWlPaNSypqcs3YmO8X8qRG+YrGwEhs/L+LB1Oz86lR9ERkO8BinKB26HNG
         oNlfkGeGvCui14e/+np9MHZcjvztPLzU1Fk8XyYvjXqoe7nemetk2gBsepX02Z+HPuUp
         pxNw==
X-Gm-Message-State: AOAM5323iVTz2ULs3doyXrHGGy5WdfHsJQtPjBySlDLBOkDnukJbX07O
        IG7z6r+mt7rnoCCW8lqKrpDr/wbVRjv1cFEwJN7jYNTQJ55o/nXqWKvZnvFKAsC3wa+56e7DvmB
        UooN7ap/hnati8lelkTd5i+8=
X-Received: by 2002:a05:600c:3391:b0:389:9c6e:c248 with SMTP id o17-20020a05600c339100b003899c6ec248mr7533660wmp.97.1646830207220;
        Wed, 09 Mar 2022 04:50:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeXHfCV/JaoT7fJMQEXpLGuGsq/2+i1HVZtyXeMJ9Df4V6oPcBL176FigUDbOU4N/swo1uMA==
X-Received: by 2002:a05:600c:3391:b0:389:9c6e:c248 with SMTP id o17-20020a05600c339100b003899c6ec248mr7533636wmp.97.1646830206986;
        Wed, 09 Mar 2022 04:50:06 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm1715420wrw.91.2022.03.09.04.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:50:06 -0800 (PST)
Message-ID: <d0c795a7-6379-fa95-7487-982e668df27d@redhat.com>
Date:   Wed, 9 Mar 2022 13:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 02/10] drm/fourcc: Add drm_format_info.is_color_indexed
 flag
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
 <c0a11d8203d58dbaa5f22479c48504dabdd9b4e1.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c0a11d8203d58dbaa5f22479c48504dabdd9b4e1.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> Add a flag to struct drm_format_info to indicate if a format is
> color-indexed, similar to the existing .is_yuv flag.
> 
> This way generic code and drivers can just check this flag, instead of
> checking against a list of fourcc formats.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

