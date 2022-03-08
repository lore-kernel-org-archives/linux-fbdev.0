Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A5AC43217
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiCHRYk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349837AbiCHRXv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 12:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD9C56276
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646760129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJ7r5VyRgX3KAENICcL5S3qj/ix1OtYfo/guqTts9VM=;
        b=YL3DbxEHfAzZrw+jq+1PA33mOmLffVqgAHpz5Lh56+2GLksup+PhpgL7CkydiNP2exve7R
        9J+0wGzWTePDbycbCkYm8d31raNNLOxSI2nmP2XIb1Qa1Omyq5Zdkf56RWcTkUIyPwErA7
        CkCXnhY05A5/XfA3oci3K06ouZgaRkA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-Zj-G-_21OnGocdrpi9cBbw-1; Tue, 08 Mar 2022 12:22:08 -0500
X-MC-Unique: Zj-G-_21OnGocdrpi9cBbw-1
Received: by mail-wm1-f70.google.com with SMTP id j42-20020a05600c1c2a00b00381febe402eso1453308wms.0
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 09:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fJ7r5VyRgX3KAENICcL5S3qj/ix1OtYfo/guqTts9VM=;
        b=JK9vPlz/b1QaNGZI5DIQ8fXttnCswrawt7DMSeOy7o+yBsiTkkM1h2OodpSTDeOZMy
         QKrnkSgE1txSJxJ9ufoH+rGSb6lEbjaJKp03yftmRddLBI3juEX301QSIGgc6fYB2V9k
         ZM2cmCMTzQsl0Xrn0sj7a1IcDjrel4uFDpaxSjhQxHZif+JUZJjnboyKDeU/07XXVWKI
         JEIWNvyFqcsuqa6kl/x80fhAZ8aWLjEVd9h0IRx1jsV+RCFGzq6MapNT3iOg09/292fj
         8Sd6sK4KtnZracIjDiq556e6B4qnH6S7ZttScOL7HtmYnLbH8eoWjZkVGH83pbmBhbFU
         sUqw==
X-Gm-Message-State: AOAM532+Od9c1e4ziNGONdsDIkI9JvaA9nlmjsVdmo0sG8odagun2fZq
        jKLcb1NDJGUBMuEprnUGt7fn1NXTm7vhmGdtvkHtQZi8oun3EgSsIiOT+aM2UdWcOzgqrvp/gJT
        VYB6ouLqij277nq9yLPQ8QCg=
X-Received: by 2002:adf:f38d:0:b0:1f0:490a:92ae with SMTP id m13-20020adff38d000000b001f0490a92aemr12728358wro.497.1646760126891;
        Tue, 08 Mar 2022 09:22:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZCpZOxciK/Q29ufTNk0vHv88pvSmESMyFveChiU2+Box+IsygA4K4y+E7u/Ni9pLr9+r+uQ==
X-Received: by 2002:adf:f38d:0:b0:1f0:490a:92ae with SMTP id m13-20020adff38d000000b001f0490a92aemr12728334wro.497.1646760126672;
        Tue, 08 Mar 2022 09:22:06 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm2752494wml.10.2022.03.08.09.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:21:59 -0800 (PST)
Message-ID: <c49bc1b5-6dcf-fb12-f0cf-837063db665c@redhat.com>
Date:   Tue, 8 Mar 2022 18:21:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/9] fbdev: Export helper for implementing page_mkwrite
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-5-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220303205839.28484-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/3/22 21:58, Thomas Zimmermann wrote:
> Refactor the page-write handler and export it as helper function
> fb_deferred_io_page_mkwrite(). Drivers that implement struct
> vm_operations_struct.page_mkwrite for deferred I/O should use the
> function to let fbdev track written pages of mmap'ed framebuffer
> memory.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

