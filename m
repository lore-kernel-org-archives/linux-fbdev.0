Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E71C4332F
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Nov 2023 10:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjKIKVk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Nov 2023 05:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIKVj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Nov 2023 05:21:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8BD19A3
        for <linux-fbdev@vger.kernel.org>; Thu,  9 Nov 2023 02:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699525297; x=1731061297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9JII0Lo4jHn5XxlrRzhOZU1i/JijstHf9Qrl/JNuDKw=;
  b=uMl9HiaaPs2sWXiSbqxURszRPbMVGVT3DUcpKSb17MUdn6PKbNjQoD26
   4Ox2YrplYGD//Gpw+96k8waih7NfWw2SWOObwFN7CY2/IRC0Qvp13PpZv
   b68rCxfLutcZ5caEu2MBP/ExeOINRinUtLoH2VT706vTrfSypYzR6MdWb
   U9ppUQz0clFNMLWctshKger9QjaFLnW+UTQh7+LEGgohSIqyyhBe5336c
   8jnkj2WHxLZX3crV4KE9LC30vd4WsmiL2rFSgKqNE1peLkM8tbcX7ZHzK
   liASDedIVYgMiGXV14aQgNq7hHLxx59YmRbqsFGLcWZ8JG1amHBdUUKyG
   Q==;
X-CSE-ConnectionGUID: Gk3+QKqkR3aW4bGUef3s3g==
X-CSE-MsgGUID: b9bulL1OTQ6rbKDqb6bpZA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="12067718"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2023 03:21:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Nov 2023 03:21:19 -0700
Received: from [10.171.248.61] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 9 Nov 2023 03:21:16 -0700
Message-ID: <58473927-563f-4615-b422-497366c9e429@microchip.com>
Date:   Thu, 9 Nov 2023 11:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] fb: atmel_lcdfb: Stop using platform_driver_probe()
To:     Helge Deller <deller@gmx.de>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>
CC:     <linux-fbdev@vger.kernel.org>, <llvm@lists.linux.dev>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <dri-devel@lists.freedesktop.org>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>
References: <20231107091740.3924258-1-u.kleine-koenig@pengutronix.de>
 <20231107091740.3924258-3-u.kleine-koenig@pengutronix.de>
 <20231108184805.GA1579138@dev-arch.thelio-3990X>
 <20231108210018.ayo5b3afggmt6wfc@pengutronix.de>
 <24c4cc36-d14b-40cc-ad8d-dea029cf1845@gmx.de>
 <20231108215220.3iw5sydxad32gufj@pengutronix.de>
 <656080fb-7d10-47ec-bdeb-a099ceee99bf@gmx.de>
 <20231109062459.5hk7vb54t4iy5kp6@pengutronix.de>
 <57de52b3-201b-4599-83ba-b0a7cc8db350@gmx.de>
Content-Language: en-US, fr-FR
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <57de52b3-201b-4599-83ba-b0a7cc8db350@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 09/11/2023 at 10:55, Helge Deller wrote:
> On 11/9/23 07:24, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Wed, Nov 08, 2023 at 10:57:00PM +0100, Helge Deller wrote:
>>> On 11/8/23 22:52, Uwe Kleine-König wrote:
>>>> But info and so info->fix live longer than the probe function, don't
>>>> they?
>>>
>>> Yes, they do.
>>> But AFAICS info->fix contains a *copy* of the initial atmel_lcdfb_fix struct
>>> (and not a pointer to it). So that should be ok.
>>
>> If you say so that's good. I grepped a bit around and didn't find a
>> place where a copy is made. But that's probably me and I'll consider the
>> case closed.
> 
> It's not directly obvious, but the copy happens in the line you pointed
> out previously.
> 
> In include/linux/fb.h:
> 
> struct fb_info {
> ...
>           struct fb_var_screeninfo var;   /* Current var */
>           struct fb_fix_screeninfo fix;   /* Current fix */
> 
> so, "fb_info.fix" is a struct, and not a pointer.
> 
> In drivers/video/fbdev/atmel_lcdfb.c:
> static int atmel_lcdfb_probe(struct platform_device *pdev)
> {
> ...
>           info->fix = atmel_lcdfb_fix;  //  (line 1065)
> 
> this becomes effectively a:
>          memcpy(&info->fix, &atmel_lcdfb_fix, sizeof(struct fb_fix_screeninfo));
> 
> so, the compiler copies the "__initconst" data over to the info->fix struct.

Helge, Uwe and Nathan,

Thanks a lot for making this move, patch and detailed explanation.

Best regards,
   Nicolas
