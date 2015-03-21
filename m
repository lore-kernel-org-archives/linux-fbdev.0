From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 21 Mar 2015 01:08:39 +0000
Subject: Re: [PATCH v1 00/47] mtrr/x86/drivers: bury MTRR
Message-Id: <CALCETrXywVY_5NHqFPxHfRFc1SMSiJyiS=sDJjNZOxvQfebc8A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Fri, Mar 20, 2015 at 4:17 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> When a system has PAT support enabled you don't need to be
> using MTRRs. Andy had added arch_phys_wc_add() long ago to
> help with this but not all drivers were converted over. We
> have to take care to only convert drivers where we know that
> the proper ioremap_wc() API has been used. Doing this requires
> a bit of work on verifying the driver split out the ioremap'd
> areas -- and if not doing that ourselves. Verifying a driver
> uses the same areas can be hard but with a bit of love Coccinelle
> can help with that.
>
> We're motivated to change drivers for a few reasons:
>
> 1) Take advantage of PAT when available
>
> 2) Help with the goal of eventually using _PAGE_CACHE_UC over
>    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (de33c442e)

Nice!

--Andy
