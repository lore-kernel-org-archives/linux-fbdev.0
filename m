Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE06DC43219
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 21:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358067AbiAaVGi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356422AbiAaVGh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:37 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3A3C061714
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m14so27679456wrg.12
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jm2tqChG+6Cl2msdB52h1xzbJ+oW9+NC/C42g3ib0k=;
        b=V36rEEp+ouYAUNQ82bxdkn5P3ZwQiqH7dskiUsOLGI+nChuOAiU1LKuyDpurK3LEf0
         e5/Y8vrIorBlvVcS6pRAaIymj3OXuaa5pr3tcxbawteVa54wRbCrtFTofJ/mCLnXSLJY
         8YIDLEgovB750ZktGu8IC9tQWaJXDtpdUOZFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jm2tqChG+6Cl2msdB52h1xzbJ+oW9+NC/C42g3ib0k=;
        b=p9w+SYTqegCyIYhC0EDvCkfvx/CU2lxMXisPjHhvZct+OQPkGcPWnGWIG9vKF/YJR9
         AEghO72IREwRc0N6GJvp8xtbgHRFNpfC8g+URxKIzQyF/uS15FnHbK/4nAAyGYji8nnx
         2FHfZU3t3Px0TdKgFuyA/Rr931EwaiYsDqQ6nIW/QSAb3zDggC7Y2fhBvIoNh1ymoOXn
         jqkH/Bu4d5nIWp4qks24AQOyjeIDDpNy7wE0d+q6e4iXmn5smnd7/QfUB19p/ob8U0mB
         DWPoCbigNDPDvFlJhJRmQJJYdykQbLg9edtvIfCDmY7E7hQbROZuAlCEY5VMaSvhVYIB
         rYNw==
X-Gm-Message-State: AOAM531+RQpSNqqtrjJvxnWfW5INCDNw8/Q1M+5V1UTq3lZWlWuhD5Wl
        u2WQPgXVNp039Um/QfF1Pj8cNA0EZy7J3g==
X-Google-Smtp-Source: ABdhPJzE6MxfkQjvT5nGD4ugcetBmrXO6zOc6yI6XQCT4PSLXqTsNaSQryY0J+V6FA5cpi73SBd1Dg==
X-Received: by 2002:a5d:64ad:: with SMTP id m13mr19468526wrp.671.1643663195774;
        Mon, 31 Jan 2022 13:06:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:35 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
Date:   Mon, 31 Jan 2022 22:05:32 +0100
Message-Id: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Ever since Tomi extracted the core code in 2014 it's been defacto me
maintaining this, with help from others from dri-devel and sometimes
Linus (but those are mostly merge conflicts):

$ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
    35  Daniel Vetter
    23  Linus Torvalds
    10  Hans de Goede
     9  Dave Airlie
     6  Peter Rosin

I think ideally we'd also record that the various firmware fb drivers
(efifb, vesafb, ...) are also maintained in drm-misc because for the
past few years the patches have either been to fix handover issues
with drm drivers, or caused handover issues with drm drivers. So any
other tree just doesn't make sense. But also, there's plenty of
outdated MAINTAINER entries for these with people and git trees that
haven't been active in years, so maybe let's just leave them alone.
And furthermore distros are now adopting simpledrm as the firmware fb
driver, so hopefully the need to care about the fbdev firmware drivers
will go down going forward.

Note that drm-misc is group maintained, I expect that to continue like
we've done before, so no new expectations that patches all go through
my hands. That would be silly. This also means I'm happy to put any
other volunteer's name in the M: line, but otherwise git log says I'm
the one who's stuck with this.

Cc: Dave Airlie <airlied@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: Sven Schnelle <svens@stackframe.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..49809eaa3096 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7573,6 +7573,12 @@ S:	Maintained
 W:	http://floatingpoint.sourceforge.net/emulator/index.html
 F:	arch/x86/math-emu/
 
+FRAMEBUFFER CORE
+M:	Daniel Vetter <daniel@ffwll.ch>
+F:	drivers/video/fbdev/core/
+S:	Odd Fixes
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+
 FRAMEBUFFER LAYER
 M:	Helge Deller <deller@gmx.de>
 L:	linux-fbdev@vger.kernel.org
-- 
2.33.0

