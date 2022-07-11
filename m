Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E459CC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 11:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiGKLdH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiGKLcu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 07:32:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4795F3E761
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657538177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JdUttr5ZKebDNfRRwhSduk+8HDPwZtCqmZ3OBESQeoQ=;
        b=PIx9fq1KyzEKELNDPHdWHSz3EjQJehfmXXTpkdSjiCekvZSCm6KHbyfCEVWjOq7w+UZb3U
        PNugs12CLrnrOFGHHeRqqKqy0thZjeTz1PeOUhtxDxCGU4LqDN3KKj5ojOwdleGKyohfau
        31V762RZDoXKNHLP8RH78YBtKnrDyvo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-nX8z1S5hPmmAcPronKgy3Q-1; Mon, 11 Jul 2022 07:16:16 -0400
X-MC-Unique: nX8z1S5hPmmAcPronKgy3Q-1
Received: by mail-wm1-f71.google.com with SMTP id a6-20020a05600c348600b003a2d72b7a15so5077310wmq.9
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JdUttr5ZKebDNfRRwhSduk+8HDPwZtCqmZ3OBESQeoQ=;
        b=oaaDpT4RhmgVBOHSEEfyKoUoNOSCY54zd/weWlImo52qa4VDLk0mFLXyiMapgN4bcx
         +G/t9aU4zLUFKGzvf7OQSEgm4uCA+6C/fWB+WmvPiCj6R8/ft5C/WIMw9ZNFoSi91ftP
         qHpOrTXuAjVhZDxJlvAAfM//DEm6+NT6PJvePxw80HiTzZa8Ca/QIJ02aWSkiaWTnc+7
         ipgrSZ72FXSD2qPU3a1w5fmDF9VCsf4EPjb81eOmd83wLf1T0Oic/JLiFmNvUGJfbjra
         NRO4NAd07sXYVyvZrFkVURQUZkWoWBdDZqF6yM//vOcJB8HpXnar+Xi1OHNe/BcX+vHG
         PYow==
X-Gm-Message-State: AJIora9/yesMOC3G80hV4hHHnem4rJdPiMKqap+XheQBRAMseEHnRyn7
        Ds4TevgvNIHxJMseyJ9EEidUcu1721aI5yY3RNYF7G7hKPLZuyp1bYqXxJPfC0VG3rxY1c3EGCa
        ZLH8EvQZtH9I8q8F0tjWcnRI=
X-Received: by 2002:a05:600c:3849:b0:3a2:e7fd:e084 with SMTP id s9-20020a05600c384900b003a2e7fde084mr5031457wmr.15.1657538175195;
        Mon, 11 Jul 2022 04:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uEx9XRLsglHmWCwo72ASF8BSSzK4h0vkHDnN9UU6eO0DlvvXvfi0JFZ5WgX9TcLEpuLZadOQ==
X-Received: by 2002:a05:600c:3849:b0:3a2:e7fd:e084 with SMTP id s9-20020a05600c384900b003a2e7fde084mr5031444wmr.15.1657538175040;
        Mon, 11 Jul 2022 04:16:15 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b0039ee51fda45sm6673199wmq.2.2022.07.11.04.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:16:14 -0700 (PDT)
Message-ID: <7b6cf5dc-eeef-96c2-947d-a09d29bd0db8@redhat.com>
Date:   Mon, 11 Jul 2022 13:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/11] video/aperture: Disable and unregister sysfb
 devices via aperture helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-8-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/7/22 17:39, Thomas Zimmermann wrote:
> Call sysfb_disable() before removing conflicting devices in aperture
> helpers. Fixes sysfb state if fbdev has been disabled.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: fb84efa28a48 ("drm/aperture: Run fbdev removal before internal helpers")
> Cc: Zack Rusin <zackr@vmware.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Changcheng Deng <deng.changcheng@zte.com.cn>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

