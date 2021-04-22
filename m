Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E42C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu, 22 Apr 2021 10:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F8261428
	for <linux-fbdev@archiver.kernel.org>; Thu, 22 Apr 2021 10:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhDVKl5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:41:57 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39649 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhDVKl5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 22 Apr 2021 06:41:57 -0400
Received: by mail-oi1-f170.google.com with SMTP id i81so45379016oif.6;
        Thu, 22 Apr 2021 03:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkoWU4pOXOH5nl2P4HSwkzSQBpPMbT0VUfATt/sd1IE=;
        b=avThzTXjdBxubTm8QOc/sOqvZpmRUcLRVS6dfT1bCchkKrNpBf0EupxdGct0AOAOsI
         hlEHKRYPGgemhk9LQ09NyQ6hutlN+dzDnaniqZ9WIrpyRLNFUdF9e4Q1/EmS9hwbnY41
         3FHk5G1TyQfp6sIxsZ58VaVFaaiMq7n1cMkWV82ZTJTpEVgpmki7A21jzSe6yVelAoxc
         RwB4ucDxBQB0U35Aug48yV+ZjR+bgFyqIEf5GfJgd8u5TkxhLI0t3U9wxqeqipj8CetA
         O+Zl+LpS00F/gyEqA7R2jnBAMDyI3yMfj1XLEc7q8p224+hdFx5V/ArS25Gf3hDb448f
         AZCw==
X-Gm-Message-State: AOAM533d0S656lpegxZoI5197zSqguhISYpytJVDhHBY5bz+SrtbHQIa
        tQmmCdLnK/dbmpf/n7gNP5RdCq2lV/FLE27dJnM=
X-Google-Smtp-Source: ABdhPJz/8mzbKbTdBB4a2vYn5MZT4pcwu5nhZkckeIyYN1aDX+TAJ2gNPiuemuE0Conc0rPMX5voV09Ws9cAelaN388=
X-Received: by 2002:aca:2107:: with SMTP id 7mr6822209oiz.8.1619088082362;
 Thu, 22 Apr 2021 03:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210413170508.968148-1-kai.heng.feng@canonical.com>
 <CADnq5_P7_7jOZWTo+KCj3jOpmyDPN8eH3jNTgg3xLC4V9QM7kQ@mail.gmail.com>
 <CAKMK7uHR0VDk=C+u1d5qiiqQP+3ad5_gXQwvmPbJ56mG=3RjpQ@mail.gmail.com> <CADnq5_MpDz9myx8HiKihq-6_Ud48sN=NXN1_ga7WZa9LguzSjA@mail.gmail.com>
In-Reply-To: <CADnq5_MpDz9myx8HiKihq-6_Ud48sN=NXN1_ga7WZa9LguzSjA@mail.gmail.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 22 Apr 2021 11:41:11 +0100
Message-ID: <CAPKp9uYEwNfmBndCWt5BSZ7VQ+JHAhzd6aBsN8WO1nmMUQ2Mcw@mail.gmail.com>
Subject: Re: [PATCH] efifb: Check efifb_pci_dev before using it
To:     Alex Deucher <alexdeucher@gmail.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        pjones@redhat.com
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 14, 2021 at 8:20 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Apr 13, 2021 at 2:37 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, Apr 13, 2021 at 8:02 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > >
> > > On Tue, Apr 13, 2021 at 1:05 PM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > On some platforms like Hyper-V and RPi4 with UEFI firmware, efifb is not
> > > > a PCI device.
> > > >
> > > > So make sure efifb_pci_dev is found before using it.
> > > >
> > > > Fixes: a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
> > > > BugLink: https://bugs.launchpad.net/bugs/1922403
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > >
> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > fbdev is in drm-misc, so maybe you can push this one too?
>
> Yes, pushed.  Thanks!
>

Can we have this pushed into the branch that gets merged into linux-next.
I still don't see this fix in -next and we are unable to do testing on our
platform as we hit a boot crash without this as reported in [1]. We prefer
running tests on -next without any additional patches or reverts, hence
the nagging, sorry for that.

Regards,
Sudeep

[1] https://lore.kernel.org/dri-devel/20210415102224.2764054-1-sudeep.holla@arm.com/
