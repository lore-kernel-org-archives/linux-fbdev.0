Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F116C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Dec 2021 19:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhLJTJP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 10 Dec 2021 14:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhLJTJN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 10 Dec 2021 14:09:13 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE14C0617A1
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Dec 2021 11:05:37 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bf8so14502755oib.6
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Dec 2021 11:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eE7LEXLBndGG1htPQ+DXNYXDObvNjAlKpnwTZx768wc=;
        b=eOJZva4Fq1luajmeTCOHeGthRyrZdIKhZ514Ze8syFWhn42iAWp7fHREQ1llf+rnDP
         ZoGAUfQfUQypcyflo52/gGgBIDeJZOKno5WHENWSjVzvVt0KVkBlO8u2JdtlUvojfjKq
         DIuCjPkbyA4Xw/5bIkLz/mYo5me9MEVPZcquO57vWajLufnnl5JnDfqxeqopN/lS5KJY
         z2u9qNDMw7d0dhFLu62zkU89T2qZrO/ie5Ui3gifR6q0YwnuTzPdJsqat0eRbrqQRfbg
         x7pjc6o2jFtWU5qATsl3I/6HW/J3YnO/WKzqe4jr3LVPBk1zBUdlMhIlYkhCv/KhKENu
         4o3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eE7LEXLBndGG1htPQ+DXNYXDObvNjAlKpnwTZx768wc=;
        b=dsJqgAzGma6K87I+lbAQ0OeZ+O+Kj0NQvUw0wO1+xZY66z2liLuqMCttxehNj6ln6y
         cjl/eFlcoiA5LE4q8fS2IVjV60iB97F2Ze4rc4W+P+SJ6okvWqigF4HDLja4xB/XYOuf
         sd0JbUOMMz7K7t7gnoIolPUgtDeaSQf7Wz5aukrMTWlXin+0vir6GsBiQuiZniYYcS1y
         yfci0E615vwsylmHX0CkDb3ngsMqs09GYesjUGRerkiD8K6fCY2Vv0dxZTVF4zUkmEE3
         kghwfd6QEo4aef6kn5eakPj7e5HMNrLprkD6EGhGDgxWHCN5zrRraeXRWzEdt6i508Vw
         EWrg==
X-Gm-Message-State: AOAM531S1ZO9Cy7cW97Bnb4WOAQyXIHBz2zem7fNbkHZeGlOSRdR3rtg
        F8zKtQF6/+mZb2InitNq3bO/7GyU/pY1zU3qIcQ=
X-Google-Smtp-Source: ABdhPJwY+3OIlLMQRK831jBALf9pBKI0vv9FSDO/7G8EZuTphIx/zK41Uwd0OUE7wTRPguj3+nvRSAdElVT9nmALC7Y=
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr13685527oig.5.1639163136150;
 Fri, 10 Dec 2021 11:05:36 -0800 (PST)
MIME-Version: 1.0
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com> <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com> <6d3c7acf-a23f-3073-56ed-375ccb8cc815@suse.de>
 <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com> <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
 <56dfb915-036b-0584-f0ef-83c786970d6e@igalia.com>
In-Reply-To: <56dfb915-036b-0584-f0ef-83c786970d6e@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 10 Dec 2021 14:05:25 -0500
Message-ID: <CADnq5_NphKQwa=sPWEWPTDbQVHGXQd0Ue8GNJR975jCvka7dQA@mail.gmail.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        kexec@lists.infradead.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, pjones@redhat.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Young <dyoung@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Dec 10, 2021 at 9:25 AM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> On 10/12/2021 11:16, Alex Deucher wrote:> [...]
> > Why not just reload the driver after kexec?
> >
> > Alex
>
> Because the original issue is the kdump case, and we want a very very
> tiny kernel - also, the crash originally could have been caused by
> amdgpu itself, so if it's a GPU issue, we don't want to mess with that
> in kdump. And I confess I tried modprobe amdgpu after a kdump, no
> success - kdump won't call shutdown handlers, so GPU will be in a
> "rogue" state...
>
> My question was about regular kexec because it's much simpler usually,
> we can do whatever we want there. My line of thought was: if I make it
> work in regular kexec with a simple framebuffer, I might be able to get
> it working on kdump heheh
>

Well if the GPU is hung, I'm not sure if you'll be able to get back
the display environment without a GPU reset and once you do that,
you've lost any state you might have been trying to preserve.

Alex
