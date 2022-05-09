Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5025BC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 May 2022 14:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbiEIOlK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 May 2022 10:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiEIOkx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 May 2022 10:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1A1025C2AB
        for <linux-fbdev@vger.kernel.org>; Mon,  9 May 2022 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652107018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4x1JmNs0lN7zeQuuaFUFxxo45axmawzrmuIq6d0Zls=;
        b=EySKNhYcCHL/N+0VN/t2VwlWCmPrMJyr0lv59WdD6nGzyXA1L7/9h0bMQcHd7OKr2TDubW
        /SOdsyuAaetyXz+N3v5AaKNJVGv2KfVNEaGnf0BXuvZdk11u6Bpw5eqqsCzRHq03BVvZ+D
        EyCx9A4c5qazkn0RsPki5LkRq79fKIk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-aMatRNIKN2mKfKM5o3Kstg-1; Mon, 09 May 2022 10:36:56 -0400
X-MC-Unique: aMatRNIKN2mKfKM5o3Kstg-1
Received: by mail-wm1-f71.google.com with SMTP id m124-20020a1c2682000000b00393fcd2722dso3946796wmm.4
        for <linux-fbdev@vger.kernel.org>; Mon, 09 May 2022 07:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n4x1JmNs0lN7zeQuuaFUFxxo45axmawzrmuIq6d0Zls=;
        b=mik2jjeXwvzXJ/ZHxSuZPJFExcOw3m1e2V9YjPYSA/cph6FMFSdhUnvEwe4jbJ5Ydv
         WnfpOsQsq6Wx14IO5J7OfRAL4so0nuvu00vwduVyLlPtd1bsGo/pPZe01jP/eiW66efJ
         IodnDgjhPhKSWWpdTSd+XJz69DrpZgzPL8gHdYN8bqBISl9UTjE1PAxPifFpOmOAwzEW
         Vh7KcLmF3/rHz1BjQrZ4pqt8pGRIwZ9wSmpyU+loiEtj49gGCht/rxT5UlUOYtN8wlw8
         A3oP9rMvW/kNw9Hw8VBJwfrxBTlWXfozVpPkLgfZYqwCk+DVRAriA/QO0FAm2aKpFoZC
         YEpg==
X-Gm-Message-State: AOAM531Xa13wNl/6H6yFemUfiHJ8OPk1+UJLvNmR5QpGX2PQwRRybd5R
        NVsfi387ds5rtArHc+I+U0FM5Zyu6UWkT0Plb7WLYQ6KjN1RJ9nrouhU30Qwa5FvqTukc4PQetV
        iv+lPV72IS/aLXjlsH5WwYjg=
X-Received: by 2002:a1c:cc08:0:b0:393:e7d2:e580 with SMTP id h8-20020a1ccc08000000b00393e7d2e580mr16812230wmb.145.1652107015560;
        Mon, 09 May 2022 07:36:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGrLL/VVSw/WOa5yPynAZPNzHztUeFn+CzxclQK7K/jvA6IsiCIdA26rF3Brew3Axf9EMHww==
X-Received: by 2002:a1c:cc08:0:b0:393:e7d2:e580 with SMTP id h8-20020a1ccc08000000b00393e7d2e580mr16812218wmb.145.1652107015350;
        Mon, 09 May 2022 07:36:55 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j14-20020adfe50e000000b0020c6a524fd5sm12998987wrm.99.2022.05.09.07.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 07:36:54 -0700 (PDT)
Message-ID: <d0c7f668-e7db-f835-b410-6a6af516ceed@redhat.com>
Date:   Mon, 9 May 2022 16:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] Revert "fbdev: Make fb_release() return -ENODEV if
 fbdev was unregistered"
Content-Language: en-US
To:     public@timruffing.de
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <642f515e-aa71-7c90-a715-e49dcf12baee@redhat.com>
 <20220509140149.34734-1-public@timruffing.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220509140149.34734-1-public@timruffing.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Tim,

On 5/9/22 16:01, public@timruffing.de wrote:
> Thanks for this patch. Do you think this can be backported to LTS 5.17.y and

You are welcome.

> 5.15.y, which are still buggy? It's not a big deal for me but others might
> profit.
>
> Background:
> The patch solves a regression from 5.17.1 to 5.17.2 or 5.15.32 and
> 5.15.33 I was about to report. On my Thinkpad T570, I got random "BUG", "Oops"
> or even panics when during booting with efifb and plymouthd (and then sometimes
> also problems when shutting down because). I had bisected the issue to commit
> 27599aacbaef. I could provide more info but I don't think it's necessary given
> that either aafa025c76dcc7d1a8c8f0bdefcbe4eb480b2f6a or your better patch now
> fixes the issue (I tested both, both work for me).
>

The patches to fix the fbdev hot-unplug regression will get merged in mainline
soon and since all have a Fixes tag, they should get picked for stable as well.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

