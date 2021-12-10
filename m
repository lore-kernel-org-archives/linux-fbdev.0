Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496E5C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Dec 2021 19:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhLJTPK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 10 Dec 2021 14:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhLJTPJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 10 Dec 2021 14:15:09 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4948CC061746
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Dec 2021 11:11:34 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bj13so14549510oib.4
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Dec 2021 11:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MCCCrMsD80PYsXI80yfhET4AB8VSWOdySeInd6qTHiw=;
        b=aBi0zyo1vOOvZtbVw1z0ewL0DB+wpsdif/9QhdpeVGrtx2FKxCx3PyanvopaVMam18
         LsNaYYxK9MWHESlmYlzj5cuePZb3rxr2ICfSp9IssOwMeQ/AGLJOBjnH9IEiTb7qbMJl
         1wLr74UaWxYx2aKRsmS0I+Cag6qTY8rx3+0de9BOEZDbaavQytFuUAl4ikacxrHA5uL+
         jsSYwgX9JiANWLyqTpVbV5DknVCz5LH436HwOZEhqmvHiyMkDtkFCRPHRdh++AczBz0q
         6c9hflbFHrmt2+yzUIQ0AQpMXZgwHFaGc8/siXhoKQcoWxbHqsoyxBXqy/DYVu80SdzS
         Ny0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MCCCrMsD80PYsXI80yfhET4AB8VSWOdySeInd6qTHiw=;
        b=B6N3EsR2sIgVM6NihzdDTuPnOl9uz2KfvL5xF7GPzENIJ/HNEiPDsr1KVuuGzMNowN
         64zW6/mYP2x4zl11dsIxsLr9FgX+1bH+BM5PEZuTiu0Pj2aP6LNFiiboRo8zaO3AHHl/
         +HgzQ6rY4lMB0YzjMpTqA9HrkpsepODvGknEFP0ipnTwHt5AmvHetB32u6IHEcNar0ND
         4vkYqUEOWltCnZXoTBjh3Ke8gonx6WJF8Xv/tvCM9zjmTQft7RvOxgY7lyRCaMuPvWgy
         6m5WX2gL5XNdsEmWaPxg6cZlqD6pw0EVQDb523iKz3EoAUNkoNwfCgwFn+BCCTJZ0Nd3
         V7ZA==
X-Gm-Message-State: AOAM530ScYn2n9Jyr0oS2b/vdTowV5PiixZzD2y0CEQlJvZsnnKyMDd4
        ZOOQfKUYW2+KhN5cbkHPL/X0MEwYwX7spaukKFBgwi6s
X-Google-Smtp-Source: ABdhPJznkZHc+/04noUEWFMaObXDPF6FRikbNCHRD5le/cb77UpNIAdmSFl/MsYmSVixh4A3WQ7/OGpzRzZw/YTh/js=
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr14026975oib.120.1639163493704;
 Fri, 10 Dec 2021 11:11:33 -0800 (PST)
MIME-Version: 1.0
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com> <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com> <6d3c7acf-a23f-3073-56ed-375ccb8cc815@suse.de>
 <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com> <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
 <56dfb915-036b-0584-f0ef-83c786970d6e@igalia.com> <d1de6ca3-11ae-af9e-a2fb-7bcb6fae01d6@amd.com>
 <0847ff12-8b1c-a046-eb05-f0011f81e172@igalia.com>
In-Reply-To: <0847ff12-8b1c-a046-eb05-f0011f81e172@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 10 Dec 2021 14:11:22 -0500
Message-ID: <CADnq5_O4+8r_NKCK3JBtHPf03hniR9Q53r-A2PFFFBR9X1nFMQ@mail.gmail.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Dec 10, 2021 at 10:24 AM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> On 10/12/2021 12:13, Christian K=C3=B6nig wrote:
> > [...]
> > How about issuing a PCIe reset and re-initializing the ASIC with just
> > the VBIOS?
> >
> > That should be pretty straightforward I think.
> >
> > Christian.
>
>
> Thanks Christian, that'd be perfect! Is it feasible? Per Alex comment,
> we'd need to run atombios commands to reprogram the timings, display
> info, etc...like a small driver would do, a full init.
>

You need the equivalent of a GOP driver or a full GPU driver.  I think
it would be less effort to just fix up any problems amdgpu has when
trying to load after the crash than to write a new mini driver.  By
the time you add everything you'd need, you'd be pretty close to a
full GPU driver.

> Also, what kind of PCIe reset is recommended for this adapter? Like a
> hot reset, powering-off/re-power, FLR or that MODE2 reset present in
> amdgpu code? Remembering this is an APU device.

You'd need to issue the relevant device specific reset sequence.  It
would be a mode2 reset on vangogh, but varies on other asics.  It
would probably be easiest to just fix up the logic in amdgpu to detect
bad GPU state on driver load and do a GPU reset before driver init.
We already have the logic in place for some dGPUs, but APUs only
recently got full GPU reset support due to architectural limitations
and hardware bugs.

Alex
