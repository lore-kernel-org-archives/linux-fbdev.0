Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9858BC4332F
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Nov 2023 15:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjKAPhA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Nov 2023 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKAPg7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Nov 2023 11:36:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D76DA;
        Wed,  1 Nov 2023 08:36:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so10901603a12.1;
        Wed, 01 Nov 2023 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853015; x=1699457815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hexmk49ujNpb1xtdHgW2u+GIQeyEe+vJ7SF4SxvQAsE=;
        b=To6GlV/KdFOpByY1yvAw7isqSl8s4HfsUh4dzfs14IXxdseir8HOdPMYZFDsVoTUdg
         WXGUwEn21qaRnWNCnIy314lqniL7n1V5gY8au63vnnqi6gzbeTSLY1TYWsJS2hov7PQ/
         4xrw/jezioilfbPeRIXruL033DEOzs0qUX+BanwxjgjVOhICC56DjPzuS7p1uy0KYk7S
         xZCZmkn8OxFiAZU0HjCtACIus/afIlH/SbV1ZdPWAP4YKAVcewuar93Qc3LyOcGiWD7s
         L0Ufh3ut/JuKtuhh7+GkHaznv/Y74z57HUXu18FskacLXYyRr7oWC25ZKXcmI5qQFDt9
         G6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853015; x=1699457815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hexmk49ujNpb1xtdHgW2u+GIQeyEe+vJ7SF4SxvQAsE=;
        b=RjFQksVYmB48C7RIXjV+r/mTLEyJ3d/lqFkvFeHT1TOQC97sOxeeq5m/kOqdmdLpoP
         U5n6pT95GdR/IufWvQbyq1TuhrIP0VeRhkzKtK8DkYD3TePMSAnywuykUF1iafRtcCfb
         RtYNm88yjMf+hIHIrkrF8ZfBwAhdDrmfhTa3k7nnZhA4DlHHxzRFkxoPrUhvskCOQN6j
         n5Pll7dMgwlV01XYoVfGMnOOuULTGgUu5VJm7DMGLARMWYX3CG314ngAiOj0ZpnIRxMS
         6V5Bz0/kvcJYWKAYdGP5KmpFNC2dVlBUlLn627JoqdSuTIpTrGFlANZmGM87CcW18ZS9
         RJ1g==
X-Gm-Message-State: AOJu0YzU3QhY1ou/7fNXksAI/lMDb9CIAY/ztrU9v7jTJx1hh05EYmN+
        XU/F++6eTYWS4Op0SPq/Og==
X-Google-Smtp-Source: AGHT+IHGBq6ikaR1Vc0Dr5gti0wNOgkMImLBk6ma21/TdEmuBAI35mUjQ49xGCe1d1e1AA5A2y3fCQ==
X-Received: by 2002:aa7:d0ca:0:b0:530:74ed:fc8a with SMTP id u10-20020aa7d0ca000000b0053074edfc8amr12958328edo.41.1698853015062;
        Wed, 01 Nov 2023 08:36:55 -0700 (PDT)
Received: from [192.168.78.129] ([105.163.156.68])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7dbca000000b0052ffc2e82f1sm1191247edt.4.2023.11.01.08.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 08:36:54 -0700 (PDT)
Message-ID: <9d00781f-3c24-401d-902a-451e38c19e3c@gmail.com>
Date:   Wed, 1 Nov 2023 18:36:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] staging: sm750fb: Remove unused return value in
 display_control_adjust_sm750le()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231019101348.22076-1-anonolitunya@gmail.com>
 <20231019101348.22076-2-anonolitunya@gmail.com>
 <2023102113-barbell-amazingly-cef6@gregkh>
From:   Dorcas Anono Litunya <anonolitunya@gmail.com>
In-Reply-To: <2023102113-barbell-amazingly-cef6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


On 21/10/2023 13:01, Greg Kroah-Hartman wrote:
> On Thu, Oct 19, 2023 at 01:13:36PM +0300, Dorcas AnonoLitunya wrote:
>> Modifies the return type of display_control_adjust_sm750le()
>> to void from unsigned long as the return value is being ignored in
>> all subsequent function calls.
>>
>> This improves code readability and maintainability.
>>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
>> ---
>>   drivers/staging/sm750fb/ddk750_mode.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> This patch doesn't apply against my latest branch.  Please rebase it and
> resend.
>
> thanks,
>
> greg k-h


Hi Greg,

Sorry for the delay. Was occupied on the project starter tasks. I have 
rebased the patch and resent it. Thanks!


Dorcas


