From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 22 Jun 2018 07:52:49 +0000
Subject: [PATCH v2 1/2] efi: drop type and attribute checks in efi_mem_desc_lookup()
Message-Id: <20180622075250.14075-2-ard.biesheuvel@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The current implementation of efi_mem_desc_lookup() includes the
following check on the memory descriptor it returns:

    if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
        md->type != EFI_BOOT_SERVICES_DATA &&
        md->type != EFI_RUNTIME_SERVICES_DATA) {
            continue;
    }

This means that only EfiBootServicesData or EfiRuntimeServicesData
regions are considered, or any other region type provided that it
has the EFI_MEMORY_RUNTIME attribute set.

Given what the name of the function implies, and the fact that any
physical address can be described in the UEFI memory map only a single
time, it does not make sense to impose this condition in the body of the
loop, but instead, should be imposed by the caller depending on the value
that is returned to it.

Two such callers exist at the moment:
- The BGRT code when running on x86, via efi_mem_reserve() and
  efi_arch_mem_reserve(). In this case, the region is already known to
  be EfiBootServicesData, and so the check is redundant.
- The ESRT handling code which introduced this function, which calls it
  both directly from efi_esrt_init() and again via efi_mem_reserve() and
  efi_arch_mem_reserve() [on x86].

So let's move this check into the callers instead. This preserves the
current behavior both for BGRT and ESRT handling, and allows the lookup
routine to be reused by other [upcoming] users that don't have this
limitation.

In the ESRT case, keep the entire condition, so that platforms that
deviate from the UEFI spec and use something other than
EfiBootServicesData for the ESRT table will keep working as before.

For x86's efi_arch_mem_reserve() implementation, limit the type to
EfiBootServicesData, since it is the only type the reservation code
expects to operate on in the first place.

While we're at it, drop the __init annotation so that drivers can use it
as well.

Cc: Peter Jones <pjones@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 3 ++-
 drivers/firmware/efi/efi.c     | 8 +-------
 drivers/firmware/efi/esrt.c    | 5 ++++-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 36c1f8b9f7e0..4ee6f4980afe 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -249,7 +249,8 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
-	if (efi_mem_desc_lookup(addr, &md)) {
+	if (efi_mem_desc_lookup(addr, &md) ||
+	    md.type != EFI_BOOT_SERVICES_DATA) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
 		return;
 	}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 232f4915223b..cbc25d1c40bb 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -388,7 +388,7 @@ subsys_initcall(efisubsys_init);
  * and if so, populate the supplied memory descriptor with the appropriate
  * data.
  */
-int __init efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
+int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 {
 	efi_memory_desc_t *md;
 
@@ -406,12 +406,6 @@ int __init efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 		u64 size;
 		u64 end;
 
-		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
-		    md->type != EFI_BOOT_SERVICES_DATA &&
-		    md->type != EFI_RUNTIME_SERVICES_DATA) {
-			continue;
-		}
-
 		size = md->num_pages << EFI_PAGE_SHIFT;
 		end = md->phys_addr + size;
 		if (phys_addr >= md->phys_addr && phys_addr < end) {
diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 1ab80e06e7c5..375a77c1c6e5 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -250,7 +250,10 @@ void __init efi_esrt_init(void)
 		return;
 
 	rc = efi_mem_desc_lookup(efi.esrt, &md);
-	if (rc < 0) {
+	if (rc < 0 ||
+	    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
+	     md.type != EFI_BOOT_SERVICES_DATA &&
+	     md.type != EFI_RUNTIME_SERVICES_DATA)) {
 		pr_warn("ESRT header is not in the memory map.\n");
 		return;
 	}
-- 
2.17.1

