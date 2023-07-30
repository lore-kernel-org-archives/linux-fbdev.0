Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB3C04A94
	for <linux-fbdev@archiver.kernel.org>; Sun, 30 Jul 2023 08:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjG3Ixx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 30 Jul 2023 04:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG3Ixw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 30 Jul 2023 04:53:52 -0400
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EAFA9
        for <linux-fbdev@vger.kernel.org>; Sun, 30 Jul 2023 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=+JD+gaz11MZ1LWv0XUsV9qyfkJlDsrQ6GFrpqvCfKgo=;
        b=VFee1HPjPKjR3a4O8BqTD/lLj4zTT7W+KFF8CiVuEDA+WhxZFlAB+bzb7H7FqxxC7GztrbvevGoRB
         45jLtphBMQOz2Kwf+AGOycmL6/jb3FfWCzvkp4F8UXQH3XePMw3S5dx0UrFrM0Pnldkv5M/IILTn6A
         fjKgzaraZu06cLJ4G37p4b5T9GiQXYaM0ISYSeDj90SALCiaXmfIFmneGepDuHZjfsbfzZLcmln6AX
         cWdx3R//rW08EHEb+rbfAfiQ+RcdVshMY1qag6XiECY7rcciNWaTuYkjOWFgaGo/4BOgUqckrg3Vzq
         D0EItGdDjMuR/Vx2p4NPo33MjyZLqfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=+JD+gaz11MZ1LWv0XUsV9qyfkJlDsrQ6GFrpqvCfKgo=;
        b=iSabB0yiaE6Z67ZhaLj5CNeTbNzvCZbOR5cQQvxDQR3Qo5z6jtwZWH3XgUUk0rNTd2nS3FODB6hYj
         mC3bDATCA==
X-HalOne-ID: 97c1a98d-2eb6-11ee-ad79-6f01c1d0a443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 97c1a98d-2eb6-11ee-ad79-6f01c1d0a443;
        Sun, 30 Jul 2023 08:53:48 +0000 (UTC)
Date:   Sun, 30 Jul 2023 10:53:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, javierm@redhat.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 0/4] fbdev: Rename helpers for struct fb_ops
Message-ID: <20230730085346.GA1322260@ravnborg.org>
References: <20230729193157.15446-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729193157.15446-1-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Sat, Jul 29, 2023 at 09:26:45PM +0200, Thomas Zimmermann wrote:
> As discussed at [1], rename helpers for struct fb_ops to include
> 'MEM' in their name to signal that these helpers operate on a
> certain type of memory address; either I/O, system or DMA-able
> ranges. These are trival renames without any functional changes.
> 
> [1] https://lore.kernel.org/dri-devel/1ab418ae-592f-4347-fa75-bf9b00115afe@gmx.de/T/#mcb92691d6131333782cc83190a5fc00bd575a0c5

Yep, Helge is right that the naming is better with MEM added.
Good that we could get this sorted out now where the impact is "only" in
drm.

All 4 patches are:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

