Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA75C433E6
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 19:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A3164E68
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 19:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhAaTia (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 14:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhAaTfS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:35:18 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A8C06178B;
        Sun, 31 Jan 2021 09:30:52 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id f63so9988311pfa.13;
        Sun, 31 Jan 2021 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5wzP23ErPEWymRBo16kOdWR6OMTJk3Dg5mRlDwF45M=;
        b=MA1P6sSe/tvl/xNGth0UQ3xw0mCwCUwKzcYbnFlZk0VMO+WcNO/or5FYh85/OjO847
         RVBv/3AuUzEDlVQFFgp/xqZMRzwlcQ0nqYDhhAgzyxfCxGkgJA87Y0GCg6sRHXBr9e/+
         Cgfay9/8nQ25MYannxKkNbiR0vR23vpNIaXauQEjW92KZrSzX8kZQ0/J6ESMsVCtvTJq
         vHxC5a8dszDULQE7vsP2mrdLFmuV8EDcHBQx+HYYcSAY+X1sXMunI2ugIOMl3AZfvDgx
         v7udoYY8R5ztskYwCnNl5UEtuA/DORxTzUuvMQi390UsIa9OYI5+LqDNyG8Xw715Y2US
         CvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5wzP23ErPEWymRBo16kOdWR6OMTJk3Dg5mRlDwF45M=;
        b=Mjkw1JII6a2jXFFzAZPkgp+XQnjnZUcwr1/+Erp73KXws3maNj9enp920sv/OV22nL
         G0PLBwD7xV93RbEsIV6Shw77ZdnW3hQ2REaAVNuqy8rkL+9oJGjdLAWMd0eZQPRjcWG/
         DQ0R+KLLS5wZybqeMrdch534wc5dd0cnx9EDgxA151Ft1oha+pUvoX9kr7Yx8IWDK0Rf
         xOa5aR2sn5W9QijM/qEAVWtT4Rx7iFr1khhwv5KCP9Jz0/gZVFb+cm4/tV3nMOwU9NTs
         g9G9cqw3rU24nbQ+DwdN7sS9HcWCSzIXONmmHTlNi421/xL42s3X5rdU+owzruHSn/eP
         TNVQ==
X-Gm-Message-State: AOAM533oxqRgdhGO3aqdLv31YGZ7qgaKfAMJVuWg6g7PTzVeAmoLBcgP
        K0RpSXYjgt/Lc0Wp1biov5A=
X-Google-Smtp-Source: ABdhPJxqAvDMo/qrnNX2hVoJHZiC2bLwNfcChMrdrFwGXf+D/Pv16veh3L2vYHbiTMOhsalbhu1+dg==
X-Received: by 2002:a63:ec09:: with SMTP id j9mr4194282pgh.179.1612114252401;
        Sun, 31 Jan 2021 09:30:52 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:19dc:4c7b:99d8:200e])
        by smtp.gmail.com with ESMTPSA id w7sm4751206pjv.24.2021.01.31.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:30:51 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        William Cohen <wcohen@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rric@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 00/13] Convert all users of strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:21 +0530
Message-Id: <20210131172838.146706-1-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This series converts all existing users of strlcpy in drivers/staging to use
strscpy instead.

strlcpy is marked as deprecated in Documentation/process/deprecated.rst, and
there is no functional difference when the caller expects truncation (when not
checking the return value). strscpy is relatively better as it also avoids
scanning the whole source string.

This silences the related checkpatch warnings from:
5dbdb2d87c29 ("checkpatch: prefer strscpy to strlcpy")

The conversions were performed in two steps:

1. The following coccinelle script was used to identify and replace call sites
that expect truncation.

$ spatch --sp-file strscpy.cocci --include-headers --dir --in-place drivers/staging

@strscpy@
expression dest, src, size;
@@
-strlcpy(dest, src, size);
+strscpy(dest, src, size);

2. Each individual automated conversion was rechecked manually for correctness.

Kumar Kartikeya Dwivedi (13):
  staging: comedi: Switch from strlcpy to strscpy
  staging: greybus: Switch from strlcpy to strscpy
  staging: fsl-dpaa2: Switch from strlcpy to strscpy
  staging: most: Switch from strlcpy to strscpy
  staging: nvec: Switch from strlcpy to strscpy
  staging: octeon: Switch from strlcpy to strscpy
  staging: olpc_dcon: Switch from strlcpy to strscpy
  staging: rtl8188eu: Switch from strlcpy to strscpy
  staging: rtl8192e: Switch from strlcpy to strscpy
  staging: rtl8192u: Switch from strlcpy to strscpy
  staging: rtl8712: Switch from strlcpy to strscpy
  staging: sm750fb: Switch from strlcpy to strscpy
  staging: wimax: Switch from strlcpy to strscpy

 drivers/staging/comedi/comedi_fops.c                      | 4 ++--
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c           | 6 +++---
 drivers/staging/greybus/audio_helper.c                    | 2 +-
 drivers/staging/greybus/audio_module.c                    | 2 +-
 drivers/staging/greybus/audio_topology.c                  | 6 +++---
 drivers/staging/greybus/power_supply.c                    | 2 +-
 drivers/staging/greybus/spilib.c                          | 4 ++--
 drivers/staging/most/sound/sound.c                        | 2 +-
 drivers/staging/most/video/video.c                        | 6 +++---
 drivers/staging/nvec/nvec_ps2.c                           | 4 ++--
 drivers/staging/octeon/ethernet-mdio.c                    | 6 +++---
 drivers/staging/olpc_dcon/olpc_dcon.c                     | 2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c            | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c           | 6 +++---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c | 2 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c             | 2 +-
 drivers/staging/sm750fb/sm750.c                           | 2 +-
 drivers/staging/wimax/i2400m/netdev.c                     | 6 +++---
 drivers/staging/wimax/i2400m/usb.c                        | 4 ++--
 19 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.29.2

