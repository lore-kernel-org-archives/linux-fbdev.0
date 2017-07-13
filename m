From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Jul 2017 21:32:22 +0000
Subject: [PATCH v3 1/2] firmware/dmi: Export dmi_system_id_match
Message-Id: <20170713213223.28503-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In some cases a driver cannot use dmi_check_system because it
needs to do more complex checks, involving runtime (non const)
variables. In such case the driver will implement its own loop over
a dmi_system_id table and to do the dmi matching part of the checks
it needs access to dmi_system_id_match.

This commit renames dmi_matches to dmi_system_id_match to better reflect
what it does and exports it for use in such drivers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-Split out of "video/console: Add dmi quirk table for x86 systems which
 need fbcon rotation" patch
---
 drivers/firmware/dmi_scan.c | 9 +++++----
 include/linux/dmi.h         | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 783041964439..b48ac837f625 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -777,10 +777,10 @@ void __init dmi_set_dump_stack_arch_desc(void)
 }
 
 /**
- *	dmi_matches - check if dmi_system_id structure matches system DMI data
+ *	dmi_system_id_match - check if dmi_system_id matches system DMI data
  *	@dmi: pointer to the dmi_system_id structure to check
  */
-static bool dmi_matches(const struct dmi_system_id *dmi)
+bool dmi_system_id_match(const struct dmi_system_id *dmi)
 {
 	int i;
 
@@ -804,6 +804,7 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
 	}
 	return true;
 }
+EXPORT_SYMBOL(dmi_system_id_match);
 
 /**
  *	dmi_is_end_of_table - check for end-of-table marker
@@ -833,7 +834,7 @@ int dmi_check_system(const struct dmi_system_id *list)
 	const struct dmi_system_id *d;
 
 	for (d = list; !dmi_is_end_of_table(d); d++)
-		if (dmi_matches(d)) {
+		if (dmi_system_id_match(d)) {
 			count++;
 			if (d->callback && d->callback(d))
 				break;
@@ -860,7 +861,7 @@ const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list)
 	const struct dmi_system_id *d;
 
 	for (d = list; !dmi_is_end_of_table(d); d++)
-		if (dmi_matches(d))
+		if (dmi_system_id_match(d))
 			return d;
 
 	return NULL;
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 9bbf21a516e4..5ee3955607b3 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -96,6 +96,7 @@ struct dmi_dev_onboard {
 };
 
 extern struct kobject *dmi_kobj;
+extern bool dmi_system_id_match(const struct dmi_system_id *dmi);
 extern int dmi_check_system(const struct dmi_system_id *list);
 const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list);
 extern const char * dmi_get_system_info(int field);
-- 
2.13.0

