From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 05 Aug 2011 21:55:54 +0000
Subject: [PATCH 3/6] viafb: remove superfluous register unlocking/locking
Message-Id: <c174e3a3cd0594958c9afc6cdb8fbe20780d9c76.1312578946.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1312578946.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1312578946.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

The locking is done within the viafb_set_*_timing functions so there
is no need to do it here. Move a missing hardware reset into the
modesetting function.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

 drivers/video/via/hw.c              |    7 -------
 drivers/video/via/via_modesetting.c |    4 ++++
 2 files changed, 4 insertions(+), 7 deletions(-)
-- 
1.6.3.2

