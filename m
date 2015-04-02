From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 02 Apr 2015 20:28:51 +0000
Subject: Re: [PATCH v1 02/47] x86: mtrr: generalize run time disabling of MTRR
Message-Id: <CAErSpo7MY7v2CWjVodpvRp+pB0cUgzN7g-RgBQhHVgA-8A5Lng@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-3-git-send-email-mcgrof@do-not-panic.com>
 <20150325195941.GM25884@l.oracle.com> <20150326233555.GE5622@wotan.suse.de>
 <CAErSpo5HJMr-HYKJRaPtb7=fb4BOq1b4EFs6S+YdG64_fGKc6Q@mail.gmail.com> <CAB=NE6Us2_sR95JQAKkbDTM9fqmh0N8rZgM3JXa=xSm4cO9DRw@mail.gmail.com>
In-Reply-To: <CAB=NE6Us2_sR95JQAKkbDTM9fqmh0N8rZgM3JXa=xSm4cO9DRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Stefan Bader <stefan.bader@canonical.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, David Vrabel <david.vrabel@citrix.com>, Toshi Kani <toshi.kani@hp.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, xen-devel <xen-devel@lists.xensource.com>

On Thu, Apr 2, 2015 at 3:20 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Thu, Apr 2, 2015 at 1:13 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> On Thu, Mar 26, 2015 at 6:35 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>>
>> > I'll rephrase this to:
>> >
>> > ---
>> > It is possible to enable CONFIG_MTRR and up with it
>> > disabled at run time and yet CONFIG_X86_PAT continues
>> > to kick through with all functionally enabled. This
>> > can happen for instance on Xen where MTRR is not
>> > supported but PAT is, this can happen now on Linux as
>> > of commit 47591df50 by Juergen introduced as of v3.19.
>>
>> I still can't parse this.  What does "up with it disabled at run time"
>> mean?
>
> It  means that technically even if your CPU/BIOS/system did support
> MTRR if you use a kernel with MTRR support enabled you might end up
> with a situation where under one situation MTRR  might be enabled and
> at another run time scenario with the same exact kernel and system you
> will end up with MTRR disabled. Such is the case for example when
> booting with Xen, which disables the CPU bits on the hypervisor code.
> If you boot the same system without Xen you'll get MTRR.

Your text is missing some words.  You seem to be using "up" as a verb,
but it's not a verb.  Maybe you meant "end up"?  Even then, it
wouldn't make sense for CONFIG_MTRR to be "disabled at run time"
because CONFIG_MTRR is a compile-time switch.  The MTRR
*functionality* could certainly be disabled at run-time, but not
CONFIG_MTRR itself.

>>  And "... continues to kick through"?  Probably some idiomatic
>> usage I'm just too old to understand :)
>
> That means for example that in both the above circumstances even if
> MTRR went disabled at run time with Xen, the kernel went through with
> getting PAT enabled.

"CONFIG_X86_PAT continues to kick through" doesn't seem a very precise
way of describing this.  But maybe it's enough for experts in this
area (which I'm not).

Bjorn
