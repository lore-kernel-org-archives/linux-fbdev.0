From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 02 Apr 2015 22:12:44 +0000
Subject: Re: [Xen-devel] [PATCH v1 02/47] x86: mtrr: generalize run time disabling of MTRR
Message-Id: <CAB=NE6WwFKVV_Jaf8eYiRD8mjV=aZ6tdu5PCSWshwgiF3tv41Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-3-git-send-email-mcgrof@do-not-panic.com>
 <20150325195941.GM25884@l.oracle.com> <20150326233555.GE5622@wotan.suse.de>
 <CAErSpo5HJMr-HYKJRaPtb7=fb4BOq1b4EFs6S+YdG64_fGKc6Q@mail.gmail.com>
 <CAB=NE6Us2_sR95JQAKkbDTM9fqmh0N8rZgM3JXa=xSm4cO9DRw@mail.gmail.com>
 <CAErSpo7MY7v2CWjVodpvRp+pB0cUgzN7g-RgBQhHVgA-8A5Lng@mail.gmail.com>
 <20150402210253.GY5622@wotan.suse.de> <CAErSpo5S7=CRyH0TKDfXzs-LWyP9kx_Xd=iFvEKyQZ5-humpxA@mail.gmail.com>
In-Reply-To: <CAErSpo5S7=CRyH0TKDfXzs-LWyP9kx_Xd=iFvEKyQZ5-humpxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, xen-devel <xen-devel@lists.xensource.com>, Suresh Siddha <suresh.b.siddha@intel.com>, "x86@kernel.org" <x86@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Borislav Petkov <bp@suse.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Antonino Daplas <adaplas@gmail.com>, Stefan Bader <stefan.bader@canonical.com>, Dave Airlie <airlied@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Juergen Gross <jgross@suse.com>, Toshi Kani <toshi.kani@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, David Vrabel <david.vrabel@citrix.com>, venkatesh.pallipadi@intel.com, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>

On Thu, Apr 2, 2015 at 3:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Apr 2, 2015 at 4:02 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>
>> ---
>> It is possible to enable CONFIG_MTRR and CONFIG_X86_PAT
>> and end up with a system with MTRR functionality disabled
>> PAT functionality enabled.
>
> This is missing a conjunction or something in "MTRR functionality
> disabled PAT functionality."

"and PAT functionality" -- fixed. Thanks.

 Luis
