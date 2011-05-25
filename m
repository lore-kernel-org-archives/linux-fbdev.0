From: Anca Emanuel <anca.emanuel@gmail.com>
Date: Wed, 25 May 2011 18:41:40 +0000
Subject: Re: [PATCH] fbmem: fix race condition between register_framebuffer()
Message-Id: <BANLkTi=Q5EzN+wP9jDNCxCnZBQ0XHOmOhQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306266871-12464-1-git-send-email-lxnay@sabayon.org>
	<20110524224545.08c53b1d@neptune.home>
	<20110525181917.12cf97b8@neptune.home>
	<BANLkTimxi-LZFzwv=z6RRBCX098hr-ViUg@mail.gmail.com>
In-Reply-To: <BANLkTimxi-LZFzwv=z6RRBCX098hr-ViUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Erculiani <lxnay@sabayon.org>
Cc: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org

On Wed, May 25, 2011 at 9:17 PM, Fabio Erculiani <lxnay@sabayon.org> wrote:
> I'm not a fbdev expert. So I leave the real fix to real men ( ;-) ).
> It is causing deadlock during boot, so I would consider it quite critical.
> Users using any fb driver will get into troubles.
> The workaround is to boot with vga=normal.

Did you test 2.6.39 ? The fix from Linus is not ok ?
