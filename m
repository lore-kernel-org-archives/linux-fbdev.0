Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6376CC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Dec 2021 19:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhLITYa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLITYa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Dec 2021 14:24:30 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EABC0617A1
        for <linux-fbdev@vger.kernel.org>; Thu,  9 Dec 2021 11:20:56 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id n66so10044907oia.9
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Dec 2021 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZruaxW8L8OX9fgPYZgSgXNy2q463+9DO5ICSEYbDKQ=;
        b=N5tZh16fD1ANTvVPiBC20CwgGsc6/G5thWhdbHIjDVfF3kjmqFrMEGeemOh0NUz55r
         T7HSSqVz8FTFdGYKmRFJKlsuNFvd/DuTJjX5ppySrk66OuO+XTQektMUkyMwOQMqzQsn
         PDtBFk2aGCQZMRGrCUIrEQZ1PQX0LeoKy40X1VNZDG2KHrz6Smd1v5EW7YhxZidbmueY
         ylnoSnwlgJVI5cADit6x6G9Mcjbz6T7oyfcnexaLMiMLZbl3cNoOterQV1DkDFAlA5RM
         Zkf86+tx85LOQ8p5BxrMEZM+6tZl4LrMp+r/srfMMzq25DIB7TtdvOWkbU1no2y5UjKw
         TNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZruaxW8L8OX9fgPYZgSgXNy2q463+9DO5ICSEYbDKQ=;
        b=Lxjgmu7xEg3ZA9j6E+P4xLkY3n7TE3wUuco4yrbidrpo9c6OjNi4cAE1Xg5DaQRNF0
         vo3fE3ibEk56VeQHtpbPBlCAFL56HbLNvSfXXcpTxu8Yv0mIvWZVUhNLvGwthF9WHmSK
         mbITqFcyOxc13E/ReSYQCjgU32l66CGzgCTa97+a8SRqKPyHKQTlh3CHO5fk9E9R4qWC
         WSCCyv2kD8NW8pdFmF9m6nGxFsO/a+VPJymlQxZQHBsbshXeK31Pt20pnRFJhMcsVDr7
         /N37LwCSFJ9/daoLqdg6ufhVM84MHZ2ovE+woNRtfmEnGOg58Kzt16lrEa7eudmXp0rH
         r5FQ==
X-Gm-Message-State: AOAM531YuijL87rn/CR+7NPUHQCgBdPcqVB8EG9XHoS3Y5LG4iOTPix8
        TPoKnlwc1R1vvGmFyfRf2Nhc5FUgMJ/f0586TTA=
X-Google-Smtp-Source: ABdhPJxCMzUslRm7FidnI2hciOCsoX6UY9Zg/OGwr/RHaqiQjQWNzl83PTeK5eoLmny8OS3z8e7aSMDIS+YzrGYC86Y=
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr7667479oig.5.1639077655957;
 Thu, 09 Dec 2021 11:20:55 -0800 (PST)
MIME-Version: 1.0
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com> <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
In-Reply-To: <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 Dec 2021 14:20:44 -0500
Message-ID: <CADnq5_P+J_xxJ62zmTPGY0NfQR05Vnp51M_bYGXmdY1cXARfLA@mail.gmail.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        kexec@lists.infradead.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, pjones@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Young <dyoung@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Dec 9, 2021 at 1:18 PM Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> Thanks again Alex! Some comments inlined below:
>
> On 09/12/2021 15:06, Alex Deucher wrote:
> > Not really in a generic way.  It's asic and platform specific.  In
> > addition most modern displays require link training to bring up the
> > display, so you can't just save and restore registers.
>
> Oh sure, I understand that. My question is more like: is there a way,
> inside amdgpu driver, to save this state before taking
> over/overwriting/reprogramming the device? So we could (again, from
> inside the amdgpu driver) dump this pre-saved state in the shutdown
> handler, for example, having the device in a "pre-OS" state when the new
> kexec'ed kernel starts.

Sure, it could be done, it's just a fair amount of work.  Things like
legacy vga text mode is a bit more of a challenge, but that tends to
be less relevant as non-legacy UEFI becomes more pervasive.

>
> >
> > The drivers are asic and platform specific.  E.g., the driver for
> > vangogh is different from renoir is different from skylake, etc.  The
> > display programming interfaces are asic specific.
>
> Cool, that makes sense! But if you (or anybody here) know some of these
> GOP drivers, e.g. for the qemu/qxl device, I'm just curious to
> see/understand how complex is the FW driver to just put the
> device/screen in a usable state.

Most of the asic init and display setup on AMD GPUs is handled via
atombios command tables (basically little scripted stored in the
vbios) which are shared by the driver and the GOP driver for most
programming sequences.  In our case, the GOP driver is pretty simple.
Take a look at the pre-DC display code in amdgpu to see what a basic
display driver would look like (e.g., dce_v11_0.c).  The GOP driver
would call the atombios asic_init table to make sure the chip itself
is initialized (e.g., memory controller, etc.), then walk the display
data tables in the vbios to determine the display configuration
specific to this board, then probe the displays and use the atombios
display command tables to light them up.

Alex
