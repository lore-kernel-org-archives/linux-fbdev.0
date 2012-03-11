From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 11 Mar 2012 18:24:57 +0000
Subject: Re: [PATCH] Video : Amba: Use in_interrupt() in clcdfb_sleep().
Message-Id: <20120311182457.29d3e42c@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331471665-22226-1-git-send-email-santoshprasadnayak@gmail.com>
	<20120311132746.GA13336@n2100.arm.linux.org.uk>
	<CAOD=uF7kQHABCmxUL3-J-hZ1E2mXrb7dgsYq7msHhiPJ4Gm-Ew@mail.gmail.com>
	<20120311143615.GB13336@n2100.arm.linux.org.uk>
	<CAOD=uF5GbsyHS5iXjJ1YcqJyGLHwT8Wjhiie1daJAVqu527Umg@mail.gmail.com>
	<20120311150311.GC13336@n2100.arm.linux.org.uk>
	<CAOD=uF5F4tOG0Y2tZdDeMgqs4-46HXYzA3RR-t8KuNuYRarJbg@mail.gmail.com>
	<20120311154846.GD13336@n2100.arm.linux.org.uk>
In-Reply-To: <20120311154846.GD13336@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: santosh prasad nayak <santoshprasadnayak@gmail.com>, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

> As I've said, if we aren't going to use this, then the only solution is
> to completely omit the msleep() there and just say "sod you to running
> anything else for 20ms while this driver busy-spins."  That's
> ultimately the safe thing to do, and at the moment I see no other
> alternative there.

Anyone having this argument is also right now peeing into the wind. Quite
a few console drivers do this including some the big name x86 ones. We
don't seem to be getting any resulting problem reports.

Architecturally we really need a way to help console drivers separate the
civilised acceleration friendly, lock friendly output paths from printk.
That's the real fix, but a whole different matter to solve cleanly.

Alan
