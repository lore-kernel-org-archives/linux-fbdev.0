From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:51:15 +0000
Subject: [PATCH v3] x86: mtrr: generalize run time disabling of MTRR
Message-Id: <1429649475-18436-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, luto@amacapital.net, mst@redhat.com, "Luis R. Rodriguez" <mcgrof@suse.com>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, venkatesh.pallipadi@intel.com, Stefan Bader <stefan.bader@canonical.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>, konrad.wilk@oracle.com, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, jbeulich@suse.com, bhelgaas@google.com, linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com

From: "Luis R. Rodriguez" <mcgrof@suse.com>

It is possible to enable CONFIG_MTRR and CONFIG_X86_PAT
and end up with a system with MTRR functionality disabled
and PAT functionality enabled. This can happen for instance
when the Xen hypervisor is used where MTRR is not supported
but PAT is. This can happen on Linux as of commit 47591df50
("xen: Support Xen pv-domains using PAT") by Juergen,
introduced as of v3.19.

Technically we should assume the proper CPU
bits would be set to disable MTRR but we can't
always rely on this. At least on the Xen Hypervisor
for instance only X86_FEATURE_MTRR was disabled
as of Xen 4.4 through Xen commit 586ab6a [0],
but not X86_FEATURE_K6_MTRR, X86_FEATURE_CENTAUR_MCR,
or X86_FEATURE_CYRIX_ARR for instance. Roger Pau Monné
has clarified though that although this is technically
true we will never support PVH on these CPU types
so Xen has no need to disable these bits on those
systems. As per Roger AMD K6, Centaur and VIA chips
don't have the necessary hardware extensions to allow
running PVH guests [1]. As per Toshi it is also possible
for the BIOS to disable MTRR support, in such cases
get_mtrr_state() would update the MTRR state as per
the BIOS, we need to propagate this information as
well.

x86 mtrr code relies on quite a bit of checks for
mtrr_if being set to check to see if MTRR did get
set up, instead of using that lets provide a generic
setter which when set will let us know that MTRR is
enabled. This also adds a few checks where they were
not before which could potentially safeguard ourselves
against incorrect usage of MTRR where this was not
desirable.

Where possible match error codes as if MTRR was
disabled on arch/x86/include/asm/mtrr.h.

Lastly, since disabling MTRR can happen at run time
and we could end up with PAT enabled best record now
on our logs when MTRR is disabled.

[0] ~/devel/xen (git::stable-4.5)$ git describe --contains 586ab6a
4.4.0-rc1~18
[1] http://lists.xenproject.org/archives/html/xen-devel/2015-03/msg03460.html

Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: venkatesh.pallipadi@intel.com
Cc: Stefan Bader <stefan.bader@canonical.com>
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: konrad.wilk@oracle.com
Cc: ville.syrjala@linux.intel.com
Cc: david.vrabel@citrix.com
Cc: jbeulich@suse.com
Cc: toshi.kani@hp.com
Cc: bhelgaas@google.com
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 arch/x86/kernel/cpu/mtrr/generic.c |  4 +++-
 arch/x86/kernel/cpu/mtrr/main.c    | 36 ++++++++++++++++++++++++++----------
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  2 +-
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index a83f27a..8763fa7 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -438,7 +438,7 @@ static void __init print_mtrr_state(void)
 }
 
 /* Grab all of the MTRR state for this CPU into *state */
-void __init get_mtrr_state(void)
+bool __init get_mtrr_state(void)
 {
 	struct mtrr_var_range *vrs;
 	unsigned long flags;
@@ -482,6 +482,8 @@ void __init get_mtrr_state(void)
 
 	post_set();
 	local_irq_restore(flags);
+
+	return !!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED);
 }
 
 /* Some BIOS's are messed up and don't set all MTRRs the same! */
diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index d8c106c..bfef424 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -59,6 +59,7 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
+int mtrr_enabled;
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
@@ -84,6 +85,9 @@ static int have_wrcomb(void)
 {
 	struct pci_dev *dev;
 
+	if (!mtrr_enabled)
+		return 0;
+
 	dev = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, NULL);
 	if (dev != NULL) {
 		/*
@@ -286,7 +290,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	int i, replace, error;
 	mtrr_type ltype;
 
-	if (!mtrr_if)
+	if (!mtrr_enabled)
 		return -ENXIO;
 
 	error = mtrr_if->validate_add_page(base, size, type);
@@ -388,6 +392,8 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 
 static int mtrr_check(unsigned long base, unsigned long size)
 {
+	if (!mtrr_enabled)
+		return -ENODEV;
 	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
 		pr_warning("mtrr: size and base must be multiples of 4 kiB\n");
 		pr_debug("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
@@ -463,8 +469,8 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 	unsigned long lbase, lsize;
 	int error = -EINVAL;
 
-	if (!mtrr_if)
-		return -ENXIO;
+	if (!mtrr_enabled)
+		return -ENODEV;
 
 	max = num_var_ranges;
 	/* No CPU hotplug when we change MTRR entries */
@@ -523,6 +529,8 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
  */
 int mtrr_del(int reg, unsigned long base, unsigned long size)
 {
+	if (!mtrr_enabled)
+		return -ENODEV;
 	if (mtrr_check(base, size))
 		return -EINVAL;
 	return mtrr_del_page(reg, base >> PAGE_SHIFT, size >> PAGE_SHIFT);
@@ -548,7 +556,7 @@ int arch_phys_wc_add(unsigned long base, unsigned long size)
 {
 	int ret;
 
-	if (pat_enabled)
+	if (pat_enabled || !mtrr_enabled)
 		return 0;  /* Success!  (We don't need to do anything.) */
 
 	ret = mtrr_add(base, size, MTRR_TYPE_WRCOMB, true);
@@ -737,10 +745,12 @@ void __init mtrr_bp_init(void)
 	}
 
 	if (mtrr_if) {
+		mtrr_enabled = true;
 		set_num_var_ranges();
 		init_table();
 		if (use_intel()) {
-			get_mtrr_state();
+			/* BIOS may override */
+			mtrr_enabled = get_mtrr_state();
 
 			if (mtrr_cleanup(phys_addr)) {
 				changed_by_mtrr_cleanup = 1;
@@ -748,11 +758,14 @@ void __init mtrr_bp_init(void)
 			}
 		}
 	}
+
+	if (!mtrr_enabled)
+		pr_info("mtrr: system does not support MTRR\n");
 }
 
 void mtrr_ap_init(void)
 {
-	if (!use_intel() || mtrr_aps_delayed_init)
+	if (!use_intel() || mtrr_aps_delayed_init || !mtrr_enabled)
 		return;
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
@@ -777,6 +790,9 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
+	if (!mtrr_enabled)
+		return;
+
 	get_online_cpus();
 	first_cpu = cpumask_first(cpu_online_mask);
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
@@ -785,7 +801,7 @@ void mtrr_save_state(void)
 
 void set_mtrr_aps_delayed_init(void)
 {
-	if (!use_intel())
+	if (!use_intel() || !mtrr_enabled)
 		return;
 
 	mtrr_aps_delayed_init = true;
@@ -796,7 +812,7 @@ void set_mtrr_aps_delayed_init(void)
  */
 void mtrr_aps_init(void)
 {
-	if (!use_intel())
+	if (!use_intel() || !mtrr_enabled)
 		return;
 
 	/*
@@ -813,7 +829,7 @@ void mtrr_aps_init(void)
 
 void mtrr_bp_restore(void)
 {
-	if (!use_intel())
+	if (!use_intel() || !mtrr_enabled)
 		return;
 
 	mtrr_if->set_all();
@@ -821,7 +837,7 @@ void mtrr_bp_restore(void)
 
 static int __init mtrr_init_finialize(void)
 {
-	if (!mtrr_if)
+	if (!mtrr_enabled)
 		return 0;
 
 	if (use_intel()) {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index df5e41f..951884d 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -51,7 +51,7 @@ void set_mtrr_prepare_save(struct set_mtrr_context *ctxt);
 
 void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
-void get_mtrr_state(void);
+bool get_mtrr_state(void);
 
 extern void set_mtrr_ops(const struct mtrr_ops *ops);
 
-- 
2.3.2.209.gd67f9d5.dirty

