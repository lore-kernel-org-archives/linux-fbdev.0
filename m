From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] fb_defio: generic write support
Date: Sun, 28 Dec 2008 01:01:00 +0800
Message-ID: <45a44e480812270901r4cda5477v86479aec62d0ba4a@mail.gmail.com>
References: <12302345513642-git-send-email-jayakumar.lkml@gmail.com>
	 <aec7e5c30812251858x1df4701fv6f3650ca650a6f13@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <aec7e5c30812251858x1df4701fv6f3650ca650a6f13@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org

On Fri, Dec 26, 2008 at 10:58 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Jaya,
>
> On Fri, Dec 26, 2008 at 4:49 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> This patch implements generic write support that can be used by deferred IO
>> client drivers. It reuses the same deferred IO callback mechanism in existing
>> client drivers and uses the pagelist to inform the client driver which pages
>> were modified in the write call. It should be possible to extend this same
>> method to imageblit/copyarea/fillrect as well. metronomefb's write has been
>> removed in favour of using this mechanism. This patch depends on Magnus'
>> patchset to add defio support for dma/kmalloc-ed memory.
>>
>> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
>
> Good plan, I agree that having more fine grained dirty page handling
> makes sense. However, if this or a dirty rectangle is better
> performance wise is not so clear. I'd say that for the write()
> operation this pagelist modification makes sense, but for
> fillrect/copyarea/imageblit it becomes more complicated since we

Yes, you're right.

> depend on video mode all of a sudden. But maybe that's a non-issue.

I think your original insight is correct, it can be complicated to
translate between pages and the structures used for the
fillrect/copyarea/imageblit operations.

>
> In my mind, the best strategy is to look at drivers and see which
> interface they need:
>
> - hecubafb: full frames

hecubafb uses pages. oh wait, I see, I had posted a patch to support
pages but I never got it merged. I'll put that on the todo list.

> - sh_mobile_lcdcfb: full frames
> - metronomefb: pages
> - xen-fbfront: area
>
> Basically we have three different requirements. For full frames the
> struct page handling is just plain overhead. So is any dirty area
> handling code. Just having the deferred io callback by itself is
> enough for the full frame type of drivers. Metronomefb would be very

Agreed.

> happy to just receive pages. And xen just a dirty area, unless I'm
> misunderstanding the code. The sh_mobile_lcdc hardware also supports
> partial screen update, so more fine grained dirty area/page handling
> is doable there as well.
>
> I suggest adding a flag variable and two flags that enable the
> pagelist and the dirty area. The full frame drivers keep the flags
> unset to get improved performance (no need to traverse the pagelist
> anymore) and the other drivers can select which modes that should be
> enabled depending on the hardware requirements.

Yes, this sounds reasonable.

>
> Or just have a single flag enabling the pagelist, and provide helper
> code for area based drivers that converts dirty pages to rectangles
> suitable for that type of hardware. The latter may be a bit too
> complicated though.

I think I agree that conversion routines would start getting messy and
require hardware specific knowledge in which case, I think we might as
well leave it for the drivers to do.

>
> This may be a good first step in the right direction though. I'd like
> to add code on top of this that disables the pagelist handling for
> full frame drivers though. Any thoughts?

Sounds like a reasonable plan. However, I think you're planning to do
page support in sh_mobile and hecubafb should be page based so that
would indicate there won't be any full frame drivers in the long term,
right? That said, I think its still valuable to have that code to make
that a possible option.

Thanks,
jaya
