From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 05 Aug 2011 21:58:55 +0000
Subject: [PATCH 5/6] viafb: simplify viafb_fill_crtc_timing
Message-Id: <92746c3c82135b13d7fb1bbdebbabb0faedd8433.1312578946.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1312578946.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1312578946.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

As the first argument is just part of the structure passed as the
second argument there is no need for it at all.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

 drivers/video/via/dvi.c |    6 ++----
 drivers/video/via/hw.c  |   12 ++++++------
 drivers/video/via/hw.h  |    4 ++--
 3 files changed, 10 insertions(+), 12 deletions(-)
-- 
1.6.3.2

