Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D02C4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiLTJ53 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiLTJ4p (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13573E99
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peb/cvmcArFz0VNGNKDmsg2+BzbJdGM2v+ntzIRyXgI=;
        b=aiGH4xZGGCNGFBXcHuOxW/rhS41asSNyus6tBfUEY3LAq6Ak5OQxoYX7FURO+T42CeofaT
        fxWv2gaP/FTlewJbzxdM8ZPWS6qGjSu+pOnBMH1TD4Gu79Nbp3YKE1UBkjRTWBdytvNnQI
        oiizZ5LSy+sGP4fSu5L7vE9vRcyEt0U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-rC_Tsbk5M9ucs1-LHMOB7w-1; Tue, 20 Dec 2022 04:52:52 -0500
X-MC-Unique: rC_Tsbk5M9ucs1-LHMOB7w-1
Received: by mail-wm1-f71.google.com with SMTP id f20-20020a7bc8d4000000b003d1cda5bd6fso2406253wml.9
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peb/cvmcArFz0VNGNKDmsg2+BzbJdGM2v+ntzIRyXgI=;
        b=yx9InlR2LbS/sPlcWQL33SaA2Wr0ha7SHYMKd7haMO1VC07XUdDJHNEyDYRFAmZB81
         do5UYZ8hV9GaoewZTwC08iAJfE6aJEcLxBExWDUqXb2oeo6IYbUAdv1tTV1FjCg8yXx7
         9Yt9UYPneNSCBRVdyNDsD4D2xqyIVRTVyXlO0JoNz1JDQv1IxiDjDaZFZbXbM9ua/FAb
         rsFYYuDcS0Bz9uf9pdtsyCHS+uiWpprEeVKUt5NVrm7HAik2PScUPTmp6S75ZTPfVHRQ
         tHzdNpMiKQH+WBotvKDGIe5LTsPXUvp43x9BdtLwpldSy+icOJ/6Ja0wmv0pW4tWiXHc
         R7fQ==
X-Gm-Message-State: AFqh2ko2j9o7NGl7yWXprlE6CBNl/7GyokKmYn+KFdOp9YLiQgdfzHhH
        GfG2Zubh35i5tK38Sa+ln9NaqXh+eH2zXnVz5gqSduwmW18LXknatBIVTJGWZziKfjThIdpDwB1
        Sgplu0lqQ7gP7aOCdpEkFj3I=
X-Received: by 2002:a5d:5752:0:b0:244:48b3:d13f with SMTP id q18-20020a5d5752000000b0024448b3d13fmr885268wrw.41.1671529971461;
        Tue, 20 Dec 2022 01:52:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvKoZa/uhHLQyBomu3k7mdpaKOE1hQIbYJw/x2IQ85DXKXu5kOtjcns/1IKHjm8l4vqFcRdlQ==
X-Received: by 2002:a5d:5752:0:b0:244:48b3:d13f with SMTP id q18-20020a5d5752000000b0024448b3d13fmr885265wrw.41.1671529971293;
        Tue, 20 Dec 2022 01:52:51 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ba12-20020a0560001c0c00b002549b649b62sm12363874wrb.50.2022.12.20.01.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:52:51 -0800 (PST)
Message-ID: <bdf39c34-2d98-8d9f-5600-13167d049ce1@redhat.com>
Date:   Tue, 20 Dec 2022 10:52:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] fbdev/hgafb: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221216174633.1971-1-tzimmermann@suse.de>
 <20221216174633.1971-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221216174633.1971-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/16/22 18:46, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

