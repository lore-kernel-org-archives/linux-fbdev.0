From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 May 2017 11:28:57 +0000
Subject: [PATCH] fbdev: via: remove possibly unused variables
Message-Id: <20170516112906.4144714-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

When CONFIG_PROC_FS is disabled, we get warnings about unused variables
as remove_proc_entry() evaluates to an empty macro.

drivers/video/fbdev/via/viafbdev.c: In function 'viafb_remove_proc':
drivers/video/fbdev/via/viafbdev.c:1635:4: error: unused variable 'iga2_entry' [-Werror=unused-variable]
drivers/video/fbdev/via/viafbdev.c:1634:4: error: unused variable 'iga1_entry' [-Werror=unused-variable]

These are easy to avoid by using the pointer from the structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/via/viafbdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 510772bed4f4..89ee4d73bcff 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -1630,16 +1630,14 @@ static void viafb_init_proc(struct viafb_shared *shared)
 }
 static void viafb_remove_proc(struct viafb_shared *shared)
 {
-	struct proc_dir_entry *viafb_entry = shared->proc_entry,
-		*iga1_entry = shared->iga1_proc_entry,
-		*iga2_entry = shared->iga2_proc_entry;
+	struct proc_dir_entry *viafb_entry = shared->proc_entry;
 
 	if (!viafb_entry)
 		return;
 
-	remove_proc_entry("output_devices", iga2_entry);
+	remove_proc_entry("output_devices", shared->iga2_proc_entry);
 	remove_proc_entry("iga2", viafb_entry);
-	remove_proc_entry("output_devices", iga1_entry);
+	remove_proc_entry("output_devices", shared->iga1_proc_entry);
 	remove_proc_entry("iga1", viafb_entry);
 	remove_proc_entry("supported_output_devices", viafb_entry);
 
-- 
2.9.0

