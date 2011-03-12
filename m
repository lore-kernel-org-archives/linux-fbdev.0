From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 12 Mar 2011 21:46:22 +0000
Subject: viafb clock/PLL patches
Message-Id: <1299966386-3439-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This patch series contains major changes in the way clocks are 
managed. A lot of duplicated and inaccurate values were removed and 
the behaviour for clocks without an exact match was improved. This 
causes some calculation overhead on each mode change but should 
allow easier extension and have always a behaviour that is at least
as good as the old one but is much saner for some clocks.

This will allow 
- easier adding of modes
- using generic mode tables
- easier adding of PLL configs
- generate PLL values on-the-fly
- use different clock sources


Best regards,

Florian Tobias Schandinat

