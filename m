Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEFBC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Apr 2022 07:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349447AbiDTHii (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Apr 2022 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359791AbiDTHih (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Apr 2022 03:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEA0A11C2F
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Apr 2022 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650440151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDRif+t8FPfoSOxs98NyECVWbLIHSIo6HCNUFdi+s6k=;
        b=VQbj/asWrbowHWNoBILt0Z+94Wbg6F3P13GmyBBeOm0gbBuYLKZYCl31RHey9ZgdP6psd0
        DgXHxR7vYMjCcfY4PDqnsu6iO4CR/xRiWnYgwN1l6pb+v5LWrwhIffnqu2qiVIuND3TbK3
        T4hW0LHTHAS58ZZEJzfdGdLp1S55QHQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-i2QhcLXgM36aVRbhudCWFQ-1; Wed, 20 Apr 2022 03:35:50 -0400
X-MC-Unique: i2QhcLXgM36aVRbhudCWFQ-1
Received: by mail-wr1-f70.google.com with SMTP id j30-20020adfb31e000000b0020a9043abd7so120134wrd.12
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Apr 2022 00:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EDRif+t8FPfoSOxs98NyECVWbLIHSIo6HCNUFdi+s6k=;
        b=1PsC9YgX0lSI0pe+UqV9UvB2QerghcjYYjOwRSfSC0oDWZySzT+CxzrKtnMmF7tEer
         c4xpwyIlmUVdSn4kRi04mp1gLCwjKIuGf0/H0lMIk/irSBXs4dF0J7KD1JObV1MEQAtm
         g5eORbtJHetyoxvXyPzGgnh8KkQ7e7Y362oV7uDa/USOCdAQjvZpzw/UhSEq4pGrgFfR
         TCVSBOa1fL+liqgnu8N+4aARKQbLugedma3sglYspedLZSdixZCrOe7ZR1xIlc2CJCaF
         aCQ7xMX12F6EIDgPoS5hhmQ+wtJnemADmF8XP61QMk3uoCb2jxJHh5a2Q7MSsNnTCHnp
         hUcA==
X-Gm-Message-State: AOAM533/wqSCxEbxM25C5RiY+uYDlH/Yjn7ZwdIMM0t1+XLGKu5Fv1tV
        z5FFVB/KzHfK+Jc0EPWwf3cAGHuhWboFBcIyo9vJVTC9beXAlC6uRA1E4zzFUMAWLvo9DFQ9E1Z
        S0W5xf8/zCKt1/7D9Q4AiKHc=
X-Received: by 2002:adf:e3c1:0:b0:20a:aba9:9b38 with SMTP id k1-20020adfe3c1000000b0020aaba99b38mr2900230wrm.673.1650440149339;
        Wed, 20 Apr 2022 00:35:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6sgyKJ2RuJP3SIGSvgHxw4lhTuGdu8X/eI4ANvHsCXwV93n7yUdOaGB6Ll1aJVD0L1RwOfA==
X-Received: by 2002:adf:e3c1:0:b0:20a:aba9:9b38 with SMTP id k1-20020adfe3c1000000b0020aaba99b38mr2900217wrm.673.1650440149133;
        Wed, 20 Apr 2022 00:35:49 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c4ec800b0039290a5b827sm10994151wmq.24.2022.04.20.00.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 00:35:48 -0700 (PDT)
Message-ID: <621dcf6a-c23d-24cd-951e-26227f465ab0@redhat.com>
Date:   Wed, 20 Apr 2022 09:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/2] fbdev: Warn in hot-unplug workaround for
 framebuffers without device
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, robh+dt@kernel.org,
        frowand.list@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        sam@ravnborg.org, linux@roeck-us.net, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org
References: <20220419100405.12600-1-tzimmermann@suse.de>
 <20220419100405.12600-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220419100405.12600-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

Thanks a lot for re-spinning your series.

On 4/19/22 12:04, Thomas Zimmermann wrote:
> A workaround makes fbdev hot-unplugging work for framebuffers without
> device. The only user for this feature was offb. As each OF framebuffer
> now has an associated platform device, the workaround hould no longer
> be triggered. Update it with a warning and rewrite the comment. Fbdev
> drivers that trigger the hot-unplug workaround really need to be fixed.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

