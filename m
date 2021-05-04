Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBD5C433B4
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 May 2021 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BEB613B3
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 May 2021 14:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEDOaJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 May 2021 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhEDOaJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 May 2021 10:30:09 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B8C061574;
        Tue,  4 May 2021 07:29:14 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so7709930oth.5;
        Tue, 04 May 2021 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKIZAu6/2NdM8fHlgkE+KZQqouzZp51NLAhVcolSIcE=;
        b=ShojezARwH1uaeTtN3VENf1RsdHgYRRDzCLnqNZoJ5xANav8dLHe59dCObS3LW7oVR
         sss3ADBtYFRFC3LdfJbp7TvbT2kYTTCJE2J48jPFCRanYOjsD3kogYxwaQfpfs99pRgF
         HMK303LDXhBkXFZ32L9X2ehbfl1UWWsAuZ8P/nUUj+240fGg1DO0x6GK15dq/riwNYeb
         aafpBSYS6aQy2TrZ/HhhvsbaW0xO2iVGk1a7cvQqrEXfxVPdaaFAV7wKKfHusrCw0zaq
         lNdzMNQADc/pwkfis9vVIuyFNLjL01BesNpG6FOxQGBvywFqcfV2Y2b2o9bOE0Y05d5J
         Nv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eKIZAu6/2NdM8fHlgkE+KZQqouzZp51NLAhVcolSIcE=;
        b=rNRxZsUyBq3uTfAiKitzkHBmpMywkulBU6G0VdCpqO3BLyMKKCHMDnpHkTlsCA9VcO
         3Fkf/vcWVJHtLctwQdcWg71bPiZhqNhpgR2bJDY/RloZXM6bWgKKlPXkXDblwOrBmUNO
         saJ5XmxvAAvsG6edWrbigHApFnZDcbaTHBOmIF7A1zNzyjRbovluCLdVnHWNOo4eHBJM
         Q+Vwq2rufRbfnqa2N5eev0qITQU0sx7burUzKaBlAg+h4ONlnEO5tyg3L3E3XeRhb+mW
         gQI0j+DbdL03ns1VUk+Vt5xcq2Roy8OqKmux3nRouECo6HTXI563uDujoXL8SF3h953z
         stOA==
X-Gm-Message-State: AOAM532TspFpAcio7AEZ1jTyPXkCl+36NCIYmml5SQvS+le1oIBOiP7A
        vFhI+uW48oyeaqpFDbvUWPA=
X-Google-Smtp-Source: ABdhPJwixsPL4gUes21e2Ym9ZiEjlDDpj7aBAgzY2n98I2gq+SjsQaNx1v6L61j1SitQH65pU7hlXQ==
X-Received: by 2002:a05:6830:1f27:: with SMTP id e7mr19351128oth.341.1620138553582;
        Tue, 04 May 2021 07:29:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15sm660543oid.39.2021.05.04.07.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:29:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] fbmem: Mark proc_fb_seq_ops as __maybe_unused
Date:   Tue,  4 May 2021 07:29:10 -0700
Message-Id: <20210504142910.2084722-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

With CONFIG_PROC_FS=n and -Werror, 0-day reports:

drivers/video/fbdev/core/fbmem.c:736:36: error:
	'proc_fb_seq_ops' defined but not used

Mark it as __maybe_unused.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 372b52a2befa..52c606c0f8a2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -733,7 +733,7 @@ static int fb_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static const struct seq_operations proc_fb_seq_ops = {
+static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
 	.start	= fb_seq_start,
 	.next	= fb_seq_next,
 	.stop	= fb_seq_stop,
-- 
2.25.1

