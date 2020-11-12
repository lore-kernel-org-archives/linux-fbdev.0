Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81CDC2D0A3
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76ADC22241
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwyvUEoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgKLMDC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgKLMDB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 12 Nov 2020 07:03:01 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE63C0613D1;
        Thu, 12 Nov 2020 04:03:00 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e21so3977710pgr.11;
        Thu, 12 Nov 2020 04:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/43Y/3X/hoeBtmO8tqJUraisqf0fxkJhB8uqeEFrzsw=;
        b=hwyvUEoF0ZgAg8kegnX9ZqNSfajqoiDUgKk2VSuxnB6ZIVrBYmn3hHEyewkqOvK/7h
         3jNlfSMC4E+cc5ItSQefgb3IhXrpUcAVFR1xsBngAkt1BfO1bY3eF3Tjmv/La4PvF//h
         WNj+GXkq1Hc+Zmc1if00t22HFKQg/nNuAha8Sk2F5v86mE/XxaCwaezwEft6YbONmZQi
         T4DLj78b3cIV9xNiYpOTi8Hi3jsWAdz7vV2VVnENzNO6tq465Tl1NIoUMemqGKo9h43f
         EShLKeu1p0tLur6Gijq9ygdhyCQ48uYH+/UMXwJNI8cBjAlcZEsI95DELrp6maT5ToiT
         Akeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/43Y/3X/hoeBtmO8tqJUraisqf0fxkJhB8uqeEFrzsw=;
        b=lW1B/cuxhmsQ8XAwSNxPoHGH7ZGC1gf06QYEyPoSsqWYW4kKHhyoqzMP7y3P5Z/hox
         QMYpSis37IUPjlbirXkk36fDSgRniTGmIZqTGWg/y5Yi3OC/Rz8giW5aOHpxlaaRNmSL
         IhDV9QIcGJKl+KoEb545WZoZig6A7B7tU9w6sAKZVzgkw7eG5t0GziyBHzLjlfqL5yTg
         3zNKghBipQx9CbbRFsVc0kb7wZK8bgh6c0OVJLH5zNe0z6bw2621kT5bZ9axiaLI7agR
         LF6IidG15hdKAWCGHiBW5ICDzy9lFY+ElMo4aunYAISS9FuK/1Geb0mSUcm0/aQ0Nl6Z
         33dw==
X-Gm-Message-State: AOAM5300urU85JYUvg2OCMjWLDmscvvvxjzQjsFGEO0iQOn8SdpJpL9E
        agEhJJmaiB1IMBFos4zjPw==
X-Google-Smtp-Source: ABdhPJxaZyjPL9SkN0EysVCsBndTodxnZWlLB+Bj+yVl/0dZWbi6ZKNItjLgJglmEO95sB65ql1bUg==
X-Received: by 2002:a63:c34d:: with SMTP id e13mr21802306pgd.22.1605182579963;
        Thu, 12 Nov 2020 04:02:59 -0800 (PST)
Received: from localhost.localdomain ([221.124.243.27])
        by smtp.gmail.com with ESMTPSA id t8sm3729264pje.23.2020.11.12.04.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:02:59 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use FNTCHARCNT() in fbcon.c
Date:   Thu, 12 Nov 2020 07:02:21 -0500
Message-Id: <cover.1605169912.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi all,

This is a collection of some miscellaneous clean-ups for fbcon and some
console drivers. Since v2, I rebased them on linux-next, added some
Reviewed-by: tags from Daniel and Greg, and rewrote the commit messages as
suggested by Jiri. See [1] for v2 links.

It does the following:

  - Garbage collect KD_FONT_OP_COPY callbacks since we disabled it
    recently. Mark it as obsolete.
  - Delete dummy con_font_op() callbacks. (Reviewed by Greg)

  - Add a charcount field to our new font descriptor, `struct font_desc`.
    (Reviewed by Daniel)
  - Do not use a hard-coded 256 for built-in font charcount in
    console/sticore.c, use the new charcount field of `struct font_desc`
    instead. (Reviewed by Daniel)
  - Similarly, in fbcon.c, avoid using the magic negative-indexing macro,
    FNTCHARCNT(). Set `vc->vc_font.charcount` properly and always use that
    instead.

Daniel, hopefully [5/5] removes FNTCHARCNT() for ever, but I have not
tested it sufficiently yet. I remember you mentioned elsewhere that
"fbtest.c" is insufficient for framebuffer testing, then how should we
test it? The first 4 patches should be fine.

Please reference commit messages for more information. Thank you!

[1] v2 links:

2/5: https://lore.kernel.org/lkml/c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com/
3/5: https://lore.kernel.org/lkml/20201028060533.1206307-1-yepeilin.cs@gmail.com/
4/5: https://lore.kernel.org/lkml/c38042bbf5c9777c84900d56c09f3c156b32af48.1603788512.git.yepeilin.cs@gmail.com/
5/5: https://lore.kernel.org/lkml/20201028155139.1220549-1-yepeilin.cs@gmail.com/

Peilin Ye (5):
  console: Delete unused con_font_copy() callback implementations
  console: Delete dummy con_font_set() and con_font_default() callback implementations
  Fonts: Add charcount field to font_desc
  parisc/sticore: Avoid hard-coding built-in font charcount
  fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount

 drivers/usb/misc/sisusbvga/sisusb_con.c | 21 --------
 drivers/video/console/dummycon.c        | 20 --------
 drivers/video/console/sticore.c         |  8 +--
 drivers/video/fbdev/core/fbcon.c        | 68 ++++++++-----------------
 drivers/video/fbdev/core/fbcon_rotate.c |  3 +-
 drivers/video/fbdev/core/tileblit.c     |  4 +-
 include/linux/console.h                 |  1 -
 include/linux/font.h                    |  1 +
 include/uapi/linux/kd.h                 |  2 +-
 lib/fonts/font_10x18.c                  |  1 +
 lib/fonts/font_6x10.c                   |  1 +
 lib/fonts/font_6x11.c                   |  1 +
 lib/fonts/font_6x8.c                    |  1 +
 lib/fonts/font_7x14.c                   |  1 +
 lib/fonts/font_8x16.c                   |  1 +
 lib/fonts/font_8x8.c                    |  1 +
 lib/fonts/font_acorn_8x8.c              |  1 +
 lib/fonts/font_mini_4x6.c               |  1 +
 lib/fonts/font_pearl_8x8.c              |  1 +
 lib/fonts/font_sun12x22.c               |  1 +
 lib/fonts/font_sun8x16.c                |  1 +
 lib/fonts/font_ter16x32.c               |  1 +
 22 files changed, 42 insertions(+), 99 deletions(-)

-- 
2.25.1

