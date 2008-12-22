From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 0/6] [patch 0/6] Atari frame buffer fixes
Date: Mon, 22 Dec 2008 15:24:04 -0800
Message-ID: <20081222152404.dbbe9bbc.akpm@linux-foundation.org>
References: <20081221150059.844577615@mail.of.borg>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20081221150059.844577615@mail.of.borg>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: schmitz@opal.biophys.uni-duesseldorf.de, linux-fbdev-devel@lists.sourceforge.net, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 21 Dec 2008 16:00:59 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> This patchsets contains several fixes for the Atari frame buffer device, and
> includes a refactoring of the c2p (Chunky-to-Planar) code:
>   [1] fbdev: atafb - Fix line length handling
>   [2] fbdev: atafb - Fix 16 bpp console
>   [3] fbdev: c2p - Cleanups
>   [4] fbdev: c2p - Extract common c2p core to c2p_core.h
>   [5] fbdev: c2p/atafb - Add support for Atari interleaved bitplanes
>   [6] fbdev: c2p - Rename c2p to c2p_planar and correct indentation
> 
> If nobody objects, I'd like to push this to Linus via the m68k tree, as the
> c2p code is used by m68k drivers (atafb and amifb) only.
> 

OK by me.

CONFIG_ATAFB_FALCON looks like a serial ATA thing.


