From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 03 Jan 2013 20:06:03 +0000
Subject: Re: 3.8-rc2: EFI framebuffer lock inversion...
Message-Id: <20130103120603.6f8e94a7.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMVG2ssA-B6s+F-g4mL0dbBSVsNupzT1nm1Kc70dXHGsNQuNYA@mail.gmail.com>
	<20130103131156.214bd7a5@pyramind.ukuu.org.uk>
	<CA+55aFyseLhQj-u7XOdCayMN2dJ+LaKKxSN2NrfqFA98o1WW+A@mail.gmail.com>
In-Reply-To: <CA+55aFyseLhQj-u7XOdCayMN2dJ+LaKKxSN2NrfqFA98o1WW+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel J Blueman <daniel@quora.org>, Peter Jones <pjones@redhat.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, nouveau@lists.freedesktop.org, Linux Kernel <linux-kernel@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Thu, 3 Jan 2013 11:40:47 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jan 3, 2013 at 5:11 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> > The fb layer locking was broken. I posted patches early December which
> > should have fixed the ones we know about. ('fb: Rework locking to fix
> > lock ordering on takeover').
> 
> That patch causes compile errors with "allmodconfig":
> 
>   ERROR: "do_take_over_console" [drivers/video/console/fbcon.ko] undefined!
>   make[1]: *** [__modpost] Error 1
>   make: *** [modules] Error 2
>   make: *** Waiting for unfinished jobs....
> 
> Hmm?

I have a couple of fixes against
fb-rework-locking-to-fix-lock-ordering-on-takeover.patch:

http://ozlabs.org/~akpm/mmots/broken-out/fb-rework-locking-to-fix-lock-ordering-on-takeover-fix.patch
http://ozlabs.org/~akpm/mmots/broken-out/fb-rework-locking-to-fix-lock-ordering-on-takeover-fix-2.patch

Florian has been busy for a month or two - I've been waiting for him to
reappear to consider this patch.
