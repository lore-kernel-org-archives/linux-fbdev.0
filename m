Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EFDC4332F
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Nov 2021 15:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhKXPLk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:11:40 -0500
Received: from asav21.altibox.net ([109.247.116.8]:53556 "EHLO
        asav21.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhKXPLj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Nov 2021 10:11:39 -0500
Received: from localhost.localdomain (211.81-166-168.customer.lyse.net [81.166.168.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: noralf.tronnes@ebnett.no)
        by asav21.altibox.net (Postfix) with ESMTPSA id 0B6CF801D8;
        Wed, 24 Nov 2021 16:08:21 +0100 (CET)
From:   =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To:     robh+dt@kernel.org, david@lechnology.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dave.stevenson@raspberrypi.com, maxime@cerno.tech,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 2/6] dt-bindings: display: sitronix,st7735r: Make reset-gpios optional
Date:   Wed, 24 Nov 2021 16:07:53 +0100
Message-Id: <20211124150757.17929-3-noralf@tronnes.org>
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
        a=ps_H7J5NogAP3zF6LHEA:9 a=QEXdDO2ut3YA:10 a=vFet0B0WnEQeilDPIY6i:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

There are other ways than using a gpio to reset the controller so make
this property optional.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 Documentation/devicetree/bindings/display/sitronix,st7735r.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml b/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
index 419c3b2ac5a6..f81d0d0d51fe 100644
--- a/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
+++ b/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
@@ -48,7 +48,6 @@ required:
   - compatible
   - reg
   - dc-gpios
-  - reset-gpios
 
 additionalProperties: false
 
-- 
2.33.0

