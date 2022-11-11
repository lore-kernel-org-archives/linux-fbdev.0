Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA8AC4332F
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Nov 2022 09:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiKKJuF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Nov 2022 04:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiKKJuE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Nov 2022 04:50:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2102A3
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Nov 2022 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668160148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5l8q5ZxVXaLzz8d0jV5gKO4snqYrCf3SKQpQlZuJqXk=;
        b=NzdUFm+hk+gEnslXLhjNeps0ZejAd8FsrSOPWNi46krHqkmhP1Q+QkkTH1QhkazF9GsZ8h
        +965OTT5hu6PuTnZHoVSvzLOj1bBw9VMITxFLEbr860SruPIy+J1QZUB8oOnSTWlauMf7o
        RKxdRwm8VECSu/0RyBZ7WS2YIOH1l3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-yeGzGgLUP36Iv2aF_ZonHA-1; Fri, 11 Nov 2022 04:49:07 -0500
X-MC-Unique: yeGzGgLUP36Iv2aF_ZonHA-1
Received: by mail-wr1-f70.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso864925wra.1
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Nov 2022 01:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5l8q5ZxVXaLzz8d0jV5gKO4snqYrCf3SKQpQlZuJqXk=;
        b=oeceiOF/I85MpRm7ck9MuzuDfjrG4wa6WMNyKm8Uf7nrcQ1bTsnjmONvK5SR3mOGot
         1br7qqHMlcdkX0QjobuUUDGnemUGaRslDSyfGAajDLU5/XMmg2nlc66iysIFoFtbtJjj
         NZKyNnjYH8+DH7pGEg/3LdAmXpXqrtC+GWkloY4qGYlJ8evVYY7QvptjaO00EgG9ps5N
         GgPLtTPRj211kbvfBd8AaGKNhol+ADvMyUDDjhqd3NkCMwTElwqAyB1fKvl5fttWAvYM
         L/PKz6ha6X7aBg5x97HbFgLiwTScllei7tWnyUfKyQ66gWfJX0q0t5zpTZhgr0NXmIRq
         tt1Q==
X-Gm-Message-State: ANoB5pmUQgXWS1DXMadJD+PAzr5V4heWEfPPU8Z0WZ0P37CkyGFz+b4Q
        F6IHka5xZvvFUbgUqjQL6lNLTtQmk0lHIq658tzSk5PWiObFTQN6W8Swp1acMBrflOZoQpn/M9J
        JPcp3Ywf56Sfumf7/U0BWIOc=
X-Received: by 2002:adf:e78c:0:b0:236:704f:29f4 with SMTP id n12-20020adfe78c000000b00236704f29f4mr763410wrm.11.1668160146567;
        Fri, 11 Nov 2022 01:49:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7OiT8Sbsve/sCxcNQRsa1xFTdkZSg0vhESZhI+f4jtxiLU7FrJfIbqBEHAWqPu0pqIqgIglw==
X-Received: by 2002:adf:e78c:0:b0:236:704f:29f4 with SMTP id n12-20020adfe78c000000b00236704f29f4mr763401wrm.11.1668160146404;
        Fri, 11 Nov 2022 01:49:06 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id by11-20020a056000098b00b002258235bda3sm1431910wrb.61.2022.11.11.01.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 01:49:05 -0800 (PST)
Message-ID: <73c7243d-b1b7-ac3c-7b17-1f0084821aa4@redhat.com>
Date:   Fri, 11 Nov 2022 10:49:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] fbdev: Add support for the nomodeset kernel parameter
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, daniel@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221107104916.18733-1-tzimmermann@suse.de>
 <20221107104916.18733-3-tzimmermann@suse.de>
 <2e2d23f3-9c2d-e75e-f390-4651a4da730f@gmx.de>
 <6547fba2-a002-f339-2997-5b28df794095@suse.de>
 <d21a0a0d-22fb-99bf-0d29-75b1fe1db677@gmx.de>
 <dfa83c75-4062-93ee-380c-3e0e4f41c448@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <dfa83c75-4062-93ee-380c-3e0e4f41c448@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/8/22 09:16, Thomas Zimmermann wrote:
> Hi

[...]

> 
> My proposal would be to add a little helper to fbdev that includes your 
> suggestions:
> 
>    bool fb_modesetting_disabled(const char *drvname)
>    {
>       fwonly = video_firmware_drivers_only()
>       if (fbonly && drvname)
> 	pr_warn("")
>       return fbonly;
>    }
> 

Agreed with this proposal.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

