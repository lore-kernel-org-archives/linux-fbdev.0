Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28325C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Sep 2021 16:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077386113E
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Sep 2021 16:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhIIQ2S (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Sep 2021 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhIIQ2S (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Sep 2021 12:28:18 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B71EC061574;
        Thu,  9 Sep 2021 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:Subject:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8fM6t+CZ3TSxl0jBQrfAnRu3bSUr2tc6gGURbxgCLUE=; b=bBMePvtXPp4cKRU4T+oMuLswT2
        dt1suHpjoK6DJwdogL2e0UPXWwhm27R1p3yJQcnovDCNgpw8xIhlsDv+GZozryPolrukMuKgpt+eB
        nvElMCPOqCPCt4nCzA+9k60oM9h6czLRJ1kMaM8A6nXFiCqt9IgtTwS6n2dmhY8K7q8r3L2sdFrRf
        OlcP5FW5vXrKjJFD9fjnRKbebaZgmDIyWotaxBFDqBLXJrJIGZBZH30bAxCYD1GVzbUcTEzCnyDh8
        a9WElTR2qa8BGnfjA07wpjgdrgiXOtQR7/Yyjqz3zgu7V6PYfRwhtOpQDvye4B5oCdpRds17Fevvc
        LKna/I2A==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49957 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mOMtG-0002FB-Ip; Thu, 09 Sep 2021 18:27:06 +0200
To:     noralf@tronnes.org
Cc:     airlied@linux.ie, bp@alien8.de, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, hpa@zytor.com,
        javierm@redhat.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mingo@redhat.com, mripard@kernel.org, pbrobinson@gmail.com,
        sam@ravnborg.org, tglx@linutronix.de, tzimmermann@suse.de,
        x86@kernel.org
References: <2527f0ef-dae1-9ad5-84a4-00712c44940d@tronnes.org>
Subject: Re: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with
 CONFIG_FB disabled
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <ff6a590e-19ee-b2b6-bed5-236962637418@tronnes.org>
Date:   Thu, 9 Sep 2021 18:27:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2527f0ef-dae1-9ad5-84a4-00712c44940d@tronnes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


> > Hi Daniel,
> >
> > >
> > > I think for a substantial improvement here in robustness what you
really
> > > want is
> > > - kmscon in userspace
> > > - disable FB layer
> > > - ideally also disable console/vt layer in the kernel
> > > - have a minimal emergency/boot-up log thing in drm, patches for that
> > >   floated around a few times
> >
> > I assume you refer to this work by David Herrmann:
> > "[RFC] drm: add kernel-log renderer"
> > https://lists.freedesktop.org/archives/dri-devel/2014-March/055136.html
> >
>
> There's also this:
>
> [PATCH v2 0/3] drm: Add panic handling
>
https://lore.kernel.org/dri-devel/20190311174218.51899-1-noralf@tronnes.org/

And here's a DRM console example that was part of the early drm_client work:

[RFC v4 25/25] drm/client: Hack: Add DRM VT console client
https://lore.kernel.org/dri-devel/20180414115318.14500-26-noralf@tronnes.org/

Noralf.
