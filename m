From: Scot Doyle <lkml14@scotdoyle.com>
Date: Mon, 26 Jan 2015 20:37:46 +0000
Subject: [PATCH v3 0/2] fbcon: user-defined cursor blink interval
Message-Id: <alpine.DEB.2.11.1501262034380.1945@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Allow users to set fbcon's cursor blink interval. The current interval
of 200 milliseconds is retained as the default. Tested with intelfb.

v2:  Use kstrtos16() instead of kstrtoul() and min_t() as suggested by
     Geert Uytterhoeven
v3:  Add error messages as suggested by Tomi Valkeinen


Scot Doyle (2):
  fbcon: store cursor blink interval in fbcon_ops
  fbcon: expose cursor blink interval via sysfs

 drivers/video/console/fbcon.c | 84 +++++++++++++++++++++++++++++++++++++++++--
 drivers/video/console/fbcon.h |  1 +
 2 files changed, 83 insertions(+), 2 deletions(-)

-- 
2.1.4

