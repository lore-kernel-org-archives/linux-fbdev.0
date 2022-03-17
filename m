Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B69FC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Mar 2022 11:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiCQL0B (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Mar 2022 07:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiCQL0B (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Mar 2022 07:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03F261E3E06
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647516284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4VprwGw6dYDLbDGYJbvBp7kiHOiEm3c/qxk/CMwxqE=;
        b=Jj5Ow0UuEU45gjaVVxbOX6qP4XioJNJJpCdTwhBw1HEyidzSZZ2nhJmwZZiSEjZMVzxBwZ
        PXHK3+IwVoWOnLN4X48xfELconswOJXJVmOqEIXUAPTUU7zDoCIvU5Mk+peUkvA4QkRu63
        vDwq0SMRHYIBkvbbyj4FAbKj82jcjAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-XgpXxqMjMq-luOvA1Byv7A-1; Thu, 17 Mar 2022 07:24:43 -0400
X-MC-Unique: XgpXxqMjMq-luOvA1Byv7A-1
Received: by mail-wr1-f69.google.com with SMTP id t8-20020adfa2c8000000b001e8f6889404so1469017wra.0
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 04:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S4VprwGw6dYDLbDGYJbvBp7kiHOiEm3c/qxk/CMwxqE=;
        b=anNP8OLo3gXNMapfUApVHwCeV+jl7X8DzkplFAHdilMWIlwz11abkihMlu1uehcYUu
         OsY2uCcB6xLfbIvc2epzm2nJ3nDsa35JU0LHR5Hd84xtksbTZJjm/HDo/xFcKPjd0F9h
         OFSRYhtxlTds5Fgg4V5IaEGSjqHfgTmry5dWr2JFP2P0X0ruAVmnn3neDLB+3a9iA4t3
         0wtjMsaGnnzvL3gtOm7z/R9VjjEuQ+RRGI0nF07cE5XADGHrdE/mb5gGTDnvRb48AezC
         ok4t0O9UT4oTFHzKjI98bQnnnkvyR1s74FBoDLdtcsPOf/7DdUzahg1gBlTx9Y+c0vDg
         WONQ==
X-Gm-Message-State: AOAM530ToLCNv7m+thmXCiQk+2zpXWu4iXa243kHFYLrOpeslgRL5ba3
        NEaFQVdMShWxEU4nUcAQAjKlSC0Lk1n7sdxIFWWD0PHfj0v9bI6t8tmXfVHnnXbYhp+tJJpl+rV
        32XrX76PavL7Re5/Rs4RRYlE=
X-Received: by 2002:adf:db4b:0:b0:203:e76f:fc45 with SMTP id f11-20020adfdb4b000000b00203e76ffc45mr3006193wrj.549.1647516281816;
        Thu, 17 Mar 2022 04:24:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOnU89ml+JaUcjGLfEaRj6DaQa6v2k32g/K6zymxVfaTNS+J88razRZqhQ3phLwUFbxXGjAA==
X-Received: by 2002:adf:db4b:0:b0:203:e76f:fc45 with SMTP id f11-20020adfdb4b000000b00203e76ffc45mr3006175wrj.549.1647516281539;
        Thu, 17 Mar 2022 04:24:41 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b0038a0165f2fbsm4650406wmq.17.2022.03.17.04.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 04:24:41 -0700 (PDT)
Message-ID: <a84b3c59-7458-78a4-4909-0424cd76af3a@redhat.com>
Date:   Thu, 17 Mar 2022 12:24:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] fbdev: defio: fix the pagelist corruption
Content-Language: en-US
To:     Chuansheng Liu <chuansheng.liu@intel.com>, jayalk@intworks.biz,
        daniel@ffwll.ch, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org
References: <20220317054602.28846-1-chuansheng.liu@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220317054602.28846-1-chuansheng.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Chuansheng,

On 3/17/22 06:46, Chuansheng Liu wrote:
> Easily hit the below list corruption:
> ==
> list_add corruption. prev->next should be next (ffffffffc0ceb090), but
> was ffffec604507edc8. (prev=ffffec604507edc8).
> WARNING: CPU: 65 PID: 3959 at lib/list_debug.c:26
> __list_add_valid+0x53/0x80
> CPU: 65 PID: 3959 Comm: fbdev Tainted: G     U
> RIP: 0010:__list_add_valid+0x53/0x80
> Call Trace:
>  <TASK>
>  fb_deferred_io_mkwrite+0xea/0x150
>  do_page_mkwrite+0x57/0xc0
>  do_wp_page+0x278/0x2f0
>  __handle_mm_fault+0xdc2/0x1590
>  handle_mm_fault+0xdd/0x2c0
>  do_user_addr_fault+0x1d3/0x650
>  exc_page_fault+0x77/0x180
>  ? asm_exc_page_fault+0x8/0x30
>  asm_exc_page_fault+0x1e/0x30
> RIP: 0033:0x7fd98fc8fad1
> ==
> 
> Figure out the race happens when one process is adding &page->lru into
> the pagelist tail in fb_deferred_io_mkwrite(), another process is
> re-initializing the same &page->lru in fb_deferred_io_fault(), which is
> not protected by the lock.
> 
> This fix is to init all the page lists one time during initialization,
> it not only fixes the list corruption, but also avoids INIT_LIST_HEAD()
> redundantly.
> 
> Fixes: 105a940416fc ("fbdev/defio: Early-out if page is already
> enlisted")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> ---

This makes sense to me. If you address Geert comment and post a v2,
feel free to add:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

