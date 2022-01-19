Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CEBC433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jan 2022 14:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbiASOBZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jan 2022 09:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354962AbiASOBY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jan 2022 09:01:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBFCC06173F
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jan 2022 06:01:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z22so12045687edd.12
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jan 2022 06:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nBImq/nQkQnpOEWVoZQh94HXj35ecrQ4IXZo3Dyzmw=;
        b=KSHMHMEeC0dv+WHm/tTZDcjCTpmGgJ+2O/Bcj5nqx14TU6rVFm0TYJQNimzbkDNAZn
         R8D5a4s470rm4/0YtqDbW1Uye6IoKCIq7W9dhj78xwaHPlVVV6WmGawx0MQMZTuxkVFU
         HmV0aG6V3m/+6aXvoG0EXnalfyW8QG4N8bJgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nBImq/nQkQnpOEWVoZQh94HXj35ecrQ4IXZo3Dyzmw=;
        b=3iyN0fkHmcAXzdW0Oys8vbgsU+LEHRMQqenynZ4zdc3tUZFeyuxv5OTtp6phKmMFaO
         kZHdZInH77RFf3wJSGdc1v0hibDfKVHuI1xB5//xm+gtl5xFColjCUSIXNAj6KBbBhVh
         nhizau4DCdIUhWaCGzQ/842WKpMmR1AUPR2i9+unhkCE9ZH+QuvNteI2uHr8qMkUpYRi
         myZQIPdXReXjJP/zvrgWLZL5pOeo6Mivm69WHN5uvrXGCrLmwMMbea0lV+3n+OomsOvQ
         qvBGJZwVlN7M2Ykfj76lIivH1v/AxV6SaVGvPVFpxZKs5mhYON+jEDToPYPu1axk0GdB
         T/kA==
X-Gm-Message-State: AOAM533NykSAnnB+egw5dnG4tmGdilmSQeNsBuES8hgUyxEOvZTAvnai
        S+mVDhl0LJX8HBS2Q5ZMsXJFoefg9oLjUrqoGBk=
X-Google-Smtp-Source: ABdhPJxNzsmhecFeKNHzPG/YCy5PIasBRbahjBjtZbkQ2xSXqX/7YsRqalLQ4CDzfueqYbSE6+byMQ==
X-Received: by 2002:a17:906:608:: with SMTP id s8mr26288943ejb.754.1642600882465;
        Wed, 19 Jan 2022 06:01:22 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id m25sm1283701edp.41.2022.01.19.06.01.20
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 06:01:21 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id m4so12106024edb.10
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jan 2022 06:01:20 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr29011574wrh.97.1642600880273;
 Wed, 19 Jan 2022 06:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20220119110839.33187-1-deller@gmx.de> <20220119110839.33187-3-deller@gmx.de>
 <Yef0j8+DBbwC7Kjv@kroah.com> <Yef15k2GtC40aJEu@kroah.com> <CAMuHMdVWFJEDwjf-htZ_D1484efmuPnz_L-qhcTeUE-GVpvZXA@mail.gmail.com>
 <4d8950c7-5f51-ca2b-4c93-741c7805a214@gmx.de>
In-Reply-To: <4d8950c7-5f51-ca2b-4c93-741c7805a214@gmx.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jan 2022 16:01:01 +0200
X-Gmail-Original-Message-ID: <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
Message-ID: <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
To:     Helge Deller <deller@gmx.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 19, 2022 at 2:29 PM Helge Deller <deller@gmx.de> wrote:
>
> >>
> >> Ah, no, that was just the soft scrollback code I was thinking of, which
>
> Right.
> That was commit 973c096f6a85 and it was about vgacon, not fbcon.

No, fbcon had some bug too, although I've paged out the details. See
commit 50145474f6ef ("fbcon: remove soft scrollback code").

If I remember correctly (and it's entirely possible that I don't), the
whole "softback_lines" logic had serious problems with resizing the
console (or maybe changing the font size).

There may have been some other bad interaction with
foreground/background consoles too, I forget.

       Linus
