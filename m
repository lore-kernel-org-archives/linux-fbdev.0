Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93478C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 12:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359867AbiEENBE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 09:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352573AbiEENBD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 09:01:03 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE72E4AE08
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651755443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LTd20GZszus523uhiNPKiPtuh2Omx+Yn3OmwG/k7wIo=;
        b=H7A8qxw6+F5A96ThLOdcb6XBtlITz/+L9EQVM9eoj2FlaRK5OGs7qybi6H7gNU9W5UthfD
        X6XpZOer1zCfa2lkHwD0X6aYrYi5KHBajlDY/pClFyRrdhMhzdo1sRMXUZLPYvHEYYxm/9
        rF6qkqt/SkK8FnSIztVLNc5m8Fq8hL8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-lHC7eJCnPq2TGdeq9ExiYw-1; Thu, 05 May 2022 08:57:19 -0400
X-MC-Unique: lHC7eJCnPq2TGdeq9ExiYw-1
Received: by mail-wr1-f69.google.com with SMTP id t17-20020adfa2d1000000b0020ac519c222so1420986wra.4
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 05:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LTd20GZszus523uhiNPKiPtuh2Omx+Yn3OmwG/k7wIo=;
        b=NBOsjUoGcIB2blD/B5vf2/88WmUWfZaEWhpjKkiLenRzdaeuTcdgIyIfX9uI6hcE/p
         Jxyol96VyoaYhRaU0S4a7mK3VyenfMYYPSQVz7oKeOcYnq1FoHIxrG9kEXIQ4bV8CdgF
         NZN4PIsCakJL7qjgJCZr4ziEn8fWFkapGwXlprc/cn8Caijs+WY0GwTZoQK3nVVqSOJc
         weekVkNFPFI12hFw5UfywanSYWcB1c2/7XSyFc6T9h0lCqjLuHiOVF6tB8hvfpumyC5x
         AKdjje4NKUdpgqD3LepuT1TRPRnckMc4cedy9culgmz9aq3HUdTzB2iTnFsP2ezOLuzd
         gBGg==
X-Gm-Message-State: AOAM530Yu3WC1a+/vC+mCbvIK6NWJQ30ORn064Z9VXWV1ZZVdmiEmiIC
        6CmJkthlWD81mT7QfQnCxM+chD4nVgg0jWIUhktnoJCTvxQlE5f5tTDIhkhqR7hhEo9CvsdDHf/
        LWYH+MxPzYUsmrdLxmmiz3M0=
X-Received: by 2002:adf:e847:0:b0:20c:24f9:57d7 with SMTP id d7-20020adfe847000000b0020c24f957d7mr21058178wrn.284.1651755438720;
        Thu, 05 May 2022 05:57:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNlA3f3CBGEHq3DExbENcRrELKVU9/LhEDR+qaqJ59JtiE6tFlZkZ+L9bNnPC7veaW19r8Lw==
X-Received: by 2002:adf:e847:0:b0:20c:24f9:57d7 with SMTP id d7-20020adfe847000000b0020c24f957d7mr21058161wrn.284.1651755438443;
        Thu, 05 May 2022 05:57:18 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b0020c5253d8e0sm1143692wrv.44.2022.05.05.05.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 05:57:18 -0700 (PDT)
Message-ID: <54ade5e4-d277-1831-06f5-da482c76601f@redhat.com>
Date:   Thu, 5 May 2022 14:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] fbdev/simplefb: Cleanup fb_info in .fb_destroy rather
 than .remove
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
 <20220504215722.56970-1-javierm@redhat.com>
 <YnPInuayAYQa1jmz@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnPInuayAYQa1jmz@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Daniel,

On 5/5/22 14:52, Daniel Vetter wrote:
> On Wed, May 04, 2022 at 11:57:22PM +0200, Javier Martinez Canillas wrote:
>> The driver is calling framebuffer_release() in its .remove callback, but
>> this will cause the struct fb_info to be freed too early. Since it could
>> be that a reference is still hold to it if user-space opened the fbdev.
>>
>> This would lead to a use-after-free error if the framebuffer device was
>> unregistered but later a user-space process tries to close the fbdev fd.
>>
>> The correct thing to do is to only unregister the framebuffer in the
>> driver's .remove callback, but do any cleanup in the fb_ops.fb_destroy.
>>
>> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> I think this should have a Fixes: line for the patch from Thomas which
> changed the remove_conflicting_fb code:
> 
> 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal")
>

Ok.
 
> I think we should also mention that strictly speaking the code flow is now
> wrong, because hw cleanup (like iounmap) should be done from ->remove
> while sw cleanup (like calling framebuffer_release()) is the only thing
> that should be done from ->fb_destroy. But the current code matches what
> was happening before 27599aacbaef so more minimal "fix"
>

Yes, I tried to make it as small as possible. Thomas pointed out that vesafb
has the same issue and I included in v2. I had move things around more there
though.
 
> With those details added Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Same for the next patch.

Thanks. I'll post a v3 adding what you suggested but probably not today.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

