Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE71C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Dec 2021 15:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhLJP2R (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:28:17 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:54754 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhLJP2R (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 10 Dec 2021 10:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d08zJAZ3+ydMRlW1z18ca2luIEumMp+4R6/Ga55iTkY=; b=jOYJBW/64rbuxHSlYHcFWfVuHm
        rzUxLqTop0VJ7hVH1LKGivj03Q5tzJUNYZW1/jjbHjbqo23+tazb4f+ZOF7V2XBbF+v+EmpyJPBlh
        72RT6kCVOHFNv3oLauDhdm8mlIz/F0bcMEYGcip2j+XgaoQxRHr+O03RENo8AH7GOyRz0n3WGXqSE
        O5OkRce0/wSCSVy1DnBkX5FrpeKcPzGaeY73OdeB/oFe0ig7qqOQKOrCB/Ps+G73Nzs9bo1C0o/9T
        +9Y01K2FyOx7lxhYDb4551Szkjt4QeWdhUDr9QaToRf23jiWT49WFOc4Y6sj2le/Gy0vtXvyAIUdb
        2bcpPLEA==;
Received: from [177.103.99.151] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1mvhl6-0002LH-QH; Fri, 10 Dec 2021 16:24:29 +0100
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        kexec@lists.infradead.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, pjones@redhat.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
 <6d3c7acf-a23f-3073-56ed-375ccb8cc815@suse.de>
 <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com>
 <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
 <56dfb915-036b-0584-f0ef-83c786970d6e@igalia.com>
 <d1de6ca3-11ae-af9e-a2fb-7bcb6fae01d6@amd.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <0847ff12-8b1c-a046-eb05-f0011f81e172@igalia.com>
Date:   Fri, 10 Dec 2021 12:24:08 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d1de6ca3-11ae-af9e-a2fb-7bcb6fae01d6@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 10/12/2021 12:13, Christian König wrote:
> [...]
> How about issuing a PCIe reset and re-initializing the ASIC with just 
> the VBIOS?
> 
> That should be pretty straightforward I think.
> 
> Christian.


Thanks Christian, that'd be perfect! Is it feasible? Per Alex comment,
we'd need to run atombios commands to reprogram the timings, display
info, etc...like a small driver would do, a full init.

Also, what kind of PCIe reset is recommended for this adapter? Like a
hot reset, powering-off/re-power, FLR or that MODE2 reset present in
amdgpu code? Remembering this is an APU device.

Thanks a lot!

