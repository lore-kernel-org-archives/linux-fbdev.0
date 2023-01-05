Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7366EC3DA7A
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Jan 2023 11:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjAELyN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Jan 2023 06:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjAELyM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 Jan 2023 06:54:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072225833D
        for <linux-fbdev@vger.kernel.org>; Thu,  5 Jan 2023 03:54:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso1110314wmp.3
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Jan 2023 03:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6MBIVunY5Es/Vsno0Ti7SjeLYrcFtxWJO9vkWYEimAw=;
        b=d20voggvW8bY264c+MJZO3kIBYQRuWZAB8xMhIbdxdgEqmDeAXW2WLRpKHPN2PusgI
         uPxhatVntbERslFC13z06n6Y5L7N6pQrQEjeYyhkO3Vy0KV7DeULvkdplYtvP2Pwckp6
         MwgxqEAD+sFGb1CK9G/MkddSsWn6123r4SSUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MBIVunY5Es/Vsno0Ti7SjeLYrcFtxWJO9vkWYEimAw=;
        b=KEOPXYvAuwSJpX/FKRB9l2wSjCJnQimgoP9vV59Vzv3g6TlK86Sz4xm7ohqTu9RqV4
         tqsSzpZxJRLkKmM/mSjT1i7X1B9tW6fprMyYwBk13lQu53Qt+XUFekCLpYQZ0Gx+2Eop
         cxrpTbgMspBi/WBCBB4YxQrDKPTQYswA3LMPJo1NhhhMPbOv2z7EsAR5gtNRk3SRyhgw
         Jw6GLkaJ6MZtG3yhbvsCp3CKQNsewCVCOqDvoV+EdThssi9P/gjm00OeElLufglA+lL/
         U3pA848m5RZZj4zrYVsDKnmMrSwkX0E59ygJx6eRQGrzQ5OWluexa85ML5tNeDVp0/bw
         23xw==
X-Gm-Message-State: AFqh2kqWXM3sVpR9ihti0tlqL6VzfpMV0ZawqRqm8LwzJfNNMsJUS7Qi
        QVA1mDn+ElVbf2Nxe6zsGPXPVw==
X-Google-Smtp-Source: AMrXdXu7JKgKphJXPI9rFE7WNG9WOKj+U55a+Gxj4Xin4d1nBnrgtW3PXTSzwJZ6Lp/30VcTbrbzVQ==
X-Received: by 2002:a05:600c:54c6:b0:3d3:4ead:bb07 with SMTP id iw6-20020a05600c54c600b003d34eadbb07mr35857240wmb.5.1672919649608;
        Thu, 05 Jan 2023 03:54:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c4fcb00b003c6f3f6675bsm2374456wmq.26.2023.01.05.03.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 03:54:08 -0800 (PST)
Date:   Thu, 5 Jan 2023 12:54:06 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Alexander Potapenko <glider@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbcon: Use kzalloc() in fbcon_prepare_logo()
Message-ID: <Y7a6XkCNTkxxGMNC@phenom.ffwll.local>
Mail-Followup-To: Alexander Potapenko <glider@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cad03d25-0ea0-32c4-8173-fd1895314bce@I-love.SAKURA.ne.jp>
 <CAMuHMdUH4CU9EfoirSxjivg08FDimtstn7hizemzyQzYeq6b6g@mail.gmail.com>
 <86bdfea2-7125-2e54-c2c0-920f28ff80ce@I-love.SAKURA.ne.jp>
 <CAG_fn=VJrJDNSea6DksLt5uBe_sDu0+8Ofg+ifscOyDdMKj3XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=VJrJDNSea6DksLt5uBe_sDu0+8Ofg+ifscOyDdMKj3XQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Dec 16, 2022 at 04:52:14PM +0100, Alexander Potapenko wrote:
> On Fri, Dec 16, 2022 at 3:03 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2022/12/15 18:36, Geert Uytterhoeven wrote:
> > > The next line is:
> > >
> > >         scr_memsetw(save, erase, array3_size(logo_lines, new_cols, 2));
> > >
> > > So how can this turn out to be uninitialized later below?
> > >
> > >         scr_memcpyw(q, save, array3_size(logo_lines, new_cols, 2));
> > >
> > > What am I missing?
> >
> > Good catch. It turned out that this was a KMSAN problem (i.e. a false positive report).
> >
> > On x86_64, scr_memsetw() is implemented as
> >
> >         static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
> >         {
> >                 memset16(s, c, count / 2);
> >         }
> >
> > and memset16() is implemented as
> >
> >         static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
> >         {
> >                 long d0, d1;
> >                 asm volatile("rep\n\t"
> >                              "stosw"
> >                              : "=&c" (d0), "=&D" (d1)
> >                              : "a" (v), "1" (s), "0" (n)
> >                              : "memory");
> >                 return s;
> >         }
> >
> > . Plain memset() in arch/x86/include/asm/string_64.h is redirected to __msan_memset()
> > but memsetXX() are not redirected to __msan_memsetXX(). That is, memory initialization
> > via memsetXX() results in KMSAN's shadow memory being not updated.
> >
> > KMSAN folks, how should we fix this problem?
> > Redirect assembly-implemented memset16(size) to memset(size*2) if KMSAN is enabled?
> >
> 
> I think the easiest way to fix it would be disable memsetXX asm
> implementations by something like:
> 
> -------------------------------------------------------------------------------------------------
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 888731ccf1f67..5fb330150a7d1 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -33,6 +33,7 @@ void *memset(void *s, int c, size_t n);
>  #endif
>  void *__memset(void *s, int c, size_t n);
> 
> +#if !defined(__SANITIZE_MEMORY__)
>  #define __HAVE_ARCH_MEMSET16
>  static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
>  {
> @@ -68,6 +69,7 @@ static inline void *memset64(uint64_t *s, uint64_t
> v, size_t n)
>                      : "memory");
>         return s;
>  }
> +#endif

So ... what should I do here? Can someone please send me a revert or patch
to apply. I don't think I should do this, since I already tossed my credit
for not looking at stuff carefully enough into the wind :-)
-Daniel

> 
>  #define __HAVE_ARCH_MEMMOVE
>  #if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
> -------------------------------------------------------------------------------------------------
> 
> This way we'll just pick the existing C implementations instead of
> reinventing them.
> 
> 
> -- 
> Alexander Potapenko
> Software Engineer
> 
> Google Germany GmbH
> Erika-Mann-Straße, 33
> 80636 München
> 
> Geschäftsführer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
