From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Jul 2010 15:39:16 +0000
Subject: [PATCH 01/11] MAINTAINERS: update viafb entry
Message-Id: <1279899566-4359-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>, Jonathan Corbet <corbet@lwn.net>, Harald Welte <laforge@gnumonks.org>

MAINTAINERS: update viafb entry

List the files that got recently moved to include/linux.
Add myself as a maintainer and remove Scott as his email address is
no longer valid and he has shown no interest in maintaining viafb.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Harald Welte <laforge@gnumonks.org>
---
 MAINTAINERS |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index db3d0f5..a402bf4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6152,9 +6152,12 @@ F:	drivers/mmc/host/via-sdmmc.c
 
 VIA UNICHROME(PRO)/CHROME9 FRAMEBUFFER DRIVER
 M:	Joseph Chan <JosephChan@via.com.tw>
-M:	Scott Fang <ScottFang@viatech.com.cn>
+M:	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 L:	linux-fbdev@vger.kernel.org
 S:	Maintained
+F:	include/linux/via-core.h
+F:	include/linux/via-gpio.h
+F:	include/linux/via_i2c.h
 F:	drivers/video/via/
 
 VIA VELOCITY NETWORK DRIVER
-- 
1.6.3.2

