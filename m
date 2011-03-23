From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 23 Mar 2011 22:35:30 +0000
Subject: viafb clock patches - first round
Message-Id: <1300919734-3931-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

These series contains a first batch of clock/PLL patches. There is 
still a lot to do (and a lot which can't be done due to missing 
documentation) but this should be enough to point in the direction 
we are heading. More PLL values have been allowed (in fact as much 
as can be done without complete documentation for each platform or 
using the knowledge Luc encoded in the Unichrome driver).
A bit restructuring was done to allow later moving the PLL/clock 
things to it's own file. Also code was added to manage PLL source 
and power but is not used yet as it is platform specific (I think) 
and we lack any useful abstraction for it at the moment. Some tests 
were performed to verify the documentation is not completly wrong.

All patches are also available at
	git://github.com/schandinat/linux-2.6.git viafb-pll

and will also show up in linux-next after the early rc's are done.


Thanks,

Florian Tobias Schandinat

