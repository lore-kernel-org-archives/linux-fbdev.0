Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57045C6FD1C
	for <linux-fbdev@archiver.kernel.org>; Sun, 26 Mar 2023 10:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjCZKms (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 26 Mar 2023 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCZKmr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 26 Mar 2023 06:42:47 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09017EDB
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Mar 2023 03:42:42 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by xavier.telenet-ops.be with bizsmtp
        id cyif290091C8whw01yifpp; Sun, 26 Mar 2023 12:42:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pgNox-00Et68-TB;
        Sun, 26 Mar 2023 12:42:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pgNpf-00D0Fi-6J;
        Sun, 26 Mar 2023 12:42:39 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-fbdev@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH fbtest] pnmtohex: Optionally use pkg-config for netpbm
Date:   Sun, 26 Mar 2023 12:42:32 +0200
Message-Id: <20230326104232.3099222-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

As of libnetpbm11 in Debian/Ubuntu, the netpbm header files are no
longer located in the root include directory, but in a netbpm
subdirectory.  Fortunately the same version added support for
pkg-config.

Support both old and new systems by using pkg-config, when available.

Reported-by: Helge Deller <deller@gmx.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Helge: Does this fix the issue for you. I don't have a system with
       libnetpbm11 handy yet.

 Rules.make        | 2 +-
 pnmtohex/Makefile | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Rules.make b/Rules.make
index 51c4e9431699d2f3..b9a098d5e0f409cb 100644
--- a/Rules.make
+++ b/Rules.make
@@ -5,7 +5,7 @@ HOSTCC = gcc
 IFLAGS = -I$(TOPDIR)/include
 #DFLAGS = -g
 OFLAGS = -O3 -fomit-frame-pointer
-CFLAGS = -Wall -Werror $(IFLAGS) $(DFLAGS) $(OFLAGS)
+CFLAGS += -Wall -Werror $(IFLAGS) $(DFLAGS) $(OFLAGS)
 
 SRCS += $(wildcard *.c)
 OBJS += $(subst .c,.o,$(SRCS))
diff --git a/pnmtohex/Makefile b/pnmtohex/Makefile
index d89c8e448db0c527..642a26f0c10c3bc2 100644
--- a/pnmtohex/Makefile
+++ b/pnmtohex/Makefile
@@ -3,9 +3,12 @@ TOPDIR = ..
 
 HOST_TARGET = pnmtohex
 
+CFLAGS += $(shell pkg-config --exists netpbm && pkg-config --cflags netpbm)
+
 # Modern distro's (e.g. Debian, Fedora Core) seem to have -lnetpbm only
 #LIBS += -lnetpnm -lnetpbm -lnetpgm -lnetppm
 LIBS += -lnetpbm
+LIBS += $(shell pkg-config --exists netpbm && pkg-config --libs netpbm)
 
 include $(TOPDIR)/Rules.make
 
-- 
2.34.1

