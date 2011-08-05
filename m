From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 05 Aug 2011 21:52:15 +0000
Subject: [PATCH 1/6] viafb: use more compact modesetting functions
Message-Id: <d60defb7b2c05b5c4b187171c09b714b0a00efe9.1312578946.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1312578946.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1312578946.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This patch replaces the old timing setup code with a redesigned one.
The new code might be slightly faster as it has no conditinals and
does not write the same register multiple times. Also it makes the
comparison to the documentation easier.
Regressions are unlikely but could happen as a lot of hardware is
undocumented.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

 drivers/video/via/hw.c              |  296 +----------------------------------
 drivers/video/via/hw.h              |  273 --------------------------------
 drivers/video/via/share.h           |   19 +--
 drivers/video/via/via_modesetting.c |  100 ++++++++++++
 drivers/video/via/via_modesetting.h |   18 ++
 5 files changed, 128 insertions(+), 578 deletions(-)
-- 
1.6.3.2

