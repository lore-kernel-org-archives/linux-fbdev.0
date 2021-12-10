Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F9EC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Dec 2021 14:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbhLJO3I (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 10 Dec 2021 09:29:08 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:35792 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLJO3I (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 10 Dec 2021 09:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KFezokHMMZ7/qP5YwEHN9+x2rpnAI51Dsg5absG2eVQ=; b=g4Mzr6e0UZ+RYapzcQBEkjTVqY
        i4ZAmpJOVZ6Qd4+vA9NMsWqM8nHLOh1hr1xhrFCUPRSvfC7eUrhADBBzFO4zVU+/V/UX4lUGoh8/m
        B5yL7Q0VsJJI10PG2OpcpQVC4UOPR2M8YBumlQI8UyboHJ1ZVokbk1OWMydzEH0ZSz9rKQ9ktcywP
        4IuvWEe4kI8l6Y21xJoUNAmxI1wewrjcQeDa+F4+dVshtdUyhzhFWdwxqYEzspDKoyfoXpFQJhXH8
        gsvHSRLM096qS9nSZkYpSAo8rrLB5GAW9jyWaXwcLfSJb+sP1hBj9RtFtZBV68yyVG/AYmmKAYZH/
        /+vNee6A==;
Received: from [177.103.99.151] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1mvgpt-0000xM-DH; Fri, 10 Dec 2021 15:25:21 +0100
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     Alex Deucher <alexdeucher@gmail.com>
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
        Dave Young <dyoung@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Vivek Goyal <vgoyal@redhat.com>
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
 <6d3c7acf-a23f-3073-56ed-375ccb8cc815@suse.de>
 <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com>
 <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <56dfb915-036b-0584-f0ef-83c786970d6e@igalia.com>
Date:   Fri, 10 Dec 2021 11:25:03 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 10/12/2021 11:16, Alex Deucher wrote:> [...]
> Why not just reload the driver after kexec?
> 
> Alex

Because the original issue is the kdump case, and we want a very very
tiny kernel - also, the crash originally could have been caused by
amdgpu itself, so if it's a GPU issue, we don't want to mess with that
in kdump. And I confess I tried modprobe amdgpu after a kdump, no
success - kdump won't call shutdown handlers, so GPU will be in a
"rogue" state...

My question was about regular kexec because it's much simpler usually,
we can do whatever we want there. My line of thought was: if I make it
work in regular kexec with a simple framebuffer, I might be able to get
it working on kdump heheh


