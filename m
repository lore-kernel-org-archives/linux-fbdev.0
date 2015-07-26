From: Ondrej Zary <linux@rainbow-software.org>
Date: Sun, 26 Jul 2015 21:26:17 +0000
Subject: [PATCH 0/5] gxt4500: Make usable on x86 and fix some bugs
Message-Id: <1437945982-3021-1-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Fire GL2 AGP has GXT6000P and is a x86 card but the gxt4500 driver is
currently limited to PPC.

This patch series makes the driver work on x86 and fixes some color problems.

-- 
Ondrej Zary

