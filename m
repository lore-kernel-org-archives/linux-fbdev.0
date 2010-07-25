From: Marcin Slusarz <marcin.slusarz@gmail.com>
Date: Sun, 25 Jul 2010 11:54:24 +0000
Subject: Re: [Nouveau] [PATCH v2] vga16fb: refuse to load in face of other
Message-Id: <20100725115424.GA2837@joi.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100720191923.GA11056@joi.lan>
 <20100722172039.e935c67d.akpm@linux-foundation.org>
 <20100723131034.GA6618@joi.lan>
 <AANLkTimQZ6_+o=3pGa6hGbeFU99RMPFRmO+ndMZDHZMS@mail.gmail.com>
In-Reply-To: <AANLkTimQZ6_+o=3pGa6hGbeFU99RMPFRmO+ndMZDHZMS@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sun, Jul 25, 2010 at 06:42:48PM +1000, Dave Airlie wrote:
> On Fri, Jul 23, 2010 at 11:10 PM, Marcin Slusarz
> <marcin.slusarz@gmail.com> wrote:
> > On Thu, Jul 22, 2010 at 05:20:39PM -0700, Andrew Morton wrote:
> >> On Tue, 20 Jul 2010 21:19:23 +0200
> >> Marcin Slusarz <marcin.slusarz@gmail.com> wrote:
> >>
> >> > We don't want vga16fb to mess with hardware initialized by other driver.
> >> > Detect it and refuse to load.
> >> > It fixes nouveau interrupt storm on some machines.
> 
> Can't we keep this all inside vga16fb? 

That's what v1 did (*), but Andrew didn't like it.

> just have it walk PCI tree
> looking for a primary VGA card, and if it has a driver bound, just
> refuse to bind.
> 
> Dave.

(*) http://lkml.org/lkml/2010/7/20/244

