Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A58C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 May 2022 12:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380250AbiEMM37 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 13 May 2022 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380274AbiEMM3z (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 13 May 2022 08:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FDEA60DAC
        for <linux-fbdev@vger.kernel.org>; Fri, 13 May 2022 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652444980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUx2v8qsPenRXH9JcXLDmo2qkX4LLDjdAwjr1Yz2a/c=;
        b=YOjNa33ZP1Cn+p47zLZHI9F4BP63n50efsfDXDqWgEz40Wcb/WsX8tgdqe5GWx+YYJLnck
        DSzgS+TKThv1yxcuTAhGFG2P2O1ngKEjya6sAUxK22URd5HGPN86AK72cRsBAb6FS/P5aM
        z3Yk/BItliXdV1kZfHcgDPChCxDbiJU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-BHHOhWSpMNCRe1GMdQrHGg-1; Fri, 13 May 2022 08:29:29 -0400
X-MC-Unique: BHHOhWSpMNCRe1GMdQrHGg-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so2876033wmr.0
        for <linux-fbdev@vger.kernel.org>; Fri, 13 May 2022 05:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RUx2v8qsPenRXH9JcXLDmo2qkX4LLDjdAwjr1Yz2a/c=;
        b=ggQTndqwtfbHqZNtCrrm07JP6JJ/ozebPRMlErdIR5I3jsJP8awUSQd/GL6EA8NNry
         vhsxFYMpQ25Z8s+WkYwNzRGnf5js3sd0ojFkN35SddHS/aCjsKmGsg1KuoNIzYcZVu/c
         z+RFBGGvT2JExpq4A8JKsxTASkENKp1xVLUwvncSl2AlJ20qgVqDhnR0Fle6ATyfvlGc
         3oQMRqIdlP6ONlBq7SckEDSmqz78UROf74UJ1sFJIrKrrIRFmKokFA6Yxi2meuyhYqoH
         sqHks33qRvTLt2b04wj/8kv/wdqPZ9Q1MIfz5RFoLxbSBYECuwtRI2/GFKl7RfKc359I
         WHDw==
X-Gm-Message-State: AOAM5302JfgNup67MHUgGnA1oOwAHZg8dwux4UNlVW41tOOPUVJWlRY2
        Udv0eLdL2Fr46Xu8CqV0/W+rv1Xo2NByaVqZ8vfd8CPqG/VFzULkXp1xEDV54FMWiNJYcxkpruC
        3SnpF5o88Z/U/6/8cdkbemkU=
X-Received: by 2002:a05:600c:3ba5:b0:394:6a82:8dbe with SMTP id n37-20020a05600c3ba500b003946a828dbemr4251409wms.185.1652444968342;
        Fri, 13 May 2022 05:29:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZHiFgsQEc6o9p9wXNxY7rLpgdqYrrRy8dqWoxDl7lbXz2Av9EzL6Uyc1s2ZY/cv0n+100bQ==
X-Received: by 2002:a05:600c:3ba5:b0:394:6a82:8dbe with SMTP id n37-20020a05600c3ba500b003946a828dbemr4251399wms.185.1652444968161;
        Fri, 13 May 2022 05:29:28 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o42-20020a05600c512a00b003942a244f49sm5910754wms.34.2022.05.13.05.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 05:29:27 -0700 (PDT)
Message-ID: <0876d022-f6e2-a0cf-0e16-d6a19aec0a48@redhat.com>
Date:   Fri, 13 May 2022 14:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fbdev: vesafb: Allow to be built if COMPILE_TEST is
 enabled
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220505120419.314136-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220505120419.314136-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/5/22 14:04, Javier Martinez Canillas wrote:
> The driver has runtime but no build time dependency with X86, so it can
> be built for testing purposes if the COMPILE_TEST option is enabled.
> 
> This is useful to have more build coverage and make sure that the driver
> is not affected by changes that could cause build regressions.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed this to drm-misc (drm-misc-next) with Thomas a-b tag provided over IRC.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

