Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B1BC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 May 2022 13:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392356AbiEFNWi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 May 2022 09:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392345AbiEFNWd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 May 2022 09:22:33 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C68FC68F86
        for <linux-fbdev@vger.kernel.org>; Fri,  6 May 2022 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651843128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6eR4SrDmEoANuYmWC0BJSoz/4Iidosis2CSmMHpx9dc=;
        b=afmGy/yaKbVWbsmokn/UBFB721WxvN2NmZFYNONmm5UjEfQmND9C0k0ADiV5EP5ciZgI8S
        eprrY2akuvJHhY1zDFpbOyQcQ8r/eGdkw195v1i1uHtaU1tRCV7We6kLcGLM7pdLnTL5fs
        ZWGi3Qdig4omzfluN3tmaOXQFmZcO1Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-1VEPjEtPNQCqiOi7XRjH5A-1; Fri, 06 May 2022 09:18:47 -0400
X-MC-Unique: 1VEPjEtPNQCqiOi7XRjH5A-1
Received: by mail-wm1-f72.google.com with SMTP id m26-20020a7bcb9a000000b0039455e871b6so2599694wmi.8
        for <linux-fbdev@vger.kernel.org>; Fri, 06 May 2022 06:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6eR4SrDmEoANuYmWC0BJSoz/4Iidosis2CSmMHpx9dc=;
        b=qZ9w8ujMeLqpY8GZCRCd04uxA3vB0W68lDkU5inNmZKWCEQBWw4PLHF6tyzPHZuwog
         5R7WIkJfH3XLiSdiFZmKb8VJ0Bas/QyYGOgp1JU5FtRTL8acSnw30gfn3yhyaEUKG56H
         5Uoo3l3Abj6f6rp91Rgemolm1stbmBK1FQZxGdxUduDdh6C0CrdvYvsbAkej87C9BKVO
         SPkGYenngQTIYoClBWf7eqt56xDyWXBT2AdUU4GaTnc7gHtJavU4gbLGHdRx3M04fHwv
         q4i8DKR4gIIqpFgn0JyB+VKqGI7p/iNlrEd1BeT7Cv9s0IgAk4RCDT1WgGdy4cND0hxS
         +25g==
X-Gm-Message-State: AOAM532lKlFJniYVJ6ZzwL9WPdlshftfGJp9A1FRfuOzfVJHFkqT+8h9
        CC9yQEdZ7xsAoMAVk8PEn/D7hYlOtLGhpn120rB586dzUS2+7PtzMxt8ZjqUVRcCuKONgTzWCip
        GYW7D6H9vqwtS6S4WmPfmDYY=
X-Received: by 2002:a5d:6d83:0:b0:20c:7329:7c36 with SMTP id l3-20020a5d6d83000000b0020c73297c36mr2784656wrs.518.1651843125832;
        Fri, 06 May 2022 06:18:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFmPqHpFl7IQ0p8a3cDOwPVFVGGBUGfQCaOkK4J9z39w72XOntceMZPP2+b4IAbt9zNBVruA==
X-Received: by 2002:a5d:6d83:0:b0:20c:7329:7c36 with SMTP id l3-20020a5d6d83000000b0020c73297c36mr2784632wrs.518.1651843125512;
        Fri, 06 May 2022 06:18:45 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s6-20020adfea86000000b0020c5253d907sm3671710wrm.83.2022.05.06.06.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 06:18:45 -0700 (PDT)
Message-ID: <00117d58-2a47-4e2b-225b-952e0e98df2f@redhat.com>
Date:   Fri, 6 May 2022 15:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/4] fbdev: efifb: Cleanup fb_info in .fb_destroy
 rather than .remove
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Peter Jones <pjones@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220505215947.364694-1-javierm@redhat.com>
 <20220505220540.366218-1-javierm@redhat.com>
 <ed57ca49-f80e-9bf5-4dc3-59fb62ca4315@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <ed57ca49-f80e-9bf5-4dc3-59fb62ca4315@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Andrzej,

On 5/6/22 15:07, Andrzej Hajda wrote:
> On 06.05.2022 00:05, Javier Martinez Canillas wrote:

[snip]

>> +
>> +	framebuffer_release(info);
>> +
>>   	if (request_mem_succeeded)
>>   		release_mem_region(info->apertures->ranges[0].base,
>>   				   info->apertures->ranges[0].size);
> 
> You are releasing info, then you are using it.
> 
> I suspect it is responsible for multiple failures of Intel CI [1].
>

Yes, it is :( sorry about the mess. Ville already reported this to me.
I'll post a patch in a minute.
 
I wonder how this didn't happen before since .remove() happens before
.fb_destroy() AFAIU...

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

