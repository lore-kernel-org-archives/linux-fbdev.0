Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA6C43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 13 Jun 2022 19:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbiFMTT5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351208AbiFMTT3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EE8D52E6B
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Jun 2022 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655141060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGvm3qwPoTuLTdX5NWsaOkcpvKYLKtr/ysaBv6CZIVc=;
        b=bntjUGXbaaJNFQeUvv040Uy44fbb826tEOs0r2sHvL0beOdB5KMMd+bqPz39ucQahWFatm
        Ys+90RP2290MOVRKlTtdhjXr8v6Wu5UCPhdtbFU6H1gsisPomLjkFPD2e88KGX0CXVBMkq
        zknNi4IJTh2C9xoiBm2ySlW8Zx9B1Ww=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-UMYv45fUOxCFCjnIUbPU-w-1; Mon, 13 Jun 2022 13:24:17 -0400
X-MC-Unique: UMYv45fUOxCFCjnIUbPU-w-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so2798204wmr.0
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Jun 2022 10:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yGvm3qwPoTuLTdX5NWsaOkcpvKYLKtr/ysaBv6CZIVc=;
        b=oXeSFChhPkK66x5vWnciwq/lgcQK8FXpL8OGrxRDTeykFzZ/cIlA30xXktHGmNfCJk
         op8gqrK6sPVRTYBPIPHsQWg/0Wl4uji097irzrZsGEce5JxaIXw8S4aG5znqCEBTFo8+
         lAwRKhShcbLCBZFXVtZ4/LLNcrrcuNODeiYx+L1KrsY2LN0WhrPkVcbJ1DRbhXlnp5zQ
         SnxWFAywqw6l54gAfaKqRkW2NWzgHuLHdxZ47bcvLYh4vE6C/eWb4+TW5PwT80hcbmeC
         JpX5wFSiimUDCNHIQptXlPP7aZCZure5Q+zSLCMuBik/bieopk8RlCNtovsgfDSCmaGt
         cYLA==
X-Gm-Message-State: AJIora/0R+8FgMMP4lQxIangFDwfSQwVNZGgoEJvJ+iv2JtVWnvjxlTS
        3/MfmTPZp/lH3m64DZ86pajbxwbfMzDTn1YTTdDtiIVyGVU/RcO7DB5CFog0wW7CBnzw7nLceVF
        oBN5WDsHVMhtjOYPOxaunvkA=
X-Received: by 2002:a5d:5109:0:b0:218:40cc:a29b with SMTP id s9-20020a5d5109000000b0021840cca29bmr858415wrt.601.1655141055797;
        Mon, 13 Jun 2022 10:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umQvbmUV5kyQfsWQKm16COOgbaUu2gIG10MNTDJcGldHmXD3XO1wIjQhiRvT60PcbnoxxDAQ==
X-Received: by 2002:a5d:5109:0:b0:218:40cc:a29b with SMTP id s9-20020a5d5109000000b0021840cca29bmr858386wrt.601.1655141055500;
        Mon, 13 Jun 2022 10:24:15 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d5385000000b00213b93cff5fsm9082661wrv.98.2022.06.13.10.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 10:24:15 -0700 (PDT)
Message-ID: <bbddcf97-7ab2-209b-e777-1874557491a3@redhat.com>
Date:   Mon, 13 Jun 2022 19:24:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Revert "fbdev: vesafb: Allow to be built if COMPILE_TEST
 is enabled"
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fbdev@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220610085450.1341880-1-javierm@redhat.com>
 <YqMTI3yxmWq/f+Gp@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YqMTI3yxmWq/f+Gp@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 6/10/22 11:47, Daniel Vetter wrote:
> On Fri, Jun 10, 2022 at 10:54:50AM +0200, Javier Martinez Canillas wrote:
>> This reverts commit fa0e256450f27a7d85f65c63f05e6897954a1d53. The kernel
>> test robot reported that attempting to build the vesafb driver fails on
>> some architectures, because these don't define a `struct screen_info`.
>>
>> This leads to linking errors, for example on parisc with allyesconfig:
>>
>>   hppa-linux-ld: drivers/video/fbdev/vesafb.o: in function `vesafb_probe':
>>>> (.text+0x738): undefined reference to `screen_info'
>>>> hppa-linux-ld: (.text+0x73c): undefined reference to `screen_info'
>>    hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>>>> (.init.text+0x28): undefined reference to `screen_info'
>>>> hppa-linux-ld: (.init.text+0x30): undefined reference to `screen_info'
>>    hppa-linux-ld: (.init.text+0x78): undefined reference to `screen_info'
>>
>> The goal of commit fa0e256450f2 ("fbdev: vesafb: Allow to be built if
>> COMPILE_TEST is enabled") was to have more build coverage for the driver
>> but it wrongly assumed that all architectures would define a screen_info.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

