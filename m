From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] fb_defio: generic write support
Date: Fri, 26 Dec 2008 11:58:05 +0900
Message-ID: <aec7e5c30812251858x1df4701fv6f3650ca650a6f13@mail.gmail.com>
References: <12302345513642-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <12302345513642-git-send-email-jayakumar.lkml@gmail.com>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org

Hi Jaya,

On Fri, Dec 26, 2008 at 4:49 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> This patch implements generic write support that can be used by deferred IO
> client drivers. It reuses the same deferred IO callback mechanism in existing
> client drivers and uses the pagelist to inform the client driver which pages
> were modified in the write call. It should be possible to extend this same
> method to imageblit/copyarea/fillrect as well. metronomefb's write has been
> removed in favour of using this mechanism. This patch depends on Magnus'
> patchset to add defio support for dma/kmalloc-ed memory.
>
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

Good plan, I agree that having more fine grained dirty page handling
makes sense. However, if this or a dirty rectangle is better
performance wise is not so clear. I'd say that for the write()
operation this pagelist modification makes sense, but for
fillrect/copyarea/imageblit it becomes more complicated since we
depend on video mode all of a sudden. But maybe that's a non-issue.

In my mind, the best strategy is to look at drivers and see which
interface they need:

- hecubafb: full frames
- sh_mobile_lcdcfb: full frames
- metronomefb: pages
- xen-fbfront: area

Basically we have three different requirements. For full frames the
struct page handling is just plain overhead. So is any dirty area
handling code. Just having the deferred io callback by itself is
enough for the full frame type of drivers. Metronomefb would be very
happy to just receive pages. And xen just a dirty area, unless I'm
misunderstanding the code. The sh_mobile_lcdc hardware also supports
partial screen update, so more fine grained dirty area/page handling
is doable there as well.

I suggest adding a flag variable and two flags that enable the
pagelist and the dirty area. The full frame drivers keep the flags
unset to get improved performance (no need to traverse the pagelist
anymore) and the other drivers can select which modes that should be
enabled depending on the hardware requirements.

Or just have a single flag enabling the pagelist, and provide helper
code for area based drivers that converts dirty pages to rectangles
suitable for that type of hardware. The latter may be a bit too
complicated though.

This may be a good first step in the right direction though. I'd like
to add code on top of this that disables the pagelist handling for
full frame drivers though. Any thoughts?

Cheers,

/ magnus
