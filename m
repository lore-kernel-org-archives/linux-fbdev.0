From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 24 Mar 2011 15:57:28 +0000
Subject: viafb clock patches - second round
Message-Id: <1300983180-7343-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Here are the remaining clock patches which finally put it in a good 
shape. Most of the clock and PLL went into an extra file making the 
codebase more structured. Only the PLL table and related code was 
left out as it is not yet in a desirable state as this table is only 
usable for the X1 source as the limits are frequency dependend.

All patches (including first round) are also available at
	git://github.com/schandinat/linux-2.6.git viafb-pll

and will also show up in linux-nexxt after the early rc's are done.


Thanks,

Florian Tobias Schandinat

