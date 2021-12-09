Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58CAC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Dec 2021 18:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhLISKR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbhLISKR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Dec 2021 13:10:17 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9624DC061746
        for <linux-fbdev@vger.kernel.org>; Thu,  9 Dec 2021 10:06:43 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso7060212ota.5
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Dec 2021 10:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVu5cc9bTD6vf22XXmPr/TIBYXrD+gTouz5yZ1xCKFU=;
        b=Xf/yTmEHMqg3WBvvWp7JeHPcAbwglbi73Ndqgu4jkx6O/nW1EQQEfD+kVPcXCNgdc2
         ch0xRU5cTdQdnLf4b6np9zbhXJQMLcwo8SDbaq25SGReFw3ZSso69BYgmUywbrZ32d8T
         LaY073GbVX8vbg+DRLxJ5R6HOazKLyLuYq/w0vqoV2EIKI2sP3dhf751sjTXaW+x0C0D
         yrBm/37MR4VsFA/iHLb18Q1PY2CT+IV4QTMv54pTkhFNymH7ItVZssRtoBS8Xb2ZSw/H
         /A6mmCtjIuD7O+4S5LfDbrwRrwkcAaJc8cDs3RW3miczuhq80AgDirUVVhF8EKCIjfFj
         1jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVu5cc9bTD6vf22XXmPr/TIBYXrD+gTouz5yZ1xCKFU=;
        b=hngf0XLgMLAjZJzYTOPTMZ2r3VkPc+qryBz7dg3X2c+ZlO0+xf5aexrloMS/vaaAbB
         hhG8jMlvybSZqMKOvsB09BaNQAxp+y7eDmTkWBVpo3RmRqS/JZfQEd5K8fqNMJyteenS
         5r99SnVt5buZ/LNOEDbEojEA3ki8jUiH6kdcjVjfZh0LO8pG96pcVZT7omelM/Bh7UL8
         DL2qcipLpt+BWLdA8uZglgrexSrl0L5+6kIqMslTWDizKH1XX2FPMofSpA9GBMRi/fwy
         bamoV5j77lIeuFHSndiIVSt/o/fiIj99Ih5paRWLEiSKtn4x935wDuoDwhhJBZJpB6Cc
         GbKg==
X-Gm-Message-State: AOAM533L2aK2pGkFyPV6PsJzaceFWDOaV3LykLBsv611sZWxNVKij8Hv
        pv7bH4QkGXnFWk+cB5ahrTnIWsKBYgaUq8iNRJc=
X-Google-Smtp-Source: ABdhPJzODhY9yg2B/H0YvUtQi1UpyUrWst1qCagatbL8h3sVtVrWHhxikW3ibeZARthXGbUpDT25ejOrazxGsyBff2w=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id v15mr6999009ota.200.1639073202803;
 Thu, 09 Dec 2021 10:06:42 -0800 (PST)
MIME-Version: 1.0
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com> <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
In-Reply-To: <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 Dec 2021 13:06:31 -0500
Message-ID: <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        kexec@lists.infradead.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel@gpiccoli.net, kasong@redhat.com,
        Baoquan He <bhe@redhat.com>,
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

On Thu, Dec 9, 2021 at 1:00 PM Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 09/12/2021 14:31, Alex Deucher wrote:
> > [...]
> > Once the driver takes over, none of the pre-driver state is retained.
> > You'll need to load the driver in the new kernel to initialize the
> > displays.  Note the efifb doesn't actually have the ability to program
> > any hardware, it just takes over the memory region that was used for
> > the pre-OS framebuffer and whatever display timing was set up by the
> > GOP driver prior to the OS loading.  Once that OS driver has loaded
> > the area is gone and the display configuration may have changed.
> >
>
> Hi Christian and Alex, thanks for the clarifications!
>
> Is there any way to save/retain this state before amdgpu takes over?

Not really in a generic way.  It's asic and platform specific.  In
addition most modern displays require link training to bring up the
display, so you can't just save and restore registers.

> Would simpledrm be able to program the device again, to a working state?

No.  You need an asic specific driver that knows how to program the
specific hardware.  It's also platform specific in that you need to
determine platform specific details such as the number and type of
display connectors and encoders that are present on the system.

>
> Finally, do you have any example of such a GOP driver (open source) so I
> can take a look? I tried to find something like that in Tianocore
> project, but didn't find anything that seemed useful for my issue.

The drivers are asic and platform specific.  E.g., the driver for
vangogh is different from renoir is different from skylake, etc.  The
display programming interfaces are asic specific.

Alex
