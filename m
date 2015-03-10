From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 08:57:39 +0000
Subject: [PATCH v3 5/5] staging: sm750fb: fix build failure
Message-Id: <1425977139-25285-5-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425977139-25285-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425977139-25285-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

for powerpc-allyesconfig build failed with an error of g_option
undeclared. we will get this error on all architecture if MODULE is
not defined. fixed the declaration of g_option.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v3: new entry in the series, it was not there till v2.

 drivers/staging/sm750fb/sm750.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 476dc5c..8c260ee 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -54,9 +54,7 @@ static const char * g_fbmode[] = {NULL,NULL};
 static const char * g_def_fbmode = "800x600-16@60";
 static char * g_settings = NULL;
 static int g_dualview = 0;
-#ifdef MODULE
 static char * g_option = NULL;
-#endif
 
 /* if not use spin_lock,system will die if user load driver
  * and immediatly unload driver frequently (dual)*/
-- 
1.8.1.2

