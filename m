Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A57C10F1E
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLTJfA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiLTJe5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:34:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7E5186A3
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVZMgP3yXzrzjDhtvsp+tMbNXy6x5UaaSyaJJzd0B0g=;
        b=e9TRzOd1GM9BZy7nwUeFTzI2fs+3M19xRDSziQ7diozTs1U+dG32FnVeAxrndE+2rscfhV
        6sZIO//1MHH0nEQuphwpdWDT0gBLnOIcHFvZ+SFr87IT8IcNP5ab2G/BsS2RWSaCKvsWYp
        tTh9xmVYGQ0Qy2zAiARa2HEbY71FJ/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-EdpIWrKmMrmh5ALm2-b2IQ-1; Tue, 20 Dec 2022 04:33:55 -0500
X-MC-Unique: EdpIWrKmMrmh5ALm2-b2IQ-1
Received: by mail-wm1-f71.google.com with SMTP id q21-20020a7bce95000000b003d236c91639so2391748wmj.8
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVZMgP3yXzrzjDhtvsp+tMbNXy6x5UaaSyaJJzd0B0g=;
        b=Vq+cmCqgGvuBpfNj9Z+0o/wn7IDq6M8RMl/5WzKJIMneSi/vFjcgb6zk/gOjMEVpoG
         dw10qL8AZNZo7+3ZBjfz0GMGIzTd4XB8QLeCg7jSUXUuNhcUxE+sopjbVsoOuHum8OaI
         J6bymTeYEdVjZHhye5P16yFHG3rzwR+b/6IA8fK4BW7DbUUcS0EnqI0j75au8UihmnC6
         2eXNwCus8GvVXSPPqMYrqBNiKLWqHOJkX9lAcH7dy5h/O1xchgCshP89oqutLVXjmyWk
         1msZz/4bkPlVBGa5H7ENU8OiKhk2I65T8fMIUKnYlrZtgRFqc01vq6/AFYRWe0d6pDyd
         7ZYQ==
X-Gm-Message-State: AFqh2koftwQkb0PYgMIhx/YfQFGJYr0tAwgsWMQpQhT2i4oncDWXqs8/
        9eeItrRjMF4FttSQAgdBZNqLb6JSfriXjAJIEw6k2BtkEcf5RuON6BuMR4YHv0H08l+0g+zxfo5
        ojVkVUvXXzGv30ynSB9012rM=
X-Received: by 2002:a05:600c:b59:b0:3d6:4ba9:c111 with SMTP id k25-20020a05600c0b5900b003d64ba9c111mr241655wmr.40.1671528834238;
        Tue, 20 Dec 2022 01:33:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsPd0UOZgaV2usn9FHot5yPumcQTQ0WuQ30V9fRvNh8brfS+c9839HDYnoS7vxUK6doBa1czQ==
X-Received: by 2002:a05:600c:b59:b0:3d6:4ba9:c111 with SMTP id k25-20020a05600c0b5900b003d64ba9c111mr241645wmr.40.1671528834044;
        Tue, 20 Dec 2022 01:33:54 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05600c1f1a00b003d070e45574sm15319946wmb.11.2022.12.20.01.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:33:53 -0800 (PST)
Message-ID: <8f63bb10-e1e4-0111-5032-dca1b4a2f437@redhat.com>
Date:   Tue, 20 Dec 2022 10:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 10/18] fbdev/efifb: Add struct efifb_par for driver data
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-11-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> The efifb_par structure holds the palette for efifb. It will also
> be useful for storing the device's aperture range.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

