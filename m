From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 24 Apr 2011 02:39:21 +0000
Subject: viafb OLPC patches
Message-Id: <1303612763-8852-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This patch series contains OLPC specific patches. One fixes the 
devices connected as seen by the driver and the other is a further 
refresh rate reduction.
Both are required to prevent regressions of the other patch series 
as we increasingly require the information of the driver to be 
correct which (hopefully only on OLPC) is not the case now.

As usual all patches are also available at
	git://github.com/schandinat/linux-2.6.git viafb-olpc

and will soon show up in linux-next.


Thanks,

Florian Tobias Schandinat

