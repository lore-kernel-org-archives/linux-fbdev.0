Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D0C433B4
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 08:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6724960249
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 08:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhEQI4B (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 17 May 2021 04:56:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8288 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232924AbhEQI4B (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 17 May 2021 04:56:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14H8kmTj029677;
        Mon, 17 May 2021 08:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=qtW+izEwvN1JhotR/PnIKHwhYFppy04AO6qnSiOTI8A=;
 b=0TsTl3ncEuHq6w+1r3Uam2RTUbUnTKDdUkQHBpxNjyL/kbsWGs/gEOlKVrunmTnH0ijs
 /slMTq9mLx2e9KKTBAfPu76qwjE3SOJcBHfrC8+buYHzoPuacUu3EIXFWSalKuQ2F/ti
 8d2KAlj1ep2L7Go5PEtId3EtECFVOMtU1nSg9GjW6CgFd6nmG3GZa488rh3yIJxBz9BI
 voaLV/M2ABM/s9w04z9O82cVsnkzxwgVDse64ndC5Nmb9e+e/Q76tbMOJTu9X9vxu52e
 rybF52hMOlkNDjfTOUTJBxbn1ZLcJ8DIvPQpbJLmNgSQUPYTF3Z7FEV826l8V7y+glqN yw== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kffu03su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 08:50:42 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14H8oflI146696;
        Mon, 17 May 2021 08:50:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38j644t24w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 08:50:41 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14H8ofHE146618;
        Mon, 17 May 2021 08:50:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38j644t23t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 08:50:41 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14H8odxC015762;
        Mon, 17 May 2021 08:50:40 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 May 2021 01:50:38 -0700
Date:   Mon, 17 May 2021 11:50:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvidia@lists.surfsouth.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] hgafb: fix probe function
Message-ID: <YKIuWEcIJvTIuE2j@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: zp_B0iEjk4-JQRkm1u9iH0RnRXT6DhA-
X-Proofpoint-GUID: zp_B0iEjk4-JQRkm1u9iH0RnRXT6DhA-
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

There is a reversed if statement in this probe function so the driver is
completely broken.

Fixes: dc13cac4862c ("video: hgafb: fix potential NULL pointer dereference")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/video/fbdev/hgafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index cc8e62ae93f6..bd3d07aa4f0e 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -558,7 +558,7 @@ static int hgafb_probe(struct platform_device *pdev)
 	int ret;
 
 	ret = hga_card_detect();
-	if (!ret)
+	if (ret)
 		return ret;
 
 	printk(KERN_INFO "hgafb: %s with %ldK of memory detected.\n",
-- 
2.30.2

