From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 24 Apr 2011 01:57:38 +0000
Subject: viafb clock patches - third round
Message-Id: <1303611201-8727-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This patch series contains basic support for the main IGP clock, 
avoids some double initialization and adds a compatiblity config 
option that ensures that you can still use a (non-fbdev) X server 
which could be otherwise confused by a disable clock/PLL due to the 
viafb power management.

All patches are also available at
	git://github.com/schandinat/linux-2.6.git viafb-pll

and will soon show up in linux-next.


Thanks,

Florian Tobias Schandinat

