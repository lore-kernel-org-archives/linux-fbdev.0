Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C761EC001DF
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Aug 2023 09:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjHCJOU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Aug 2023 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHCJOT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 3 Aug 2023 05:14:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36CADA
        for <linux-fbdev@vger.kernel.org>; Thu,  3 Aug 2023 02:14:17 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RGjn24tDfz1GDTw;
        Thu,  3 Aug 2023 17:13:10 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 17:14:13 +0800
Message-ID: <4d371c7e-c945-26c0-ebcd-48c6bb886dc8@huawei.com>
Date:   Thu, 3 Aug 2023 17:14:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: Make fbcon_registered_fb and
 fbcon_num_registered_fb static
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     <deller@gmx.de>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20230803020939.491-1-guozihua@huawei.com>
 <ZMtoA/cYt6rtTpAD@phenom.ffwll.local> <ZMtq2NtCIQxKRqPh@phenom.ffwll.local>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <ZMtq2NtCIQxKRqPh@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2023/8/3 16:52, Daniel Vetter wrote:
> On Thu, Aug 03, 2023 at 10:40:35AM +0200, Daniel Vetter wrote:
>> On Thu, Aug 03, 2023 at 10:09:39AM +0800, GUO Zihua wrote:
>>> fbcon_registered_fb and fbcon_num_registered_fb is not referred outside
>>> drivers/video/fbdev/core/fbcon.c, so make them static.
>>>
>>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>>
>> Applied both of your patches to drm-misc-next.
> 
> Correction, I dropped the agpgart patch again because amd gart x86 arch
> code needs that symbol.

Thanks Daniel. Blind enough to not found this usage while making the
patch, sorry for the burden.
> 
>> -Daniel
>>
>>> ---
>>>  drivers/video/fbdev/core/fbcon.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>>> index 887fad44e7ec..976900d6893c 100644
>>> --- a/drivers/video/fbdev/core/fbcon.c
>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>> @@ -102,8 +102,8 @@ enum {
>>>  
>>>  static struct fbcon_display fb_display[MAX_NR_CONSOLES];
>>>  
>>> -struct fb_info *fbcon_registered_fb[FB_MAX];
>>> -int fbcon_num_registered_fb;
>>> +static struct fb_info *fbcon_registered_fb[FB_MAX];
>>> +static int fbcon_num_registered_fb;
>>>  
>>>  #define fbcon_for_each_registered_fb(i)		\
>>>  	for (i = 0; WARN_CONSOLE_UNLOCKED(), i < FB_MAX; i++)		\
>>> -- 
>>> 2.17.1
>>>
>>
>> -- 
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
> 

-- 
Best
GUO Zihua

