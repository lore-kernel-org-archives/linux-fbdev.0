From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 09 Apr 2015 19:51:27 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <2137270.OOdtDiT2H4@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd> <552660C7.4020805@ti.com> <552663C2.70308@ti.com>
In-Reply-To: <552663C2.70308-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, shc_work-JGs/UdohzUI@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org, Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

On Thursday 09 April 2015 14:34:26 Tomi Valkeinen wrote:
> On 09/04/15 14:21, Tomi Valkeinen wrote:
> > On 09/04/15 14:06, Pavel Machek wrote:
> >> On Tue 2015-04-07 14:19:33, Geert Uytterhoeven wrote:
> >>> Hi Pavel,
> >>>
> >>> On Tue, Apr 7, 2015 at 2:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >>>> I have an socfpga board, which uses has simple framebuffer implemented
> >>>> in the FPGA. On 3.15, framebuffer is fast:
> >>>>
> >>>> root@wagabuibui:~# time cat /dev/fb0 > /dev/null
> >>>> real               0m 0.00s
> >>>> user               0m 0.00s
> >>>> sys                0m 0.00s
> >>>>
> >>>> on 3.18, this takes 220msec. Similar slowdown exists for
> >>>> writes. Simple framebuffer did not change at all between 3.15 and
> >>>> 3.18; resource flags of the framebuffer are still same (0x200).
> >>>>
> >>>> If I enable caching on 3.18, it speeds up a bit, to 70msec or
> >>>> so... Which means problem is not only in caching.
> >>>>
> >>>> Any ideas?
> >>>
> >>> My first guess was  commit 67dc0d4758e5 ("vt_buffer: drop console buffer
> >>> copying optimisations"), but this was introduced only in v4.0-rc1.
> >>>
> >>> Just in case you encounter another performance regression after upgrading
> >>> to a more modern kernel 
> >>
> >> :-). I did a git bisect, and it pointed to this. And reverting it
> >> indeed fixes the problem in 3.18. Problem is still there in 4.0.
> 
> The difference is probably caused by memcpy() vs memcpy_fromio(). The
> comment above memcpy_fromio() says "This needs to be optimized". I think
> generally speaking memcpy_fromio() is correct for a framebuffer.
> 
> That said, if the fb is in RAM, and is only written by the CPU, I think
> a normal memcpy() for fb_memcpy_fromfb() should be fine...

Could memcpy() cause alignment traps here if the fb pointer is unaligned
and uncached?

	Arnd
