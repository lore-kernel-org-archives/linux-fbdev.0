Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7CAC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 May 2022 13:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384872AbiEBNNc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 May 2022 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiEBNNb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 May 2022 09:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFAF41929B
        for <linux-fbdev@vger.kernel.org>; Mon,  2 May 2022 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651497001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M98yuoliII0uhmAHMZF66gc9CngyxoP5h99A2Tsi4xY=;
        b=EBbFVwCJwJ9npy/ioOpNz3rXoqLvdTqkpxdDwqzObFgdhcdOUPA0RGPPEYBJfn8wUg61n8
        eV7pxCKXVNtTynM7Oudn8uYtx38I8x/YnmDIrhcHvOczyQfOXNzxJaO5NrJ0UHLZnyMmDR
        leWFu4L+UsSvSyaUFn5NdrAHOZUAxnk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-S1Gai02YMWSh_xm_RyZW_w-1; Mon, 02 May 2022 09:10:00 -0400
X-MC-Unique: S1Gai02YMWSh_xm_RyZW_w-1
Received: by mail-wr1-f71.google.com with SMTP id l7-20020adfbd87000000b0020ac0a4d23dso5320139wrh.17
        for <linux-fbdev@vger.kernel.org>; Mon, 02 May 2022 06:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M98yuoliII0uhmAHMZF66gc9CngyxoP5h99A2Tsi4xY=;
        b=cxgrhDy1La6x8aTR2RbIJx4iiWb3KK7lRZS9m9rqE2cOShaaHn4YFY2juTIEp1ZRHX
         PnjxZZxPx4O+uCJ4d/Uj7hcVwjscJcd5QXDQbyI/q5WVwT5Cwed4Z/I/LaL8ms4Kag36
         LI1onl4FEHd3u2x5hnCYOSjGv26LBFLyEPAwAGMsYNjJrSmUPmnVy/sWq+MRo8h/Owaq
         gUkMm+jsqfRLtHpMwBqcjC77ECZ0rcT35HKhDW5soYTVAwoFAT04FsMjqSs9Q59Q4Gu1
         PoBCUzripBzFSs/2UqqSQ1Bc3IS/E3P6sXuK1d2xOsXzcUXT8h0B0t2XqTrVZ7UahseM
         8ztw==
X-Gm-Message-State: AOAM530cUmgdWwZH8Vlzis9LB5yiLszvW1hfwcnodWSjoBgFcfN4zeLV
        NqIlLN6FzWEoRK2ZYSmM4vRc72pRb3ClRyrxtBLiOIlotGEdUo8J/TCfV9XB5gn7ZVPv0bIrJ2V
        5J64JPBOkWIyqkICjhWuTs28=
X-Received: by 2002:a5d:4302:0:b0:206:4b2:8690 with SMTP id h2-20020a5d4302000000b0020604b28690mr9494466wrq.224.1651496999237;
        Mon, 02 May 2022 06:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKVP2T2hazdS7uD0pMN5Q6bcG0ygMlmFscepv/VzzVywZGxoSQ2B+d0TgKpqI/Cu+rYnhltw==
X-Received: by 2002:a5d:4302:0:b0:206:4b2:8690 with SMTP id h2-20020a5d4302000000b0020604b28690mr9494444wrq.224.1651496999021;
        Mon, 02 May 2022 06:09:59 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y16-20020adfc7d0000000b0020adc114136sm9302081wrg.0.2022.05.02.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:09:58 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 0/2] fbdev: Fix a NULL pointer dereference in fb_release()
Date:   Mon,  2 May 2022 15:09:42 +0200
Message-Id: <20220502130944.363776-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

This small series contains fixes for two bugs I found in fbmem.c, that may
explain a bug reported in the rpi4 [0] when using simplefb and vc4 drivers.

I was not able to reproduce the mentioned bug, but looking at the code I
think that it might explain the issue.

I've tested these patches in a rpi4 with both simplefb and vc4 drivers
built-in and did not find any regression.

[0]: https://github.com/raspberrypi/linux/issues/5011

Best regards,
Javier


Javier Martinez Canillas (2):
  fbdev: Check in file_fb_info() if the fb_info was already been freed
  fbdev: Make fb_release() return -ENODEV if fbdev was unregistered

 drivers/video/fbdev/core/fbmem.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.35.1

