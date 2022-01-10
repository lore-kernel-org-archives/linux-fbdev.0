Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13E5C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 10 Jan 2022 09:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbiAJJ4d (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 10 Jan 2022 04:56:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243435AbiAJJ4b (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 10 Jan 2022 04:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641808590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ObCOlx7qc1MuxpL5+ry8PrWxS3J2SNPySVs4WNajgno=;
        b=WFEq4vk6Za+3RZ7KDUAkyBsxx9Ms858MsbiEp7XIZeCaocrjbCrmXJDb9xjFJk7QGZwc5I
        mN7aLFPYgLWYHsVIn/o+qO6IfObJRvDwGtqOOcOR0jXnNOnfj98PQUQ/AJ6f/A4oSe57CR
        E97hmAJ7gT1n6xLett37PdHprNR6fL8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-Re8_GUSBPMS97UcbdfNrxA-1; Mon, 10 Jan 2022 04:56:29 -0500
X-MC-Unique: Re8_GUSBPMS97UcbdfNrxA-1
Received: by mail-wm1-f71.google.com with SMTP id m17-20020a05600c3b1100b0034922b9c177so276622wms.6
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Jan 2022 01:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ObCOlx7qc1MuxpL5+ry8PrWxS3J2SNPySVs4WNajgno=;
        b=NHzYCnEX1ny+xGA7aVYrWNbHMUDq/oJdeMc82iD7Zue5BrlOcw9BOb//6+7IBHTjpq
         9Z1EoQwyOjJZh2z3jfZwJAkyBxG6qYEG8J9URNpcmyNnrQWioPGYkfzFUTcRZ3+kTiPQ
         VXwlY9RuTjv8+Kd/qItKLJwhfjIdH3y8LYDGs4KP4+sZx9p/Us8hVv9foJjlA9EVdXCH
         qU7YVVrl9HIMWEwPFLadH6j/WBM3giyxATLXtDrnhFBSYTUpffTQb84V52bhEKHLvwHY
         xPhs2rsbKubhBQW7M1i0oWgX45oLFBAOE9XQnvPcykghWUIkG9Yf1MHSdnMnmYj57P53
         l9pg==
X-Gm-Message-State: AOAM533NDegmcER8XSFkTqGyLEqC6tTfegUtAjTFAsfGMx1bF5duEZvs
        JzV4ln1R48wzRAC77J4Fwyi17q+b2yxzSvE9U8Xh/QGdyAEOUPLpHVXMQ6nTmWm3X4SkIFQ68ts
        O1ADJX5jz6oT8Vs6puaC4TBs=
X-Received: by 2002:a05:6000:1687:: with SMTP id y7mr62811730wrd.636.1641808588373;
        Mon, 10 Jan 2022 01:56:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGrDXSR/pexIPk1NzHcVn2qTkgOkF6tU7OxEDfgPSVggBPqdm80ZGadCbvMnDG9B5WHjpKYA==
X-Received: by 2002:a05:6000:1687:: with SMTP id y7mr62811720wrd.636.1641808588144;
        Mon, 10 Jan 2022 01:56:28 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b13sm6315167wrf.64.2022.01.10.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:56:27 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kris Karas <bugs-a21@moonlit-rail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 0/2] video: A couple of fixes for the vga16fb driver
Date:   Mon, 10 Jan 2022 10:56:23 +0100
Message-Id: <20220110095625.278836-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This patch series contains two fixes for the vga16fb driver. I looked at
the driver due a regression reported [0], caused by commit d391c5827107
("drivers/firmware: move x86 Generic System Framebuffers support").

The mentioned commit didn't change any logic but just moved the platform
device registration that matches the vesafb and efifb drivers to happen
later. And this caused the vga16fb driver to be probed even in machines
that don't have an EGA or VGA video adapter.

This is a v2 of the patch series that addresses issues pointed out by
Geert Uytterhoeven.

Patch #1 is fixing the wrong check to determine if either EGA or VGA is
used and patch #2 adds a check to the driver to only be loaded for EGA
and VGA 16 color graphic cards.

[0]: https://bugzilla.kernel.org/show_bug.cgi?id=215001

Best regards,
Javier

Changes in v2:
- Make the change only for x86 (Geert Uytterhoeven)
- Only check the suppported video mode for x86 (Geert Uytterhoeven).

Javier Martinez Canillas (2):
  video: vga16fb: Fix logic that checks for the display standard
  video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

 drivers/video/fbdev/vga16fb.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.33.1

