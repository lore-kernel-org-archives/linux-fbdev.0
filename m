Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61113C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Feb 2022 13:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354368AbiBNNjc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:39:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbiBNNjc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Feb 2022 08:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F5C4A3CB
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 05:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644845963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0nJAs/QVKzUPfZInqWn93G2x7vjNHkbBF9qYOiGnWA=;
        b=EIM8L2IGNNvknl0PiT4UVjdf6md0DG52BThBD2gbDTOOKnRyRZdAm5JAHSAi2LFwrDUF5V
        rR4Wj++BeSe+w1iREGppfLgf2BvY7AHSha0du8CrMcCQtA6YLmxL2+PSijEBdDL08ia9yQ
        Fl1+eTjhTBV/wbqBBC0i6/nPZvEyCnA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-U0CYydbLOmi6O_3prc4Gfg-1; Mon, 14 Feb 2022 08:39:22 -0500
X-MC-Unique: U0CYydbLOmi6O_3prc4Gfg-1
Received: by mail-wm1-f71.google.com with SMTP id r8-20020a7bc088000000b0037bbf779d26so5010008wmh.7
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 05:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0nJAs/QVKzUPfZInqWn93G2x7vjNHkbBF9qYOiGnWA=;
        b=Hx2kVOxQmzBD9mXZT/k/Ei3p21GIr0/4b9ICSFUeWS8Ci15zB/skOvpliKoC4VMWet
         7jxS9gGr/yxn4LFXwDstmBVj0ecJHBbNFZcmPx6zxWyxtUQWlFmZCnnZw8f7NBweV/Jg
         uzcww568wZ0N6lT9FI+ddL4/0lV5VFlcVq8zS1ROBpq5Pyx6gG27PFMaaaxqbb/uJLZ9
         kB9YPCuJvlgv1vYLEXZLDr6a8PgKuQXg2QkcA/8OmVzmPKf1s1a7brpSt7lK+AMvY3cH
         K12zY1EoscLXiBiyLk5WYGO6eNE9zfvUUO9ZR5rCe98dtJG47XlE5R1mWOAopB3hPb2J
         pvNQ==
X-Gm-Message-State: AOAM532gYwl23h8Gafvtx1tFFb1/wYzhwJJ/ZpZxA8zXaR7lG0/OYkaE
        2hPvk9ILdHNlNiNh+RSFmyqqhFgbfDfavhbIm95IOFs8lUGM5HkN3Wzo0Ub5Uf+pVxBrx68gFib
        hAvc3ETJ5Xc17UFkrRRUVBKc=
X-Received: by 2002:a5d:4652:: with SMTP id j18mr9457905wrs.600.1644845961573;
        Mon, 14 Feb 2022 05:39:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynrCAqmAm2n2lQ+jT84K1ccY7RTWNT1XbLbIiM5V2Tu7Q5FECiZBbqhtjbe/uKekjhMZ/1gA==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr9457887wrs.600.1644845961377;
        Mon, 14 Feb 2022 05:39:21 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n20sm2108941wmq.42.2022.02.14.05.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:39:21 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v6 5/6] MAINTAINERS: Add entry for Solomon SSD130x OLED displays DRM driver
Date:   Mon, 14 Feb 2022 14:39:15 +0100
Message-Id: <20220214133915.3278886-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214133710.3278506-1-javierm@redhat.com>
References: <20220214133710.3278506-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

To make sure that tools like the get_maintainer.pl script will suggest
to Cc me if patches are posted for this driver.

Also include the Device Tree binding for the old ssd1307fb fbdev driver
since the new DRM driver was made compatible with the existing binding.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

(no changes since v5)

Changes in v5:
- Add Andy Shevchenko's Reviewed-by tag to patch #5.

Changes in v3:
- Adapt MAINTAINERS entry to point to the new drivers/gpu/drm/solomon directory.

Changes in v2:
- Add Sam Ravnborg's acked-by to patch adding a MAINTAINERS entry (Sam Ravnborg)

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d03ad8da1f36..05c306986ab0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6102,6 +6102,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/repaper.txt
 F:	drivers/gpu/drm/tiny/repaper.c
 
+DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
+M:	Javier Martinez Canillas <javierm@redhat.com>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+F:	drivers/gpu/drm/solomon/ssd130x*
+
 DRM DRIVER FOR QEMU'S CIRRUS DEVICE
 M:	Dave Airlie <airlied@redhat.com>
 M:	Gerd Hoffmann <kraxel@redhat.com>
-- 
2.34.1

