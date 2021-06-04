Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29C9C07E94
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Jun 2021 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB00D61418
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Jun 2021 12:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFDM0x (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Jun 2021 08:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230034AbhFDM0w (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 4 Jun 2021 08:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622809505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=T1WL3P0Jah1FRVj8EdxTUun4/hVMeybsNLS0++AfbT0=;
        b=D3VABfUUepIQpkGzBNNtoCxgF9w6jX5wGmxab+XTFwco2KchhvHzsahZF8QO3ftCaLI210
        QBdEkDLsga3+h++dWYiUsvkkKjCeZtgvrQyZU2gcHcN3pF7UzNLkxs28FIpi3L/CoUFvrx
        Dtk65n0cEte+dTj7rDwAMH+tWzoebJQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-12f550LUNdiaVpbu6C4yFQ-1; Fri, 04 Jun 2021 08:25:04 -0400
X-MC-Unique: 12f550LUNdiaVpbu6C4yFQ-1
Received: by mail-ej1-f69.google.com with SMTP id gs18-20020a1709072d12b02903f19777c38aso3345862ejc.9
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Jun 2021 05:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=T1WL3P0Jah1FRVj8EdxTUun4/hVMeybsNLS0++AfbT0=;
        b=sJp6EjAnruXCn+6HNyTDyfwN+37TTsP2d0YXS3WyQzfxZd0Kru4p36uU7K9wwpEBCS
         +HFTOfrF6wiuwY8p1r46zfQTvbmWyIXE5/6wmVEWjS3oghC/aZMdf7yA5KvOzeG6X9K5
         3FamdISZlQ/nTHcOdxQATMXG3DzU6pS4BKmfvsyA1zqSsbjfvfdkIj+0j8daLJ/2mMD9
         yn4JXetEBCQLJxbX/axvIORAWONolWI2GL7YjQwVeSkQanmweXXAjheYghMJq/uiWohS
         MaOUgX+Dd7wBa27z5G5YTrf95KWG0nloDuRhAeHFWQoAn5OCsFRiu4iCbsYk+nAc7WHB
         oWKA==
X-Gm-Message-State: AOAM5310p7P5/linKt4oLzj5qYgfD9dw1eeAnUKXtyMG5b1uAH4Yr4Ku
        xpSQFWeGz0Nd01/8mla1XX0K0gnej90sOioce3JRtRmlrJ1yotV88l25QDVxz8Fsdv/5WAl97p2
        n5YiGoATwnF3KRVjie4gMU2c=
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr3970593ejz.330.1622809503416;
        Fri, 04 Jun 2021 05:25:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfBZrM0jIbqGlvYiCojcZlu9rkqXCZiG0w6fufb5vpo1LYyrvNtiveJmLUv90tBUtvyXi0ew==
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr3970577ejz.330.1622809503266;
        Fri, 04 Jun 2021 05:25:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e22sm3207492edv.57.2021.06.04.05.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:25:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Matthew Wilcox (Oracle) <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>, wei.liu@kernel.org,
        Dexuan Cui <decui@microsoft.com>
Subject: [bug report] Commit ccf953d8f3d6 ("fb_defio: Remove custom
 address_space_operations") breaks Hyper-V FB driver
Date:   Fri, 04 Jun 2021 14:25:01 +0200
Message-ID: <87v96tzujm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

Commit ccf953d8f3d6 ("fb_defio: Remove custom address_space_operations")
seems to be breaking Hyper-V framebuffer
(drivers/video/fbdev/hyperv_fb.c) driver for me: Hyper-V guest boots
well and plymouth even works but when I try starting Gnome, virtual
screen just goes black. Reverting the above mentioned commit on top of
5.13-rc4 saves the day. The behavior is 100% reproducible. I'm using
Gen2 guest runing on Hyper-V 2019. It was also reported that Gen1 guests
are equally broken.

Is this something known?

-- 
Vitaly

