From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 05 Aug 2011 21:58:06 +0000
Subject: [PATCH 4/6] viafb: remove superfluous mode lookup
Message-Id: <9ee3ec49e268c7a01217d7865c53562fae1edf33.1312578946.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1312578946.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1312578946.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

As the result is not used anywhere there is no need to perform the
lookup at all.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

 drivers/video/via/viafbdev.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)
-- 
1.6.3.2

