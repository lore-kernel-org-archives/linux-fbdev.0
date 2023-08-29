Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F46C83F14
	for <linux-fbdev@archiver.kernel.org>; Tue, 29 Aug 2023 16:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbjH2QqR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbjH2Qpy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 29 Aug 2023 12:45:54 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E816C1A1
        for <linux-fbdev@vger.kernel.org>; Tue, 29 Aug 2023 09:45:49 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-64f4ac604c2so23558256d6.1
        for <linux-fbdev@vger.kernel.org>; Tue, 29 Aug 2023 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693327549; x=1693932349;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gd7wbDLNyz8eBHL7fGCPyOOExG5MY/ZyAjupuh5K/2U=;
        b=HaXmMM9EX6NG/E/ePntVX4MvLS/9Bx4fRXcv7ussLeXTZOdZOS/LqfmjBM8ohryTt9
         wvBkhAnaAh9sYZ8KMb9StpU5wQ78P4J//rF2vCmv6OtBEmW4y6c0ZPzOV8Z92s1j465E
         6BJQVeujYC6QBknB+9VhksHfV8vWWR+U56HltBfS8MYs341LnooqP6sfzTMVDYPr7/j5
         5fYnCGD1dMdnL5Tp+f4DSIgcqd59EKNU52fLtXhcp8O8EhE0UZEjnk2CPXe36aIcNIvM
         BV7URAe3NbqVPg1m+61uFXuXgFuaxlMuqD2P2cHRbRALOrQUMeU1ntTM7eY2AQVVmjhM
         ukoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327549; x=1693932349;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gd7wbDLNyz8eBHL7fGCPyOOExG5MY/ZyAjupuh5K/2U=;
        b=K0hOfg6qpUfmrPbi5hRVCcDR57lYPfZieHqygYQoqI9EZGosR9mbLnnav8jsdMxnNE
         do5SckI6/cpX0A6pceMB5wuKjJBnrMuTDf8yAirEM0icEOiFxO5GtHr45smrZiU5NGiE
         vnCp9XwtgggzVbRmu0mZMiMsymlkE6jQROEIrcpdcby7jUWxD53G/XBwVY5GEQVX2R7t
         76umut7Wa0YW7imqAgWdKwsV7QkZ56W6eQc/FdEaHFxNCcLHbIJvlbmn6mPUHcH6ounS
         qn7INRRcVh/oh1gd1FNJPvC7SwYBDaMeDjkOmYUxqQV/FsGQvx/A7Sm02TQzHnDxKzKv
         7Rpw==
X-Gm-Message-State: AOJu0Yy5718ZPIzdqhRCI32Q8DAASPucKidCJMEt7BvkIJkeMThngcK0
        K7swL31b6LdcWg3UcgcaB5cleB9v/C4Cjyh9G9Ccug==
X-Google-Smtp-Source: AGHT+IFMxQxI9GFxNCtBrC7GsH5CSI9yib7ImtOZtC9YNFMY9C889/jaH2b0JivfMTd74M/lUF+8Hsx7eUcoq7MLAFE=
X-Received: by 2002:a0c:e451:0:b0:64f:91de:2ece with SMTP id
 d17-20020a0ce451000000b0064f91de2ecemr7657913qvm.21.1693327548975; Tue, 29
 Aug 2023 09:45:48 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Aug 2023 09:45:38 -0700
Message-ID: <CAKwvOdn0xoVWjQ6ufM_rojtKb0f1i1hW-J_xYGfKDNFdHwaeHQ@mail.gmail.com>
Subject: truncation in drivers/video/fbdev/neofb.c
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Helge,
A recent change in clang made it better about spotting snprintf that
will result in truncation.  Nathan reported the following instances:

drivers/video/fbdev/neofb.c:1959:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
17 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1963:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
18 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1967:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
17 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1971:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
17 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1978:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
18 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1985:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
17 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1992:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
18 [-Wfortify-source]

https://github.com/ClangBuiltLinux/linux/issues/1923

Clang is right here.  `info->fix.id` is declared as `char id[16];` so
indeed string literals like "MagicGraph 256AV+" indeed lead to
truncation. But this is declared in include/uapi/linux/fb.h; I assume
those headers cant be changed? Can the strings be shortened then? Is
it perhaps time to delete this driver?

I see AKPM mentioned alluded to this in
commit 0e90454 ("neofb: avoid overwriting fb_info fields")

(Also, snprintf probably isn't necessary for string literals that
don't contain format strings)
-- 
Thanks,
~Nick Desaulniers
