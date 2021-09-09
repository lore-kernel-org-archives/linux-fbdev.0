Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D283CC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Sep 2021 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FC26113A
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Sep 2021 15:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhIIPx6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhIIPx5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Sep 2021 11:53:57 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21461C061574;
        Thu,  9 Sep 2021 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:Subject:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uwZkGDe+5yKUNrBX24pEyL/TFCLpIwoT4rE5dF+jo9Q=; b=R6+gKJvEWq5xj0o2GwdFVFdGgr
        9ujtFg02VpVABYtSj1TKtBQfOOSp0HbJePYERRYAcgg6x6rMR4KxKavPzAwCk+JHpeYe8rkBM2d1S
        cCjeFCUsmdJu4j9kozpED3Gt9PsvFKcSXokJOVteEffE/2WCy2U6EdscAI1DDQAsi/wC5SVnJjvvx
        K5BKf+Z1AdHq1NAdDZBdnFgerfV5qZr8syfGd7extn3SHY60xXCgRkb4o0/mZQY9Ck05DPZ65UFcX
        9USVju7taOb2+U8v5QubsB30NsHwojaILxcVi5vfGwWAAE8RMv3Ycv62J1tLvH8+vlFNkI3v3BEyl
        lK10fUEg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:60364 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mOMLz-0001BY-VF; Thu, 09 Sep 2021 17:52:43 +0200
To:     sam@ravnborg.org
Cc:     airlied@linux.ie, bp@alien8.de, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, hpa@zytor.com,
        javierm@redhat.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mingo@redhat.com, mripard@kernel.org, pbrobinson@gmail.com,
        tglx@linutronix.de, tzimmermann@suse.de, x86@kernel.org
References: <YS+Lhz9gg/0Caa+0@ravnborg.org>
Subject: Re: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with
 CONFIG_FB disabled
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <2527f0ef-dae1-9ad5-84a4-00712c44940d@tronnes.org>
Date:   Thu, 9 Sep 2021 17:52:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YS+Lhz9gg/0Caa+0@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


> Hi Daniel,
>
> >
> > I think for a substantial improvement here in robustness what you really
> > want is
> > - kmscon in userspace
> > - disable FB layer
> > - ideally also disable console/vt layer in the kernel
> > - have a minimal emergency/boot-up log thing in drm, patches for that
> >   floated around a few times
>
> I assume you refer to this work by David Herrmann:
> "[RFC] drm: add kernel-log renderer"
> https://lists.freedesktop.org/archives/dri-devel/2014-March/055136.html
>

There's also this:

[PATCH v2 0/3] drm: Add panic handling
https://lore.kernel.org/dri-devel/20190311174218.51899-1-noralf@tronnes.org/

Noralf.
