Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C332C4708F
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Jun 2021 02:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C1F61027
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Jun 2021 02:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhFBCTR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Jun 2021 22:19:17 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3378 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhFBCTO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Jun 2021 22:19:14 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fvsyb0xLrz66rD;
        Wed,  2 Jun 2021 10:13:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 10:17:27 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 10:17:26 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] video: fbdev: w100fb: use DEVICE_ATTR_WO macro
Date:   Wed, 2 Jun 2021 10:17:16 +0800
Message-ID: <20210602021716.10640-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use DEVICE_ATTR_WO macro helper instead of plain DEVICE_ATTR, which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/video/fbdev/w100fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index d96ab28f8ce4ae5..64a5e048c13f76a 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -108,7 +108,7 @@ static ssize_t flip_store(struct device *dev, struct device_attribute *attr, con
 
 static DEVICE_ATTR_RW(flip);
 
-static ssize_t w100fb_reg_read(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t reg_read_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long regs, param;
 	regs = simple_strtoul(buf, NULL, 16);
@@ -117,9 +117,9 @@ static ssize_t w100fb_reg_read(struct device *dev, struct device_attribute *attr
 	return count;
 }
 
-static DEVICE_ATTR(reg_read, 0200, NULL, w100fb_reg_read);
+static DEVICE_ATTR_WO(reg_read);
 
-static ssize_t w100fb_reg_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t reg_write_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long regs, param;
 	sscanf(buf, "%lx %lx", &regs, &param);
@@ -132,7 +132,7 @@ static ssize_t w100fb_reg_write(struct device *dev, struct device_attribute *att
 	return count;
 }
 
-static DEVICE_ATTR(reg_write, 0200, NULL, w100fb_reg_write);
+static DEVICE_ATTR_WO(reg_write);
 
 
 static ssize_t fastpllclk_show(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.26.0.106.g9fadedd


