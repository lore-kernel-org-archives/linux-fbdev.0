Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E7C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Apr 2022 07:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355208AbiD2HhY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Apr 2022 03:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355202AbiD2HhX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Apr 2022 03:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 721B8B89BD
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651217645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OcIvWzPcJnww0zTz6xq/G3xwoPRJB4jNoVaJfsinXWU=;
        b=DS/DWeDoqY5YrXeKtSP9PopafGEoEeQI5/qEzc0trPVNjA8inhZrFZ/aIXbWrYuAMZZ25u
        A8NmsgnxfLE7zXOWPFCbWEOuYezLKPEXcdGyG4HQzWE/mUqanFELIGJwU8dTCs4MoVwjpK
        +0DFcsNxOnpipWZPDNOHLgwxxj0j2DA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-F_iBZPkkM42FMBcDburT1A-1; Fri, 29 Apr 2022 03:34:03 -0400
X-MC-Unique: F_iBZPkkM42FMBcDburT1A-1
Received: by mail-wm1-f72.google.com with SMTP id p32-20020a05600c1da000b00393fbf9ab6eso4577123wms.4
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 00:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OcIvWzPcJnww0zTz6xq/G3xwoPRJB4jNoVaJfsinXWU=;
        b=eM60NUmJ9GGhYQooEWk3+VTBDQI9LhlRC7UTs4Kv9v5777sBhqcRnhukJMSvqA3n8h
         TUgQFfrRm3HDl4Y9Sy3JetkO2bgnZGTaw/LniaJCsEJrV+Ep7VMNwZxI4s1LCMjfYTuj
         IkW+zvO+jLquULKmGUI96aZ5SHli3OLCreDbbtXCF8BqvZ0vrnYaHdGuKP0g3dQbAA80
         5EpnI23zbWg/bmSsmRIjmWN7rDc/7ZuKlVeVD+dQi5Uwh0/3m+9L6D0nNW+nQo48QwYf
         iFpt5FFdwq5HeqCwbe31e1BKbc5qe6VsLe5iiUs6anr0O0SfSc09IHnzhTPvQ8bvDuJh
         WrMQ==
X-Gm-Message-State: AOAM532qKO4fdw5cES0ajV0DjK12cYD9QNY7utxix2iZK5L0SkOAXd4S
        00YGiMi8HaxUonfL/WJplExY33DWUnHAaTKGOt5tqQ7R0Tvv0mVrHTDbqdtzLp2St6XlehVjx+o
        4b22zIDXxvsYqWsrtaCno4yA=
X-Received: by 2002:adf:d1c9:0:b0:203:c225:d042 with SMTP id b9-20020adfd1c9000000b00203c225d042mr29168271wrd.630.1651217642692;
        Fri, 29 Apr 2022 00:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKeChGxDtUOIOIVUKYT/bPfzc5CwFC1QoimsKjIsxsaE/PpQ3Tz6m0jAjbCqtV0ydl1Zka6A==
X-Received: by 2002:adf:d1c9:0:b0:203:c225:d042 with SMTP id b9-20020adfd1c9000000b00203c225d042mr29168261wrd.630.1651217642460;
        Fri, 29 Apr 2022 00:34:02 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020aa79d55b5sm2001749wrb.35.2022.04.29.00.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 00:34:02 -0700 (PDT)
Message-ID: <00a89131-9cb6-4022-b7fd-7531c980ec32@redhat.com>
Date:   Fri, 29 Apr 2022 09:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 5/5] fbdev: Use pageref offset for deferred-I/O
 writeback
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, airlied@linux.ie, maarten.lankhorst@linux.intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220426120359.17437-1-tzimmermann@suse.de>
 <20220426120359.17437-6-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220426120359.17437-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 4/26/22 14:03, Thomas Zimmermann wrote:
> Use pageref->offset instead of page->index for deferred-I/O writeback
> where appropriate. Distinguishes between file-mapping offset and video-
> memory offset. While at it, also remove unnecessary references to
> struct page.
> 
> Fbdev's deferred-I/O code uses the two related page->index and
> pageref->offset. The former is the page offset in the mapped file,
> the latter is the byte offset in the video memory (or fbdev screen
> buffer). It's the same value for fbdev drivers, but for DRM the values
> can be different. Because GEM buffer objects are mapped at an offset
> in the DRM device file, page->index has this offset added to it as well.
> We currently don't hit this case in DRM, because all affected mappings
> of GEM memory are performed with an internal, intermediate shadow buffer.
> 
> The value of page->index is required by page_mkclean(), which we
> call to reset the mappings during the writeback phase of the deferred
> I/O. The value of pageref->offset is for conveniently getting an offset
> into video memory in fb helpers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Thanks for including this patch.

[snip]

>  	list_for_each_entry(pageref, pagereflist, list) {
> -		struct page *page = pageref->page;
> -		start = page->index << PAGE_SHIFT;
> +		start = pageref->offset;

It also has the side effect that makes the code easier to read and as you
said in the change description, eliminates the references to struct page.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

