Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F139C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245E260F5A
	for <linux-fbdev@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhKFVFr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:05:47 -0400
Received: from outbound5i.eu.mailhop.org ([35.156.234.212]:42742 "EHLO
        outbound5i.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbhKFVFr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 6 Nov 2021 17:05:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1636232584; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=to5iLk+2q1vfVlOTuPGvPT6vQTxyEsdvawx04QJafpsvYD6OST5yOjcYRqe30jrRNFaVv8dD/kbdv
         cXVn9PgzRVXQIHoVi6A3M9IiMA2UjecVb0SzRxeeKnn8nvCR6pLUDlQ+eCOgDNe70pv9+CMAx6SODU
         ntYMp41DaGVaz3dtZfP4+aYoOeFO9GnvA6IDFQC82X/ku/qqoG1fQzQmBlD3zbN2AaFpK0m9X3YaZd
         03SuXKKsS3A8uLqF7tE0duJmLSNIlBtq0VpnlAjvNmVWtE1P3VuoCudJd8mvgnBIvViwGfr5a5/OxE
         DkTxfV1Wc31ULzBL3nnDOoJp8AVEqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=0MBGuzUkLcp0R0JFWcdoVV3M1cQOHai/JPSjIYTAT8E=;
        b=mzN9jwicxZdDLtceUZKcpwKopJQkNcWh0HH54H1IzzS2UhD8LTtA20Jh0QHMdkyEgqQPGy69ogThH
         OSxqigGe+TiHpHbspGQk3xEYdL0AbUNf4VtMnBdWgf0815TNTXeTH8vZldBvWNRBVLIwECxVEhgHKq
         JJGFTFjafDOeS3u+4aBwhqh0WNpZGevPnZbC+nv/fqfhCWFx+6EhhsXdHazvMeSkyIdMjJ+mUzHsVJ
         eW85eXTQa4sJKiW6wAv4HEjXr6OfYCfi7pUsvXlY3pdUyyxpnd+OYgGa5t3I8xBKUgnA9h3EKn+NoR
         NUH7Yh5Z2oNGtej2/4+p+nXyAfKZ+0Q==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=0MBGuzUkLcp0R0JFWcdoVV3M1cQOHai/JPSjIYTAT8E=;
        b=MVqmXoMdVPr7cf5dEXFnQGQ/b/K3TFDlLpBsANZKMNOSd426sTwfscBZCL6x1jd0gZrJhBxRLyiVW
         ONmy8o+JB/9pgS/3o+/MLaeLKok+Woick18FiCFiTPN7yfAjOYDCGKILgWPgSddrwFp9G82KxdoR0r
         O+i5scGa9B/PGW2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=0MBGuzUkLcp0R0JFWcdoVV3M1cQOHai/JPSjIYTAT8E=;
        b=kgUMDCynqrfNJUhtOXrwIKd0nM4Bn6P6iH1Jr2BapSnZkpN95suqxlX7GpSy0KmwkRBfgqi3u4PrG
         QDYq+XtE+MRCbO4tyWtERXJr7H1CcNUgzgSPHFScWQuKrS88QYoXmt5XXcdD7NmGx/pQ1AdC5qZ9sn
         Xlb7q9RaM2khbnyly+9Wp8c8DqIU6NADE82Rl5xbMP8MQdILVohmDXo2SB2JNPh6xGcwoNQD7K2SCa
         7xQz04ZwXWJmJHdEKOF8n/bV3LAk820zqo9dD2sk74Xl3y5cRMxRdujTrNw8vYQfRVCeS8kuwOoipJ
         3DHcHHflvS7RxEmjdod+/zGWBugSXXQ==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: ec6f18a5-3f44-11ec-a072-973b52397bcb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound2.eu.mailhop.org (Halon) with ESMTPSA
        id ec6f18a5-3f44-11ec-a072-973b52397bcb;
        Sat, 06 Nov 2021 21:03:00 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1mjSq3-00DrWQ-3h; Sat, 06 Nov 2021 23:02:59 +0200
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
Date:   Sat, 06 Nov 2021 22:02:57 +0100
In-Reply-To: <e21cdf83-2178-7c59-2585-a6012f861f68@suse.de> (Thomas
        Zimmermann's message of "Mon, 1 Nov 2021 10:33:12 +0100")
Message-ID: <87o86x80am.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 01.11.21 um 09:54 schrieb Sven Schnelle:
>> Hi Thomas,
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
> XRGB8888 to 8-bit RGB332 and install a corresponding palette. Don't
> worry, it's easy. Take a look at the cirrus driver for a simple DRM
> driver. [1]

I have converted the driver, but am using FORMAT_C8 because i haven't
figured out yet how to switch the card to XRGB8888. That's still on the
TODO list.

One question about hw blitting: with the old fbdev framework one could
replace the fb_imageblit function. For normal console text, this
function gets called with a monochrome bitmap, and an fg/bg color value.
This makes it easy to use HW accelerated blitting for text. In the
gpu/drm drivers i think i found only one driver (nouveau) doing this and
that was via the drm fbdev layer.

Is that still the way to go, or is there a better way to do HW accelerated
text blitting?

Thanks
Sven
