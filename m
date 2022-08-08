Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D06EC00140
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 Aug 2022 10:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbiHHKQ1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 8 Aug 2022 06:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242372AbiHHKQZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 8 Aug 2022 06:16:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF732FD0A
        for <linux-fbdev@vger.kernel.org>; Mon,  8 Aug 2022 03:16:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s9so9295354ljs.6
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Aug 2022 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9X5+OY9C1JUS8+hnV0IE5pgrose61H6CK2ZponbGyzQ=;
        b=EyfrmTnrDXlotODXx82gzFKRsGHHudSI5dBZz7dEPF+vwq5g/VpTEuVygENJLc9MYg
         jkSzsUqmuwtDhKuwCelC1wSm+xTxwXILTvPepVU6oZGefnUrElS8baaEtmnDnDQelyth
         kjoaoE4KmDDWxs28HadN8/MTqZUymyqjEe5+pzFlwYiog9sjBbIXIB3cKPIl+9fXoQvR
         3oyL9iT6JED3JMHn+WN9TMBRDonmkG8Jz6/HxVrmDIpNQMZIAeHoH7AYU8UPAQE2A15b
         0bH5uQiYftr4gt5wYQdr4Czjg73qkzDl/cmud2Ei+QHhZv5KxwRk0brHHV875fnsp3qk
         DQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9X5+OY9C1JUS8+hnV0IE5pgrose61H6CK2ZponbGyzQ=;
        b=Cm/jsKxqPBdOK8E3HCUt4RqlVd5kgeuXsAkD9/vk9i46CbAu4wlgEtnF+X1TNyQavj
         tqk2L3lVAwUykT9htGhN1yAHXNFwv1tjLlzFu/qKGqZpdjSbunUJbD/ekCihmcbDax2d
         t1ysYykOjSzaoqRtW+8sAFkGk1r7i6n1CmtewzeYLH0Yh+A3ntRpzWn5EGkztSBLYKWK
         52hgi3W/WiHts40ZJNcxf4yN2+96FJPEonu9WcEMOIONhjm9f692t3pc5insqX7mf/CD
         3UyywS+Q/oFkhacbeqH55WQMVO4jw01MNFEbXwtTSnpykfOM4EEA57E+/rwHySbQHFmZ
         tfUQ==
X-Gm-Message-State: ACgBeo0sWZuLN4hFLqn/xap7DLXW0UsASMiLhOia0BTee3xw6CheviEw
        V4Q95ebULx5mvjcyKfy6rlS/gg==
X-Google-Smtp-Source: AA6agR4tttRe6G0iEjjBNa15w2EGKbZLas/+/O7VoRN7jyC3KSWWrfglGpmZ0iCybcN82fFC9txRag==
X-Received: by 2002:a2e:9e17:0:b0:25d:78d8:407f with SMTP id e23-20020a2e9e17000000b0025d78d8407fmr5948114ljk.433.1659953782159;
        Mon, 08 Aug 2022 03:16:22 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512070200b0048b193f677dsm1377489lfs.178.2022.08.08.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:16:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] dt-bindings: display: simple-framebuffer: Drop Bartlomiej Zolnierkiewicz
Date:   Mon,  8 Aug 2022 13:15:26 +0300
Message-Id: <20220808101526.46556-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
References: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Bartlomiej's Samsung email address is not working since around last
year and there was no follow up patch take over of the drivers, so drop
the email from maintainers.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I assume that if other change was preferred, there was quite enough of
time to send a patch for this. :)
---
 .../devicetree/bindings/display/simple-framebuffer.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index 27ba4323d221..1f905d85dd9c 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Simple Framebuffer Device Tree Bindings
 
 maintainers:
-  - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
   - Hans de Goede <hdegoede@redhat.com>
 
 description: |+
-- 
2.34.1

