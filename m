Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B97FC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Nov 2021 10:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B7160EBC
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Nov 2021 10:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhKAKOR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Nov 2021 06:14:17 -0400
Received: from outbound5g.eu.mailhop.org ([18.156.67.42]:30238 "EHLO
        outbound5g.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhKAKOG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 1 Nov 2021 06:14:06 -0400
X-Greylist: delayed 51395 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 06:14:06 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1635761490; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=klmD5MAIFeOxUWaub7V7oGxwF9IdhdYny/kwMAogcXvPSdnhP1wIF4p2D8hjEC6ZjVX8Edq28rt2v
         uzFxB03jJbS5hTFh0+wFT2jS8vaUi3JetfOONCBcQQtnvdIJe81DzH0xnCmayWc1CB9WPLHqZ32Ads
         m+UnmQIGH7cGQYrauYGpkY1OqJ45ZdJCSUOEvKYnu5vOXxxOiOsNvi1r7Zb0C+hqdgkWiJxuEuXTig
         y742L28NYFYZXOzjU7G0lcmT/ZSMjz1JzjNaEDD3YpvIIN5QYyEP+GaM7R16k8Uj7pXmIQGQARo0K+
         R23krZOD4DtXSfYymaUpuUw9ks434hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=qo6OKJzPQ3GHXEjx4uWdACygWPEVR6iwuI1csc2XXxY=;
        b=qcDMnfNaONS+lPowMVqlVo0xk9q9e3lBr9n38nO2gHojeu/+t3e+1yqZ5D5RlIrWsAOs+tc0sTLXz
         QXpHBoUhHNocqihB35jUaq36kWpEju8ms9dN5KaJaX+rQhZSRZCGjyYR474dbP/5/fs6vqHhAwtJIb
         LVCo/z1yAKKB4I6ZHJ4LtrYh1xLvhRQdmNTntBGF6jY98s6EqCmvIEvffBEzGOMcPJJ/SuMsOihJSK
         k0ogFHxcL8FTlqSXUSjF89iFc8itK2td0S/qw+hVAEx5T1+6UJ9S1y1gvtrD4TIGG1idEKcpzJ8DJm
         buhBC9jlvWk6/UlUwY9ZaVHQTWVCtUg==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=qo6OKJzPQ3GHXEjx4uWdACygWPEVR6iwuI1csc2XXxY=;
        b=FUvOI540IO8bFt9BR0u1hp24YJbSAx2d9o+YtyF0cu35AXOK855TQD7s5+HC0WABD9XnimaRAa3WV
         IMv0OnHfpAuOu2rqfVlMVfiL29NdJ9jBgLmsINjn/8oN1NvjzSZp7GWbSpSVvWrP3+CiB5HOFQ2OP3
         XU2F83hAD7zhQ4xA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=qo6OKJzPQ3GHXEjx4uWdACygWPEVR6iwuI1csc2XXxY=;
        b=ckGeLFW1SVOpGcu9I7un5bAOotVzuRwBmkSJQ/RMHZVtJYGWVO4jXsGA62KduNdIz4Z2hZGDeanyb
         Pigml/UUhH5x2FAVkWmONRvymDzOzrxoFOt1iVVEfBMX4oiHNw8OGj55CcYtrsOWZc16Cbc0YSavnS
         waOMwirjrBxqeebtfIAWL5orV67p7fYEcuaHpOZoO315gd0HjBj5u/puJpCgjQTUwfcH2rdZdw8X0I
         Kw9k8PJf/vTdVhssySNtqZnDCUEV4GlH2cBFMS8a0Pp4Uz1b72o54CppuGdsGUIL5eeCMI/xuF9RIK
         HjPMxE1n+S/0q1YZj5OKo3tOzYH4BJg==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 12a54a57-3afc-11ec-a070-973b52397bcb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound2.eu.mailhop.org (Halon) with ESMTPSA
        id 12a54a57-3afc-11ec-a070-973b52397bcb;
        Mon, 01 Nov 2021 10:11:26 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1mhUHl-00DInm-DH; Mon, 01 Nov 2021 12:11:25 +0200
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
Date:   Mon, 01 Nov 2021 11:11:23 +0100
In-Reply-To: <e21cdf83-2178-7c59-2585-a6012f861f68@suse.de> (Thomas
        Zimmermann's message of "Mon, 1 Nov 2021 10:33:12 +0100")
Message-ID: <87lf28rxro.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Am 01.11.21 um 09:54 schrieb Sven Schnelle:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> Thanks, i wasn't aware as i normally don't do any graphics related
>> development. I take a look at dri and port the driver, which is
>> hopefully not too hard.
>
> Sounds good.
>
> The one big difference when converting is that DRM really wants
> drivers to support 32-bit XRGB colors. It's not a DRM limitation per
> se, but a requirement of today's userspace programs. AFAICS your fbdev
> driver uses a 256-color palette format. So the DRM driver would have
> to convert
> XRGB8888 to 8-bit RGB332 and install a corresponding palette.

Right now the driver only supports 8 bit pseudocolor, because i wanted
to start with something easy to get the kernel fbcon running. I have no
idea (yet) how to switch the card into other color formats. And neither
how to do pseudo color with drm. But i'll figure it out i guess.

> Don't worry, it's easy. Take a look at the cirrus driver for a simple DRM
> driver. [1]

Great, i also picked that driver as a template. :-)

Thanks for your help and pointers, much appreciated!

Sven
