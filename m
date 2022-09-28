Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27A6C32771
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Sep 2022 09:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiI1J0V (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Sep 2022 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiI1J0E (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Sep 2022 05:26:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145F2ED5D
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Sep 2022 02:26:03 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mcrdr1GbWzHqLK;
        Wed, 28 Sep 2022 17:23:44 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 17:26:01 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 17:26:00 +0800
Subject: Re: [PATCH -next v3] backlight: gpio_backlight: Switch to use
 dev_err_probe() helper
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <jingoohan1@gmail.com>, <yangyingliang@huawei.com>
References: <20220927033138.1945842-1-yangyingliang@huawei.com>
 <YzLW6zo/7k031jzi@maple.lan> <YzQPqjinYYAZdcR+@google.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <982139ba-2bc4-8865-f50d-4eaf78ed8bef@huawei.com>
Date:   Wed, 28 Sep 2022 17:25:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YzQPqjinYYAZdcR+@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 2022/9/28 17:11, Lee Jones wrote:
> On Tue, 27 Sep 2022, Daniel Thompson wrote:
>
>> On Tue, Sep 27, 2022 at 11:31:38AM +0800, Yang Yingliang wrote:
>>> In the probe path, dev_err() can be replaced with dev_err_probe()
>>> which will check if error code is -EPROBE_DEFER and prints the
>>> error name. It also sets the defer probe reason which can be
>>> checked later through debugfs. It's more simple in error path.
>>>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> The original patch is not in my inbox.
>
> Was I missed from the original mail?
I have already add your mail address to my Cc list, when sending the patch.

Here is the early mail:
V1:
https://lore.kernel.org/linux-fbdev/f98b2e35-0f86-ffd0-db11-ca91930e153f@huawei.com/T/#t

V2:
https://lore.kernel.org/linux-fbdev/7d8cfce2-ba08-afc0-de2d-972ee15b5865@huawei.com/T/#t

Thanks,
Yang
