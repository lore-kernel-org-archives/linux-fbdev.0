From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 13:34:04 +0000
Subject: [PATCH v3 3/4] simplefb: Change simplefb_init from module_init to fs_initcall
Message-Id: <1415885645-24613-3-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

One of the reasons for having the simplefb nodes in /chosen, and doing
explicit enumeration of the nodes there, is too allow enumerating them sooner,
so that we get a console earlier on.

Doing this earlier then fs_initcall is not useful, since the fb only turns into
a console when fbcon intializes, which is a fs_initcall too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Grant Likely <grant.likely@linaro.org>
---
 drivers/video/fbdev/simplefb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 223f230..1028a0d 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -409,7 +409,11 @@ static void __exit simplefb_exit(void)
 	platform_driver_unregister(&simplefb_driver);
 }
 
-module_init(simplefb_init);
+/*
+ * While this can be a module, if builtin it's most likely the console
+ * So let's leave module_exit but move module_init to an earlier place
+ */
+fs_initcall(simplefb_init);
 module_exit(simplefb_exit);
 
 MODULE_AUTHOR("Stephen Warren <swarren@wwwdotorg.org>");
-- 
2.1.0

