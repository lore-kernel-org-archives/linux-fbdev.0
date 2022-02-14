Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F71BC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Feb 2022 09:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiBNJFf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Feb 2022 04:05:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiBNJFf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Feb 2022 04:05:35 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B25FF14
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 01:05:28 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id n14so8586571vkk.6
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 01:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACc7MhlmQaRHyX1iGzVS1S3D+ci69MdBwNfaRqsmbHE=;
        b=YZhu6SEE8QalJqWI8Ep+I5vQMwIdKru3ikif2s6e4GzXlfnm1ySAH4bvSbCq23LZWk
         zexP01ECfYXX6kn2GDVfuZNqb4fPZiDziTwyHc4Di3jRMopeEGuJNratbOSsJkY0DFQb
         BK+8WMPJKox1M7lo9BQDgm1KPeXJfm34FMQ9n6yckEZ1Ca+s1xUfRWH3IdamKOMcp7sV
         Rt9fkyv+ew3LQSXIti/8I9Pgg7TYy8h7yBx4XvoRsoDBxv6mp//hPCNrAq57AwChaLnh
         tRlPuNyx+1AtE+W0poyIVpf4mYygKTH9bImPt3Q/R+Ixp1foVOBl5EPCZWicVNLVqQVn
         If7w==
X-Gm-Message-State: AOAM530OstqNwPd0PQKv7she6Swn5M1YyoPs5PnsjXIRyHkZZUc/6ft5
        3HEPNCRIkiRPg6EW0JHqjwn0xe7v/RsnXA==
X-Google-Smtp-Source: ABdhPJyA602pYytcQyOCGJAPRAlQ9+dXXAs37NoMpMRt4dtxeDihW3TA2IhJlfP4vPU9TO2SDMzhcw==
X-Received: by 2002:a05:6122:9a8:: with SMTP id g40mr3681130vkd.15.1644829527033;
        Mon, 14 Feb 2022 01:05:27 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id q131sm2273535vkq.23.2022.02.14.01.05.26
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 01:05:26 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id e5so456908vsg.12
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 01:05:26 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr936716vsb.5.1644829525839;
 Mon, 14 Feb 2022 01:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20220210141111.5231-1-tzimmermann@suse.de> <20220210141111.5231-3-tzimmermann@suse.de>
 <CAMuHMdVb1JjZkEo-PM6DTXOywcmJDRr0a=Ci94DJCj7dXbbihw@mail.gmail.com> <9b2e2649-1511-66a3-b346-60863de788fc@suse.de>
In-Reply-To: <9b2e2649-1511-66a3-b346-60863de788fc@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 10:05:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPw8UcTVown3Zghxn11-WuqSBNCWKpP3T5NUxxZmntcA@mail.gmail.com>
Message-ID: <CAMuHMdWPw8UcTVown3Zghxn11-WuqSBNCWKpP3T5NUxxZmntcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fbdev: Don't sort deferred-I/O pages by default
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, deller@gmx.de,
        linux-staging@lists.linux.dev, javierm@redhat.com,
        dri-devel@lists.freedesktop.org, bernie@plugable.com,
        noralf@tronnes.org, andriy.shevchenko@linux.intel.com,
        jayalk@intworks.biz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Mon, Feb 14, 2022 at 9:28 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 14.02.22 um 09:05 schrieb Geert Uytterhoeven:
> > On Thu, Feb 10, 2022 at 4:24 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Fbdev's deferred I/O sorts all dirty pages by default, which incurs a
> >> significant overhead. Make the sorting step optional and update the few
> >> drivers that require it. Use a FIFO list by default.
> >>
> >> Sorting pages by memory offset for deferred I/O performs an implicit
> >> bubble-sort step on the list of dirty pages. The algorithm goes through
> >> the list of dirty pages and inserts each new page according to its
> >> index field. Even worse, list traversal always starts at the first
> >> entry. As video memory is most likely updated scanline by scanline, the
> >> algorithm traverses through the complete list for each updated page.
> >>
> >> For example, with 1024x768x32bpp a page covers exactly one scanline.
> >> Writing a single screen update from top to bottom requires updating
> >> 768 pages. With an average list length of 384 entries, a screen update
> >> creates (768 * 384 =) 294912 compare operation.
> >
> > What about using folios?
> > If consecutive pages are merged into a single entry, there's much less
> > (or nothing in the example above) to sort.
>
> How would the code know that? Calls to page_mkwrite happen
> pagefault-by-pagefault in any order AFAICT.

fb_deferred_io_mkwrite() would still be called for a page, but an
adjacent page can be merged with an existing entry while adding it
to the list.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
