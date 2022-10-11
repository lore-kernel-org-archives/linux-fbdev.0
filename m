Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734B9C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 11 Oct 2022 14:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJKONM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 11 Oct 2022 10:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJKONJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 11 Oct 2022 10:13:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84535925D
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Oct 2022 07:13:07 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MmyNn3SVFz1CF0j;
        Tue, 11 Oct 2022 22:10:33 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 22:13:04 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 22:13:03 +0800
Message-ID: <363cdfe4-f54d-0ce4-2f03-bcfe998deeef@huawei.com>
Date:   Tue, 11 Oct 2022 22:13:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
Subject: Question about patch "fbdev: smscufx: Fix use-after-free in
 ufx_ops_open()"
To:     Hyunwoo Kim <imv4bel@gmail.com>
CC:     <steve.glendinning@shawell.net>, <deller@gmx.de>,
        <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <imv4bel@gmail.com>, "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>,
        <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Hyunwoo:

[patch "fbdev: smscufx: Fix use-after-free in 
ufx_ops_open()"](https://lore.kernel.org/all/20220925133243.GA383897@ubuntu/T/) 
fix [CVE-2022-41849](https://nvd.nist.gov/vuln/detail/CVE-2022-41849).

If the UAF scenarios is as follows, it seems that [fix path 
v3](https://lore.kernel.org/all/20220925133243.GA383897@ubuntu/T/) will 
not avoid race contidion of krefs:

```
           cpu0                       |        cpu1
-------------------------------------|---------------------------------------------------
  1. open()                           |
     ufx_ops_open()                   |
-------------------------------------|---------------------------------------------------
                                      | 2. ufx_usb_disconnect()
                                      |    dev->virtualized = true;
                                      |    atomic_set()
                                      |    usb_set_intfdata()
                                      |
                                      | 3. if (dev->fb_count == 0)
                                      |    schedule_delayed_work()
                                      |    kref_put()   <- kref count : 1
                                      |    kref_put()   <- kref count : 0
                                      |    ufx_free()
                                      |    kfree(dev);
-------------------------------------|---------------------------------------------------
  4. if (dev->virtualized) <==== UAF  |
```

Did I misunderstand the UAF scenarios ?
