Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15CFC4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jan 2022 09:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573970AbiAYJgU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:36:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1574340AbiAYJdX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Jan 2022 04:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643103198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEIrERDn4Bih0BsT7Q6ri6so+lgoG4CTnKlVf6K4FYA=;
        b=VRTdeeJae3bi2JBGr8JBFa/sTFep0elsNUWrRsqP00Bq66p2sERl3Uja7bSkBsK7zQgYnR
        tmiuMUM3cY+At9pTq8GoALzMosvVYxAe/2eSRPT1SiqgW4p48J9Rd0P3LSNqcobszx6ZIa
        0cum7yQjs+oxQscQWKlFMynIvi86FUE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-jtWIPWEpMZexBUrCws9KEA-1; Tue, 25 Jan 2022 04:33:15 -0500
X-MC-Unique: jtWIPWEpMZexBUrCws9KEA-1
Received: by mail-wm1-f71.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso1153728wmb.9
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Jan 2022 01:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KEIrERDn4Bih0BsT7Q6ri6so+lgoG4CTnKlVf6K4FYA=;
        b=rL7Km7XJ1NkYk+V1TOr3ai6fS9nQE0Y9RbUqdRj+vYuVJydGp9X+qfIul2v6emd8S3
         MI2VLU3gYhTXQinIxoLqh1V+sD3AdJpt5mfw+46lh0YS4A//T6Yek1K6I+BlDYhEeTsw
         RApq6xoffnBZ2qiz+J0CQ0soaSVZmreDXL9CY6Apr7d4gprAryc60F+gtEeBjb5oQjLh
         sSaIJphaceFJxPJgnjt2hyWZUmCluPasyRd8cilAfeIgGU6uEKX7z2uWZ+nQSFsLrKLA
         DpOlYKtgmJwQLENLsnhJdALd0n6Q9MkxS7nIlxIp7G4a5ZTvMMhYWc9nhrEaTh15LBwO
         Ktow==
X-Gm-Message-State: AOAM531tlXC7mDMOoUaB43D++USr0Av1Jd5T40XWQRPetvrMzjMli89B
        d8oXXzmcrSSCfO/2is21U2uJgqP9IzQXfaVXNi+KwCBfV3MPl6EdrESxT3NfOa6zMz8gZ/lYkWd
        N9lNg6Wi9nJ6AV3SNpQKGIFI=
X-Received: by 2002:a05:600c:1f16:: with SMTP id bd22mr2126383wmb.91.1643103194371;
        Tue, 25 Jan 2022 01:33:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+hdEt2uINp6DhGe9P9TDw6/5Wl8ziv2lioaaxK6wjExUJ2fHba9mtfodIfrJx7uO5S7/r6w==
X-Received: by 2002:a05:600c:1f16:: with SMTP id bd22mr2126363wmb.91.1643103194184;
        Tue, 25 Jan 2022 01:33:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i6sm6627wma.22.2022.01.25.01.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 01:33:13 -0800 (PST)
Message-ID: <db92f89b-e266-f87d-d635-4207fd2585c4@redhat.com>
Date:   Tue, 25 Jan 2022 10:33:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/5] fbdev/simplefb: Request memory region in driver
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, zackr@vmware.com,
        jfalempe@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, hdegoede@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220125091222.21457-1-tzimmermann@suse.de>
 <20220125091222.21457-5-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220125091222.21457-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 1/25/22 10:12, Thomas Zimmermann wrote:
> Requesting the framebuffer memory in simpledrm marks the memory
> range as busy. This used to be done by the firmware sysfb code,
> but the driver is the correct place.
> 
> v2:
> 	* store memory region in struct for later cleanup (Javier)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Thanks a lot for updating the patch. Now this logic is also more
similar to the changes done for the simpledrm driver in PATCH 3/5.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

