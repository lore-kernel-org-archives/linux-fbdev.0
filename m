Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DAFC64ED6
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Mar 2023 13:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCANlp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Mar 2023 08:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCANlo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Mar 2023 08:41:44 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144703E09A
        for <linux-fbdev@vger.kernel.org>; Wed,  1 Mar 2023 05:41:44 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id k17so146873iob.1
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Mar 2023 05:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq5OR9hoC260+bemchGBNuQjrNOZhrK9iuZRCuifkTs=;
        b=RNGjW0fKHBPVSu32cnLyQ80bXdFmMDWGyWr8DyQlkX0JakbZI256w+r+tZD8H5sgLv
         Mv93XNX6nbqefYx/euZAMec/fMtwLa6mGSn4k3ROmTxw2u0ojuqabJH+jtV4tzRPAMKB
         Sf4KhzQY2gByZpvCMeUGD+L6zbuVQ94yycdGRyqLMeZsxotjVaKc1YYEOfw+n4dN1ZvQ
         Fgf2sYQftnkmbDAqBSJbZxAR34gndmTIaEgKOwgBjqv+i0tZaPptUnvevGUMUG3iHXCh
         bev3NxJ2B5iVDweZuR2h4Wenct2gS8Uo/P9mjYJ37PUqnG+cmME2c1cqJdMTE6E2Xg2W
         lHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kq5OR9hoC260+bemchGBNuQjrNOZhrK9iuZRCuifkTs=;
        b=LuurM0gUWr8H5D6oiKpxhwWalrUrPbQMC29DHOqkU4yUlwIWzGs2Xd8REVHCWmBZj1
         sGUAKwBZdUvv+kl35uHLuQZDiJdgjCbpfs7E1CulNS0m8m6xGX+Hgsji4p9pkGRItC0/
         d0tGKkPpcSEv27x2hPhDqgVJ5QCC6rJMJnfXKa87qk9IOakeUDnLY9dqmA7egc6abaL9
         bvaTfXFSbZNShYDzVmyNkv03Xrio3wxetIqz5oF/ElZSraWuvuXSB+anj5PThYaHkKxV
         Tanfv4Ea2YFJ13gi24MInnX/v/ctzv2MSLOxGyWFefuP/dWVglQ2p4r95K4zMG4YECCu
         KiVg==
X-Gm-Message-State: AO0yUKUFus6bg+W0bUc9ysY5Zpzxx324RLmxdZfjfBBQQQy7m0i4sMRt
        uvMIFlJY3JQhgWNg4iIxogydvE6oo041KAL+fONl2w==
X-Google-Smtp-Source: AK7set+BWIITMwStn5iOknYU9Ytckv0R80OlViWQC7TNRL095p3FTuT9mKhGhMd4MFbc9GXISWxJtJVx+O7r52M/2LM=
X-Received: by 2002:a02:85cb:0:b0:3c5:b47:539a with SMTP id
 d69-20020a0285cb000000b003c50b47539amr2818912jai.5.1677678103307; Wed, 01 Mar
 2023 05:41:43 -0800 (PST)
MIME-Version: 1.0
References: <cad03d25-0ea0-32c4-8173-fd1895314bce@I-love.SAKURA.ne.jp>
 <CAMuHMdUH4CU9EfoirSxjivg08FDimtstn7hizemzyQzYeq6b6g@mail.gmail.com>
 <86bdfea2-7125-2e54-c2c0-920f28ff80ce@I-love.SAKURA.ne.jp>
 <CAG_fn=VJrJDNSea6DksLt5uBe_sDu0+8Ofg+ifscOyDdMKj3XQ@mail.gmail.com>
 <Y7a6XkCNTkxxGMNC@phenom.ffwll.local> <032386fc-fffb-1f17-8cfd-94b35b6947ee@I-love.SAKURA.ne.jp>
In-Reply-To: <032386fc-fffb-1f17-8cfd-94b35b6947ee@I-love.SAKURA.ne.jp>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 1 Mar 2023 14:41:06 +0100
Message-ID: <CAG_fn=V4-zzo+6HFG+wCbJRYHRh+Xx=r1weyCBJG-afpaG4Hag@mail.gmail.com>
Subject: Re: [PATCH] fbcon: Use kzalloc() in fbcon_prepare_logo()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

>
> I'd like to avoid touching per-arch asm/string.h files if possible.
>
> Can't we do like below (i.e. keep asm implementations as-is, but
> automatically redirect to __msan_memset()) ? If yes, we could move all
> __msan_*() redirection from per-arch asm/string.h files to the common
> linux/string.h file?
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index c062c581a98b..403813b04e00 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -360,4 +360,15 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
>         return strncmp(str, prefix, len) == 0 ? len : 0;
>  }
>
> +#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
> +#undef memset
> +#define memset(dest, src, count) __msan_memset((dest), (src), (count))
> +#undef memset16
> +#define memset16(dest, src, count) __msan_memset((dest), (src), (count) << 1)
> +#undef memset32
> +#define memset32(dest, src, count) __msan_memset((dest), (src), (count) << 2)
> +#undef memset64
> +#define memset64(dest, src, count) __msan_memset((dest), (src), (count) << 3)
> +#endif

The problem with this approach is that it can only work for
memset/memcpy/memmove, whereas any function that is implemented in
lib/string.c may require undefining the respective __HAVE_ARCH_FNAME
so that KMSAN can instrument it.
