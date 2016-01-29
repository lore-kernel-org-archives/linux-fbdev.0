From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Fri, 29 Jan 2016 14:03:22 +0000
Subject: [PATCH tip v7 1/7] video: Use bool instead int pointer for get_opt_bool() argument
Message-Id: <1454076208-28354-2-git-send-email-daniel.wagner@bmw-carit.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
In-Reply-To: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun.feng@gmail.com>, Maik Broemme <mbroemme@plusserver.de>, Ralf Baechle <ralf@linux-mips.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>

As the function name already indicates that get_opt_bool() parses
for a bool. It is not a surprise that compiler is complaining
about it when -Werror=incompatible-pointer-types is used:

drivers/video/fbdev/intelfb/intelfbdrv.c: In function ‘intelfb_setup’:
drivers/video/fbdev/intelfb/intelfbdrv.c:353:39: error: passing argument 3 of ‘get_opt_bool’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   if (get_opt_bool(this_opt, "accel", &accel))

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
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

