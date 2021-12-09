Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333C5C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Dec 2021 18:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhLISVv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:21:51 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:56582 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhLISVu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Dec 2021 13:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Rz9HthfWS5XpA9c8jhlf214xM5YUiYfJJdxPSAqbHi8=; b=YvGNVESzooPeFFuYzoPk7pwnF8
        QElZRuWPwoWCs5DGopfrD723w4yUXZhQKtnAhuLCq1Zzc0++BtViqO6TJ6IL1oysVVNui5ioFa1S+
        v3CF63KvgnR8I312MaDxkEt2gYNEtENZGosLjEUFjXvWR3HCgnfHU0JEKwl0V5Q6QSmF8lppbhrMI
        NVbQ/iEw4nYuZlqtR+PRHRsgRL3wmGCsOx7yP0KFHhySM17xdzhtdqjY0TA9UXHpzBLaaZkKE9CAP
        MyF8d6bBCcDYjEecmwSnM9Vl7Y4PjO1WJn8+cRSNrq/XXtdNaIdWfoUW5h54P+1O6EnY3iMgOYYqi
        TNEPPI9w==;
Received: from [177.103.99.151] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1mvNzZ-000Cbb-Ny; Thu, 09 Dec 2021 19:18:06 +0100
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        kexec@lists.infradead.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>,
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
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
Date:   Thu, 9 Dec 2021 15:17:51 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thanks again Alex! Some comments inlined below:

On 09/12/2021 15:06, Alex Deucher wrote:
> Not really in a generic way.  It's asic and platform specific.  In
> addition most modern displays require link training to bring up the
> display, so you can't just save and restore registers.

Oh sure, I understand that. My question is more like: is there a way,
inside amdgpu driver, to save this state before taking
over/overwriting/reprogramming the device? So we could (again, from
inside the amdgpu driver) dump this pre-saved state in the shutdown
handler, for example, having the device in a "pre-OS" state when the new
kexec'ed kernel starts.

> 
> The drivers are asic and platform specific.  E.g., the driver for
> vangogh is different from renoir is different from skylake, etc.  The
> display programming interfaces are asic specific.

Cool, that makes sense! But if you (or anybody here) know some of these
GOP drivers, e.g. for the qemu/qxl device, I'm just curious to
see/understand how complex is the FW driver to just put the
device/screen in a usable state.

Cheers,


Guilherme
