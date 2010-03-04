From: "stanley.miao" <stanley.miao@windriver.com>
Subject: vdds_dsi doesn't exist on all omap3430 arch chip
Date: Thu, 04 Mar 2010 18:29:10 +0800
Message-ID: <4B8F8B76.9050807@windriver.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi, Tomi,

The commit below:
http://www.gitorious.org/linux-omap-dss2/linux/commit/ec70668fa99b2dd0d305fbdb451a728f2e2a4c58
doesn't apply to ti_omap_am3517. There is no "vdds_dsi" on am3517.

Stanley.

