Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90EC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Dec 2021 18:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbhLISD6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:03:58 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:40400 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhLISD5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Dec 2021 13:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Du1ulIl0nJfgyvVBjJv/Ni5rMz9pM/5JhDhCLOiqtLI=; b=f5ccjmB3z3Zsg2zp2C8KIiTaiG
        tahGEqJAgk3bk+K6yWDfuLwt/tvjKrhO1YMODbN6TCytk2eORd1BC9+cWTxGJTO7rQTSWoue7nkI2
        VcTT1bf1bG0L8QDTZUsmuykcluNaxRhqPPoUEQBqNJ84NB4cMX34ZxurAV9R5iA/EZJsS3MGi14ba
        agwm4gNpMR0pdaoRzsI9RQUo12pkECE3pBX/XPpuQVouGHr5DA68VtRiegqmfxnVg0GGTQ+eWjWod
        E2HJ2Nv2Nre8M1b/JYa6wKSlp8Be1AWvTV5CETadnDwF8arM/0Ka8hG/l+s8kKKDKs5YOG/PILlV+
        jBVbIt0Q==;
Received: from [177.103.99.151] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1mvNiD-000C0Z-09; Thu, 09 Dec 2021 19:00:09 +0100
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        kexec@lists.infradead.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel@gpiccoli.net, kasong@redhat.com,
        Baoquan He <bhe@redhat.com>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, pjones@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Young <dyoung@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Vivek Goyal <vgoyal@redhat.com>
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
Date:   Thu, 9 Dec 2021 14:59:52 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 09/12/2021 14:31, Alex Deucher wrote:
> [...] 
> Once the driver takes over, none of the pre-driver state is retained.
> You'll need to load the driver in the new kernel to initialize the
> displays.  Note the efifb doesn't actually have the ability to program
> any hardware, it just takes over the memory region that was used for
> the pre-OS framebuffer and whatever display timing was set up by the
> GOP driver prior to the OS loading.  Once that OS driver has loaded
> the area is gone and the display configuration may have changed.
> 

Hi Christian and Alex, thanks for the clarifications!

Is there any way to save/retain this state before amdgpu takes over?
Would simpledrm be able to program the device again, to a working state?

Finally, do you have any example of such a GOP driver (open source) so I
can take a look? I tried to find something like that in Tianocore
project, but didn't find anything that seemed useful for my issue.

Thanks again!
