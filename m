From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH 0/2] OMAP: DSS2: Fix DSS core init fail path
Date: Thu,  6 May 2010 14:59:01 +0300
Message-ID: <cover.1273146321.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com, khilman@deeprootsystems.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, ext-jani.1.nikula@nokia.com

Hi -

These patches fix the broken DSS omap_dss_probe() fail path, reported by Kevin
Hilman [1].

Kevin, could you please check this with your setup too? It would be much
appreciated.

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27112.html


BR,
Jani.


Jani Nikula (2):
  OMAP: DSS2: omap_dss_probe() conditional compilation cleanup
  OMAP: DSS2: Fix omap_dss_probe() error path

 drivers/video/omap2/dss/core.c |   85 ++++++++++++++++++++++++---------------
 drivers/video/omap2/dss/dss.h  |   40 +++++++++++++++++++
 2 files changed, 92 insertions(+), 33 deletions(-)

