From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Wed, 03 Jan 2018 15:23:25 +0000
Subject: Re: [PATCH v3] Fix loading of module radeonfb on PowerMac
Message-Id: <20180103152325.5qu52gc5g5edfp22@csclub.uwaterloo.ca>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479153557-20849-1-git-send-email-malat@debian.org>
 <CGME20171221220824epcas3p1cd1ac40219c9b8bf7be52bc104e31918@epcas3p1.samsung.com>
 <20171221220757.24672-1-malat@debian.org>
 <1565457.zQ5DZdIQMY@amdc3058>
In-Reply-To: <1565457.zQ5DZdIQMY@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mathieu Malaterre <malat@debian.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Wed, Jan 03, 2018 at 03:47:35PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Thursday, December 21, 2017 11:07:56 PM Mathieu Malaterre wrote:
> > When the linux kernel is build with (typical kernel ship with Debian
> > installer):
> > 
> > CONFIG_FB_OF=y
> > CONFIG_VT_HW_CONSOLE_BINDING=y
> > CONFIG_FB_RADEON=m
> > 
> > The offb driver takes precedence over module radeonfb. It is then
> > impossible to load the module, error reported is:
> > 
> > [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> > [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
> > [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> > [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
> > 
> > This patch reproduce the behavior of the module radeon, so as to make it
> > possible to load radeonfb when offb is first loaded.
> > 
> > It should be noticed that `offb_destroy` is never called which explain the
> > need to skip error detection on the radeon side.
> 
> This still needs to be explained more, from my last mail:
> 
> "The last put_fb_info() on fb_info should call ->fb_destroy
> (offb_destroy in our case) and remove_conflicting_framebuffers()
> is calling put_fb_info() so there is some extra reference on
> fb_info somewhere preventing it from going away.
> 
> Please look into fixing this."

My impression of that problem is that the offb driver is in use because
it is running the console, and until the radeonfb driver is loaded and
ready to take over, you can't stop using the offb driver, but you can't
currently load the radeonfb because offb is holding resources it wants.

Maybe I have misunderstood what the code is doing, but that seems to be
the problem.

On an x86 PC you could drop one fb and go to text mode then start another
fb driver.  PPC doesn't have that option since there is no text mode.

-- 
Len Sorensen
