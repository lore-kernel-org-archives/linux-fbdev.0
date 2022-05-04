Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C3BC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 17:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiEDR0R (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357073AbiEDRWc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 13:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0446B4FC4F
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651683733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=su2fcE/ZTpO/A41EAyixuSURd7XYYslQVS9rF55do8s=;
        b=dAAh8mQh8z1jm89qyyVh4wmLmMdt1C/kDUXHP+6f6vY0r2y9GdKDlmuER5agwJqFu5740X
        QLPJg3ADSX/ucLeA6pcGW+c2bzjfXWytjTwo2KkTqtl7k/DU3tVw1PfjLlIS+ZJ2/5p538
        YvZr0OPpZavHl7K6uGn/b0hgNamXgZA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-KenlRBKXNwaHf2wHupHDbA-1; Wed, 04 May 2022 13:02:11 -0400
X-MC-Unique: KenlRBKXNwaHf2wHupHDbA-1
Received: by mail-wm1-f71.google.com with SMTP id o24-20020a05600c379800b003943412e81dso892217wmr.6
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 10:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=su2fcE/ZTpO/A41EAyixuSURd7XYYslQVS9rF55do8s=;
        b=lsFxUJkl/x4NIUrqOWS30HEpcyrfOUcm4Qj6Usxw/MkmvsXf2fWLzrM//d4EBfcEvT
         +YfwYO28bnZr2xQ9te6kmV8mNJXZlnDr8NiZfpzn2F9iH7i166/pTmZRzlkHIvl9tWXg
         B2GiMTZ6ibfxhcjlgftaiZ2gH9NGADK7dteeMsvK4OefzbKE98jsX28ik8iqKc3zMKRH
         1QmKgwWyrD5AtSnqCBS7cWiIPIb8+dBxHk2Ugxz+cEIAwOXDR369KyWMor5AgYlKRRko
         u8OoWYeIJHO2BvzVHJGkWr59k1hCfeodhay3aK6VOZ19nwYTBwAsxMZGNnAlzyocwC0C
         BRUA==
X-Gm-Message-State: AOAM530zTzksfTsbmTOFWRDcXNulOnFSMBL9i2/c+v8PXKvdNcaOzzvX
        v3bBG4com4zYIBBGEtNBBK0EH7mZ52VMNUcjATTE+Cwlbefb4SGAx9QcOEYSDNxIptqwr3cN/z+
        MoyhQ/bkwZjHqcX8G3X0KoSQ=
X-Received: by 2002:a05:6000:1c02:b0:20c:7d20:cad6 with SMTP id ba2-20020a0560001c0200b0020c7d20cad6mr4049792wrb.373.1651683728521;
        Wed, 04 May 2022 10:02:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf1id7XWx3NZcKVfmk3aRE3FalMReMMEUbJDaOtcBm4Gbck3VS/Amr1NlXOkEwj/GbfgB1RA==
X-Received: by 2002:a05:6000:1c02:b0:20c:7d20:cad6 with SMTP id ba2-20020a0560001c0200b0020c7d20cad6mr4049781wrb.373.1651683728291;
        Wed, 04 May 2022 10:02:08 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c1d0600b003942a244f34sm3008867wms.13.2022.05.04.10.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 10:02:07 -0700 (PDT)
Message-ID: <fd36a5ec-e795-8b60-3a02-b865ef897da2@redhat.com>
Date:   Wed, 4 May 2022 19:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: disable runpm if we are the
 primary adapter"
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20220504134833.1672728-1-alexander.deucher@amd.com>
 <f48a0482-7be9-29d5-b179-e572dfac11fa@redhat.com>
 <CADnq5_Mp7EnBUgXaT=-5ndWMW9svpsDbTypj+DdehOXsEAw_4w@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CADnq5_Mp7EnBUgXaT=-5ndWMW9svpsDbTypj+DdehOXsEAw_4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/4/22 18:50, Alex Deucher wrote:
> On Wed, May 4, 2022 at 12:46 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Hello Alex,
>>
>> On 5/4/22 15:48, Alex Deucher wrote:
>>> This reverts commit b95dc06af3e683d6b7ddbbae178b2b2a21ee8b2b.
>>>
>>> This workaround is no longer necessary.  We have a better workaround
>>> in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are displays attached (v3)").
>>>
>>
>> I would write this line instead as:
>>
>> in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are
>> displays attached (v3)").
> 
> When you do it that way checkpatch and some maintainers complain about
> splitting up a commit line across multiple lines.
>

It does indeed, how silly. Scratch my comment then.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

