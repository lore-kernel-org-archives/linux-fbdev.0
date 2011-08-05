From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 05 Aug 2011 21:55:17 +0000
Subject: [PATCH 2/6] viafb: kill viafb_load_crtc_timing
Message-Id: <f18e3e0ce0dacca497e3f1547095b3f9b111b0f7.1312578946.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1312578946.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1312578946.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This patch replaces calls to viafb_load_crtc_timing with the code.
This should make it easier to fix the oddity that in the modetable
the blank and sync end entries contain the length and we need to add
the start values to get those to be written to the hardware.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

 drivers/video/via/hw.c  |   30 ++++++++----------------------
 drivers/video/via/lcd.c |   41 +++++++++++++++++++----------------------
 drivers/video/via/lcd.h |    2 --
 3 files changed, 27 insertions(+), 46 deletions(-)
-- 
1.6.3.2

