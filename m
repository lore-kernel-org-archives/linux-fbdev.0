Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020F9C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 May 2022 09:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiEJJtJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 10 May 2022 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbiEJJtG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 10 May 2022 05:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD0E529BC53
        for <linux-fbdev@vger.kernel.org>; Tue, 10 May 2022 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652175894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIkeEVePGlxbsvPHtH0nGpkFA24GFXTnSwZmVR9DJTA=;
        b=AMmj/VzNJnMjy+5NXP8aEbX55HY5xyiQhF0oPs4MaOoKv7ZXaTs7MUW69oSmoq7l2HOLB7
        RGfhZoCQNX0Pl8K+NnK/4WTpCukBWEXKzSHqhpNYQQ4rn+xyQUSfxPQwXoRW+v0OyuTIPX
        CyzqCmJL2YKptYxKJm0Ka38/DpOW1I8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-CUdfPOIoNQGx0qoY9Haz1w-1; Tue, 10 May 2022 05:44:52 -0400
X-MC-Unique: CUdfPOIoNQGx0qoY9Haz1w-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so575887wmj.0
        for <linux-fbdev@vger.kernel.org>; Tue, 10 May 2022 02:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZIkeEVePGlxbsvPHtH0nGpkFA24GFXTnSwZmVR9DJTA=;
        b=hP+Cnk+/LxThZ86V2rbsj/BQzRcWtF6Vd0TVNqGn/3uoNw5CrQaEmc0UJ26XGJOU3J
         izawP3DOM0PvxAbED1y1nq5hJHR2JA5odopKYLHXAO/ZqcJr0AfKBwD7ahigo+5jveEv
         KNhqa3jXbnQ9DKDrV/njbYfL0PloDNNAsUjIDo87Jj55ygasWJBlgV4NyHj8yh/HDyz7
         onh9zz+6hRh7uV8tgEXB0qX+Zd/qFcgzrwMrHsezg/TNxqLrTZ+DKvTcamFMvrEbdx/2
         VUFhiOXujiNTu1crvSR5PefMnXBiCMsX0oF8EdpZrAfJZfjY++t1N0Ug2pNcqTXYGqeY
         CZ7A==
X-Gm-Message-State: AOAM532Ci4oY4d/+RVideHxkEZHJB3vO2r29fKIXawmpoDx6E5CCkwFR
        a4lVPy9Ug4IaMrW204s4Y2aEVOvPnF9Qk3HaefIpLfzOnNeXllm/1fBgaiG26pGq/xPDa10EC6a
        EExqQ4US9BoIwgUglLCVNNbg=
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr27255205wma.140.1652175890834;
        Tue, 10 May 2022 02:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqZdOByE2SRyxmDOrncLZ/RO7E0TZVermOqH+9uwM0OqnYhPpwaZ5UwYEr+j+uTXKTM8aeLw==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr27255188wma.140.1652175890613;
        Tue, 10 May 2022 02:44:50 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b0039429bfebeasm6470780wmq.2.2022.05.10.02.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 02:44:50 -0700 (PDT)
Message-ID: <c148afe9-f10a-8751-d761-2480c05a137a@redhat.com>
Date:   Tue, 10 May 2022 11:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/4] fbdev: Prevent possible use-after-free in
 fb_release()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220505215947.364694-1-javierm@redhat.com>
 <20220505220413.365977-1-javierm@redhat.com>
 <753d0350-42dc-389b-b10b-4533ddcf32ac@intel.com>
 <1f788b8f-0bea-1818-349e-b1bc907bf251@redhat.com>
 <a339df59-9e00-c7cb-e33d-2ac626443639@intel.com>
 <3b7fe4fe-fdec-cef2-4e0e-309d9dc4a8af@redhat.com>
 <b5ab1c49-04e7-36c3-677d-2989b79e50ca@suse.de>
 <2bf27b09-0896-1849-254f-d5b19abdc892@redhat.com>
 <fc3e8a40-664f-07ae-7474-c0412a1ab1b5@intel.com>
 <1c36d431-d5c0-7278-c9e0-61867e9dc174@redhat.com>
 <79aaea41-5dab-f896-ab3d-d6bc9a5de615@suse.de>
 <2d8d8583-3a39-b826-dd83-ba5bc4c5b082@redhat.com>
 <7ffd92d7-9c07-fa9c-dc95-9e82719fd237@suse.de>
 <71ebd5f7-64d0-510a-6f1b-29921fca19fa@suse.de>
 <35ffd96d-3cbe-12dd-c1ea-878299ec173c@redhat.com>
 <23ae6eaa-c281-9fc1-2c64-dd953ad2f5f1@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <23ae6eaa-c281-9fc1-2c64-dd953ad2f5f1@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/10/22 11:39, Thomas Zimmermann wrote:

[snip]

>>
>> 3) Set .fb_destroy to drm_fbdev_fb_destroy() if isn't set by drivers when
>>     they call drm_fb_helper_initial_config() or drm_fb_helper_fill_info().
>>
>> I'm leaning towards option (3). Then the fb_info release will be automatic
>> whether drivers are using the generic setup or a custom one.
> 
> IMHO this would just be another glitch to paper over all the broken 
> code. And if you follow through drm_fbdev_fb_helper(), [1] it'll call 
> _fini at some point and probably blow up in some other way. Instances of 
> struct fb_ops are also usually const.
> 
> The only reliable way AFAICT is to do what generic fbdev does: use 
> unregister_framebuffer and do the software cleanup somewhere within 
> fb_destroy. And then fix all drivers to use that pattern.
> 

Right. We can't really abstract this away from drivers that are not
using the generic fbdev helpers. So then they will have to provide
their own .fb_destroy() callback and do the cleanup.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

