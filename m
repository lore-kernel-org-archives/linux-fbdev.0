From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 14:38:44 +0000
Subject: Re: [PATCH] fbdev: Distinguish between interlaced and progressive modes
Message-Id: <1576014.4cjCWdVE3G@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180622183803epcas2p383d0e15368afc6cd983a931b15e4e350@epcas2p3.samsung.com>
 <1828178.vF6XXv5T2I@amdc3058> <20180704190846.GC2701@localhost.localdomain>
In-Reply-To: <20180704190846.GC2701@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fredrik Noring <noring@nocrew.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, "Maciej W. Rozycki" <macro@linux-mips.org>

On Wednesday, July 04, 2018 09:08:48 PM Fredrik Noring wrote:
> Hi Bartlomiej,
> 
> > > With this change fb_find_mode can match interlaced and progressive
> > > modes equally well, and distinguish between for example 1920x1080i
> > > and 1920x1080p.
> > > 
> > > Signed-off-by: Fredrik Noring <noring@nocrew.org>
> > 
> > Could you please give some examples of use cases that need this change
> > (i.e. which fbdev drivers need it for which modes etc.)?
> 
> I discovered the problem when developing a frame buffer driver for the
> PlayStation 2 (not yet merged), using the following video modes for the
> PlayStation 3 in drivers/video/fbdev/ps3fb.c:
> 
>     }, {
> 	/* 1080if */
> 	"1080if", 50, 1920, 1080, 13468, 148, 484, 36, 4, 88, 5,
> 	FB_SYNC_BROADCAST, FB_VMODE_INTERLACED
>     }, {
> 	/* 1080pf */
> 	"1080pf", 50, 1920, 1080, 6734, 148, 484, 36, 4, 88, 5,
> 	FB_SYNC_BROADCAST, FB_VMODE_NONINTERLACED
>     },
> 
> In ps3fb_probe, the mode_option module parameter is used with fb_find_mode
> but it can only select the interlaced variant of 1920x1080 since the loop
> matching the modes does not take the difference between interlaced and
> progressive modes into account.
> 
> In short, without the patch, progressive 1920x1080 cannot be chosen as a
> mode_option parameter since fb_find_mode (falsely) thinks interlace is a
> perfect match.

Patch queued for 4.19 (with the above explanation used as patch description),
thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

