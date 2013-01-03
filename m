From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 03 Jan 2013 19:40:47 +0000
Subject: Re: 3.8-rc2: EFI framebuffer lock inversion...
Message-Id: <CA+55aFyseLhQj-u7XOdCayMN2dJ+LaKKxSN2NrfqFA98o1WW+A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMVG2ssA-B6s+F-g4mL0dbBSVsNupzT1nm1Kc70dXHGsNQuNYA@mail.gmail.com>
 <20130103131156.214bd7a5@pyramind.ukuu.org.uk>
In-Reply-To: <20130103131156.214bd7a5@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel J Blueman <daniel@quora.org>, Peter Jones <pjones@redhat.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, nouveau@lists.freedesktop.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Jan 3, 2013 at 5:11 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> The fb layer locking was broken. I posted patches early December which
> should have fixed the ones we know about. ('fb: Rework locking to fix
> lock ordering on takeover').

That patch causes compile errors with "allmodconfig":

  ERROR: "do_take_over_console" [drivers/video/console/fbcon.ko] undefined!
  make[1]: *** [__modpost] Error 1
  make: *** [modules] Error 2
  make: *** Waiting for unfinished jobs....

Hmm?

               Linus
