From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Fri, 13 Mar 2015 21:31:28 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150313223128.2a3a682e@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
	<20150207111821.GN2079@lukather>
	<20150207163541.30047a33@maestro.intranet>
	<20150212151121.GJ2079@lukather>
	<20150214152212.1643da7d@maestro.intranet>
	<54FED559.2030506@ti.com>
In-Reply-To: <54FED559.2030506@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org

Am Tue, 10 Mar 2015 13:28:25 +0200
schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:

> On 14/02/15 16:22, Thomas Niederprüm wrote:
> > Am Thu, 12 Feb 2015 16:11:21 +0100
> > schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
> > 
> >> On Sat, Feb 07, 2015 at 04:35:41PM +0100, Thomas Niederprüm wrote:
> >>> Am Sat, 7 Feb 2015 12:18:21 +0100
> >>> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
> >>>
> >>>> Hi,
> >>>>
> >>>> On Fri, Feb 06, 2015 at 11:28:10PM +0100,
> >>>> niederp@physik.uni-kl.de wrote:
> >>>>> From: Thomas Niederprüm <niederp@physik.uni-kl.de>
> >>>>>
> >>>>> It makes sense to use vmalloc to allocate the video buffer
> >>>>> since it has to be page aligned memory for using it with mmap.
> >>>>
> >>>> Please wrap your commit log at 80 chars.
> >>>
> >>> I'll try to do so in future, sorry for that.
> >>>
> >>>>
> >>>> It looks like there's numerous fbdev drivers using this
> >>>> (especially since you copy pasted that code, without mentionning
> >>>> it).
> >>>
> >>> Yes, I should have mentioned that in the commit message. As
> >>> implicitly indicated in the cover letter the rvmalloc() and
> >>> rvfree() are copy pasted from the vfb driver. Honestly, I didn't
> >>> give this one too much thought. It seemed a viable solution to the
> >>> mmap problem. For a bit more history on that, see my comment
> >>> below.
> >>>
> >>>>
> >>>> That should be turned into an allocator so that drivers all get
> >>>> this right.
> >>>>
> >>>>> Also deffered io seems buggy in combination with kmalloc'ed
> >>>>> memory (crash on unloading the module).
> >>>>
> >>>> And maybe that's the real issue to fix.
> >>>
> >>> The problem is solved by using vmalloc ;)
> >>
> >> Yep, but why do you need to mark the reserved pages?
> >>
> >> ...
> > 
> > As far as I understood mmaped memory is marked as userspace memory
> > in the page table and is therefore subject to swapping. The pages
> > are marked reserved to make clear that this memory can not be
> > swapped and thus lock the pages in memory. See discussions [0,1,2]. 
> 
> Why is it a problem if it is swapped? Only CPU uses the memory, as far
> as I can see.

It seems to be no problem at all. I was copying the allocation code
from the vfb driver. The memory is no longer marked as reserved from
v2 on.

> Also, isn't doing __pa() for the memory returned by vmalloc plain
> wrong?

> What was the crash about when using kmalloc? It would be good to fix
> defio, as I don't see why it should not work with kmalloced memory.

The main challenge here is that the memory handed to userspace upon
mmap call needs to be page aligned. The memory returned by kmalloc has
no such alignment, but the pointer presented to the userspace program
gets aligned to next page boundary. It's not clear to me whether there
is an easy way to obtain page aligned kmalloc memory. Memory
allocated by vmalloc on the other hand is always aligned to page
boundaries. This is why I chose to go for vmalloc.

Thomas
