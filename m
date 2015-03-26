From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 26 Mar 2015 23:35:55 +0000
Subject: Re: [PATCH v1 02/47] x86: mtrr: generalize run time disabling of MTRR
Message-Id: <20150326233555.GE5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-3-git-send-email-mcgrof@do-not-panic.com>
 <20150325195941.GM25884@l.oracle.com>
In-Reply-To: <20150325195941.GM25884@l.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Stefan Bader <stefan.bader@canonical.com>, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, toshi.kani@hp.com, bhelgaas@google.com, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, xen-devel@lists.xensource.com

On Wed, Mar 25, 2015 at 03:59:41PM -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Mar 20, 2015 at 04:17:52PM -0700, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > It is possible to enable CONFIG_MTRR and up with it
> > disabled at run time and yet CONFIG_X86_PAT continues
> > to kick through fully functionally. This can happen
> 
> s/fully/full/ ?

I'll rephrase this to:

---
It is possible to enable CONFIG_MTRR and up with it
disabled at run time and yet CONFIG_X86_PAT continues
to kick through with all functionally enabled. This
can happen for instance on Xen where MTRR is not
supported but PAT is, this can happen now on Linux as
of commit 47591df50 by Juergen introduced as of v3.19.
---

Which BTW I had also mentioned on the cover letter that
this is a good time to address if we want to make PAT
then a first class citizen, to detangle it from depending
on MTRR. If so I can do that later.

> > Technically we should assume the proper CPU
> > bits would be set to disable MTRR but we can't
> > always rely on this. At least on the Xen Hypervisor
> > for instance only X86_FEATURE_MTRR was disabled
> > as of Xen 4.4 through Xen commit 586ab6a [0],
> > but not X86_FEATURE_K6_MTRR, X86_FEATURE_CENTAUR_MCR,
> > or X86_FEATURE_CYRIX_ARR for instance.
> 
> Oh, could you send an patch for that to Xen please?

Done.

> > x86 mtrr code relies on quite a bit of checks for
> > mtrr_if being set to check to see if MTRR did get
> > set up, instead of using that lets provide a generic
> > setter which when set we know MTRR is enabled. This
> 
> s/we know MTRR is enabled/will let us know that MTRR is enabled/

Amended.

  Luis
