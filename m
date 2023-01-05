Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A27C3DA7A
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Jan 2023 19:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjAET0a (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Jan 2023 14:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjAETZx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 Jan 2023 14:25:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB3A473
        for <linux-fbdev@vger.kernel.org>; Thu,  5 Jan 2023 11:21:38 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y5so1030059pfe.2
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Jan 2023 11:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=97sxfhjaB8PxBR7URrYCExoGnpeZKnrOyMFs+deDqoA=;
        b=IFFFns4mTLHYiYPOdpH3k/Z6BfSYt1T8o7KcJMEOb7uldcq+iWk0U8tofOlIyAkpKx
         Zm2YjpnCHTIqDwutAyZ/t+YGUhFLuddGsBcIAIPJyosjV4qRzQJLBfboku0pRLxE3rwg
         E92VlWkAp8E1qj7r+WM0hJV4a+/SrUMEFxVSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97sxfhjaB8PxBR7URrYCExoGnpeZKnrOyMFs+deDqoA=;
        b=usHgGLs1Ivfo76kYmQkjZGTznhG90s1BG7w9HF7ScRTRR+oWd44fYugbZOPaJfUscE
         6ozEv6UcFc1/Rau/UiMvoUXhOzK0OkxNR+qTf7s6VGg/1SYiOI4d2CEBnjHzNAk7sERC
         xR0uU+Cs6bgwF8bH8ocaSykKeAtcQs/Qzne5j1sxWi87bIk5mdzltWo0pAJJBejvtMg2
         1BIFpXNfNavivrb8LRU8JCUxg8uFmnYjJZEoWrdBZ9JaMqTsB7tr4HhVF2Oy4fWQBbio
         oKVW/q+gKExp2dmWdvCqZV8FgSHCmgHX7Z/R5oYB8e1mjekckdW4oMumB7DeoRALVykr
         QcFg==
X-Gm-Message-State: AFqh2kpP3N38PR8KtxvO/MsVB40RVALDupKVP1GN3XcY7Fnw9mrtY53g
        xcrTa7Mp///BNVwowO6VDGX1Ig==
X-Google-Smtp-Source: AMrXdXtusMz0bppoL5uIlyajN4gT+TrhL1MIdwcwHem6NamVhADBBImbslU9eAUU89LaXsDyEkiXYA==
X-Received: by 2002:a62:4e8e:0:b0:583:3d70:3661 with SMTP id c136-20020a624e8e000000b005833d703661mr473651pfb.9.1672946440663;
        Thu, 05 Jan 2023 11:20:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h11-20020aa79f4b000000b00582bdaab584sm5868470pfr.81.2023.01.05.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 11:20:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] fbdev: Replace 0-length array with flexible array
Date:   Thu,  5 Jan 2023 11:20:38 -0800
Message-Id: <20230105192034.never.249-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; h=from:subject:message-id; bh=eBudshCogBtu2xin7cq/2EcDLuR1Ha1dnf+jDA9WM7A=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjtyMFUMFrIl5nzBw/rrohurWWx677rm+9jnFO2OEH EHsCmCCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7cjBQAKCRCJcvTf3G3AJh39D/ 9JXSePQkOSG9y/c/7C77a7sNLOH6tRaBYFyxy0DqaiEqTL/wMEaWTJIe/TCr3eh5BcFRGkvE9aIydJ k0rjqKkxDAuT1SXy1IBz60cx2VutSvE62Wg6uN3jeM3wPgOHq+ccnA71nY8P8nAsDE0iC/5YR4s0tO e1YWFmLBF8TiWofavtjiQzRN5JArRGAdoSseCu9rM4Agl2OI1Z99fhdxq3LrYJXFVDdZLIlMW8n1DO egCycrggYzOaG114EndKmY7TBCBUfZkAxDU0O/t/YRLEBYqVlpZTGugD+LL0Odn8sgVNk5qwzCabkA A6v2Azd+H1iC5u5tFAoJD01fRv6ehdA4UZP+Alp0cSfooDCbJ8gHvwkVaktKC6pwKotnrI9de/3zpO 46+EcziPobYfUE/n+MG406Cr5/DbX8EH9RPVHvhxCN4tY5nHwpnIrHnelwe0RJOypvREb+N9DWq3hk QV+e8YP2rpKcIn25nevZZYExlnnxRWg+81Eo2n4xhAAtGY0ixR7hSYBOTp3jD1BuSfucmRBNiCuXRL qAMcw3Ygfp9kKDBDxcXrVBF21hRPN0cv45Odmb5Ee2GoQKhWYwpTAqHsctn4r3fhnQU7DNTWYzTjXp EU6fBQVzpe+v4o+gD7iVUj1EdwkxfMj9MlKVTgdtSKn+PDYo58UfpL2zyUyw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct aperture's "ranges"
0-length array with a flexible array. (How is the size of this array
verified?) Detected with GCC 13, using -fstrict-flex-arrays=3:

samples/vfio-mdev/mdpy-fb.c: In function 'mdpy_fb_probe':
samples/vfio-mdev/mdpy-fb.c:169:32: warning: array subscript 0 is outside array bounds of 'struct aperture[0]' [-Warray-bounds=]
  169 |         info->apertures->ranges[0].base = info->fix.smem_start;
      |         ~~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from samples/vfio-mdev/mdpy-fb.c:21:
include/linux/fb.h:510:19: note: while referencing 'ranges'
  510 |                 } ranges[0];
      |                   ^~~~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Helge Deller <deller@gmx.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 96b96323e9cb..bf59d6a3590f 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -507,7 +507,7 @@ struct fb_info {
 		struct aperture {
 			resource_size_t base;
 			resource_size_t size;
-		} ranges[0];
+		} ranges[];
 	} *apertures;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
-- 
2.34.1

