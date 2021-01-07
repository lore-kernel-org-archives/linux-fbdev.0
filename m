Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE30C433DB
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jan 2021 22:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03157235FA
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jan 2021 22:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbhAGW5a (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Jan 2021 17:57:30 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61944 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGW5a (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Jan 2021 17:57:30 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 107Mumtu091038;
        Fri, 8 Jan 2021 07:56:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Fri, 08 Jan 2021 07:56:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 107MumS6091031
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Jan 2021 07:56:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [Patch] fbcon: i want fbcon soft scrollback feature come back
To:     xuhuijie <huijiexu295@gmail.com>, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, jirislaby@kernel.org,
        yepeilin.cs@gmail.com, b.zolnierkie@samsung.com,
        george.kennedy@oracle.com, natechancellor@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210107154801.1997-1-huijiexu295@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0994b84e-4370-1065-c0ed-87c8b946a741@i-love.sakura.ne.jp>
Date:   Fri, 8 Jan 2021 07:56:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107154801.1997-1-huijiexu295@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2021/01/08 0:48, xuhuijie wrote:
> This commit 50145474f6ef(fbcon: remove soft scrollback code) remove soft scrollback in
> fbcon. So the shift+PageDown and shift+PageUp is missing. But PageUp is a vary important
> feature when system panic or reset. I can get log by PageUp before, but now there is no
> way to get. Especially on the server system, we always use bmc to control computer.
> So I hope the community can add this feature back.
> 

You can configure kdump for panic, and netconsole for reset.
(I don't know whether PageUp key works after panic...)
