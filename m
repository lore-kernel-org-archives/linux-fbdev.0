Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF7C4167B
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiLTJqn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiLTJqL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F200B1A066
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=NP17ZwoCKE9mNJxk6hj66wAKLkQqmXGV30l77IXay48yKfhHqefNyO0DtiZp+SB1Vw+IXu
        RIXgm4ws8zCUUIXfjYyFSPkenguypMWdrlIyGdihoclnP6W6lb5pxUNx8HYQEceCw227xK
        3nzZoel7RLhbUJ9q3N4Y7yUODksJ47I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-3vTm3EthOwi2STm63o4ezQ-1; Tue, 20 Dec 2022 04:43:56 -0500
X-MC-Unique: 3vTm3EthOwi2STm63o4ezQ-1
Received: by mail-wr1-f69.google.com with SMTP id i25-20020adfaad9000000b002426945fa63so2089126wrc.6
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=IviXbCvJlWX8BY927vsHhRGSgEhwTCJTb/d5pDWiYWNp4jei5fch9kRePN1ZmZUmi4
         M3khnM/K2AqP57iJF73LZkbc2oo826CAASBlNoUt2EvzSR5ZyoCZBvc9YPncc8Kxb6tJ
         yHTvo39hZq4eUUPYGzwv6xf/sAE24WuGT8FoiPjk373nZJVgY4fdg9NAOku/6nTynDLK
         AdIIWy0yy9W4xtqrdJ1izrHe9ItslynD+zKoqE/jDzHmoylB/8iKqoIYspSoOTGNu8XL
         CKmgpd+HVinHC2ABU951rjMRcxPZgToXLcBXA/WsiaQeBsTG0pnRkbn/o52dRpviCa4S
         ODhQ==
X-Gm-Message-State: AFqh2kp/TWCxNviUiYI4zprU66zbC5xaGRZTKKlM8HSI+5rQ5qxI/Kvh
        Kb2rMxWFnl1+TNue2h6xvjnbWPGM+r995NPUawayy+2o93zP/MB8pb+q3lMHAWtreFr8OqMWl2T
        prNN1GJAqHZBZjRBZlEByBTM=
X-Received: by 2002:a05:600c:4311:b0:3d2:3e75:7bb9 with SMTP id p17-20020a05600c431100b003d23e757bb9mr994923wme.34.1671529435450;
        Tue, 20 Dec 2022 01:43:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvfI2fbHCkuQqRJ76jLZpFV0pKFd9I/EWHnHADcWJc2WmgvjMGHFvYEzSGe6w+l7QXDUqu6sg==
X-Received: by 2002:a05:600c:4311:b0:3d2:3e75:7bb9 with SMTP id p17-20020a05600c431100b003d23e757bb9mr994914wme.34.1671529435238;
        Tue, 20 Dec 2022 01:43:55 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003d33ab317dasm17144094wmq.14.2022.12.20.01.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:43:54 -0800 (PST)
Message-ID: <c9a34fd2-3dc5-18d7-20b4-b5c9e69ad039@redhat.com>
Date:   Tue, 20 Dec 2022 10:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 16/18] fbdev/vesafb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-17-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-17-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Acquire ownership of the firmware scanout buffer by calling Linux'
> aperture helpers. Remove the use of struct fb_info.apertures and do
> not set FBINFO_MISC_FIRMWARE; both of which previously configured
> buffer ownership.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

