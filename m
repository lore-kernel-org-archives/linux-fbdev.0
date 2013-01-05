From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 05 Jan 2013 12:07:29 +0000
Subject: Re: [PATCH] fb: Rework locking to fix lock ordering on takeover
Message-Id: <20130105120729.7677c333@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20121116192606.11799.35711.stgit@localhost.localdomain>
	<CA+5PVA6nKNZY70UoeDUhQo9Rj4Ck+k+XTHL++gwErgzqAdy6Aw@mail.gmail.com>
	<20121121125310.00625f55@pyramind.ukuu.org.uk>
	<CA+5PVA5iQwYOcoSYtLOoRBHaTNJANdv+X-C78474n3SzZg_m9w@mail.gmail.com>
	<CA+1xoqe0G4rha5bDcoQQUcACYbQ8BCO7AE_JE8z5VjJLeNUdyA@mail.gmail.com>
	<CAM_iQpWLgnxQR+oYD+Dnh9NprR1-QLjXa6T+dtHUs3A-_N2wmQ@mail.gmail.com>
	<CA+1xoqf0d5ckDZ3o1-Y+qd61nvVA7EECeH20U+WjDpNVb4E=pw@mail.gmail.com>
	<20121227045301.GB17472@x1.alien8.de>
	<20121228115022.GA28009@S2101-09.ap.freescale.net>
	<20121228124026.GB12918@x1.alien8.de>
	<50E6D01D.6040304@ahsoftware.de>
	<20130104132557.70e0c527@pyramind.ukuu.org.uk>
	<50E6DAC9.802@ahsoftware.de>
	<50E81166.6050605@ahsoftware.de>
In-Reply-To: <50E81166.6050605@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Holler <holler@ahsoftware.de>
Cc: Borislav Petkov <bp@alien8.de>, Shawn Guo <shawn.guo@linaro.org>, Sasha Levin <levinsasha928@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>, Josh Boyer <jwboyer@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Florian Tobias Schandinat <florianSchandinat@gmx.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-fbdev@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, Dave Airlie <airlied@redhat.com>

> So to add such an "I am crap" flag my idea would be to add an 
> .fb_handle_damage to struct fb_ops and then call that (if exists) 
> whenever something was changed.

I was thinking much higher level - ie at the printk kind of level

> My patch (for udlfb) follows as an reply to this message. If that patch 
> is ok, it should be applied to smscufx too (I would make it). In regard 
> to udl I don't know, I haven't had a deeper look at it nor used it up to 
> now.

Looks pretty clean as a solution to me.
