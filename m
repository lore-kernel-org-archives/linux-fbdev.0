From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Date: Fri, 21 Aug 2015 08:48:07 +0000
Subject: Re: omapdss: Division by zero in kernel
Message-Id: <20150821084807.GD27391@pali>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201507241803.42891@pali>
 <55D6E466.5060706@ti.com>
In-Reply-To: <55D6E466.5060706@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

On Friday 21 August 2015 11:42:14 Tomi Valkeinen wrote:
> 
> 
> On 24/07/15 19:03, Pali Rohár wrote:
> > Hello,
> > 
> > when on N900 (real HW or qemu) I run this command
> > 
> > / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo 0 > /sys/class/graphics/fb0/size
> > 
> > then kernel crash with this error message
> > 
> > / # [   29.904113] Division by zero in kernel.
> 

Hi! Thanks for explaining.

> The problem is that fb console uses the kernel mmapped framebuffer, but
> omapfb is not aware of the fb console. So the above commands free the
> framebuffer, as omapfb thinks no one is using it, and then fb console
> tries to touch the fb.
> 

What about refusing those calls from fb console? So fb console will not
know about this problem and omapfb will just ignore drawn functions?

> omapfb tracks mmaps from userspace, and refuses to free a fb it it's
> mmapped.
> 
> I don't know how to fix it straight away. Maybe there's a way for omapfb
> to check if the fbcon uses the fb in question, and if so, refuses to
> release/resize the memory.
> 
>  Tomi
> 

Maemo userspace (on Nokia N900) uses above commands to initialize
graphic and Xserver. So it would be nice if disabling framebuffer would
work even if fbcon.ko is loaded (or compiled directly into zImage).

-- 
Pali Rohár
pali.rohar@gmail.com
