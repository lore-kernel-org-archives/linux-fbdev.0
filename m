Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C62C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Nov 2021 15:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhKXPLk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:11:40 -0500
Received: from asav21.altibox.net ([109.247.116.8]:53540 "EHLO
        asav21.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhKXPLj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Nov 2021 10:11:39 -0500
Received: from localhost.localdomain (211.81-166-168.customer.lyse.net [81.166.168.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: noralf.tronnes@ebnett.no)
        by asav21.altibox.net (Postfix) with ESMTPSA id AB64E801D0;
        Wed, 24 Nov 2021 16:08:20 +0100 (CET)
From:   =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To:     robh+dt@kernel.org, david@lechnology.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dave.stevenson@raspberrypi.com, maxime@cerno.tech,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 1/6] dt-bindings: display: sitronix,st7735r: Fix backlight in example
Date:   Wed, 24 Nov 2021 16:07:52 +0100
Message-Id: <20211124150757.17929-2-noralf@tronnes.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124150757.17929-1-noralf@tronnes.org>
References: <20211124150757.17929-1-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ZLv5Z0zb c=1 sm=1 tr=0
        a=OYZzhG0JTxDrWp/F2OJbnw==:117 a=OYZzhG0JTxDrWp/F2OJbnw==:17
        a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=SJz97ENfAAAA:8
        a=9M2p-XWGhT6DPqkpO5wA:9 a=QEXdDO2ut3YA:10 a=vFet0B0WnEQeilDPIY6i:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The backlight property was lost during conversion to yaml in commit
abdd9e3705c8 ("dt-bindings: display: sitronix,st7735r: Convert to DT schema").
Put it back.

Fixes: abdd9e3705c8 ("dt-bindings: display: sitronix,st7735r: Convert to DT schema")
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 Documentation/devicetree/bindings/display/sitronix,st7735r.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml b/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
index 0cebaaefda03..419c3b2ac5a6 100644
--- a/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
+++ b/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
@@ -72,6 +72,7 @@ examples:
                     dc-gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
                     reset-gpios = <&gpio 80 GPIO_ACTIVE_HIGH>;
                     rotation = <270>;
+                    backlight = <&backlight>;
             };
     };
 
-- 
2.33.0

