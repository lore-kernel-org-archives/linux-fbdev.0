Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B99C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 Jan 2022 22:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiAMWc0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 13 Jan 2022 17:32:26 -0500
Received: from outbound3.eu.mailhop.org ([52.29.21.168]:13864 "EHLO
        outbound3.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiAMWcX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 13 Jan 2022 17:32:23 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 17:32:22 EST
ARC-Seal: i=1; a=rsa-sha256; t=1642110372; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=uennW3yVcMIzJ0RkJuN4g8GIrLxFLIfDRHEsh9iL73IRCu0bpq5H135TaiK261VPPU1CeYvue5/Yr
         Xe+f2rm2n4g/r15Q6RGT6E44t81u2ZQlW5ITNjYz4QRRLqx5WxLDBOuPFiovyw80qzFPlFWdECfWTN
         RJFo00IdtTHhENvWbmn3Bn8AcPeBqu3N2DEJ/k5oJFd7+8saP6VvN9mfL4WEGBB9QLcgiW27bLgSZO
         4npZc6prj6rSPKkg5jHoVifVViJoqcgq5vR00aZuqSvUzVWAOY+vdlEzcthlXckeLcwITH/i2aneTi
         NWHC3vCJp83q2OZf9yEIVP717xmd+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=rNWUHGGDvJfQLWY/taj1SWuCMTjnvjFPnINSJEKI1nY=;
        b=umlXFqOegdeuW0i6SozAUVanrJXKIAq1QORnUnO4R+4cjIHdl3cJtZ5xq5UtEET2OjqQ+yEGonhQk
         IVosFw+tywLXvaBVLweVRWXILm+lPmoQxc/VOBNqZEx0nHFmuj2Td6NYeficIoLOEcrn2wnpV5+j/n
         QZFtGAXVPkwA3zOj6zrEiYZw6iJnCi9YBPEvOJiZhV03PDYZ/Uh1kHKUBUPExz3UllSl+seCC+kDJc
         4+CHwwaQ//I/Db79egLJemY7jWDBGVU2YEnBVI7a7tSpJdneTPrWSvqUtmNURFT00juGrqt1xct+P1
         XkpGRnomY54q63p02z8CoeXWP687JCQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=rNWUHGGDvJfQLWY/taj1SWuCMTjnvjFPnINSJEKI1nY=;
        b=RZuusrOs3EEIxaRIEGZabYaW7WRXhVybWvqucjpgddag6UgRP0fGLtb/iHpIeBGWLOp+T1fVBlaWO
         FlUR0K1DsAhSF5TLmAu/Yxjus2U9T87D/i1+qmZLVCBBfGz+u2bnIJkN/Xcnx2g3XlSghD8Ly9cYTq
         U9wtIRwew2uYuavg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=rNWUHGGDvJfQLWY/taj1SWuCMTjnvjFPnINSJEKI1nY=;
        b=qzXT/BXVCWUn9Aj0QVMxnMm/giqAVWL+LdsEFu095+2rX7grGODOG4jeRf4KcziPEUrFkfkhDuH3M
         NOor7sHEYMd6nhJZInocaH8ibq3vVAVtJibB3UrJ63pLuFznpOf59cwWAZDSK/M0XxksUh30LM0v+5
         p19gRfpPqzpxagBjD2PS4kR5NAom/oCxLdMzO2HE3Fbj4TqlOEg+LZGKYpEZe0fpxRP42NnnuG2gjI
         z2cPCq0oKuzj+F5eCyMsUxKoNiHOtrofjofgpzUoLOOnNCxYlXyVggv2ZLQqQsnEkpitO4tWSTeqf2
         VNTtPvI/JAQEzwc6BPStWy7bglPtCQQ==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 35ec3706-74ba-11ec-ba80-95b64d6800c5
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound3.eu.mailhop.org (Halon) with ESMTPSA
        id 35ec3706-74ba-11ec-ba80-95b64d6800c5;
        Thu, 13 Jan 2022 21:46:07 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1n87v3-004SHi-8E; Thu, 13 Jan 2022 23:46:05 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdev: Garbage collect fbdev scrolling acceleration
References: <feea8303-2b83-fc36-972c-4fc8ad723bde@gmx.de>
Date:   Thu, 13 Jan 2022 22:46:03 +0100
In-Reply-To: <feea8303-2b83-fc36-972c-4fc8ad723bde@gmx.de> (Helge Deller's
        message of "Thu, 13 Jan 2022 17:36:22 +0100")
Message-ID: <87zgnz71ic.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Helge Deller <deller@gmx.de> writes:

> I may have missed some discussions, but I'm objecting against this patch:
>
> 	b3ec8cdf457e5 ("fbdev: Garbage collect fbdev scrolling acceleration, part 1 (from TODO list)")
>
> Can we please (partly) revert it and restore the scrolling behaviour,
> where fbcon uses fb_copyarea() to copy the screen contents instead of
> redrawing the whole screen?
>
> I'm fine with dropping the ypan-functionality.
>
> Maybe on fast new x86 boxes the performance difference isn't huge,
> but for all old systems, or when emulated in qemu, this makes
> a big difference.
>
> Helge

I second that. For most people, the framebuffer isn't important as
they're mostly interested in getting to X11/wayland as fast as possible.
But for systems like servers without X11 it's nice to have a fast
console.
