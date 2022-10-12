Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1F0C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 12 Oct 2022 19:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJLTS7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJLTS6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 12 Oct 2022 15:18:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1FD8EFE
        for <linux-fbdev@vger.kernel.org>; Wed, 12 Oct 2022 12:18:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b2so17123304plc.7
        for <linux-fbdev@vger.kernel.org>; Wed, 12 Oct 2022 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfNZT46KpoZ6E+JcaCCJsllBrcf6mEq3qk/ybdRTrq0=;
        b=X+DPYNJrssrHWrE1RZGFFcJAHcL8f3jkXOrZa2E/MM2M/to/lV2QrCFKS8bI7qt/0E
         8/koq5Qr1X9hUTAPwaYWMWYd+CohHeCQZwo03o04Zwg3JXYnYwu93IAJaJCZbF767eTe
         6z3UH6dskbodOaDb67ec4ZtUKpL9WlqzWt0Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfNZT46KpoZ6E+JcaCCJsllBrcf6mEq3qk/ybdRTrq0=;
        b=xCpdywI3AQWiNWRj9RIkWoNl7xIAE9NBxVKd3Df3tXBs3lvHBJjB5f6yOg0d1Ovoj8
         EAGRjYeq8APDRKe+WpJB/nELPrF4TZlgfv06lwoEJvNDM7NGZ3GJOWj1MPI3MYBAPvXz
         ssNlkrd5l8AknKJka1mwKiQtgmX1a5vAjVOyN3HSMkCWmYlxMpo8Qzr0U1ysIknR4uUz
         yisGTZDkLT1mi3/TOQHeADVZuCm84pn0B2OQTBSF3DKIVqW2fqOzT+cELZ1yosd6oIlu
         0JvqLBTpEta+9RaHnMBJ665GFkejeuzko8lmRT7xV6XXjiGuysHz8d0ijZvb1Ur+qdib
         oatA==
X-Gm-Message-State: ACrzQf2mv4uP1WUPum+YvTBkQjCtgHV7V7gCjaxoGcL2Eggg0IyL9igA
        hmfZkigtJFgxUfm/BXn/RC8hog==
X-Google-Smtp-Source: AMsMyM6/xIjOix8KD97FHd4GE6/wahQp6RRj0q3RGJzOPf50xMJPV0jcuY79BaTZXUVDboidomw0Gg==
X-Received: by 2002:a17:90b:4c48:b0:20d:5c55:b8a8 with SMTP id np8-20020a17090b4c4800b0020d5c55b8a8mr6894465pjb.207.1665602337108;
        Wed, 12 Oct 2022 12:18:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z19-20020aa79593000000b0056316f0b7f8sm250273pfj.33.2022.10.12.12.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:18:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] fbdev: MIPS supports iomem addresses
Date:   Wed, 12 Oct 2022 12:18:54 -0700
Message-Id: <20221012191838.never.778-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; h=from:subject:message-id; bh=RSExtY7BNwRYriF1xMHXemT9zuCYbQ4xQoSpDfr8rVo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjRxMeloP/ixxePXeqRevP8QT9EZXyWJkUAg4g2qmM AE/qZjCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0cTHgAKCRCJcvTf3G3AJmN4D/ 4hcVz71SZPswjgclHLavAl1hUb1O3LJ1wli7G8k2lX2OMCcN80qc088g6rbhMQOA1Ig6UWiLFJz6ZP 3mDl2lt1VDZ1nOdA6412wHxsH8eVGKhtT/KFln4bCbGPDfEIAh5Uh2ih9uDdJ+yUCHJZlMi0EueYsy ous3OfunCbRYnOJRm8VCCJYW8ow04uaO3Eiryj74ccpNGl8OZ0aZvnMSs0qCJpH7PLhmhKIDsnMDwJ Chvht0XOjXBshmliHA8U/1Zta3yXsufhHO1wtSKL7Orkkv9UZDsrnIoCRAKkZYctL8pov/Po7zES2Q rlBCf+Y094+ABm9epnmtuYCQMOOqFvNaGyzLzkqmqqVlS9sA2qQrWlZ95AlRLrPFfmlJ/rU0B6US4o 1d/nwuLYg7vLtnV5sZnuTBH2Ur+tH7b2HK5QHDsPrNlE4uHPB6XwtwcT+xst9sFKEDHFzNWvRdut/9 JEWP+4LDD5z38jIjzDkeq5Ujv7KmYbu5be4pUNsVW+jBQj9eSBxV5gktwCh9sMylU87Qgw6CrgUpZb bdgcoaPV8cTPL8br9Yt+eA+hm39dRSR+wcMRAJWI++zPLUXXZpwoGxlBNOhNqbudpn+QxRwgTChyFK G2AW+Sk5wgsR2sjAZYcVFlkbg1esbL1G8/zRrAd2wjAmeI1/6aRSWjAUPKmw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add MIPS to fb_* helpers list for iomem addresses. This silences Sparse
warnings about lacking __iomem address space casts:

drivers/video/fbdev/pvr2fb.c:800:9: sparse: sparse: incorrect type in argument 1 (different address spaces)
drivers/video/fbdev/pvr2fb.c:800:9: sparse:     expected void const *
drivers/video/fbdev/pvr2fb.c:800:9: sparse:     got char [noderef] __iomem *screen_base

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202210100209.tR2Iqbqk-lkp@intel.com/
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 07fcd0e56682..3822734a38c7 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -555,7 +555,7 @@ static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
 
 #elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) ||	\
 	defined(__hppa__) || defined(__sh__) || defined(__powerpc__) ||	\
-	defined(__arm__) || defined(__aarch64__)
+	defined(__arm__) || defined(__aarch64__) || defined(__mips__)
 
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
-- 
2.34.1

