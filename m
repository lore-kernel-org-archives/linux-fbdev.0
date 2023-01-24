Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBAEC25B4E
	for <linux-fbdev@archiver.kernel.org>; Tue, 24 Jan 2023 10:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjAXKK7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 24 Jan 2023 05:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjAXKK6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 24 Jan 2023 05:10:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5258F6EB3
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Jan 2023 02:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFDK+kFH8HIC/TzW1KCoOg355Vt7UsVPru6vlXZw2AA=;
        b=RKYI5nJ54GYnhQr8K+8GVdM3m9W03/94vqw/V2YdN/sAqGpLmaAHsmER0G9LXMGUQzZ3qz
        CaoATN2WkXqeomOxj+Fk2hd0AywoijUs3skh8Jlvllnl4pZ4uh7UD4n1WSJrp0uecMH0UB
        URNiclil1qznMk+IjfS2kndwqfBDBDI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-Cl4GuD4fOK6FCcpMreA7gg-1; Tue, 24 Jan 2023 05:10:02 -0500
X-MC-Unique: Cl4GuD4fOK6FCcpMreA7gg-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a1c3507000000b003d355c13ba8so8950591wma.6
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Jan 2023 02:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFDK+kFH8HIC/TzW1KCoOg355Vt7UsVPru6vlXZw2AA=;
        b=NuOfH5Yeb3ZHD0CfXZlFdJRVO2KwzFs6eHJB1LbxUM2pnwhvBb0fVCWCIMhaA1bIdz
         J3ehN+MTM4TMBU8LUhwbjP8hgHQ42Jmy5oaXTrWNlrowhjkXEosGo+tAXLpJKPRL953c
         5olI3tT/Yf6SDK0Q1o8/4eHAofXy1tKGnw8+egDjhmsBXerVFhK74VVpNISatppyTdFU
         VfGgVcwtXw75ToQfJGILNmg4eBT+my+pTXacmFG7ouFBO/pc3C4jT36a+MO/2DyI7WQQ
         9P+tvdzP+w6WAvHC9CxHh+A/micEO40v0rGXpz6NdOCA7wCrjvw5KFRY0iJwbOT82KnG
         QPjQ==
X-Gm-Message-State: AO0yUKWpb/Kuuu5hIshYmAmGnxdAJXo7XHVnfgnWKG4uwf3Jec+uIoJN
        hSetPHIVnM1SoUs88svCL9eawNlMGaFJANhxUQEa9yDitpsVOxlH7HmH776Ylp2+cVy/HT0CwCO
        p0f5JIXsy9C5XnOCFj4zJ7oE=
X-Received: by 2002:adf:ce04:0:b0:2bf:ae15:5950 with SMTP id p4-20020adfce04000000b002bfae155950mr2064114wrn.20.1674555001389;
        Tue, 24 Jan 2023 02:10:01 -0800 (PST)
X-Google-Smtp-Source: AK7set8JCDaZ6+VVJYdKA3bFSsDgu6eawmj4lpdDSlBDI/rz3pyQULfDuvWJ7TNd2EQjXNI5XGujFw==
X-Received: by 2002:adf:ce04:0:b0:2bf:ae15:5950 with SMTP id p4-20020adfce04000000b002bfae155950mr2064099wrn.20.1674555001179;
        Tue, 24 Jan 2023 02:10:01 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d604d000000b002bddd75a83fsm1538673wrt.8.2023.01.24.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:10:00 -0800 (PST)
Message-ID: <03881b6b-baeb-0e23-5e5d-e625b52366bd@redhat.com>
Date:   Tue, 24 Jan 2023 11:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/3] fbdev: Remove unused struct fb_deferred_io
 .first_io field
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20230121192418.2814955-1-javierm@redhat.com>
 <20230121192418.2814955-2-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230121192418.2814955-2-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/21/23 20:24, Javier Martinez Canillas wrote:
> This optional callback was added in the commit 1f45f9dbb392 ("fb_defio:
> add first_io callback") but it was never used by a driver. Let's remove
> it since it's unlikely that will be used after a decade that was added.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Pushed this to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

