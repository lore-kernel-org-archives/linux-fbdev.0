From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 05 Aug 2011 21:59:16 +0000
Subject: [PATCH 6/6] viafb: remove 640x480-60 CRT special case
Message-Id: <0492262281b82e71c6063e35ef73a33fad93cc6d.1312578946.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1312578946.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1312578946.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

The timing for 640x480-60 was handled different than all others.
This patch changes this by changing the blanking start and end.
The reason for this is that I can't find any reason for the old
behaviour and it was not consistent anyway as the special case for
LCD did not always trigger as the LCD code does not use this
function and it did trigger regardless of whether the display set is
CRT or LCD but only based whether any DVI/LCD device exists.
There are no negative effects observed for CRT or DVI devices.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

 drivers/video/via/hw.c      |   14 --------------
 drivers/video/via/viamode.c |    2 +-
 2 files changed, 1 insertions(+), 15 deletions(-)
-- 
1.6.3.2

