Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545C6C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jan 2022 16:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354199AbiASQP5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:15:57 -0500
Received: from outbound1a.eu.mailhop.org ([52.58.109.202]:27588 "EHLO
        outbound1a.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346196AbiASQPz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jan 2022 11:15:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1642608952; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=kxC1WkaeocxOKFARM9ByXViqcVSKvTabcCDr4GkmmWh+KoePfqjGC1TTdYIyG+To3KM90FO9nU5Fa
         WlgBobjn/449O//6+Uptcg176qgS38tplmAdna5bscD4XDxwWxoQw0NrHbXi0M+TNBAPrEvilwWHn/
         iIAPp63HzTv9RdZc6u2Ek89LRUlfiD+/92tVXNAenAy5dvp/ieb/iySM7zSffbaYF9iaspIC32pU3Y
         ArmO0Yg/c773Ta/4KLHW1LCBZKc9/wd10sESTdfO3QmOnk8SGcnzukVDLGin4Rg5Sbr/MGFzHQL9ly
         y5AT1v2GoVKAW8Z2QPje0uKE/KqsUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=VQkws5cfDXUAVloFG/KiXRI6miR49pWBsef8Tqe52gE=;
        b=DROucEpWMAWSNzreneKr2Wz/6RktSjothuyxVhBgglmkQDlPGbCp71wAK6+oz5diROqQGswUAKT5m
         g/M4NdoWG8iM7Fttgt2BugwZji6DRpvSNNx88Cx+sals5DtpDZpVzUIlDyOz7Te6jld5rpIEPqfAGo
         94ZmaoMff//l8NCDcC6SIQlP6lNh2q30MKOXyoTVyzwyb65EdwrhyBHO26DScc1mKU+YkTM0ivHGZ2
         pcY+g3AlmpFTfk0l8xHLP7e4TU120aemRVRz6hGURThae6EKkOjmdYW4dFThUsmchYJ258jfSyxpxP
         LyB33MK6NNz4gnMhgzdeSHNqLYT0MLQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=VQkws5cfDXUAVloFG/KiXRI6miR49pWBsef8Tqe52gE=;
        b=TToPtR0bHKToDxiw8UMDGv10xrkXW8uyXFRYgxY5Mhkw4EsVhsQD4dK9xGYuzQRc1N8MKa8o8+BLr
         axYeMiqDMaIXozAFfQ7f/OA9CMgsERMBk/O4AH8dD+RqYujBUhK/u2s2pNPDx5QZN3VI6tOXU8uz8F
         vbS5DUXV0PsSM8Jo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=VQkws5cfDXUAVloFG/KiXRI6miR49pWBsef8Tqe52gE=;
        b=E0YaHv4GxVcZCjbY0tPAynCkZWuJgL947/czeFAJpN4/sK4xGesGsghce17+LLzjEOE8Lfd4PvU9D
         DBoxb7YuiSl4UjjzmEoG0wrYwZyIEgP5OSQYOHeniikKx4yJdqxhlDvKnTzxKUUekYkl2Burd6Oige
         c4MOegAiQeblQWiIsryC5qlvDQdrunVMF3be5dRC1McNCqwWyqSvazmL5I2DpBaPWOjwjVTOrcoehC
         zAewZqvn1/fNdp6d/5gTxH3dmYBdc7Xr1cuwOFE1UA/+LZAUgVSA3ngkdmjkzsqn6qL8yHNabTIQyj
         7sk2GAf9sV7gqPCQsowAsOyigxh2GZg==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 0f13a236-7943-11ec-a077-973b52397bcb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound2.eu.mailhop.org (Halon) with ESMTPSA
        id 0f13a236-7943-11ec-a077-973b52397bcb;
        Wed, 19 Jan 2022 16:15:47 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1nADcf-0059VO-M4; Wed, 19 Jan 2022 18:15:45 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: fbdev: Garbage collect fbdev scrolling acceleration
References: <feea8303-2b83-fc36-972c-4fc8ad723bde@gmx.de>
        <87zgnz71ic.fsf@x1.stackframe.org>
        <Yegwl/rwRhjROxcy@phenom.ffwll.local>
Date:   Wed, 19 Jan 2022 17:15:44 +0100
In-Reply-To: <Yegwl/rwRhjROxcy@phenom.ffwll.local> (Daniel Vetter's message of
        "Wed, 19 Jan 2022 16:39:03 +0100")
Message-ID: <87y23bitvz.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel,

Daniel Vetter <daniel@ffwll.ch> writes:

> On Thu, Jan 13, 2022 at 10:46:03PM +0100, Sven Schnelle wrote:
>> Helge Deller <deller@gmx.de> writes:
>> > Maybe on fast new x86 boxes the performance difference isn't huge,
>> > but for all old systems, or when emulated in qemu, this makes
>> > a big difference.
>> >
>> > Helge
>> 
>> I second that. For most people, the framebuffer isn't important as
>> they're mostly interested in getting to X11/wayland as fast as possible.
>> But for systems like servers without X11 it's nice to have a fast
>> console.
>
> Fast console howto:
> - shadow buffer in cached memory
> - timer based upload of changed areas to the real framebuffer
>
> This one is actually fast, instead of trying to use hw bltcopy and having
> the most terrible fallback path if that's gone. Yes drm fbdev helpers has
> this (but not enabled on most drivers because very, very few people care).

Hmm.... Take my Laptop with a 4k (3180x2160) screen as an example:

Lets say on average the half of every line is filled with text.

So 3840/2*2160 pixels that change = 4147200 pixels. Every pixel takes 4
bytes = 16,588800 bytes per timer interrupt. In another Mail updating on
vsync was mentioned, so multiply that by 60 and get ~927MB. And even if
you only update the screen ony 4 times per second, that would be ~64MB
of data. I'm likely missing something here.
