Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20384C43461
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4AD613CD
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbhDGGhX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348928AbhDGGhR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:37:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C2C06174A;
        Tue,  6 Apr 2021 23:37:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x26so5447482pfn.0;
        Tue, 06 Apr 2021 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wteGrNjTPUFB2ScDRoKVavC5gzuo9SnMMiAPfPlNCw=;
        b=IEn9J76Lrugc/nUlPH9NZtZ75aywRi+kX3Z/6TeK3ZWmibspXs2M1eoU+9sqvzHuNk
         qWN1keMnWiY2Fm47qlCozmZvdxu+uDJ2bAm2JiiWl6JAiOi4Qi7QzeiHrqucDiWKr9N8
         CXhtRgNZXTv+RzqAV4mrzFi1qf0xLZF08e9l+v2X3zW/ZGQyMeHyx6jxxDEssosnMGdh
         HB8EGRQf2sYxPlgTTR85hYX1K/U/OjMyWWk76OF/C5uGrV/OWE9pvEJIMHqyO30Dq0Y6
         S16zyrPXvCmrp002Co2RleisWdkIdkq3wmq5nR4kLsKIeTMeLWtGMSdu1oDgXDMj4Ong
         RwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5wteGrNjTPUFB2ScDRoKVavC5gzuo9SnMMiAPfPlNCw=;
        b=WDaqTElxJOqubkZ8piYt4JS/q0dKvB7QiXlCvHQojbZKvI7MsFhucmnP1ms3X6QTmW
         dTEdNZ9Ywch9owa8/Eiwx88jUdWFCUtnf/onmlBNRAe599y55vyXZp5vzUE/tQitvzk+
         4eR5EYnwq4mhDgb7B97b6JiV0Ww94+aPV78+iUAh3i1Gi+8eLvALvXBXOkQ7ZsnIQw2W
         jUB94vDXNRf/6PtLfEPP3pEb0KbWIIG2Q0xklNc9rDVj2nzp+BZDbQ5Ac3tgwI+bdwBo
         ZlzBhM8NmlBvSx8YGvIbCVPKRqrwyj/CjMwdPlh3Mzp/O8ALNEGK5bK/fkPTcX2kh1FF
         nsvQ==
X-Gm-Message-State: AOAM533/RtBNvHt1jJIYtr7FBgEDL0JowBQRu9CN8HinjSVH9Ll1RGcN
        tm8R84CVXBWPKN+Z+IFsV5w=
X-Google-Smtp-Source: ABdhPJxnL2AlOFOVq2buT/wYmiXorBFb4z+UVn2KSZphdDcp2PVtoou+pHQjsExZXemZ91dpLqPvYw==
X-Received: by 2002:a62:1c93:0:b029:1fd:2216:fb45 with SMTP id c141-20020a621c930000b02901fd2216fb45mr1476120pfc.13.1617777427417;
        Tue, 06 Apr 2021 23:37:07 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id b84sm20998653pfb.162.2021.04.06.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:37:07 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:37:05 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/49] staging: sm750fb: Rename vendorID local variable to
 snake case
Message-ID: <c48ef3dbe6d2bc6b9b059b6178f73b07b8239ac4.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for the local
variable vendorID in the function sii164_get_vendor_id.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index af14273b99eb..14d7083775b4 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -37,14 +37,14 @@ static char *gDviCtrlChipName = "Silicon Image SiI 164";
  */
 unsigned short sii164_get_vendor_id(void)
 {
-	unsigned short vendorID;
+	unsigned short vendor_id;
 
-	vendorID = ((unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
+	vendor_id = ((unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					       SII164_VENDOR_ID_HIGH) << 8) |
 		   (unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					      SII164_VENDOR_ID_LOW);
 
-	return vendorID;
+	return vendor_id;
 }
 
 /*
-- 
2.30.2

