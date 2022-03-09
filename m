Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D52C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Mar 2022 11:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiCILa7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCILa6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Mar 2022 06:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1158C14FBCC
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Mar 2022 03:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646825399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HnlUMIzNyqkqH+xHxo42IHozaUvb7gIZp8zyXlaq0wo=;
        b=KTHTZX2q4OYHzArEWM/VbuETTSpMlNn0m2RaxA7Uje3x5+vhfespy/ENPUs2UQpNPN4Wl3
        9kTsoIT0YKEfh0aK347LWRaajWfwYz1/fNTpb+kVAORhXT2AdYKZXOJC0fzMo8gP9yH1jB
        YWbpYl11ufqNhciGRO1HK8+4+f+XvbE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-1ERREr2DNvy1CPBgE-POrA-1; Wed, 09 Mar 2022 06:29:57 -0500
X-MC-Unique: 1ERREr2DNvy1CPBgE-POrA-1
Received: by mail-wm1-f70.google.com with SMTP id j42-20020a05600c1c2a00b00381febe402eso2492162wms.0
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Mar 2022 03:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HnlUMIzNyqkqH+xHxo42IHozaUvb7gIZp8zyXlaq0wo=;
        b=d3IEHD7RSRvx7+XFo0NuXMkj0eSxSILng0wYHKWuQ87rQ2F5UDfr3wvh9+vACcRPuX
         UJtpNdfS+FBLOXGWuEsv60j9r2TWgCuqtZqelki9sg5SDPWKrKVzKoGV6bokKNkrA3jp
         pEw0rk9mkuuYygz7GLm4e9oUPIlDptpAlMxrq6CVXjan9lwYRWbDJxcKDurjwnquT1r9
         kIcTDbHpDSMHV5/xoim32G3p3qunBJFoA2AWUD5jJVvkKymRcnSh7QkAJewcGEv3TXI+
         w3/JdgX/Dh4Oyws9GYq6OeOvwhDSbzGm1tFXiSFUnQtcdMATM06+qB/ZEs5x7Zn1Sw8r
         88rw==
X-Gm-Message-State: AOAM532k1pChRDjiD0QuM0KWWyIpYxwYeRQYDhPeZ5Y8dtwIkcDMUqaw
        iIxH4cDaQbizVBqbn0MZP7xZpQ9e9PPtm0V9JQe5v8+eKn0tsILWE+KX2Km2MvUsgDn+hz69gAg
        v9/zPflW/nDLavdS+I2/cTpk=
X-Received: by 2002:a05:6000:1a87:b0:203:7089:a985 with SMTP id f7-20020a0560001a8700b002037089a985mr4916352wry.487.1646825396681;
        Wed, 09 Mar 2022 03:29:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBmRvb7LqphR27TvNl9xg2A5igntxMD1AB4+Q0/ZWq2SZv47J3rQA6ziMwODlncZSqtS4y/w==
X-Received: by 2002:a05:6000:1a87:b0:203:7089:a985 with SMTP id f7-20020a0560001a8700b002037089a985mr4916337wry.487.1646825396478;
        Wed, 09 Mar 2022 03:29:56 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c501400b0038995ede299sm1432746wmr.17.2022.03.09.03.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 03:29:55 -0800 (PST)
Message-ID: <ff826df9-119b-563e-c666-c979dcd97f17@redhat.com>
Date:   Wed, 9 Mar 2022 12:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 9/9] drm/virtio: Implement dumb_create_fbdev with GEM
 SHMEM helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-10-tzimmermann@suse.de>
 <b1af16e7-a20f-5499-6234-c5090349305f@redhat.com>
 <971ff2e6-adda-17ee-d002-5b32403d344f@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <971ff2e6-adda-17ee-d002-5b32403d344f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/9/22 09:52, Thomas Zimmermann wrote:

[snip]

>>> +struct drm_gem_object *virtio_gpu_create_object_fbdev(struct drm_device *dev,
>>> +						      size_t size)
>>> +{
>>> +	return ERR_PTR(-ENOSYS);
>>> +}
>>
>> As mentioned, I believe this should be ERR_PTR(-ENOTSUPP) instead.
> 
> I've been wondering about this as well. I finally went with the rules at 
> [1].  All the variants of ENOTOP/ENOTSUPP seem to be for specific use 
> cases, such as a certain feature is not implemented be a specific 
> interface (e.g., sockets for EOPNOTSUPP).  ENOSYS is the only general 
> error that indicates that an entire interface is missing. Even though 
> checkpatch.pl warns that it's only for system calls.
> 
> Best regards
> Thomas
> 
> [1] https://www.cs.helsinki.fi/linux/linux-kernel/2002-30/1135.html
>

Thanks for the link. It would be good to have an authoritative guideline
about this in the kernel documentation (and make checkpatch.pl aware).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

