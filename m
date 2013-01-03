From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 03 Jan 2013 13:11:56 +0000
Subject: Re: 3.8-rc2: EFI framebuffer lock inversion...
Message-Id: <20130103131156.214bd7a5@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMVG2ssA-B6s+F-g4mL0dbBSVsNupzT1nm1Kc70dXHGsNQuNYA@mail.gmail.com>
In-Reply-To: <CAMVG2ssA-B6s+F-g4mL0dbBSVsNupzT1nm1Kc70dXHGsNQuNYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel J Blueman <daniel@quora.org>
Cc: Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org, Linux Kernel <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org

On Thu, 3 Jan 2013 20:56:30 +0800
Daniel J Blueman <daniel@quora.org> wrote:

> On 3.8-rc2 with lockdep enabled and dual-GPU setup (Macbook Pro
> Retina), I see two releated lock inversion issues with the EFI
> framebuffer, leading to possible deadlock: when X takes over from the
> EFI framebuffer [1] and when nouveau releases the framebuffer when
> being vgaswitcherood [2].
> 
> Let me know if you'd like any testing or analysis when I can get the time.

The fb layer locking was broken. I posted patches early December which
should have fixed the ones we know about. ('fb: Rework locking to fix
lock ordering on takeover').

Alan
