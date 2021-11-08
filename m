Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01143C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 Nov 2021 16:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7A761361
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 Nov 2021 16:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbhKHQeB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 8 Nov 2021 11:34:01 -0500
Received: from outbound5g.eu.mailhop.org ([18.156.67.42]:56504 "EHLO
        outbound5g.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbhKHQd6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 8 Nov 2021 11:33:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1636389072; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=H/bamtFAiYWfkzdRDIMobMiGKexyzxMpMeq1racSV95jHYj2qB4pPp/LsdW8jz3milrs7xElPQCeT
         U4/u+poguhpgz5z3g9Q0VCK7eiaZKiR9NFqX2CB0rAY3RQjlAAd6q/F5dk2kRwgpQJot4D45r5GGUG
         FQ4u1xaC7uB1p0MTxoDgqdNdoUpI8npueWx7mq8rh9/wXzOFvUNyPkTX7HNqn0xwJp2sPmx20rShKa
         0hlLRj7mjRjDq7aKA+ioFAeza3mn4HpxkotvhV7jroMysXP6TXccJTGR4WaH2CQy8kWzGvCkrAXneG
         TRIe/VBXTI9O/dkwJS6eRN1g5OrWhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=Zle7H/bD/7mnAWLln86LRfcBP/BDM9FqhSInrmlVFBk=;
        b=JQn1zxutdjOuVdsfv7x65mBIM+d9AlZzCWyLt/LuVQbKoomrCGfWB6asy+rgeSh/fvRWoVfvbnqw+
         VhMTkgTj7P69vU7GZr0DHekc/+h0UfEoogHHocn7guZmZ3ugGKALVN0Vz2YpFdOogM6OpTwU5r6x5o
         M2zLGfX0ysudjrQfEc0LNddp54WosGKsH6+/XEQZa55jRYn63+1Aws74JwzM3NvzUEnRPjS5CU1sak
         TBGv1Xnu7XaW95/DKuSigAi7VJBp5iTF389EbsCdgnyjffUE/TItCrsouMCmjUN/cGJVVsCWatboFQ
         cvW0zsRtG7ueLQPMm4pQ0EqyTUSGnGQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=Zle7H/bD/7mnAWLln86LRfcBP/BDM9FqhSInrmlVFBk=;
        b=mdJpOBRx1BldloOyCmN7GUoZzYS6Q3vh/Ibcv2VxFUFP69t1tiGyEpMF5QVVNFf0VY9zNX3Ro6SYk
         Fmgge0j5Q99KCsRuFHMl/5GB2j2d1ulmRbpxCOv07ApGtIWeaBrVUdWAMMSXi3WnOXjD6A36ZYcD4e
         G1qLQqx+O6dcL8vw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=Zle7H/bD/7mnAWLln86LRfcBP/BDM9FqhSInrmlVFBk=;
        b=M7I/lRHHZo+mQDzAzJ1ixX9Y7NgtJ2O5OUYWedSICCk5fuGEY1bikSNQ80tOs03hFWXcm5F0NTejE
         Ek6+JsfRFU2YT1N6si1DCNPNFKdIyEqe2MkAgUcJJ+yDridHvbZOd4r15027Oo3bNIdhvTaA6AZAEG
         SGOQSlllfZhJhn7s8deTwMz+BQGCFItruH32gdFWOz+OovNFF84NODN80nu87eHnfme7+0SrV6QdOm
         3qQ00N/Bht63Kq0FGDElmQU/7DCML8ep7y+Oep1twCnt43C95fMXpJqCQ+pybI9619AP//9bq9iGj1
         qkyKmWlQOoInNLFt8kZrizXBTzyJbxg==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 45c59303-40b1-11ec-a072-973b52397bcb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound2.eu.mailhop.org (Halon) with ESMTPSA
        id 45c59303-40b1-11ec-a072-973b52397bcb;
        Mon, 08 Nov 2021 16:31:07 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1mk7Y1-00E2t3-Qy; Mon, 08 Nov 2021 18:31:05 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH/RFT] fbdev driver for HP Visualize FX cards
References: <20211031195347.13754-1-svens@stackframe.org>
        <cd0f90d9-7dba-af33-f88b-289fc6f80b51@suse.de>
        <87r1c0s1bt.fsf@x1.stackframe.org>
        <e21cdf83-2178-7c59-2585-a6012f861f68@suse.de>
        <87o86x80am.fsf@x1.stackframe.org>
        <312d6427-67ff-67c5-b662-23127bb76d12@suse.de>
Date:   Mon, 08 Nov 2021 17:31:04 +0100
In-Reply-To: <312d6427-67ff-67c5-b662-23127bb76d12@suse.de> (Thomas
        Zimmermann's message of "Mon, 8 Nov 2021 09:37:01 +0100")
Message-ID: <87ee7qvcc7.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 06.11.21 um 22:02 schrieb Sven Schnelle:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>>> Hi
>>>
>>> Am 01.11.21 um 09:54 schrieb Sven Schnelle:
>>>> Hi Thomas,
>>>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>>> Thanks, i wasn't aware as i normally don't do any graphics related
>>>> development. I take a look at dri and port the driver, which is
>>>> hopefully not too hard.
>>>
>>> Sounds good.
>>>
>>> The one big difference when converting is that DRM really wants
>>> drivers to support 32-bit XRGB colors. It's not a DRM limitation per
>>> se, but a requirement of today's userspace programs. AFAICS your fbdev
>>> driver uses a 256-color palette format. So the DRM driver would have
>>> to convert
>>> XRGB8888 to 8-bit RGB332 and install a corresponding palette. Don't
>>> worry, it's easy. Take a look at the cirrus driver for a simple DRM
>>> driver. [1]
>> I have converted the driver, 
>
> Cool!
>
>> but am using FORMAT_C8 because i haven't
>> figured out yet how to switch the card to XRGB8888. That's still on the
>> TODO list.
>
> Don't worry. As I outlined , you can still convert any image from
> XRGB888 to RGB332 and display this instead.
>
>> One question about hw blitting: with the old fbdev framework one
>> could
>> replace the fb_imageblit function. For normal console text, this
>> function gets called with a monochrome bitmap, and an fg/bg color value.
>> This makes it easy to use HW accelerated blitting for text. In the
>> gpu/drm drivers i think i found only one driver (nouveau) doing this and
>> that was via the drm fbdev layer.
>> Is that still the way to go, or is there a better way to do HW
>> accelerated
>> text blitting?
>
> Simply call drm_fbdev_generic_setup() after registering the
> device. This should give you a console.

Yes, that's what i have, and it works. The only thing that is odd (and i'm
not sure whether that's a bug or not), is that fbset changes the
resolution of the framebuffer, but doesn't reprogram the hardware to the
new resolution. That means if i boot with 1920x1080 resolution, and do a
fbset -a 640x480-60, only a small part of the screen is used now, but
the physical resolution stays at 1920x1080. I first thought that's a bug
in my driver, but my x86 Thinkpad X1 with nouveau behaves the same.

> Don't bother about HW-accelerated blitting. From what I've heard, it
> barely makes a difference nowadays. And our generic helpers have
> plenty of features. Not using them to get a small benefit from HW
> blitting isn't worth it.

Not sure. With my first driver (the fbdev/fbcon one without drm), that
made a big difference when scrolling or the whole screen was updated. I
never measured it, but i would think it was a 1:10 ratio.

Regards
Sven
