Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C9BC00140
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Aug 2022 02:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbiHACoL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jul 2022 22:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbiHACoK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jul 2022 22:44:10 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3770613D09;
        Sun, 31 Jul 2022 19:44:09 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lx2V371dpz9t05;
        Mon,  1 Aug 2022 10:42:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 10:44:01 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 10:44:00 +0800
Subject: Re: [PATCH -next] video: fbdev: imxfb: fix return value check in
 imxfb_probe()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <deller@gmx.de>
References: <20220729024134.159942-1-yangyingliang@huawei.com>
 <20220730231815.dzuscf2x2sgj66bg@pengutronix.de>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <b1487b74-cbc1-013b-f734-c78319d76894@huawei.com>
Date:   Mon, 1 Aug 2022 10:43:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220730231815.dzuscf2x2sgj66bg@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 2022/7/31 7:18, Uwe Kleine-König wrote:
> Hello,
>
> On Fri, Jul 29, 2022 at 10:41:34AM +0800, Yang Yingliang wrote:
>> If devm_ioremap_resource() fails, it never return NULL, replace
>> NULL test with IS_ERR().
> Oh, thanks for cleanup up behind me. Did you find this using some static
> analysis tool? I would consider it interesting and fair to mention this
> in the commit log.
I found it by coccicheck like this:

@@
expression ret, E;
@@
ret = \(devm_ioremap_resource\)(...);
... when != ret = E
     when != IS_ERR(ret)
(
  ret == NULL || IS_ERR(ret)
|
  IS_ERR(ret) || ret == NULL
|
  ret != NULL && !IS_ERR(ret)
|
  !IS_ERR(ret) && ret != NULL
|
- ret == NULL
+ IS_ERR(ret)
|
- ret != NULL
+ !IS_ERR(ret)
)

Thanks,
Yang
>
> Best regards
> Uwe
>
>
