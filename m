Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3779CC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Mar 2022 22:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355272AbiCXWPW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Mar 2022 18:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiCXWPV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Mar 2022 18:15:21 -0400
X-Greylist: delayed 1749 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 15:13:48 PDT
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.193.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC46CA6E14
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Mar 2022 15:13:47 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 930F31B6EF
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Mar 2022 16:18:10 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id XUqQnX13c22u3XUqQntFpS; Thu, 24 Mar 2022 16:18:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uYIalswLom+ceKwMGJo6mQG4+4OkZPeJDwH7fRE+ZPk=; b=cMxNZZ92vrPsegNwniVsIiJu6H
        cjg0z0Aq0AcDBpxN2VsWvG9wDTT34MReKb1oO5UGRnZcwNJG1f9Eo2uM8Naq2VkW6x7XwbmQAfXHr
        JRf0KsW/pTJcxLSqrCMQAeqPnwqhxfoq8whse9R2+mxnQuUxiRsHU0wvZvzM4D9LQEimEOudZyKRN
        0OQ4O6f2mVCShIIEnnJVdSHl/D2eJc/Fctnfq0YAJoTLwVPQIGBEtboCNaPZ89EgVBCNdZwEvetjP
        3/KFA5PV1K09QNsDE9HnEkNKxCFok3ntDVoKIc1bV7MPs2TQDER2STwyF4iPJzJ7a+G8q/URFCqB5
        DxVxXxdg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54452)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nXUqP-004IOY-Ss; Thu, 24 Mar 2022 21:18:09 +0000
Message-ID: <05be3d3b-16a7-2a65-fa58-606f22bfeeb8@roeck-us.net>
Date:   Thu, 24 Mar 2022 14:18:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/5] fbdev: Improve performance of cfb_imageblit()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, sam@ravnborg.org, kraxel@redhat.com,
        ppaalanen@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220223193804.18636-1-tzimmermann@suse.de>
 <20220223193804.18636-5-tzimmermann@suse.de>
 <20220324191116.GA1045463@roeck-us.net>
 <db7e3568-5dc2-eb84-8ee4-191442da85e9@suse.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <db7e3568-5dc2-eb84-8ee4-191442da85e9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nXUqP-004IOY-Ss
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54452
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 10
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/24/22 12:18, Thomas Zimmermann wrote:
> Hi
> 
> Am 24.03.22 um 20:11 schrieb Guenter Roeck:
>> Hi,
>>
>> On Wed, Feb 23, 2022 at 08:38:03PM +0100, Thomas Zimmermann wrote:
>>> Improve the performance of cfb_imageblit() by manually unrolling
>>> the inner blitting loop and moving some invariants out. The compiler
>>> failed to do this automatically. This change keeps cfb_imageblit()
>>> in sync with sys_imagebit().
>>>
>>> A microbenchmark measures the average number of CPU cycles
>>> for cfb_imageblit() after a stabilizing period of a few minutes
>>> (i7-4790, FullHD, simpledrm, kernel with debugging).
>>>
>>> cfb_imageblit(), new: 15724 cycles
>>> cfb_imageblit(): old: 30566 cycles
>>>
>>> In the optimized case, cfb_imageblit() is now ~2x faster than before.
>>>
>>> v3:
>>>     * fix commit description (Pekka)
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
>> This patch causes crashes with arm mainstone, z2, and collie emulations.
>> Reverting it fixes the problem.
>>
>> collie crash log and bisect log attached.
> 
> Does it work if you apply the fixes at
> 
> https://patchwork.freedesktop.org/series/101321/
> 
> ?
> 

Yes, it does, specifically the cfb related patch. I sent a Tested-by:.

Thanks,
Guenter
