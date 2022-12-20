Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D96C3DA78
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiLTJmo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiLTJmI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:42:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD437120A5
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LveyBWJYAPbiyv73TUAfukc6OJNlBtbiuo6YSIh6FLQ=;
        b=aEDKtyS+M8N2U9M9q5HBtxOiypTIoQCppxvr2+W6y4S0U2424W/QwNiVeg67YgRIprkZjr
        GxoKKU40yc6KdDBZPoQKOgnlz4N3WhhV7bMwfFLi3GcYmaYKynBSj3baWxkWxC/Kr73rHG
        kr05ccTK+0ojKeQ5eBu+oB1xO8/mKyE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-kwaHBwXsOXeXBRKNSH7zgA-1; Tue, 20 Dec 2022 04:40:58 -0500
X-MC-Unique: kwaHBwXsOXeXBRKNSH7zgA-1
Received: by mail-wr1-f70.google.com with SMTP id n12-20020adfc60c000000b0026647ef69f4so255226wrg.10
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LveyBWJYAPbiyv73TUAfukc6OJNlBtbiuo6YSIh6FLQ=;
        b=T8HbfFmvF+Hi5R9PoGEDGphJEfDvBfMtrGx1ooEP8ga+u8HlM3Z3AKacmDF7kEM+wa
         xNkVRFXwTAruNAk3JkWAZaaQsOB3KseLqWRYcs4YgO+WMGzJC4LmLbFBXQd/Tzpej03C
         /yl+PgGDyCrSR158Ilz/eaEPdf8UOigufRY7kro6WyqwU0s3mJN02flXTmRg3SNTUMCF
         Ewx53THUNXyZpz65LXtZA6I27Eb65fD4VJLOXHuLt4H48zxkTKsvMfUrAP59+zkr/lLV
         EDMV+wxkKIztAUUOm1gDbvkFSaAKilVQ+WRVRrxeqGylNMHYafALNAHvK9udSvNnDsow
         fdtQ==
X-Gm-Message-State: ANoB5pmrYwKpLa+sxONWBQHK7Ioosc/nr10ba9m7KZk00XeTC1o6+GL2
        wHlhtqusegc9ztiN4TXr9VCxhc4FSPaBwW1nXC8Wz5Z3zOrmuJViakEp8u3OO+VqMJ3aN8CjjAw
        xbKGLOAM31ay9XoRXj/9eWSA=
X-Received: by 2002:a05:600c:1c23:b0:3d2:3376:6f2e with SMTP id j35-20020a05600c1c2300b003d233766f2emr22381402wms.9.1671529257842;
        Tue, 20 Dec 2022 01:40:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7eSfSzTvRvhDpxH502Pk0KEhQEu8qDdlhID/m63O9KppBhxg3tASNRV4SrXUiQOLpYrNpaag==
X-Received: by 2002:a05:600c:1c23:b0:3d2:3376:6f2e with SMTP id j35-20020a05600c1c2300b003d233766f2emr22381388wms.9.1671529257649;
        Tue, 20 Dec 2022 01:40:57 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id by3-20020a056000098300b002366c3eefccsm12187201wrb.109.2022.12.20.01.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:40:57 -0800 (PST)
Message-ID: <6b3825fc-e149-9096-0438-0fb2c717f3d6@redhat.com>
Date:   Tue, 20 Dec 2022 10:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 15/18] fbdev/vesafb: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-16-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-16-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
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

