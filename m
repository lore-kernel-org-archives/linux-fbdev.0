From: Scot Doyle <lkml14@scotdoyle.com>
Date: Fri, 30 Jan 2015 09:35:13 +0000
Subject: [PATCH v6 0/2] fbcon: user-defined cursor blink interval
Message-Id: <alpine.DEB.2.11.1501300932470.2288@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501300836140.2305@localhost.localdomain> <alpine.DEB.2.11.1501300843200.2423@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.11.1501300843200.2423@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard.weinberger@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Since users prefer different fbcon cursor blink intervals, allow the
interval to be set via sysfs. The current interval of 200 milliseconds
is retained as the default. Tested with intelfb.

v2:  Use kstrtos16() instead of kstrtoul() and min_t() as suggested by
     Geert Uytterhoeven
v3:  Add error messages as suggested by Tomi Valkeinen
v4:  Add rationale into the patches as suggested by Richard Weinberger
v5:  Return error codes instead of logging error messages (my mistake)
v6:  Uncomment the correct line (my mistake again!)

Scot Doyle (2):
  fbcon: store cursor blink interval in fbcon_ops
  fbcon: expose cursor blink interval via sysfs

 drivers/video/console/fbcon.c | 70 +++++++++++++++++++++++++++++++++++++++++--
 drivers/video/console/fbcon.h |  1 +
 2 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.1.4

