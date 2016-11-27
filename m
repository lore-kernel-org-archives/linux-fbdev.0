From: Adam Borowski <kilobyte@angband.pl>
Date: Sun, 27 Nov 2016 23:53:16 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161127235316.GB29376@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
 <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, andrey_utkin@fastmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

\e[3J works well now, thanks!

I haven't found any more problems; your changes also appear to make no
regressions in at least nouveau fb (which obviously doesn't have this goodie
yet).

Patch 2 doesn't apply cleanly on current Linus' tree but it's just a matter
of more fuzz than "git am" allows.

Tested-by: Adam Borowski <kilobyte@angband.pl>


Meow!
-- 
The bill declaring Jesus as the King of Poland fails to specify whether
the addition is at the top or end of the list of kings.  What should the
historians do?
