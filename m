From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 03 Jan 2013 14:28:21 +0000
Subject: Re: 3.8-rc2: EFI framebuffer lock inversion...
Message-Id: <20130103142821.2571e2da@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMVG2ssA-B6s+F-g4mL0dbBSVsNupzT1nm1Kc70dXHGsNQuNYA@mail.gmail.com>
	<20130103131156.214bd7a5@pyramind.ukuu.org.uk>
	<CAMVG2sv8p1wFXqOJObfKg9OvyQCsNqw1QmiwXsk7nwZS8ymcbw@mail.gmail.com>
In-Reply-To: <CAMVG2sv8p1wFXqOJObfKg9OvyQCsNqw1QmiwXsk7nwZS8ymcbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel J Blueman <daniel@quora.org>
Cc: Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org, Linux Kernel <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org

> The only patch I could find [1] (mid Nov) looks like it needs another
> sites updating, since we now see an i915 vs efifb lock ordering issue
> [2].
> 
> I can get some time next week to take a look if it helps.

That would be great. I've not got any EFI afflicted hardware and I'm
doing my best to avoid it.

Alan
