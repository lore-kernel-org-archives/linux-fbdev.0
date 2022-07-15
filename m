Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67722C43334
	for <linux-fbdev@archiver.kernel.org>; Fri, 15 Jul 2022 11:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiGOL4v (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 15 Jul 2022 07:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiGOL4u (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 15 Jul 2022 07:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF34089EB7
        for <linux-fbdev@vger.kernel.org>; Fri, 15 Jul 2022 04:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657886209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZGkIOwyvFmzhbCUYm5+8xL8ziiXjaFbbfd3qqafzd8M=;
        b=Y3/it1xrUXTF5lojXyNVM/ULiouaCCj0+IPboVSokkjNJSs8GeXzY6on0A/1AmNYXpA1Q/
        ftYtDnlIsFCIg/NCn8fZldn4amrMVn8rX01zP0V16aL1ah7an6CnmFxo1jP3JSyfRT3KOA
        cBee8TSGlId/6EN8bRcoao17GUR/swo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-jHwDiQ0FNj68SKSaBXK1pg-1; Fri, 15 Jul 2022 07:56:40 -0400
X-MC-Unique: jHwDiQ0FNj68SKSaBXK1pg-1
Received: by mail-wm1-f69.google.com with SMTP id v123-20020a1cac81000000b003a02a3f0beeso4165219wme.3
        for <linux-fbdev@vger.kernel.org>; Fri, 15 Jul 2022 04:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZGkIOwyvFmzhbCUYm5+8xL8ziiXjaFbbfd3qqafzd8M=;
        b=2HuAr+fxhwE97nFhpByo11Zou8SMeq5DCGvy76Fz6zSwvyij82rlmX7TLlLSSoZwid
         KanEZ3HH0FfDJxkmY+7pCxPr8GIk3yGAsI7th9z+u9bwXhSxhmUyKYE6pgwavJhffG5I
         o1WaeAOYgx2vAkpC4IOUiSkwTkc6VP35RgQCgdhAC+BCaw6OzTrUdEu6gWhvq9UuAJTu
         jQhP0tZsLjADGujiPWkdLj7aLWa89yR/OlG/U4dOSfH+bTZzvll1OY4lVlTR8Q2FMGSm
         cXlpj1UVx58qd6eMnqRHRssEGHtnHM51yC2b3S4l5eQm7qWzZZgboa+dv+nKCbc5pa/X
         +ouw==
X-Gm-Message-State: AJIora9jbp3wvD4oh/laWPL5jRYmhKwW/sB8n9ceRfLUY8V/mJq0dI2d
        KvB8bC0qrpm0c97mQJWP3tUbS5+hYdClvAvAMgHv1I4jmQqXfM79aEoCUr2q5swc253lBwUWsXQ
        /hoxvRnjdd00NVYn8EsLr2dM=
X-Received: by 2002:a5d:56d1:0:b0:21d:78ad:c8bf with SMTP id m17-20020a5d56d1000000b0021d78adc8bfmr12518028wrw.175.1657886199137;
        Fri, 15 Jul 2022 04:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1smSq19q7Fkw60FMFkswIMOeyBLouoE4txw/9cp+WjMYOqudNHfchdpbzC3yv2/xNNoXTjqGA==
X-Received: by 2002:a5d:56d1:0:b0:21d:78ad:c8bf with SMTP id m17-20020a5d56d1000000b0021d78adc8bfmr12518016wrw.175.1657886198959;
        Fri, 15 Jul 2022 04:56:38 -0700 (PDT)
Received: from [172.20.10.7] ([84.78.249.231])
        by smtp.gmail.com with ESMTPSA id e39-20020a5d5967000000b0021badf3cb26sm4476823wri.63.2022.07.15.04.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 04:56:38 -0700 (PDT)
Message-ID: <3b707e5f-ce33-b08d-371b-701b3a84f549@redhat.com>
Date:   Fri, 15 Jul 2022 13:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/11] fbdev: Convert drivers to aperture helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-6-tzimmermann@suse.de>
 <8ebc1f33-f654-6b93-8a41-1aa66ab1901c@redhat.com>
 <558097f5-95bc-fa3c-d08e-1ca0a4d6eec2@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <558097f5-95bc-fa3c-d08e-1ca0a4d6eec2@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 7/15/22 13:48, Thomas Zimmermann wrote:

[...]

>>> +
>>> +	return aperture_remove_conflicting_devices(base, size, primary, "sm750_fb1");
>>
>> Do you know why this can't just use aperture_remove_conflicting_pci_devices() ?
> 
> I simply don't want change too much at once, because there was this 
> problem with the PCI helper on ast.
>

Makes sense. Feel free to add:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

> At some point we can make a push to really fix this throughout the code 
> base. And that would include an update to fb_is_primary_device(), [1] 
> which doesn't fill well into the new interfaces.
>

Agreed.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

