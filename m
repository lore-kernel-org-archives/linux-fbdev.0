From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 02 Apr 2015 22:09:15 +0000
Subject: Re: [PATCH v1 02/47] x86: mtrr: generalize run time disabling of MTRR
Message-Id: <CAErSpo5S7=CRyH0TKDfXzs-LWyP9kx_Xd=iFvEKyQZ5-humpxA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-3-git-send-email-mcgrof@do-not-panic.com>
 <20150325195941.GM25884@l.oracle.com> <20150326233555.GE5622@wotan.suse.de>
 <CAErSpo5HJMr-HYKJRaPtb7=fb4BOq1b4EFs6S+YdG64_fGKc6Q@mail.gmail.com>
 <CAB=NE6Us2_sR95JQAKkbDTM9fqmh0N8rZgM3JXa=xSm4cO9DRw@mail.gmail.com>
 <CAErSpo7MY7v2CWjVodpvRp+pB0cUgzN7g-RgBQhHVgA-8A5Lng@mail.gmail.com> <20150402210253.GY5622@wotan.suse.de>
In-Reply-To: <20150402210253.GY5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Stefan Bader <stefan.bader@canonical.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, David Vrabel <david.vrabel@citrix.com>, Toshi Kani <toshi.kani@hp.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, xen-devel <xen-devel@lists.xensource.com>

On Thu, Apr 2, 2015 at 4:02 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:

> ---
> It is possible to enable CONFIG_MTRR and CONFIG_X86_PAT
> and end up with a system with MTRR functionality disabled
> PAT functionality enabled.

This is missing a conjunction or something in "MTRR functionality
disabled PAT functionality."

Bjorn
