Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395C3C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 May 2022 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiECPcE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 May 2022 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiECPcE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 May 2022 11:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB05828992
        for <linux-fbdev@vger.kernel.org>; Tue,  3 May 2022 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651591710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j50Hj8tQeVhAw3UmlHVgCe3j3gT0Gu2X85okQiDa4t8=;
        b=IIah3cKIpzLg1XhNGjdv4uJiD6E1So0flN40r1k/kmkY2JL31EOm/7d3GSSFVKv3CLfVs4
        SGreuHNOpp9oyBdFKyzyFx/lO30KWupIg24UcH9L3TBYe5XQ0oj+9+KzO6VoI5sFSCf2XU
        vCpD1g/P+hXOT0wOreUisT7HZiOn5iI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-zfhNjeO7Nd29U-g8tapfvA-1; Tue, 03 May 2022 11:28:12 -0400
X-MC-Unique: zfhNjeO7Nd29U-g8tapfvA-1
Received: by mail-wm1-f71.google.com with SMTP id p32-20020a05600c1da000b00393fbf9ab6eso1513065wms.4
        for <linux-fbdev@vger.kernel.org>; Tue, 03 May 2022 08:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j50Hj8tQeVhAw3UmlHVgCe3j3gT0Gu2X85okQiDa4t8=;
        b=l3yAxDE7fauRxsChQjh2J8tm2ednzjX0k0xZZ9yWRAVvsrLyfG9BRuiVYEm0GJ8/eE
         mvlXhXLmIVWEUBTa+/R7y19x5YkMzfdbWZ5sucAaq/0btCsdlPoM9cFUa3xd88ZXQvRk
         xh8AiNXSC9zBnzuW5pD16Cd9kc9ROulf/k/DzRS2bsh6mgkLJWERQGgiqNod/3OFn1c7
         Dyd4F2RXSk5395z8r/BYB1jwNmh3f+YchQuM08RQ7si4gOlFxUvyR7XAGXoyczQcQd/q
         vhoMGFIwfkAz0HEvmJ308urVIU+6axWQ4bzOkA3L2CHcvRPQJEjSOtCDIxlLiv3VEx0Y
         /2Iw==
X-Gm-Message-State: AOAM531PBzUhfHw7/MVEoqG93feohqqH5gXvX7bmvCHzw2tAwzMZG5FT
        qNvPBLm64oRhxZOhp8mgbcEMco6tj6VaWorS0iFHrAAml3oRM1myv4LdoOl9QLRZc8gx30YvTAx
        InfpfouUN531FrcKXwI0iE6c=
X-Received: by 2002:a05:600c:3c8d:b0:38e:4bc6:abde with SMTP id bg13-20020a05600c3c8d00b0038e4bc6abdemr3770023wmb.13.1651591691255;
        Tue, 03 May 2022 08:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8aKnCRfGAhf0ml55t4COEjHHc51OmLWEBcp/UoDfVA5aOjYQU7dHI4VJyeVwkP7P18G5xAA==
X-Received: by 2002:a05:600c:3c8d:b0:38e:4bc6:abde with SMTP id bg13-20020a05600c3c8d00b0038e4bc6abdemr3769995wmb.13.1651591690935;
        Tue, 03 May 2022 08:28:10 -0700 (PDT)
Received: from [10.201.33.11] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id u21-20020adfa195000000b0020c5253d8c4sm9568792wru.16.2022.05.03.08.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:28:10 -0700 (PDT)
Message-ID: <e3ce080c-8ef8-f838-d4a8-b10cd5d5c172@redhat.com>
Date:   Tue, 3 May 2022 17:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zack Rusin <zackr@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220502135014.377945-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220502135014.377945-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/2/22 15:50, Javier Martinez Canillas wrote:
> A reference to the framebuffer device struct fb_info is stored in the file
> private data, but this reference could no longer be valid and must not be
> accessed directly. Instead, the file_fb_info() accessor function must be
> used since it does sanity checking to make sure that the fb_info is valid.
> 
> This can happen for example if the registered framebuffer device is for a
> driver that just uses a framebuffer provided by the system firmware. In
> that case, the fbdev core would unregister the framebuffer device when a
> real video driver is probed and ask to remove conflicting framebuffers.
> 
> The bug has been present for a long time but commit 27599aacbaef ("fbdev:
> Hot-unplug firmware fb devices on forced removal") unmasked it since the
> fbdev core started unregistering the framebuffers' devices associated.
> 
> Fixes: 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal")
> Reported-by: Maxime Ripard <maxime@cerno.tech>
> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
Applied to drm-misc (drm-misc-fixes).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

