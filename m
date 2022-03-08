Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7528AC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 18:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349924AbiCHS6I (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 13:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiCHS5s (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 13:57:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 809DA53E1B
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646765810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjiLkkf7xDfrn30MY8PE4+C9BbuVWl8TzJ7Ra7e8GYQ=;
        b=I/czqNxETksaPVhL+KksoArWsAP8Mqde9nc4DivhQBbOuPyqiicLFx54YjOIh+TsKV7J+d
        PZv2IpqIQQ/4aJiHA92NP+2TDVRhCsP4kprRHUJ0fjsaiLPZHEtWp5m58I7UEnWtaxlo+U
        EwUipAf1U2QBG/DZGAIOEsNb6AqTJfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-izCFc1zAO16Fcxxe0yjUow-1; Tue, 08 Mar 2022 13:56:49 -0500
X-MC-Unique: izCFc1zAO16Fcxxe0yjUow-1
Received: by mail-wr1-f71.google.com with SMTP id m18-20020a5d4a12000000b00203731460e6so568481wrq.3
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 10:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kjiLkkf7xDfrn30MY8PE4+C9BbuVWl8TzJ7Ra7e8GYQ=;
        b=73au0WzJJM8vXmQm6pTOvVN/eS9czbmZWgJ+yla69RncquWP/5MLdWoyA3PW0xa8qJ
         GZzRMuMs5kXkg8Gsx6ah83CJEnZcO4Ac1LUARB31BxFnrBN+leFODU1ZZGwVoC4lrxb2
         +lLsY5sZYoAdn8UaBBsER0RTZupPUWy6j1tlwUkNo2by/XBau5hUA9G7iZDwW2aJ13rp
         6T5p4dtggsoZGlbMV3o9slxclZkEUduYveQmqg5hez3hQAzzKT4CijuFPKHS9KmkGPIK
         YFqq4J14bjz2eCLIgcWUwQxRuPAUKmOQBB8HadbNQ8V6UhB+fun74LH7Y0XyRtfaCnmU
         VHww==
X-Gm-Message-State: AOAM532IJA8HRUrEwqP4/9FTM6xRiMwmCRSdebR89Nd9JdTBxVQjwVxJ
        8PAU3CyRAP6pJkhk2OAV6JDWQWIgsvpVoezwCKT2z9EeSx3RMh1xHcCWzokckkYd9wPtVads7RO
        oJRVe7/SLYAGiBGhDWaQvD2Y=
X-Received: by 2002:a5d:4089:0:b0:1f0:4819:61ba with SMTP id o9-20020a5d4089000000b001f0481961bamr13586846wrp.307.1646765808423;
        Tue, 08 Mar 2022 10:56:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyii7JCimUU2MPgDsFizZxxW2nHtAnaQCXh6270neK9jP7tByZhvzDFA4sRDDojmjTFNnCEUg==
X-Received: by 2002:a5d:4089:0:b0:1f0:4819:61ba with SMTP id o9-20020a5d4089000000b001f0481961bamr13586826wrp.307.1646765808140;
        Tue, 08 Mar 2022 10:56:48 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s17-20020adfdb11000000b001f02d5fea43sm15744026wri.98.2022.03.08.10.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:56:47 -0800 (PST)
Message-ID: <2c02dd69-cb1b-a862-04ed-d9677987bb7e@redhat.com>
Date:   Tue, 8 Mar 2022 19:56:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 7/9] drm/fb-helper: Provide fbdev deferred-I/O helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-8-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220303205839.28484-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/3/22 21:58, Thomas Zimmermann wrote:
> Add drm_fb_helper_vm_page_mkwrite(), a helper to track pages written
> by fbdev userspace. DRM drivers should use this function to implement
> fbdev deferred I/O.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

