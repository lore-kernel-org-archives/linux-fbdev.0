From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 27 Mar 2015 19:43:55 +0000
Subject: Re: [PATCH v1 09/47] vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
Message-Id: <CALCETrVfC8aGKuPvaqv3edBADnKKvgDRiKbDvaaOr-HLB7jijg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
 <20150321091514.GA22926@sci.fi> <20150327193813.GH5622@wotan.suse.de>
In-Reply-To: <20150327193813.GH5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, Bjorn Helgaas <bhelgaas@google.com>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 27, 2015 at 12:38 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Sat, Mar 21, 2015 at 11:15:14AM +0200, Ville Syrjälä wrote:
>> On Fri, Mar 20, 2015 at 04:17:59PM -0700, Luis R. Rodriguez wrote:
>> > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
>> > index 8025624..8875e56 100644
>> > --- a/drivers/video/fbdev/aty/atyfb_base.c
>> > +++ b/drivers/video/fbdev/aty/atyfb_base.c
>> > @@ -2630,21 +2630,10 @@ static int aty_init(struct fb_info *info)
>> >
>> >  #ifdef CONFIG_MTRR
>> >     par->mtrr_aper = -1;
>> > -   par->mtrr_reg = -1;
>> >     if (!nomtrr) {
>> > -           /* Cover the whole resource. */
>> > -           par->mtrr_aper = mtrr_add(par->res_start, par->res_size,
>> > +           par->mtrr_aper = mtrr_add(info->fix.smem_start,
>> > +                                     info->fix.smem_len,
>> >                                       MTRR_TYPE_WRCOMB, 1);
>>
>> MTRRs need power of two size, so how is this supposed to work?
>
> As per mtrr_add_page() [0] the base and size are just supposed to be in units
> of 4 KiB, although the practice is to use powers of 2 in *some* drivers this
> is not standardized and by no means recorded as a requirement. Obviously
> powers of 2 will work too and you'd end up neatly aligned as well. mtrr_add()
> will use mtrr_check() to verify the the same requirement. Furthermore,
> as per my commit log message:

Whatever the code may or may not do, the x86 architecture uses
power-of-two MTRR sizes.  So I'm confused.

--Andy

>
> ---
>     The last thing we do must do to remain sane is ensure we
>     use the info->fix.smem_start and info->fix.smem_len for
>     the framebuffer MTRR as we know that is always well adjusted.
>     The *one* concern here would be if the MTRR is not in units
>     of 4K __but__ we already know that in the PCI case this cannot
>     happen, in the shared space setting the MTRR would be up to
>     0x7ff000 and assuming a 4K page:
>
>     ; 0x7ff000 / 0x1000
>         2047
>
>     Also, internally when MTRR is used mtrr_add() will use mtrr_check()
>     and that should splat a warning when the MTRR base and size are
>     not compatible with what is expected for MTRR usage.
> ---
>
> If any of this is too risky we can use the __arch_phys_wc_add() (or as
> Andy suggested perhaps use set_page_* stuff, although I am still evaluating
> this) but I did this change to show the effort required for a change when
> the registers / framebuffer is on the same PCI BAR but at different offsets.
>
> [0] scripts/kernel-doc -man -function mtrr_add_page arch/x86/kernel/cpu/mtrr/main.c | nroff -man | less
>
>   Luis



-- 
Andy Lutomirski
AMA Capital Management, LLC
