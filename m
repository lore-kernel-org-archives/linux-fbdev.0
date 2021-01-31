Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD2C433DB
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 19:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC40364E25
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 19:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhAaTrY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 14:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhAaTgN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:36:13 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C192C061353;
        Sun, 31 Jan 2021 09:32:59 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id e19so9999246pfh.6;
        Sun, 31 Jan 2021 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKI25e/jJLfDV6Kg+PuHK7AdOezrhXeGKxAKRdL5O5c=;
        b=NZcWTveJhv5rbkJbLgSmHjwf6GQe9APQLUr0ywzyJM8YOZdKLDVjpOlWiqUVM3EYNh
         kVuCCm5wXBU2CzBpOGGvpr1BpC2rqWrQeI06JQ+SETI199L8+FYBQKp89qv5dG75eYTW
         KWNOwfxDvOcvULC3hmRatn9Q4lf1Cq3pLf8Qx4umAZfUd4mAYHqrmX4Go7rUJOSRRkJY
         AsFOhMO81LuYJHC3r4erHnmawkginx2aVB88AKq463Zgz7HOHICH1Nj2Ej16T3V73iQ7
         2EiZ8RG+u8M76R39DPXF34+0sdMtwNcnubNW+xTw/tY6N2wafaytjUKh5roXYOGeEtUq
         rINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKI25e/jJLfDV6Kg+PuHK7AdOezrhXeGKxAKRdL5O5c=;
        b=tt1iT9orJLG3nCuFds1StDkvkG7joNJC81YQB51fg0hfMTjyy7LiKVs1s5jju/rWaP
         +XFCDu9y1LRwn2aWSRiyGdmHCBYDYwbUrj9JNnPIUcJYmuPB55Pb5rY281Ge5qWH8gyn
         cKyz9w9g7Rh7KmsnuNwZyF5upk79KlaxIKO5wZOKaE5XPDLEsAAi4oxe66pTmJRt7A6d
         wUQkgsHT/0FFUoXrJM9oEGzhbGW3ZYFRAHTvdzuheYd8T66jkSDJ78H3e3+JJJj+1OpW
         S7nCfIZ6wFoU8frb1xfhHvac86nmPLupBRuu5IIfeT6RSyCSRFFVIm4gTevJP+Pw/DfG
         dyxQ==
X-Gm-Message-State: AOAM532zyWTNhl2jKTt38Q3wqXnVPaaDfKFBp4W98gOd+cQ3aAo/jLmQ
        AOm+boO60LE2yN0oZ07AB/M=
X-Google-Smtp-Source: ABdhPJxJdjPPIgHhUA+gd6c590Us77Rv3SAo0M63OGyZ3eELnR08dADDz7f1OMchhqa7A2U6TYf6aw==
X-Received: by 2002:a62:7b8a:0:b029:1bb:4a06:bb57 with SMTP id w132-20020a627b8a0000b02901bb4a06bb57mr12418121pfc.47.1612114378549;
        Sun, 31 Jan 2021 09:32:58 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id a141sm15124191pfa.189.2021.01.31.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:32:58 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Cohen <wcohen@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 11/13] staging: rtl8712: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:32 +0530
Message-Id: <20210131172838.146706-12-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131172838.146706-1-memxor@gmail.com>
References: <20210131172838.146706-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

strlcpy is marked as deprecated in Documentation/process/deprecated.rst,
and there is no functional difference when the caller expects truncation
(when not checking the return value). strscpy is relatively better as it
also avoids scanning the whole source string.

This silences the related checkpatch warnings from:
5dbdb2d87c29 ("checkpatch: prefer strscpy to strlcpy")

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index cbaa7a489..81de5a9e6 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -1784,7 +1784,7 @@ static int r871x_wx_set_enc_ext(struct net_device *dev,
 		return -ENOMEM;
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
 	eth_broadcast_addr(param->sta_addr);
-	strlcpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
+	strscpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
 	if (pext->ext_flags & IW_ENCODE_EXT_GROUP_KEY)
 		param->u.crypt.set_tx = 0;
 	if (pext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)
-- 
2.29.2

