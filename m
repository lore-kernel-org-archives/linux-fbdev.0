Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FBC433E0
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Mar 2021 13:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CDD6187E
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Mar 2021 13:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhCVNEQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhCVNC0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 22 Mar 2021 09:02:26 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956DAC061756;
        Mon, 22 Mar 2021 06:02:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c3so10359024qkc.5;
        Mon, 22 Mar 2021 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMH4QAnKMYAm7SV5kDPsGP+GUy0GDEG+vPXEkoZ0Tc8=;
        b=UiWo5DT0T6s2hIq4vT2rvCAkJOPIUgQVjcBgQe58BOP9zL6pUJF0ZKVaJ0GiW97qeK
         hqMjKxAti3LtuoC30QcGslmlNw/9tJoC/hcDjIR/2ECJbIqxUg/uS9G222r1CulMkv4s
         DHo/nJ4n1Y9Ee+RyyzxSahr+v5eV9Cuz/wSO7zizBtqEkPs7TtCXpv7UtRSjLD6Dz3Hv
         fSRIePlXgSFxGJjzIJMfDS5JJOyiFhLBS5DwDsUO8yEQrTR3iR2icQVJRcNu4hORRvzd
         45JQDRKjfEigGkKFr/peQNu3GmT7zVCA9qUComZupiOCC8chBYFGwVwQCgr6RG+VqSal
         MmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMH4QAnKMYAm7SV5kDPsGP+GUy0GDEG+vPXEkoZ0Tc8=;
        b=jWbMLzYnKP941AAzjhAZEOEPyj1XmQ1ZHwBuz40cNAPziKIacgRMkF+vkFbzugyn0R
         88yOclxkQwJa5lyk/PLWKwi5gRpkb8uauuk8dFI34wxzEBgPrW2oaAAzWob+KDyjHEYi
         tRKg/IC9hd62MNhpQI2JKqjfInwn3njb8hkcKKzcOVk4ZnZBiKjQgVmYRG38McdWcblR
         7dLsnnNegZPyXLTqcQi5eRn8LXmbsoNLcKzQ+kNcBdgzIUYvKrX6tQWKrqyLetYOPa54
         CgB4wJtB0jLEkDLTZIJJiSTnmYMVL51IoXYX2Q47rUalXSIQrfFhL3rYQoM8SMTHlMSX
         E+tQ==
X-Gm-Message-State: AOAM533PX2GFpURyqTG/DWz9swqyjqFXjOeJ2VKHLCG4oqAItVzjmXNQ
        GVT5YDqwZmFTu0yraYoJ4Ck=
X-Google-Smtp-Source: ABdhPJx+9Viv9Em+PGreRyAyt7xaYv9wDXL//i4JvTFnQZYD+AXa6lRIzDFP80ZnSLA7VZ3tVkmr1w==
X-Received: by 2002:a37:a9cf:: with SMTP id s198mr10303355qke.143.1616418144881;
        Mon, 22 Mar 2021 06:02:24 -0700 (PDT)
Received: from localhost.localdomain ([143.244.44.200])
        by smtp.gmail.com with ESMTPSA id z89sm8963497qtd.5.2021.03.22.06.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 06:02:22 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] video: mmp: Few typo fixes
Date:   Mon, 22 Mar 2021 18:32:10 +0530
Message-Id: <20210322130210.3641181-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


s/configed/configured/
s/registed/registered/
s/defintions/definitions/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/video/mmp_disp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
index 77252cb46361..ea8b4331b7a1 100644
--- a/include/video/mmp_disp.h
+++ b/include/video/mmp_disp.h
@@ -172,7 +172,7 @@ struct mmp_panel {
 	/* use node to register to list */
 	struct list_head node;
 	const char *name;
-	/* path name used to connect to proper path configed */
+	/* path name used to connect to proper path configured */
 	const char *plat_path_name;
 	struct device *dev;
 	int panel_type;
@@ -291,7 +291,7 @@ static inline int mmp_overlay_set_addr(struct mmp_overlay *overlay,
  * it defined a common interface that plat driver need to implement
  */
 struct mmp_path_info {
-	/* driver data, set when registed*/
+	/* driver data, set when registered*/
 	const char *name;
 	struct device *dev;
 	int id;
@@ -309,7 +309,7 @@ extern void mmp_unregister_path(struct mmp_path *path);
 extern void mmp_register_panel(struct mmp_panel *panel);
 extern void mmp_unregister_panel(struct mmp_panel *panel);

-/* defintions for platform data */
+/* definitions for platform data */
 /* interface for buffer driver */
 struct mmp_buffer_driver_mach_info {
 	const char	*name;
--
2.31.0

