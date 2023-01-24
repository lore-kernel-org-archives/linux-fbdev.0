Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9AEC54EED
	for <linux-fbdev@archiver.kernel.org>; Tue, 24 Jan 2023 22:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjAXWmG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 24 Jan 2023 17:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjAXWmF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 24 Jan 2023 17:42:05 -0500
Received: from out-166.mta0.migadu.com (out-166.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5AC4EE7
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Jan 2023 14:42:02 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674600121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oAapRs/RO6y9QOzK9GfRl6P67ERhquKIA38gdlc10UE=;
        b=F9hZW2m6lNyDvtRi0AzaKisYqewyHLR/1ADPdWh9FhsKqTvl8q/VaU1PJCfMsfSO+w6IEi
        tmbTPlUrATcShnkvCa3+ReiVF8V3IWzypuX0RdOvvjlr89FUZ9mK+lsSCBFTuC3NkUns5p
        fPnXDh78TFNKytnOHgLrCjkhIAcbAPY=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Rayyan Ansari <rayyan@ansari.sh>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 0/2] SimpleDRM: allow configuring physical width and height
Date:   Tue, 24 Jan 2023 22:41:40 +0000
Message-Id: <20230124224142.7133-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

The following patches:
- Add support for configuring the width-mm and height-mm DRM mode
  properties in the SimpleDRM driver via Device Tree
- Document these two new Device Tree properties

This is useful for allowing interfaces such as Phosh to calculate
proper scaling values and for early boot code knowing if hi-dpi
rendering is necessary.

Changes since v2:
- Remove $ref property (because it is an SI unit)
- Extend commit messages

Rayyan Ansari (2):
  drm/simpledrm: Allow physical width and height configuration via DT
  dt-bindings: display: simple-framebuffer: Document physical width and
    height properties

 .../bindings/display/simple-framebuffer.yaml  |  6 ++
 drivers/gpu/drm/tiny/simpledrm.c              | 60 ++++++++++++++++---
 2 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.39.1

