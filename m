Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8912DC433B4
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Apr 2021 08:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401F261104
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Apr 2021 08:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDTIZO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Apr 2021 04:25:14 -0400
Received: from foss.arm.com ([217.140.110.172]:58312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhDTIZO (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Apr 2021 04:25:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1746A1435;
        Tue, 20 Apr 2021 01:24:43 -0700 (PDT)
Received: from bogus (unknown [10.57.52.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0529B3F85F;
        Tue, 20 Apr 2021 01:24:41 -0700 (PDT)
Date:   Tue, 20 Apr 2021 09:24:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Jones <pjones@redhat.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efifb: Fix runtime pm calls for non PCI efifb device
Message-ID: <20210420082439.2xvrmcoa6kygbhow@bogus>
References: <20210415102224.2764054-1-sudeep.holla@arm.com>
 <20210420075332.t56dlpppb6bnpjzd@bogus>
 <CAAd53p6zti5rmJ5LjW3WbYsSGBs5CgBuOztHv-nvMObGBh7Q+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6zti5rmJ5LjW3WbYsSGBs5CgBuOztHv-nvMObGBh7Q+A@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 20, 2021 at 04:12:26PM +0800, Kai-Heng Feng wrote:
> Hi Sudeep,
>
> On Tue, Apr 20, 2021 at 3:53 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Gentle Ping! There is boot failure because of this issue with linux-next
> > on few arm platforms with non PCIe efifb. Please review and get the fix
> > merged ASAP so the testing on these platforms can continue with linux-next.
>
> It was merged in drm-tip as d510c88cfbb2 ("efifb: Check efifb_pci_dev
> before using it").
>

Ah OK, thanks! But I don't think it is appear on -next yet.

--
Regards,
Sudeep
