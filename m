Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696DBC3DA66
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Aug 2023 20:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjHWU03 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Aug 2023 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjHWU0W (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Aug 2023 16:26:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8271A5
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Aug 2023 13:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692822360; x=1693427160; i=deller@gmx.de;
 bh=PhrGsHXGaQjIMk2bZf7/D8Uivx3B4otze2QEAyyNkds=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=F/x9+bQFRoQ+t4C+Z9PnO4tX9Ou852yHqFW6ec3/vWcW/JsjmxTHdl1hAPH1yHEUk5cQC5S
 kl46G6/0bYA+UODVrir/6AkCOuLn42LBuHW29e9wAX5InYqA+9xbs9KNcnMITJ9AXrGxR3m5s
 Ij2mAfRjJH/nXYtZsQvFb5OrdejkUBUlPG051T9HWCz1USUJY84tr89kC22iPrB2EivoElXe6
 kNQgs6+iGVdJ57Okyc9XgKqw0UU40f3EfDxB38GoJdTbi8CjiJnoS61/quDx06kiLeiAE+fw5
 gNzM/GMTipFzz4hlYqvcqjwliU9NYWy7l4/Sl9APnd+CuKt6H2bQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.150.103]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeMj-1qCXvP1kup-00Vhdv; Wed, 23
 Aug 2023 22:26:00 +0200
Message-ID: <5f33d29a-f5c7-0d35-3327-e31a26e5c8b4@gmx.de>
Date:   Wed, 23 Aug 2023 22:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] fbdev/core: Use list_for_each_entry() helper
Content-Language: en-US
To:     Jinjie Ruan <ruanjinjie@huawei.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        sam@ravnborg.org, javierm@redhat.com, syoshida@redhat.com,
        Daniel Vetter <daniel@ffwll.ch>
References: <20230823072150.451189-1-ruanjinjie@huawei.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230823072150.451189-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:keMXXUzzlqo3L2Az8U9hj7+vLEJYcKnOamLDCYZ0Fj7RsN4JojE
 7xDZ0W7Ggx/V/6QCcUWR/ofbsIgOvepYfEGa0jH0L0lhcFOjULbWGoWFOS7EVvCbzvYa3/G
 C/jNl2iiqwDUgqh1hMxYVF8gdmhQ7/vqe0AD7ilUnLpduecUFTjPUrT2t/A73vZ30e2Udui
 FjuMZvt/XpPCMyI+iAArA==
UI-OutboundReport: notjunk:1;M01:P0:aj2K7ii9Gug=;dJtgR652gOPsH0WQ6OPzKL6LCs0
 5pZVzBXyGsHmCsSvokUOPmV+iSQsf8ECfntkYmDBMtnHatZrtjKpSX4WMJsKtBgcD5KJvbPuM
 nbDySfbe0UEnXZRbIPBzlcjsj5WxvUGbsfq9MbFXA8gy8/QJJzijDSHgECUzN/UbFiRJ6OXWf
 mwlXLXKdWzyzkHKFJ55jVXrfPHyL+yTlqq+p1rBomt0FQMhdqspXRGSextzFlJNYdo8Ibtsvx
 JZliboNWiTW67Drh146dgSZh2LyhtN4VWJju2Pr4t1AygLpToHh4PVtZCr5q/Mrr1GFlijmKp
 l7Jv7Aig2OrrKE8wNIqc7GSOT3AZ7vgXaSwHjVhSsNiI5L3mEqm2WB+zcQYI4bae0Udxu+rTo
 IdSmi26PyL44yxNeOvA9nWwqA2ZogK9dwxz8gMIXdAk9lkhii4GdqgpSTMijv5q2DSA1aRPs8
 1ka7tUVry5qkwf4Kh/B6NIa4xm/nKvfUkhCF6IO09C2hBaDD8pNUa58whX1D3RjMY+eXej9oN
 QRRYCnxmwVilLBXfq0w+NEOUW4dTlHj0Dqn/LTIsg721QlZfo7J5Y06pKgn0yeKw4ft6eZOdG
 ThcPjGVu7y4tyvmOrfWHzpLeGTUtnPhAPaIkOrVCCkPBXbcpf5X4djaNnJgwYD8tqsPL+1JQ7
 ZSTvRWuzDQvuNfkSrB1TNKVGKEnT++3qz24XksWK0tXCnNJq3Fmz4ehmQLqP1ItP6G7kUkWbw
 zAQflomM2zkkhSBrnUdXayM+9cksjY4BB9srV976en6nAFDgquJ//PXr3s7lsmIFRLlkrw7Lq
 XyvjiNopfPZhIqHg9KH526Fc2SPB25Xc6I6ewsbMtIsZZp30hVrrTV7GD9u/OJV7oYaqGt5gi
 5oqpWkE8zLLge/vPqVVLp+OGc0phSV1Fn5yz4cdKfPS8+zdaT3hVbuUBIQGcMOxtQlMfX07GL
 JVuCrQ==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 8/23/23 09:21, Jinjie Ruan wrote:
> Convert list_for_each() to list_for_each_entry() so that the pos
> list_head pointer and list_entry() call are no longer needed, which
> can reduce a few lines of code. No functional changed.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

applied.

Thanks!
Helge

