From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Fri, 29 Jan 2016 13:23:25 +0000
Subject: [PATCH] video: Use bool instead int pointer for get_opt_bool() argument
Message-Id: <1454073805-14443-1-git-send-email-daniel.wagner@bmw-carit.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de>
In-Reply-To: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Maik Broemme <mbroemme@plusserver.de>, Daniel Wagner <daniel.wagner@bmw-carit.de>

As the function name already indicates that get_opt_bool() parses
for a bool. It is not a surprise that compiler is complaining
about it when -Werror=incompatible-pointer-types is used:

drivers/video/fbdev/intelfb/intelfbdrv.c: In function ‘intelfb_setup’:
drivers/video/fbdev/intelfb/intelfbdrv.c:353:39: error: passing argument 3 of ‘get_opt_bool’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   if (get_opt_bool(this_opt, "accel", &accel))

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
Hi,

In the 'simple wait queue support' series is a patch
which turns on -Werror=incompatible-pointer-types which will
result in a compile error for intelfb.

https://lkml.org/lkml/2016/1/28/462

Even if that patch wont make it, this one makes sense (at least
for me :))

I'll prepend this patch to the next version of the series in order
to see if I got rid of all incompatible pointer types errors caught
by the kbuild test robot.

cheers,
daniel

drivers/video/fbdev/intelfb/intelfbdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index bbec737..bf20744 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -302,7 +302,7 @@ static __inline__ int get_opt_int(const char *this_opt, const char *name,
 }
 
 static __inline__ int get_opt_bool(const char *this_opt, const char *name,
-				   int *ret)
+				   bool *ret)
 {
 	if (!ret)
 		return 0;
-- 
2.5.0

