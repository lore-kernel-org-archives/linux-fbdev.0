Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B71C61DA3
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Jan 2023 18:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjAZSY6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 Jan 2023 13:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjAZSYx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 Jan 2023 13:24:53 -0500
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED33D59B46
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Jan 2023 10:24:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
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
Subject: [PATCH v4 0/2] SimpleDRM: allow configuring physical width and height
Date:   Thu, 26 Jan 2023 18:24:33 +0000
Message-Id: <20230126182435.70544-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes since v3:
- Use panel node

Rayyan Ansari (2):
  drm/simpledrm: Allow physical width and height configuration via panel
    node
  dt-bindings: display: simple-framebuffer: Document the panel node

 .../bindings/display/simple-framebuffer.yaml  |  9 ++++++
 drivers/gpu/drm/tiny/simpledrm.c              | 32 +++++++++++++------
 2 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.39.1

