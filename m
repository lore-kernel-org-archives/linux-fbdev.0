From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Wed, 25 Mar 2015 19:59:41 +0000
Subject: Re: [PATCH v1 02/47] x86: mtrr: generalize run time disabling of MTRR
Message-Id: <20150325195941.GM25884@l.oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-3-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Stefan Bader <stefan.bader@canonical.com>, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, toshi.kani@hp.com, bhelgaas@google.com, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, xen-devel@lists.xensource.com

On Fri, Mar 20, 2015 at 04:17:52PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>=20
> It is possible to enable CONFIG_MTRR and up with it
> disabled at run time and yet CONFIG_X86_PAT continues
> to kick through fully functionally. This can happen

s/fully/full/ ?


> for instance on Xen where MTRR is not supported but
> PAT is, this can happen now on Linux as of commit
> 47591df50 by Juergen introduced as of v3.19.

s/3.19/4.0/
>=20
> Technically we should assume the proper CPU
> bits would be set to disable MTRR but we can't
> always rely on this. At least on the Xen Hypervisor
> for instance only X86_FEATURE_MTRR was disabled
> as of Xen 4.4 through Xen commit 586ab6a [0],
> but not X86_FEATURE_K6_MTRR, X86_FEATURE_CENTAUR_MCR,
> or X86_FEATURE_CYRIX_ARR for instance.

Oh, could you send an patch for that to Xen please?
>=20
> x86 mtrr code relies on quite a bit of checks for
> mtrr_if being set to check to see if MTRR did get
> set up, instead of using that lets provide a generic
> setter which when set we know MTRR is enabled. This

s/we know MTRR is enabled/will let us know that MTRR is enabled/

> also adds a few checks where they were not before
> which could potentially safeguard ourselves against
> incorrect usage of MTRR where this was not desirable.
>=20
> Where possible match error codes as if MTRR was
> disabled on arch/x86/include/asm/mtrr.h.
>=20
> Lastly, since disabling MTRR can happen at run time
> and we could end up with PAT enabled best record now
> on our logs when MTRR is disabled.
>=20
> [0] ~/devel/xen (git::stable-4.5)$ git describe --contains 586ab6a
> 4.4.0-rc1~18
>=20
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Suresh Siddha <suresh.b.siddha@intel.com>
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: venkatesh.pallipadi@intel.com
> Cc: Stefan Bader <stefan.bader@canonical.com>
> Cc: konrad.wilk@oracle.com
> Cc: ville.syrjala@linux.intel.com
> Cc: david.vrabel@citrix.com
> Cc: jbeulich@suse.com
> Cc: toshi.kani@hp.com
> Cc: bhelgaas@google.com
> Cc: Roger Pau Monn=E9 <roger.pau@citrix.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: xen-devel@lists.xensource.com
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  arch/x86/include/asm/mtrr.h        |  2 ++
>  arch/x86/kernel/cpu/mtrr/cleanup.c |  2 +-
>  arch/x86/kernel/cpu/mtrr/generic.c |  5 +++--
>  arch/x86/kernel/cpu/mtrr/if.c      |  3 +++
>  arch/x86/kernel/cpu/mtrr/main.c    | 31 ++++++++++++++++++++++---------
>  5 files changed, 31 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
> index f768f62..cade917 100644
> --- a/arch/x86/include/asm/mtrr.h
> +++ b/arch/x86/include/asm/mtrr.h
> @@ -31,6 +31,7 @@
>   * arch_phys_wc_add and arch_phys_wc_del.
>   */
>  # ifdef CONFIG_MTRR
> +extern int mtrr_enabled;
>  extern u8 mtrr_type_lookup(u64 addr, u64 end);
>  extern void mtrr_save_fixed_ranges(void *);
>  extern void mtrr_save_state(void);
> @@ -50,6 +51,7 @@ extern int mtrr_trim_uncached_memory(unsigned long end_=
pfn);
>  extern int amd_special_default_mtrr(void);
>  extern int phys_wc_to_mtrr_index(int handle);
>  #  else
> +static const int mtrr_enabled;
>  static inline u8 mtrr_type_lookup(u64 addr, u64 end)
>  {
>  	/*
> diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtr=
r/cleanup.c
> index 5f90b85..784dc55 100644
> --- a/arch/x86/kernel/cpu/mtrr/cleanup.c
> +++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
> @@ -880,7 +880,7 @@ int __init mtrr_trim_uncached_memory(unsigned long en=
d_pfn)
>  	 * Make sure we only trim uncachable memory on machines that
>  	 * support the Intel MTRR architecture:
>  	 */
> -	if (!is_cpu(INTEL) || disable_mtrr_trim)
> +	if (!is_cpu(INTEL) || disable_mtrr_trim || !mtrr_enabled)
>  		return 0;
> =20
>  	rdmsr(MSR_MTRRdefType, def, dummy);
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtr=
r/generic.c
> index 09c82de..df321b2 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -116,7 +116,8 @@ static u8 __mtrr_type_lookup(u64 start, u64 end, u64 =
*partial_end, int *repeat)
>  	u8 prev_match, curr_match;
> =20
>  	*repeat =3D 0;
> -	if (!mtrr_state_set)
> +	/* generic_mtrr_ops is only set for generic_mtrr_ops */
> +	if (!mtrr_state_set || !mtrr_enabled)
>  		return 0xFF;
> =20
>  	if (!mtrr_state.enabled)
> @@ -290,7 +291,7 @@ static void get_fixed_ranges(mtrr_type *frs)
> =20
>  void mtrr_save_fixed_ranges(void *info)
>  {
> -	if (cpu_has_mtrr)
> +	if (mtrr_enabled && cpu_has_mtrr)
>  		get_fixed_ranges(mtrr_state.fixed_ranges);
>  }
> =20
> diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
> index d76f13d..e9e001a 100644
> --- a/arch/x86/kernel/cpu/mtrr/if.c
> +++ b/arch/x86/kernel/cpu/mtrr/if.c
> @@ -436,6 +436,9 @@ static int __init mtrr_if_init(void)
>  {
>  	struct cpuinfo_x86 *c =3D &boot_cpu_data;
> =20
> +	if (!mtrr_enabled)
> +		return 0;
> +
>  	if ((!cpu_has(c, X86_FEATURE_MTRR)) &&
>  	    (!cpu_has(c, X86_FEATURE_K6_MTRR)) &&
>  	    (!cpu_has(c, X86_FEATURE_CYRIX_ARR)) &&
> diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/m=
ain.c
> index ea5f363..7db9c47 100644
> --- a/arch/x86/kernel/cpu/mtrr/main.c
> +++ b/arch/x86/kernel/cpu/mtrr/main.c
> @@ -59,6 +59,7 @@
>  #define MTRR_TO_PHYS_WC_OFFSET 1000
> =20
>  u32 num_var_ranges;
> +int mtrr_enabled;
> =20
>  unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
>  static DEFINE_MUTEX(mtrr_mutex);
> @@ -84,6 +85,9 @@ static int have_wrcomb(void)
>  {
>  	struct pci_dev *dev;
> =20
> +	if (!mtrr_enabled)
> +		return 0;
> +
>  	dev =3D pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, NULL);
>  	if (dev !=3D NULL) {
>  		/*
> @@ -286,7 +290,7 @@ int mtrr_add_page(unsigned long base, unsigned long s=
ize,
>  	int i, replace, error;
>  	mtrr_type ltype;
> =20
> -	if (!mtrr_if)
> +	if (!mtrr_enabled)
>  		return -ENXIO;
> =20
>  	error =3D mtrr_if->validate_add_page(base, size, type);
> @@ -388,6 +392,8 @@ int mtrr_add_page(unsigned long base, unsigned long s=
ize,
> =20
>  static int mtrr_check(unsigned long base, unsigned long size)
>  {
> +	if (!mtrr_enabled)
> +		return -ENODEV;
>  	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
>  		pr_warning("mtrr: size and base must be multiples of 4 kiB\n");
>  		pr_debug("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
> @@ -463,8 +469,8 @@ int mtrr_del_page(int reg, unsigned long base, unsign=
ed long size)
>  	unsigned long lbase, lsize;
>  	int error =3D -EINVAL;
> =20
> -	if (!mtrr_if)
> -		return -ENXIO;
> +	if (!mtrr_enabled)
> +		return -ENODEV;
> =20
>  	max =3D num_var_ranges;
>  	/* No CPU hotplug when we change MTRR entries */
> @@ -523,6 +529,8 @@ int mtrr_del_page(int reg, unsigned long base, unsign=
ed long size)
>   */
>  int mtrr_del(int reg, unsigned long base, unsigned long size)
>  {
> +	if (!mtrr_enabled)
> +		return -ENODEV;
>  	if (mtrr_check(base, size))
>  		return -EINVAL;
>  	return mtrr_del_page(reg, base >> PAGE_SHIFT, size >> PAGE_SHIFT);
> @@ -545,7 +553,7 @@ int arch_phys_wc_add(unsigned long base, unsigned lon=
g size)
>  {
>  	int ret;
> =20
> -	if (pat_enabled)
> +	if (pat_enabled || !mtrr_enabled)
>  		return 0;  /* Success!  (We don't need to do anything.) */
> =20
>  	ret =3D mtrr_add(base, size, MTRR_TYPE_WRCOMB, true);
> @@ -734,6 +742,7 @@ void __init mtrr_bp_init(void)
>  	}
> =20
>  	if (mtrr_if) {
> +		mtrr_enabled =3D true;
>  		set_num_var_ranges();
>  		init_table();
>  		if (use_intel()) {
> @@ -744,12 +753,13 @@ void __init mtrr_bp_init(void)
>  				mtrr_if->set_all();
>  			}
>  		}
> -	}
> +	} else
> +		pr_info("mtrr: system does not support MTRR\n");

 'pr_warn' ?=20
>  }
> =20
>  void mtrr_ap_init(void)
>  {
> -	if (!use_intel() || mtrr_aps_delayed_init)
> +	if (!use_intel() || mtrr_aps_delayed_init || !mtrr_enabled)
>  		return;
>  	/*
>  	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
> @@ -774,6 +784,9 @@ void mtrr_save_state(void)
>  {
>  	int first_cpu;
> =20
> +	if (!mtrr_enabled)
> +		return;
> +
>  	get_online_cpus();
>  	first_cpu =3D cpumask_first(cpu_online_mask);
>  	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
> @@ -782,7 +795,7 @@ void mtrr_save_state(void)
> =20
>  void set_mtrr_aps_delayed_init(void)
>  {
> -	if (!use_intel())
> +	if (!use_intel() || !mtrr_enabled)
>  		return;
> =20
>  	mtrr_aps_delayed_init =3D true;
> @@ -810,7 +823,7 @@ void mtrr_aps_init(void)
> =20
>  void mtrr_bp_restore(void)
>  {
> -	if (!use_intel())
> +	if (!use_intel() || !mtrr_enabled)
>  		return;
> =20
>  	mtrr_if->set_all();
> @@ -818,7 +831,7 @@ void mtrr_bp_restore(void)
> =20
>  static int __init mtrr_init_finialize(void)
>  {
> -	if (!mtrr_if)
> +	if (!mtrr_enabled)
>  		return 0;
> =20
>  	if (use_intel()) {
> --=20
> 2.3.2.209.gd67f9d5.dirty
>=20
