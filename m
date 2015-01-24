From: Scot Doyle <lkml14@scotdoyle.com>
Date: Sat, 24 Jan 2015 01:10:36 +0000
Subject: [RFC PATCH 0/2] fbcon: user-defined cursor blink interval
Message-Id: <alpine.DEB.2.11.1501240109060.3489@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Allow users to set fbcon's cursor blink interval. The current interval
of 200 milliseconds is retained as the default.

Tested with intelfb.

Scot Doyle (2):
  fbcon: store cursor blink interval in fbcon_ops
  fbcon: expose cursor blink interval via sysfs

 drivers/video/console/fbcon.c | 80 +++++++++++++++++++++++++++++++++++++++++--
 drivers/video/console/fbcon.h |  1 +
 2 files changed, 79 insertions(+), 2 deletions(-)

-- 
2.1.4

