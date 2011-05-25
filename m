From: Fabio Erculiani <lxnay@sabayon.org>
Date: Wed, 25 May 2011 18:17:08 +0000
Subject: Re: [PATCH] fbmem: fix race condition between register_framebuffer()
Message-Id: <BANLkTimxi-LZFzwv=z6RRBCX098hr-ViUg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306266871-12464-1-git-send-email-lxnay@sabayon.org>
	<20110524224545.08c53b1d@neptune.home>
	<20110525181917.12cf97b8@neptune.home>
In-Reply-To: <20110525181917.12cf97b8@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org

I'm not a fbdev expert. So I leave the real fix to real men ( ;-) ).
It is causing deadlock during boot, so I would consider it quite critical.
Users using any fb driver will get into troubles.
The workaround is to boot with vga=normal.

Cheers,
-- 
Fabio Erculiani
