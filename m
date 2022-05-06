Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73ADC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 May 2022 07:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiEFHiS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 May 2022 03:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389596AbiEFHiQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 May 2022 03:38:16 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49E895D674
        for <linux-fbdev@vger.kernel.org>; Fri,  6 May 2022 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651822473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVV/F9WHxdXScNEZChl8c5nYVrBEBDkMFqnLnJ3JUR8=;
        b=PhHnJBpZYUF9xOddaPoPXTIbpOw1P2iKlC+7GBZ1ZBpL+sT+eLliUrlZr5wFBTY9HTWIs1
        W4b7rEpfQHCouBqNUcBaBm1qXalfLWoqVGxg6GtEB57rhXim8ICfzlioMYPDVwLH38Gy6p
        pPRpbCFb0ncX0bvMXwvHewO+4N5ODSE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-ljKeILjoMb2AyWUh-_JQtw-1; Fri, 06 May 2022 03:34:32 -0400
X-MC-Unique: ljKeILjoMb2AyWUh-_JQtw-1
Received: by mail-wr1-f70.google.com with SMTP id e21-20020adfa455000000b0020ae075cf35so2281849wra.11
        for <linux-fbdev@vger.kernel.org>; Fri, 06 May 2022 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YVV/F9WHxdXScNEZChl8c5nYVrBEBDkMFqnLnJ3JUR8=;
        b=QkN8TyAcUw5f/oI7xavNWz5uajAW5ereLOOi+Yq07dHIkuTQ7590WAhdR/z0y1O3ud
         q/JCi8pM8ED/lDqAyWR52o0r5NrteL0gzSXJplTrGJzLUf9BnBmAyGBi5ligk9XoF6Ce
         aKiQP3kC6WdQ2v4Sm4ET/Dqvtir700If0DWiFcAPiSut7uKFF442enPpzKY0DMfMoUJs
         Vv+LSfwYRLB22XTIxzF2N0PXVJnDMVBjNCsuHuV512PtnQM7SrGGdkEanJtXsSGlux30
         yiYPhnMbdAZZSCvFm9p9OojK1rRtuIUZswxswafK6VjFSFyn4ZUxqy8K+NLfzaiZZRDJ
         UC5g==
X-Gm-Message-State: AOAM5305AWTjV8R/SEWlBrLe7bQ7rq6Vxp3iyfNSwRvqB7lrOriML0+C
        5lZGHzboo/oXkzxxreq+sFxBh9oJjxh2wg/bwefUksrdPjgeOKVeTrxV54QmvTvEIqdL4moiQ9U
        inQgm+k6F7YjGQNigJu1wBgE=
X-Received: by 2002:a1c:f312:0:b0:387:8bf:bd3 with SMTP id q18-20020a1cf312000000b0038708bf0bd3mr2012827wmq.112.1651822471128;
        Fri, 06 May 2022 00:34:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3zBi5qrCjqE/FCrjwQZMOB3aA4NN9P3JVqib/Yx6UdP7hc96qqNbtfggn1wFtLl0BTWjHiw==
X-Received: by 2002:a1c:f312:0:b0:387:8bf:bd3 with SMTP id q18-20020a1cf312000000b0038708bf0bd3mr2012807wmq.112.1651822470916;
        Fri, 06 May 2022 00:34:30 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d4f87000000b0020c5253d8bfsm2923866wru.11.2022.05.06.00.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:34:30 -0700 (PDT)
Message-ID: <6936289f-acab-7140-9bb4-73b42db91876@redhat.com>
Date:   Fri, 6 May 2022 09:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/4] fbdev: Fix use-after-free caused by wrong fb_info
 cleanup in drivers
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220505215947.364694-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220505215947.364694-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/5/22 23:59, Javier Martinez Canillas wrote:
> Hello,
> 
> This series contains patches suggested by Daniel Vetter to fix a use-after-free
> error in the fb_release() function, due a fb_info associated with a fbdev being
> freed too early while a user-space process still has the fbdev dev node opened.
> 
Pushed this to drm-misc (drm-misc-fixes).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

