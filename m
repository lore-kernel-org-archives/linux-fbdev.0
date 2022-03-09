Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA8DC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Mar 2022 11:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiCILW4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiCILWz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Mar 2022 06:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8541713DFE
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Mar 2022 03:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646824916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axxJQPKDz/ZKFzx7js+EM+U1rMdue7zxP8Cr6MBe+XM=;
        b=El6MM3OeyKYvwTg6GPUK5FAaGy5WE6Gur8kUTOhaLZ2jejkcggW/gxEawwshzB6UxRvEgr
        F8/6oYCco7DU3yNPwlx5uMloLIapFKVeG4iVh1YNVRWPiuH4TMa0f8VE2jAvrWOcu9ZeOR
        bRSEmDEmXXS4sTUbPRX++grmZN0PA6A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-jd1iRk8KMm-evYqNDKjYuQ-1; Wed, 09 Mar 2022 06:21:55 -0500
X-MC-Unique: jd1iRk8KMm-evYqNDKjYuQ-1
Received: by mail-wm1-f70.google.com with SMTP id 3-20020a05600c230300b00384e15ceae4so2455151wmo.7
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Mar 2022 03:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=axxJQPKDz/ZKFzx7js+EM+U1rMdue7zxP8Cr6MBe+XM=;
        b=dHkV+nk1k64W45FHt0iPKAyknDHQ3NHs/45+sIPJJbNlLQJ3hnKMgF5CZ5OdsYREw0
         CeMmOau7cuTMR4RCxz8QR8za3/BRaIIbQRZ1VeV8fZFxt9Tzg0vEvGb/Qyn/QDUhmGZC
         0Cvd46wVjFkfMZC6i7uwJyAYS736TVFnqONPtOP8hCvb4ToL2Gx5IMQ8vMgW1P4iVXcL
         nl6mNPd83SOw/Z5vLh5d0crkyGvcHDA/dLvpZcKc42UTSfNR/k7CNd0JV2JCOQDt0adN
         v1TQ46e/zwtsuOOONR5LkbYdXyGfybK02zqm2QP43ipdl7A8LZP8ruALZliXeZaa4+xc
         TVsQ==
X-Gm-Message-State: AOAM530r5ahZ9lXgRc+oRxpIXkAnv4xRQYoDVjWCCiOOFXNSzdNRlLaU
        4NB+sVuneX452UtfSL1Ncz4wjzarjloOpgnhX/3onjrGBJnv6wU4ZSOuFgQhi35XwbTbD5cj+jd
        DcRjvzDX0c95EzMojPo6ntkI=
X-Received: by 2002:a5d:6405:0:b0:1f1:faf1:a48f with SMTP id z5-20020a5d6405000000b001f1faf1a48fmr9546217wru.684.1646824914262;
        Wed, 09 Mar 2022 03:21:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdqAEqF3qLcKLuYFsHLZlnN18Wpty0xUyufZbpPlI3IiACoue56r06p5xuvHPwTYE1rxu7kg==
X-Received: by 2002:a5d:6405:0:b0:1f1:faf1:a48f with SMTP id z5-20020a5d6405000000b001f1faf1a48fmr9546205wru.684.1646824914048;
        Wed, 09 Mar 2022 03:21:54 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b001f1d72a6f97sm1384827wru.50.2022.03.09.03.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 03:21:53 -0800 (PST)
Message-ID: <7599362f-4c66-673b-7cd4-cbb3e81c8755@redhat.com>
Date:   Wed, 9 Mar 2022 12:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/9] fbdev: Track deferred-I/O pages in pageref struct
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-4-tzimmermann@suse.de>
 <291426e8-32ed-ba0b-4d23-38218d450c93@redhat.com>
 <0dcc965e-fbda-fbe7-fac0-31f0df9f3234@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <0dcc965e-fbda-fbe7-fac0-31f0df9f3234@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 3/9/22 09:36, Thomas Zimmermann wrote:

[snip]

> 
> I thought about using pageref->offset in fbdev drivers as well. It would 
> be more correct, but didn't want to add unnecessary churn. Especially 
> since I cannot test most of the fbdev drivers. If you think it's worth 
> it, I'd change the drivers as well.
>

Thanks for the explanation. No, I don't think is worth it or at least as
as part of this series.
 
> Best regards
> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

