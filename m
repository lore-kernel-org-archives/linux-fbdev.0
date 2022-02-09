Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5F1C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 16:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiBIQF4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbiBIQFz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 11:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 064D2C05CB82
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644422757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TAmHdeWTvg28aUVJ1ETzsjk2tMW9UdCMcB5C9Mn4Tw=;
        b=VzOMnX0+TH8tk+uKw/VUJY4XcNv63/vRLop6sZI71RCwg75tnGihYZKet8ZUBhcAZa8byp
        3vpe0/n/xRJNIQPwA65hBQjWl+9d68yNkMbLk7tKR52X0fgF1WpvYf2HRgFHZiKaaYw/da
        A4R5IM+/QMNQ3QKxaEt99Qg3r5+YWMc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-Q2LizBDBMmawzM5nR28cKQ-1; Wed, 09 Feb 2022 11:05:56 -0500
X-MC-Unique: Q2LizBDBMmawzM5nR28cKQ-1
Received: by mail-wm1-f69.google.com with SMTP id v190-20020a1cacc7000000b0034657bb6a66so253163wme.6
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 08:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5TAmHdeWTvg28aUVJ1ETzsjk2tMW9UdCMcB5C9Mn4Tw=;
        b=HUOq3d/6k+8jb4/uQbbBI1/DHgZ/icSseDDbrMGDIfWOcCfMAmIOgfV6kVzmfbnBVD
         RTXTvqejLXnsvv13toAL+R8ZrwbdzvGINzXa1c8se/MVu+ciQqPdrD+Gas9zTso4dzwq
         5Cb/4ImMo8Th4o9BEyr0mgmuKhn6xtC18h+jrjZAqVWMolqeaF85J+PB6EOG1BtDI4fK
         tVUfgBfGtmVDGHamgoj9r/MBa7wE0kUrvMfubTSSjX5+MPfYmgBwM/3lzS4Zcl3Faz0x
         lgv+IuzmG0DLj6BC+HI1TDn3uezVhnBmf12PYGk4htKDAMyr/dPMLO60yZk3NYG/T8rX
         gqDg==
X-Gm-Message-State: AOAM532NHjrsTwJWk9W1ReCjqHEhBvPazvV5lu13ei1dcVCVZNWnj+O5
        qOCKAt/neljSFMv++UiQBM1RJW2dxs8h96zEfh2GtCrTzPC+Cu1dPDshLyoe4n62wyzi3huPdtq
        xoSKAqUAQIiBZRJ34XslbXRQ=
X-Received: by 2002:adf:ffca:: with SMTP id x10mr2725665wrs.248.1644422754731;
        Wed, 09 Feb 2022 08:05:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQmH0hF86x5L3n3fUWIlDsIruVfpsZiFRZH6CEakA0J830BtIAGYu0zKtjzdbc8XMHNPqYCg==
X-Received: by 2002:adf:ffca:: with SMTP id x10mr2725648wrs.248.1644422754526;
        Wed, 09 Feb 2022 08:05:54 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r2sm19113350wrz.76.2022.02.09.08.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:05:54 -0800 (PST)
Message-ID: <af9959db-96cc-8d53-27c7-9a0db1bbfdbe@redhat.com>
Date:   Wed, 9 Feb 2022 17:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <YgPa2AD727QnlRWW@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPa2AD727QnlRWW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/9/22 16:16, Andy Shevchenko wrote:
> On Wed, Feb 09, 2022 at 10:12:04AM +0100, Javier Martinez Canillas wrote:
>> The ssd130x driver only provides the core support for these devices but it
>> does not have any bus transport logic. Add a driver to interface over SPI.
> 
> Thanks!
> 
> Same set of comments as per I²C patch.
> 

Sure, thanks for your feedback!

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

