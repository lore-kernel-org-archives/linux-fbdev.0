Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1187AC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jan 2022 16:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356089AbiASQfF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:35:05 -0500
Received: from outbound3.eu.mailhop.org ([52.29.21.168]:15866 "EHLO
        outbound3.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344646AbiASQfE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jan 2022 11:35:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1642610042; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=Y+tPn/5aEtxkM96TTJjQp1NAuC8n41DwWghKukM5OXiUlxFkzE/4WTiAAY1bxCvncLV7T+tBABLtP
         lz/xjIFbpvLtuRAa6NKKimTUsyvvqkbciekEpueWU0ca4Id8GPKqB5bjHM5pkkffBe8frBjR/ajwXr
         2f0hstN7wgA2jtAO5c12crWwt8X5YwXzzh+Q6E3QOQdOu7NP/qR15TyImgFjIk9AkxJOtCIa3VYPBH
         qw3LIJLJ+SPxHlc5IEOuYhHpRobu20/6lMdGmzjfL+1AmNLPC6wysKjmMtYY9cphfSi3W9ihY/CwE5
         Y4+VPu7jMLdTeYd9UBKm5kbR0RSQpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=7ctqYw8QlI1E1AnvRvotZUK92AmaQDVXBVY1gD/M+fo=;
        b=BGyEodF1TcKUtT5PUOWf0TY4SB5hfTyLq1KjPTRjOyvFhBfftWgdKGf80/uEqK5Cl64yPVgqn3PP8
         a8C/ZWrKVtPm93A1pWMnElIc+wUHX/Xbvjm2FV+DqktccM8ol1hj45jJu9GwsbDGBTV9+phmP/7wYd
         oz7md/cCA0j1Cxy1H4cmcu668GfwdtTVyjbz54w2v8CpW6KJXWkfFhiqPjRmK+mXR4uhPAxduM8IIg
         8OXjPxuRy73p+Dz4jsgTpm8rBPDM5yqQ8tM3lEKlpBXHCE81p112ffY+nN8yv1h0cSTNp4+RgBOq5t
         q4AzO1jhqJ+vUq3uVyi00Niklectb8g==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=7ctqYw8QlI1E1AnvRvotZUK92AmaQDVXBVY1gD/M+fo=;
        b=I075ed2j0VOXU7SjA5CFHcYp23agZYZNqmSTEZVl4M5Ll96QfnUHOTJ77sa3eqtLWYwNNnOtAEf/r
         BJ4RnSCRjmsrc+QpQZjeSpJcCumwW49x2AjoiiGz1Qxdny37F/IOiNE6euw7EQLe4O8Uv92bzfEQGu
         2m0X9l1wyGVV6npY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=7ctqYw8QlI1E1AnvRvotZUK92AmaQDVXBVY1gD/M+fo=;
        b=KcMtmBOzRIe//z92gp6ouawTqh9lOmQP4NxJXMJvEPfXE/Sm0rixUvcRuVKOem3Juoi9QzqfAmoCV
         jvCPja+z7P8qhmcQv6JAuuIA2ksszgjJvltO3N3DkeL+IO8N9UyS3TtXzpDlZW5i0I74Sc/jnUthJh
         NJndDCJq142u7Xn2XzsUHmKXrKO+EAu9J/SrFXqAS+OKN4NSssQ6/k9NV13CGd1a5y5pwomRdL/FOG
         uAw3E7F9wHmEh2IEevqCgGtL6Vbzb5G/bqp9e5EJUtoT2vKZbuIkJ8aiKFpqDiINXTo8++DdUPlC4v
         4pps31XCHHMWMEI+Rl2QuXbnz3aSKlw==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 986eedd9-7945-11ec-9572-95b64d6800c5
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound3.eu.mailhop.org (Halon) with ESMTPSA
        id 986eedd9-7945-11ec-9572-95b64d6800c5;
        Wed, 19 Jan 2022 16:33:56 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1nADuF-0059af-32; Wed, 19 Jan 2022 18:33:55 +0200
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
        <87y23bitvz.fsf@x1.stackframe.org>
        <Yeg6nYZX0/0UUd/N@phenom.ffwll.local>
Date:   Wed, 19 Jan 2022 17:33:53 +0100
In-Reply-To: <Yeg6nYZX0/0UUd/N@phenom.ffwll.local> (Daniel Vetter's message of
        "Wed, 19 Jan 2022 17:21:49 +0100")
Message-ID: <87tudzit1q.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel,

Daniel Vetter <daniel@ffwll.ch> writes:

> On Wed, Jan 19, 2022 at 05:15:44PM +0100, Sven Schnelle wrote:
>> Hi Daniel,
>> 
>> Daniel Vetter <daniel@ffwll.ch> writes:
>> 
>> > On Thu, Jan 13, 2022 at 10:46:03PM +0100, Sven Schnelle wrote:
>> >> Helge Deller <deller@gmx.de> writes:
>> >> > Maybe on fast new x86 boxes the performance difference isn't huge,
>> >> > but for all old systems, or when emulated in qemu, this makes
>> >> > a big difference.
>> >> >
>> >> > Helge
>> >> 
>> >> I second that. For most people, the framebuffer isn't important as
>> >> they're mostly interested in getting to X11/wayland as fast as possible.
>> >> But for systems like servers without X11 it's nice to have a fast
>> >> console.
>> >
>> > Fast console howto:
>> > - shadow buffer in cached memory
>> > - timer based upload of changed areas to the real framebuffer
>> >
>> > This one is actually fast, instead of trying to use hw bltcopy and having
>> > the most terrible fallback path if that's gone. Yes drm fbdev helpers has
>> > this (but not enabled on most drivers because very, very few people care).
>> 
>> Hmm.... Take my Laptop with a 4k (3180x2160) screen as an example:
>> 
>> Lets say on average the half of every line is filled with text.
>> 
>> So 3840/2*2160 pixels that change = 4147200 pixels. Every pixel takes 4
>> bytes = 16,588800 bytes per timer interrupt. In another Mail updating on
>> vsync was mentioned, so multiply that by 60 and get ~927MB. And even if
>> you only update the screen ony 4 times per second, that would be ~64MB
>> of data. I'm likely missing something here.
>
> Since you say 4k it's a modern box, so you have on the order of 10GB/s of
> write bandwidth.
>
> And around 100MB/s of read bandwidth. Both from the cpu. It all adds up.
> It's that uncached read which kills you and means dmesg takes seconds to
> display.
>
> Also since this is 4k looking at sales volume we're talking integrated, so
> whether it's the gpu or the cpu that's doing the memcpy, it's the same
> memory bw budget you're burning down.

That might be true for integrated graphics, as said, i don't know the
architecture. But saying it's good just because it's good on one
architecture doesn't mean it's good for everyone. If you have an
external GPU, than the memory/system bus BW would be different whether
it's memcpy or the GPU doing the scrolling. And whether internal or external
graphics - the CPU could do other stuff while the GPU scrolls stuff.

Quite a lot of discussion for a revert of a patch that was already in
the kernel for more than 20(?) years.

/Sven
