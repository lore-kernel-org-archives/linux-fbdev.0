From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 13:34:05 +0000
Subject: [PATCH v3 4/4] fbcon: Change fbcon_init from module_init to fs_initcall
Message-Id: <1415885645-24613-4-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Various fb drivers register themselves before module_init so as to have a
console as early as possible, this is of little use if fbcon does not initialze
early too.

Fbcon cannot initialize earlier then fs_initcall, because then the creation
of /sys/class/graphics/fbcon will fail.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/console/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index eb976ee..ea43724 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3624,7 +3624,7 @@ static int __init fb_console_init(void)
 	return 0;
 }
 
-module_init(fb_console_init);
+fs_initcall(fb_console_init);
 
 #ifdef MODULE
 
-- 
2.1.0

