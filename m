Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B717BC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Nov 2021 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhKXPLj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:11:39 -0500
Received: from asav21.altibox.net ([109.247.116.8]:53518 "EHLO
        asav21.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhKXPLj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Nov 2021 10:11:39 -0500
Received: from localhost.localdomain (211.81-166-168.customer.lyse.net [81.166.168.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: noralf.tronnes@ebnett.no)
        by asav21.altibox.net (Postfix) with ESMTPSA id 828228017B;
        Wed, 24 Nov 2021 16:08:18 +0100 (CET)
From:   =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To:     robh+dt@kernel.org, david@lechnology.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dave.stevenson@raspberrypi.com, maxime@cerno.tech,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 0/6] drm/tiny/st7735r: Match up with staging/fbtft driver
Date:   Wed, 24 Nov 2021 16:07:51 +0100
Message-Id: <20211124150757.17929-1-noralf@tronnes.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ZLv5Z0zb c=1 sm=1 tr=0
        a=OYZzhG0JTxDrWp/F2OJbnw==:117 a=OYZzhG0JTxDrWp/F2OJbnw==:17
        a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=Q2Zrx5qe7pKZDP6xzOoA:9
        a=QEXdDO2ut3YA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

This patchset adds a missing piece for decommissioning the
staging/fbtft/fb_st7735r.c driver namely a way to configure the
controller from Device Tree.

All fbtft drivers have builtin support for one display panel and all
other panels using that controller are configured using the Device Tree
'init' property. This property is supported by all fbtft drivers and
provides a generic way to set register values or issue commands
(depending on the type of controller).

It is common for these types of displays to have a datasheet listing the
necessary controller settings/commands or some example code doing the
same.

This is how the panel directly supported by the fb_st7735r staging
driver is described using Device Tree with that driver:

    width = <160>;
    height = <128>;

    init = <0x1000001
            0x2000096
            0x1000011
            0x20000ff
            0x10000B1 0x01 0x2C 0x2D
            0x10000B4 0x07
            0x10000C0 0xA2 0x02 0x84
            0x10000C1 0xC5
            0x10000C2 0x0A 0x00
            0x10000C5 0x0E
            0x100003a 0x55
            0x1000036 0x60
            0x10000E0 0x0F 0x1A 0x0F 0x18 0x2F 0x28 0x20 0x22
                      0x1F 0x1B 0x23 0x37 0x00 0x07 0x02 0x10
            0x10000E1 0x0F 0x1B 0x0F 0x17 0x33 0x2C 0x29 0x2E
                      0x30 0x30 0x39 0x3F 0x00 0x07 0x03 0x10
            0x1000029
            0x2000064>;


This is how the same panel is described using the st7735r drm driver and
this patchset:

    width = <160>;
    height = <128>;

    frmctr1 = [ 01 2C 2D ];
    invctr = [ 07 ];
    pwctr1 = [ A2 02 84 ];
    pwctr2 = [ C5 ];
    pwctr3 = [ 0A 00 ];
    vmctr1 = [ 0E ];
    madctl = [ 60 ];
    gamctrp1 = [ 0F 1A 0F 18 2F 28 20 22 1F 1B 23 37 00 07 02 10 ];
    gamctrn1 = [ 0F 1B 0F 17 33 2C 29 2E 30 30 39 3F 00 07 03 10 ];


Back when the fbtft drivers were added to staging I asked on the DT
mailinglist if it was OK to use the 'init' property but it was turned
down. In this patchset I'm trying the same approach used by the
solomon,ssd1307fb.yaml binding in describing the attached panel. That
binding prefixes the properties with the vendor name, not sure why that
is and I think it looks strange so I try without it.

Noralf.


Noralf Trønnes (6):
  dt-bindings: display: sitronix,st7735r: Fix backlight in example
  dt-bindings: display: sitronix,st7735r: Make reset-gpios optional
  dt-bindings: display: sitronix,st7735r: Remove spi-max-frequency limit
  dt-bindings: display: sitronix,st7735r: Add initialization properties
  drm/mipi-dbi: Add device property functions
  drm: tiny: st7735r: Support DT initialization of controller

 .../bindings/display/sitronix,st7735r.yaml    | 122 ++++++++++++++-
 drivers/gpu/drm/drm_mipi_dbi.c                | 139 ++++++++++++++++++
 drivers/gpu/drm/tiny/st7735r.c                |  87 +++++++++--
 include/drm/drm_mipi_dbi.h                    |   3 +
 4 files changed, 334 insertions(+), 17 deletions(-)

-- 
2.33.0

