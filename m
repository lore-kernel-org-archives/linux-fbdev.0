From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Thu, 12 Jan 2017 12:54:57 +0000
Subject: [PATCH RESEND 0/2] DEC frame buffer modular driver cleanups
Message-Id: <alpine.LFD.2.20.1701120212430.19339@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

 This is a pair of small cleanups for `__init' annotation issues in PMAG-B 
and PMAGB-B frame buffer drivers discovered in a modular build, which is a 
seldom used, but supported configuration.

 Resending this series now that the framebuffer subsystem is looked after 
again (thanks for your commitment!); please apply.

  Maciej
