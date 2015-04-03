From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 03 Apr 2015 01:08:59 +0000
Subject: Re: [PATCH v1 02/47] x86: mtrr: generalize run time disabling of MTRR
Message-Id: <20150403010859.GB5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-3-git-send-email-mcgrof@do-not-panic.com>
 <1427488817.31093.54.camel@misato.fc.hp.com>
 <20150327235630.GR5622@wotan.suse.de>
 <20150402214912.GZ5622@wotan.suse.de>
 <1428018736.31093.102.camel@misato.fc.hp.com>
In-Reply-To: <1428018736.31093.102.camel@misato.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Toshi Kani <toshi.kani@hp.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Stefan Bader <stefan.bader@canonical.com>, konrad.wilk@oracle.com, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, bhelgaas@google.com, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, xen-devel@lists.xensource.com

On Thu, Apr 02, 2015 at 05:52:16PM -0600, Toshi Kani wrote:
> On Thu, 2015-04-02 at 23:49 +0200, Luis R. Rodriguez wrote:
> > On Sat, Mar 28, 2015 at 12:56:30AM +0100, Luis R. Rodriguez wrote:
> > > On Fri, Mar 27, 2015 at 02:40:17PM -0600, Toshi Kani wrote:
> > > > On Fri, 2015-03-20 at 16:17 -0700, Luis R. Rodriguez wrote:
> > > >  :
> > > > > @@ -734,6 +742,7 @@ void __init mtrr_bp_init(void)
> > > > >  	}
> > > > >  
> > > > >  	if (mtrr_if) {
> > > > > +		mtrr_enabled = true;
> > > > >  		set_num_var_ranges();
> > > > >  		init_table();
> > > > >  		if (use_intel()) {
> > > >                         get_mtrr_state();
> > > > 
> > > > After setting mtrr_enabled to true, get_mtrr_state() reads
> > > > MSR_MTRRdefType and sets 'mtrr_state.enabled', which also indicates if
> > > > MTRRs are enabled or not on the system.  So, potentially, we could have
> > > > a case that mtrr_enabled is set to true, but mtrr_state.enabled is set
> > > > to disabled when MTRRs are disabled by BIOS.
> > > 
> > > Thanks for the review, in this case then we should update mtrr_enabled to false.
> > > 
> > > > ps.
> > > > I recently cleaned up this part of the MTRR code in the patch below,
> > > > which is currently available in the -mm & -next trees.
> > > > https://lkml.org/lkml/2015/3/24/1063
> > > 
> > > Great I will rebase and work with that and try to address this
> > > consideration you have raised.
> > 
> > OK I'll mesh in this change as well in my next respin:
> > 
> > diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> > index a83f27a..ecf7cb9 100644
> > --- a/arch/x86/kernel/cpu/mtrr/generic.c
> > +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> > @@ -438,7 +438,7 @@ static void __init print_mtrr_state(void)
> >  }
> >  
> >  /* Grab all of the MTRR state for this CPU into *state */
> > -void __init get_mtrr_state(void)
> > +bool __init get_mtrr_state(void)
> >  {
> >  	struct mtrr_var_range *vrs;
> >  	unsigned long flags;
> > @@ -482,6 +482,8 @@ void __init get_mtrr_state(void)
> >  
> >  	post_set();
> >  	local_irq_restore(flags);
> > +
> > +	return !!mtrr_state.enabled;
> 
> This should be:
> 	return mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED;
> 
> because the MTRR_STATE_MTRR_FIXED_ENABLED flag is ignored when the
> MTRR_STATE_MTRR_ENABLED flag is clear.

Thanks, I've used

	return !!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED);

Amended.

  Luis
