From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 02 Apr 2015 00:04:08 +0000
Subject: Re: [PATCH v1 09/47] vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
Message-Id: <CALCETrWLBCp7vseAUYRjiM3h5fvO-jB6zc0qGsSCiJ6Pr3eQaA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
 <20150321091514.GA22926@sci.fi> <20150327193813.GH5622@wotan.suse.de>
 <CALCETrVfC8aGKuPvaqv3edBADnKKvgDRiKbDvaaOr-HLB7jijg@mail.gmail.com>
 <20150327195759.GK5622@wotan.suse.de> <20150327215655.GA29933@sci.fi>
 <CALCETrWW9WrE_4x6SctQQBe=zXp1yMQ1i=qtsACTnHV0_Ku2iQ@mail.gmail.com>
 <20150328002818.GT5622@wotan.suse.de> <20150328122334.GA32543@sci.fi> <20150401235211.GV5622@wotan.suse.de>
In-Reply-To: <20150401235211.GV5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, Bjorn Helgaas <bhelgaas@google.com>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Wed, Apr 1, 2015 at 4:52 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Sat, Mar 28, 2015 at 02:23:34PM +0200, Ville Syrjälä wrote:
>> On Sat, Mar 28, 2015 at 01:28:18AM +0100, Luis R. Rodriguez wrote:
>> > On Fri, Mar 27, 2015 at 03:02:10PM -0700, Andy Lutomirski wrote:
>> > > On Fri, Mar 27, 2015 at 2:56 PM, Ville Syrjälä <syrjala@sci.fi> wrote:
>> > > > On Fri, Mar 27, 2015 at 08:57:59PM +0100, Luis R. Rodriguez wrote:
>> > > >> On Fri, Mar 27, 2015 at 12:43:55PM -0700, Andy Lutomirski wrote:
>> > > >> > On Fri, Mar 27, 2015 at 12:38 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>> > > >> > > On Sat, Mar 21, 2015 at 11:15:14AM +0200, Ville Syrjälä wrote:
>> > > >> > >> On Fri, Mar 20, 2015 at 04:17:59PM -0700, Luis R. Rodriguez wrote:
>> > > >> > >> > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
>> > > >> > >> > index 8025624..8875e56 100644
>> > > >> > >> > --- a/drivers/video/fbdev/aty/atyfb_base.c
>> > > >> > >> > +++ b/drivers/video/fbdev/aty/atyfb_base.c
>> > > >> > >> > @@ -2630,21 +2630,10 @@ static int aty_init(struct fb_info *info)
>> > > >> > >> >
>> > > >> > >> >  #ifdef CONFIG_MTRR
>> > > >> > >> >     par->mtrr_aper = -1;
>> > > >> > >> > -   par->mtrr_reg = -1;
>> > > >> > >> >     if (!nomtrr) {
>> > > >> > >> > -           /* Cover the whole resource. */
>> > > >> > >> > -           par->mtrr_aper = mtrr_add(par->res_start, par->res_size,
>> > > >> > >> > +           par->mtrr_aper = mtrr_add(info->fix.smem_start,
>> > > >> > >> > +                                     info->fix.smem_len,
>> > > >> > >> >                                       MTRR_TYPE_WRCOMB, 1);
>> > > >> > >>
>> > > >> > >> MTRRs need power of two size, so how is this supposed to work?
>> > > >> > >
>> > > >> > > As per mtrr_add_page() [0] the base and size are just supposed to be in units
>> > > >> > > of 4 KiB, although the practice is to use powers of 2 in *some* drivers this
>> > > >> > > is not standardized and by no means recorded as a requirement. Obviously
>> > > >> > > powers of 2 will work too and you'd end up neatly aligned as well. mtrr_add()
>> > > >> > > will use mtrr_check() to verify the the same requirement. Furthermore,
>> > > >> > > as per my commit log message:
>> > > >> >
>> > > >> > Whatever the code may or may not do, the x86 architecture uses
>> > > >> > power-of-two MTRR sizes.  So I'm confused.
>> > > >>
>> > > >> There should be no confusion, I simply did not know that *was* the
>> > > >> requirement for x86, if that is the case we should add a check for that
>> > > >> and perhaps generalize a helper that does the power of two helper changes,
>> > > >> the cleanest I found was the vesafb driver solution.
>> > > >>
>> > > >> Thoughts?
>> > > >
>> > > > The vesafb solution is bad since you'll only end up covering only
>> > > > the first 4MB of the framebuffer instead of the almost 8MB you want.
>> > > > Which in practice will mean throwing away half the VRAM since you really
>> > > > don't want the massive performance hit from accessing it as UC. And that
>> > > > would mean giving up decent display resolutions as well :(
>> > > >
>> > > > And the other option of trying to cover the remainder with multiple ever
>> > > > smaller MTRRs doesn't work either since you'll run out of MTRRs very
>> > > > quickly.
>> > > >
>> > > > This is precisely why I used the hole method in atyfb in the first
>> > > > place.
>> > > >
>> > > > I don't really like the idea of any new mtrr code not supporting that
>> > > > use case, especially as these things tend to be present in older machines
>> > > > where PAT isn't an option.
>> > >
>> > > According to the Intel SDM, volume 3, section 11.5.2.1, table 11-6,
>> > > non-PAT CPUs that have a WC MTRR, PCD = 1, and PWT = 1 (aka UC) have
>> > > an effective memory type of UC.
>
> This is true but non-PAT systems that use just ioremap() will default to
> _PAGE_CACHE_MODE_UC_MINUS, not _PAGE_CACHE_MODE_UC, and _PAGE_CACHE_MODE_UC_MINUS
> on Linux has PCD = 1, PWT = 0. The list comes from:
>
> uint16_t __cachemode2pte_tbl[_PAGE_CACHE_MODE_NUM] = {
>         [_PAGE_CACHE_MODE_WB      ]     = 0         | 0        ,
>         [_PAGE_CACHE_MODE_WC      ]     = _PAGE_PWT | 0        ,
>         [_PAGE_CACHE_MODE_UC_MINUS]     = 0         | _PAGE_PCD,
>         [_PAGE_CACHE_MODE_UC      ]     = _PAGE_PWT | _PAGE_PCD,
>         [_PAGE_CACHE_MODE_WT      ]     = 0         | _PAGE_PCD,
>         [_PAGE_CACHE_MODE_WP      ]     = 0         | _PAGE_PCD,
> };
>
> This can better be read here:
>
>  PAT
>  |PCD
>  ||PWT
>  |||
>  000 WB          _PAGE_CACHE_MODE_WB
>  001 WC          _PAGE_CACHE_MODE_WC
>  010 UC-         _PAGE_CACHE_MODE_UC_MINUS
>  011 UC          _PAGE_CACHE_MODE_UC
>
> On x86 ioremap() defaults to ioremap_nocache() and right now that uses
> _PAGE_CACHE_MODE_UC_MINUS not _PAGE_CACHE_MODE_UC. We have two cases
> to consider for non-PAT systems then:
>
> a) Right now as ioremap() and ioremap_nocache() default to _PAGE_CACHE_MODE_UC_MINUS
>    on x86. In this case using a WC MTRR seems to use PWT=0, PCD=1, and
>    table table 11-6 on non-PAT systems seems to place this situation as
>    "implementation defined" and not encouraged.
>
> a) when commit de33c442e "x86 PAT: fix performance drop for glx, use
>    UC minus for ioremap(), ioremap_nocache() and pci_mmap_page_range()"
>    gets reverted and we use _PAGE_CACHE_MODE_UC by default. In this
>    case on x86 for both ioremap() and ioremap_nocache() as they will
>    both default to _PAGE_CACHE_MODE_UC we'll end up as you note with
>    an effective memory type of UC.
>
> If I've understood this correctly then neither of these situations are good and
> its just by chance that on some systems situation a) has lead to proper WC.
>
> On a PAT system we have a bit different combinatorial results (based on Table
> 11-7):
>
> a) Right now ioremap() and ioremap_nocache() defaulting to
>     _PAGE_CACHE_MODE_UC_MINUS yields + MTRR WC = WC
>
> b) When commit de33c442e gets reverted _PAGE_CACHE_MODE_UC + MTRR WC = UC
>
> So to be clear right now atyfb should work fine on PAT systems
> with de33c442e in place, once reverted as-is right now we'd end
> up with UC effective memory type.
>
> For both PAT and non-PAT systems when commit de33c442e gets reverted
> we'd end up with UC as the effective memory type for atyfb. Right
> now it shoud work on PAT systems and by chance its suspected to work
> on non-PAT systems. We want to phase MTRR though, specially to avoid
> all this insane combinatorial nightmware.
>
>> > > Hence my suggestion to add
>> > > ioremap_x86_uc and/or set_memory_x86_uc to punch a UC hole in an
>> > > otherwise WC MTRR-covered region.
>
> To be clear I think you mean then that ioremap_x86_uc() would help us avoid the
> jumps between combinatorial issues with MTRR on PAT / non-PAT systems before
> and after commit de33c442e gets reverted. So for instance if we had on the
> atyfb driver:
>
> ioremap_x86_uc(PCI BAR)
> ioremap_wc(framebuffer)
> arch_phys_add_wc(PCI BAR)
>
> On non-PAT systems on the MMIO region with PWT=1, PCD=1 we'd end up with UC.
> Sadly though since _PAGE_CACHE_WC on non-PAT has PWT=1, PCD=0, the WC
> MTRR that follows would mean we'd end up with another grey area (but
> similar to before as technically an effectivethe memory type of WC).
>
> On PAT systems the above would not use MTRRs but we'd be counting on
> overlapping memory types -- its not clear if aliasing here is a problem.
>
> Also Intel SDM, volume 3, section "11.11.4 Range Size and Alignment Requirement"
> describes that: "the minimum range size is 4 KiB, the base address must be on
> a 4 KiB boundary. For ranges greater than 4 KiB each range must be of length
> 2^n and its base address must be alinged on a 2^n boundary where n is a value
> equal or greatar then 12. The base-address alignment value cannot be less
> than its length. For example, an 8-KiB range cannot be aligned on a
> 4-KiB boundary. It must be aligned on at least an 8-KiB boundary"
>
> So to answer my own question: indeed, our framebuffer base address must be
> aligned on a 2^n boundary, the size also has to be a power of 2. MTRR supports
> fixed range sizes and variable range sizes, in case of the MMIO that does
> not need to abide by the power of 2 rule as a fixed range size of 4 KiB
> could be used although upon review ouf our own implemetnation its unclear if
> that is what is used for 4 KiB sized MTRRs.
>
> Hence my arch_phys_add_wc(PCI BAR) as above.
>
>> > OK I think I get it now.
>> >
>> > And I take it this would hopefully only be used for non-PAT systems?
>
> Since we likely could care to use ioremap_x86_uc() on PAT systems as well we
> could make the effective for both PAT and non-PAT obviously then.  Later when
> we get ioremap() to default to strong UC we could drop ioremap_x86_uc() as we'd
> only need it as transitory until then -- that is unless we want perhaps a strong
> UC ioremap primitive which is always following strong UC when available regardless
> of these default transitions.
>
> The big issue I see here is simply the combinatorial issues, so I do think
> its best to annotate these corner cases well and avoid them.
>
>> > Would there be a use case for PAT systems? I wonder if we can wrap
>> > this under some APIs to make it clean and hide this dirty thing
>> > behind the scenes, it seems a fragile and error prone and my hope
>> > would be that we won't need more specialization in this area for
>> > PAT systems.
>>
>> One potential complication is kernel vs. userspace mmap. MTRR applies to
>> the physical address, but PAT applies to the virtual address, so with
>> the WC MTRR you get WC for userspace "for free" as well.
>
> What is the performance impact of having the conversion being done by the
> kernel? Has anyone done measurements? If significant can't the subsystem mmap()
> cache the phys address for PAT? Shouldn't the TLB take care of those considerations
> for us? If this is generally desirable shouldn't we just generalize the cache
> for devices for O(1) access through a generic API?

We're pretty much required to keep the PTE memory types consistent for
aliasses of the same page.  I think that the x86 pageattr code is
supposed to take care of this.  IOW, if everything is working right,
then the supposedly uncached mmap should either fail, be promoted to
WC, or cause the existing WC map to degrade to UC.  The code is really
overcomplicated right now.

--Andy
