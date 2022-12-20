Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA2AC4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLTJL2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLTJL0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:11:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1DD17AAF
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671527438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nkva43Ev6FmONs/91WyhlWJwflJzPv43uZcJFYvlalU=;
        b=ZOz9yi8O6/fuTaqK9UF8rBB9tViyIklanR+2/D8Pg1cHkv/FseZD58SNNgCcVBFVw+WC5E
        sBhslITFibruSdTiCcBXCV63EEpsIH8W+lonbrkZ0sHhtkCJl8ze2uP02ux1QU9OyVGGIy
        ebBFYn/rHbaFHuGgh+AJ4qLBAzmtGJg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-207-ctGPAa36NnqAKxF9IC6Ruw-1; Tue, 20 Dec 2022 04:10:36 -0500
X-MC-Unique: ctGPAa36NnqAKxF9IC6Ruw-1
Received: by mail-wr1-f71.google.com with SMTP id i13-20020adfa50d000000b0025f5084b95dso1140855wrb.5
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nkva43Ev6FmONs/91WyhlWJwflJzPv43uZcJFYvlalU=;
        b=sgFmTsGbnySftbdW8QwlItXMgPUh4YWIKz1a33sTKgk8vnc6rheB5SBbrjnB8BMOYA
         gs7o4X+X50ZAHe7/Q1Yx+8TFx5xEs6b4YmhDH4H88YY0uJtk7WSBL0ryl75clnXGsrSG
         3QpYuQfZTwrK+7yam3Ok670O/l3EC42wcmcquC5jJmbYwpIy/A+Hr8uf7TGtNi/hMG1R
         DF9iCVU2wQpLQ+nwnokTipSSO3PVjkDo0yLomIvWsAKGXxKPT2iVO+A1Wg6NgJDlMIaG
         FWkCQ+3fHfb+UCRtiypx5scVNlPgNZN6ZDPWiRmPr2aDyDIcuX+6Umdh8RD9ZSox5/cw
         mHXQ==
X-Gm-Message-State: AFqh2kpMkOPZ0e4+2ao5N9B1MPUF/OUUHqC32l56QpwGIwlFec1ed6nN
        TgbiwUnSOTZT+VqeGaTXp4RZ42IgprFiZUaTgqv6tsEilleA/n87xDMkHIpaeiW3lnJ8jWBhPAo
        1evtebmVC7i43Ntb16ry9uNs=
X-Received: by 2002:a5d:624a:0:b0:242:19b3:67 with SMTP id m10-20020a5d624a000000b0024219b30067mr748878wrv.37.1671527435425;
        Tue, 20 Dec 2022 01:10:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZ4T3pjgbBye4AD0pnUB9As/CnLPdlMjMDQrxm4f9mLfnMBPQihgpuK1r6jSAdZ8wsH7ZV9g==
X-Received: by 2002:a5d:624a:0:b0:242:19b3:67 with SMTP id m10-20020a5d624a000000b0024219b30067mr748861wrv.37.1671527435215;
        Tue, 20 Dec 2022 01:10:35 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d59c5000000b00241fea203b6sm12177113wry.87.2022.12.20.01.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:10:34 -0800 (PST)
Message-ID: <1ba311d8-efe5-c3f0-761e-1b5695dd5ba2@redhat.com>
Date:   Tue, 20 Dec 2022 10:10:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/18] fbcon: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:04, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

