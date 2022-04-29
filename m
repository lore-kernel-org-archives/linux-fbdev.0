Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C00C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Apr 2022 08:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355375AbiD2IKS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Apr 2022 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355373AbiD2IKR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Apr 2022 04:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE4ACBC85D
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651219619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLGpZkEk0zrBfkXdyDNagV1Ot68Eefe6MnXYNDLKtfw=;
        b=QTjC2iFKVFQk6y/2r2Z7/mQuZ0pwzA7EYrbNajsQi0knxTNti1DXoVLccT/zvelepw4TXK
        U1Rmd6vM3NfSp+pYi/GkXW2y2dgFUYmEw7/AjxGb51vipjfZ6nhD61uLDz0NHHy5RRtf0d
        UBq3DTv7rvNQ64mpvMu1F6IKVoA070I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-Ja2L1DCGNQqUdTibEretiA-1; Fri, 29 Apr 2022 04:06:57 -0400
X-MC-Unique: Ja2L1DCGNQqUdTibEretiA-1
Received: by mail-wm1-f69.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso5558724wmh.2
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 01:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DLGpZkEk0zrBfkXdyDNagV1Ot68Eefe6MnXYNDLKtfw=;
        b=2C0GyaumC5ihsK0Ca/+IqJAjha8+heWdelQDd1adAGc6yn36FRgO9UPzDcPDaU4fPi
         bXQ33HaZvUCUN6npEontq9uHT9qPFBgmq8noQVghEKctWFFS5VYZL0hB8LLok4q1+R9o
         HV4iTFVzz5kCRF9pZeS9JqoUHEwSOOfWG5ccg7vxaYbQL4Jll3yhps6FcpPEQlSAIuVu
         4OkTtZFYaK5kuFKER4jYdkpX8xHSMkqrUm/y674Ghoz9nKF/nTYQRd4iKHf3X09x7FL8
         WgfT3+FTEXyECzKXAf05JXpEcIlZD9xC9Qdy6VGjIYo5df/XinMbEPbV7wdhaf+rnxoH
         reAQ==
X-Gm-Message-State: AOAM531A6q1ODRzhXBXRlrgtpZD70p6p8Orxbdeq9+cN3TVQ8yJDic6f
        BG0nmohP7pN/bnds6dtsWV+7+d5k9IdYAbMafLI1pQcM8le5N5qiS5YqPH5fP1rAJDHFCUJIPd8
        OUAhpNn6klioI+kw2zzmGpkQ=
X-Received: by 2002:a05:600c:4ec6:b0:394:1f35:4c69 with SMTP id g6-20020a05600c4ec600b003941f354c69mr1623996wmq.61.1651219616605;
        Fri, 29 Apr 2022 01:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4nhCTQSlkHFSNiSRmvTsdvHGIghcHcLc724I/E5mgFee4F74Ys2EQrG5GMimuyw2I7UjkHA==
X-Received: by 2002:a05:600c:4ec6:b0:394:1f35:4c69 with SMTP id g6-20020a05600c4ec600b003941f354c69mr1623967wmq.61.1651219616352;
        Fri, 29 Apr 2022 01:06:56 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z11-20020a7bc14b000000b0039419dfbb39sm2210341wmi.33.2022.04.29.01.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:06:54 -0700 (PDT)
Message-ID: <97339148-9876-cfc1-8df8-dbb21a9c3c7c@redhat.com>
Date:   Fri, 29 Apr 2022 10:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/5] Fix some race conditions that exists between fbmem
 and sysfb
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yizhuo Zhai <yzhai003@ucr.edu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220420085303.100654-1-javierm@redhat.com>
 <535ebbe4-605c-daf5-1afb-f5225e4bb3a8@suse.de>
 <093d742f-4c87-2ff3-e9fe-153cd734f8e4@suse.de>
 <220929be-91c4-d19c-b04f-312c5f7e9e40@redhat.com>
 <YmuYE2t51lPIRT8p@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YmuYE2t51lPIRT8p@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Daniel,

On 4/29/22 09:47, Daniel Vetter wrote:

[snip]

>>
>> Exactly, should be done when the device is registered rather than when
>> the driver is registered or a call is made to remove the conflicting FB.
>>
>> I'll rework this series with only the bits for sysfb_disable() and drop
>> the rest. We can go back to the discussion of the remaining parts later
>> if that makes sense (I still think that patch 3/5 is a better approach,
>> but let's defer that for a different series).
> 
> We need to kill sysfb _before_ the driver loads, otherwise you can have
> two drivers fighting over each another. And yes that means you might end
> up with black screen if the driver load goes wrong, but the two drivers
> fighting over each another can also result in black screens. And the
> latter isn't fixable any other way (in general at least) than by making
> sure the fw stuff is gone before driver load starts in earnest.

Yes, you are correct. I didn't realize all the possible cases when agreed
with Thomas about doing this but tried and found that it's not enough.

I've a full patch-set now and will post as a RFC so we can discuss more.

> -Daniel

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

