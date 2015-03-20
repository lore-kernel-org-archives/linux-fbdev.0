From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 20 Mar 2015 23:48:46 +0000
Subject: Re: [PATCH v1 06/47] mtrr: add __arch_phys_wc_add()
Message-Id: <CALCETrWJzOCqUOg2oAzTeAaURwkjCfZdPyT--mTDsf4aatJoDw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com> <1426893517-2511-7-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-7-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 20, 2015 at 4:17 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> Ideally on systems using PAT we can expect a swift
> transition away from MTRR. There can be a few exceptions
> to this, one is where device drivers are known to exist
> on PATs with errata, another situation is observed on
> old device drivers where devices had combined MMIO
> register access with whatever area they typically
> later wanted to end up using MTRR for on the same
> PCI BAR. This situation can still be addressed by
> splitting up ioremap'd PCI BAR into two ioremap'd
> calls, one for MMIO registers, and another for whatever
> is desirable for write-combining -- in order to
> accomplish this though quite a bit of driver
> restructuring is required.
>
> Device drivers which are known to require large
> amount of re-work in order to split ioremap'd areas
> can use __arch_phys_wc_add() to avoid regressions
> when PAT is enabled.
>
> For a good example driver where things are neatly
> split up on a PCI BAR refer the infiniband qib
> driver. For a good example of a driver where good
> amount of work is required refer to the infiniband
> ipath driver.
>
> This is *only* a transitive API -- and as such no new
> drivers are ever expected to use this.

What's the exact layout that this helps?  I'm sceptical that this can
ever be correct.

Is there some awful driver that has a large ioremap that's supposed to
contain multiple different memtypes?  If so, can we ioremap +
set_page_xyz instead?

--Andy
