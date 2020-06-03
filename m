From: Finn Thain <fthain@telegraphics.com.au>
Date: Wed, 03 Jun 2020 00:20:21 +0000
Subject: Re: [PATCH v2 1/2] video: fbdev: amifb: add FIXME about dead APUS support
Message-Id: <alpine.LNX.2.22.394.2006031002550.8@nippy.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <767d36ff-22ec-8136-7ebc-1d9d0d3ac98d@samsung.com>
 <CAMuHMdWac+YE3qr0CTepn5K24tGZq0VHuQDGg-yUOHW1rJDbbg@mail.gmail.com>
 <20200602161225.GJ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200602161225.GJ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, 2 Jun 2020, Al Viro wrote:

> I have done that on aranym (which is how I'd been doing all testing for 
> e.g. signal-related m68k patches) and I've seen references to some 
> out-of-tree qemu variant doing quadra, but nothing for amiga 
> emulators...
> 

Laurent Vivier's Quadra 800 emulation is no longer out of tree. It 
appeared in QEMU v4.2.0 and ethernet support was stabilized in QEMU 
v5.0.0.
