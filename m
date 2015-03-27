From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 27 Mar 2015 19:58:02 +0000
Subject: Re: [PATCH v1 06/47] mtrr: add __arch_phys_wc_add()
Message-Id: <CALCETrU-EATXPNt8p21=1rsbAsWX-kJys1rwzYyZ2S1h2enVYw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-7-git-send-email-mcgrof@do-not-panic.com>
 <CALCETrWJzOCqUOg2oAzTeAaURwkjCfZdPyT--mTDsf4aatJoDw@mail.gmail.com> <20150327195350.GJ5622@wotan.suse.de>
In-Reply-To: <20150327195350.GJ5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Mike Marciniszyn <infinipath@intel.com>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 27, 2015 at 12:53 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Fri, Mar 20, 2015 at 04:48:46PM -0700, Andy Lutomirski wrote:
>> On Fri, Mar 20, 2015 at 4:17 PM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
>> >
>> > Ideally on systems using PAT we can expect a swift
>> > transition away from MTRR. There can be a few exceptions
>> > to this, one is where device drivers are known to exist
>> > on PATs with errata, another situation is observed on
>> > old device drivers where devices had combined MMIO
>> > register access with whatever area they typically
>> > later wanted to end up using MTRR for on the same
>> > PCI BAR. This situation can still be addressed by
>> > splitting up ioremap'd PCI BAR into two ioremap'd
>> > calls, one for MMIO registers, and another for whatever
>> > is desirable for write-combining -- in order to
>> > accomplish this though quite a bit of driver
>> > restructuring is required.
>> >
>> > Device drivers which are known to require large
>> > amount of re-work in order to split ioremap'd areas
>> > can use __arch_phys_wc_add() to avoid regressions
>> > when PAT is enabled.
>> >
>> > For a good example driver where things are neatly
>> > split up on a PCI BAR refer the infiniband qib
>> > driver. For a good example of a driver where good
>> > amount of work is required refer to the infiniband
>> > ipath driver.
>> >
>> > This is *only* a transitive API -- and as such no new
>> > drivers are ever expected to use this.
>>
>> What's the exact layout that this helps?  I'm sceptical that this can
>> ever be correct.
>>
>> Is there some awful driver that has a large ioremap that's supposed to
>> contain multiple different memtypes?
>
> Yes, I cc'd you just now on one where I made changes on a driver which uses one
> PCI with mixed memtypes and uses MTRR to hole in WC. A transition to
> arch_phys_wc_add() is therefore not possible if PAT is enabled as it would
> regress those drivers by making the MTRR WC hole trick non functional.
> The changes are non trivial and so in this series I supplied changes on
> one driver only to show the effort required. The other drivers which
> required this were:
>
> Driver          File
> ------------------------------------------------------------
> fusion          drivers/message/fusion/mptbase.c
> ivtv            drivers/media/pci/ivtv/ivtvfb.c
> ipath           drivers/infiniband/hw/ipath/ipath_driver.c
>
> This series makes those drivers use __arch_phys_wc_add() more as a
> transitory phase in hopes we can address the proper split as with the
> atyfb illustrates. For ipath the changes required have a nice template
> with the qib driver as they share very similar driver structure, the
> qib driver *did* do the nice split.
>
>> If so, can we ioremap + set_page_xyz instead?
>
> I'm not sure I see which call we'd use.  Care to provide an example patch
> alternative for the atyfb as a case in point alternative to the work required
> to do the split?
>

I'm still confused.  Would it be insufficient to ioremap_nocache the
whole thing and then call set_memory_wc on parts of it?  (Sorry,
set_page_xyz was a typo.)

--Andy


-- 
Andy Lutomirski
AMA Capital Management, LLC
