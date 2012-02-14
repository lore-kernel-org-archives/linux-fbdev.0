From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 14 Feb 2012 12:06:43 +0000
Subject: OMAP DSS warning in apply.c
Message-Id: <20120214120643.GH15338@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org

kautobuildv2 discovered this in its omap4430sdp oldconfig build:

drivers/video/omap2/dss/apply.c:350: warning: 'wait_pending_extra_info_updates' defined but not used

This looks like a valid warning, because wait_pending_extra_info_updates()
seems to be completely unreferenced.  Should the function be removed?
It looks like extra_updated_completion can also be removed as well, as
that function is the only place it gets initialized and waited for.

The function also looks weird - it calls extra_info_update_ongoing() first
under a lock, and then outside the lock.  It's not particularly nice API
wise to have stuff sometimes called under a lock and sometimes not.
