Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D00EC43219
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Nov 2022 07:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiKOHJl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Nov 2022 02:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiKOHJi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Nov 2022 02:09:38 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B1212AE8
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Nov 2022 23:09:36 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NBHJj2hPVzJnlf;
        Tue, 15 Nov 2022 15:05:57 +0800 (CST)
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 15:09:04 +0800
Message-ID: <244a4384-91e3-ecff-5957-94df26921cda@huawei.com>
Date:   Tue, 15 Nov 2022 15:09:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH -next] fbdev: via: Fix section mismatch warning in
 via_core_init()
To:     Helge Deller <deller@gmx.de>, <FlorianSchandinat@gmx.de>,
        <corbet@lwn.net>, <sfr@canb.auug.org.au>,
        <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20221115025306.2602-1-shangxiaojing@huawei.com>
 <156a9800-b40a-8e83-86d2-27f9e2e67523@gmx.de>
 <1e9e04d2-29b4-6e37-fa5f-f0f4b767171b@huawei.com>
 <2d79ad8e-45b7-d095-8f26-4f2e8aba66f7@gmx.de>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <2d79ad8e-45b7-d095-8f26-4f2e8aba66f7@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org



On 2022/11/15 15:05, Helge Deller wrote:
> On 11/15/22 07:52, shangxiaojing wrote:
>>
>>
>> On 2022/11/15 13:14, Helge Deller wrote:
>>> On 11/15/22 03:53, Shang XiaoJing wrote:
>>>> Due to viafb_exit() with "__exit" tag, it should not be called by the
>>>> __init function via_core_init().
>>>
>>> I wonder if you can't instead of this and your previous patch 
>>> (ab885d8c7e15)
>>> turn the i2c and gpio drivers to proper platform drivers, e.g.
>>> adding to bottom of via/via_i2c.c:
>>> module_platform_driver(&via_i2c_driver)
>>> instead of viafb_i2c_init() and viafb_i2c_exit().
>>>
>>> Shouldn't they then automatically be loaded/unloaded?
>>>
>>
>> I'm sorry that I have no idea how to change an i2c driver to a 
>> platform driver.
>>
>> As for module_platform_driver(), I have checked and it looks like just 
>> a helper macro to definite XXX_init() and XXX_exit() instead of 
>> automatically load/unload the driver.
> 
> module_platform_driver() uses module_driver() which adds module_init() 
> which then
> adds code to call the generated xxx_init() functions at startup and exit.
> 
>> Besides, the XXX_init() and XXX_exit() definited by the
>> module_platform_driver() can only call
>> platform_driver_register()/platform_driver_unregister(), perhaps not
>> suitable for via_driver? (or just need to call
>> platform_driver_register() after change to platform driver)
> 
> platform_driver_register() will be called by the newly generated 
> XXX_init().
> 
> Do you have such a viafb card and can try?
> 

I'm sorry that I run the test on qemu, and have no viafb card.

Thanks,
-- 
Shang XiaoJing
