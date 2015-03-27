From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 27 Mar 2015 23:56:30 +0000
Subject: Re: [PATCH v1 02/47] x86: mtrr: generalize run time disabling of MTRR
Message-Id: <20150327235630.GR5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-3-git-send-email-mcgrof@do-not-panic.com>
 <1427488817.31093.54.camel@misato.fc.hp.com>
In-Reply-To: <1427488817.31093.54.camel@misato.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Toshi Kani <toshi.kani@hp.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Stefan Bader <stefan.bader@canonical.com>, konrad.wilk@oracle.com, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, bhelgaas@google.com, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, xen-devel@lists.xensource.com

On Fri, Mar 27, 2015 at 02:40:17PM -0600, Toshi Kani wrote:
> On Fri, 2015-03-20 at 16:17 -0700, Luis R. Rodriguez wrote:
>  :
> > @@ -734,6 +742,7 @@ void __init mtrr_bp_init(void)
> >  	}
> >  
> >  	if (mtrr_if) {
> > +		mtrr_enabled = true;
> >  		set_num_var_ranges();
> >  		init_table();
> >  		if (use_intel()) {
>                         get_mtrr_state();
> 
> After setting mtrr_enabled to true, get_mtrr_state() reads
> MSR_MTRRdefType and sets 'mtrr_state.enabled', which also indicates if
> MTRRs are enabled or not on the system.  So, potentially, we could have
> a case that mtrr_enabled is set to true, but mtrr_state.enabled is set
> to disabled when MTRRs are disabled by BIOS.

Thanks for the review, in this case then we should update mtrr_enabled to false.

> ps.
> I recently cleaned up this part of the MTRR code in the patch below,
> which is currently available in the -mm & -next trees.
> https://lkml.org/lkml/2015/3/24/1063

Great I will rebase and work with that and try to address this
consideration you have raised.

  Luis
