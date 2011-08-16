From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 16 Aug 2011 07:22:25 +0000
Subject: [ANNOUNCE] fbdev maintainer change
Message-Id: <4E4A1AB1.6040001@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

Hi all,

as Paul hasn't been able to catch up with the patches lately and as already 
about half of the development cycle passed I decided to take over maintaining 
the fbdev subsystem, at least for now. So please send all patches you want to go 
mainline via fbdev also directly to me in addition to sending them to linux-fbdev.
Please help me to avoid picking up outdated, buggy versions of your patches by 
resending your final, bug-free ;) version if they are not already included in 
3.1-rc2. I'll be on vacation for a week now, so do not expect immediate 
response, I just wanted to give you some time to polish your patches. When I'm 
back I'll start setting up a fbdev-next branch, probably based on 3.1-rc3, and 
adding your patches to it. So feel free to drown me in patches.
I want to say thanks to Paul for his work, as well as all those people who made 
the fbdev subsystem such a great thing during the past decades and to those who 
are still working to make it even better.


Thanks and happy coding,

Florian Tobias Schandinat
