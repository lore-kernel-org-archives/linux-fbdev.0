From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 17:28:57 +0000
Subject: [PATCH 6/6] staging: sm750fb: correct integer comparison
Message-Id: <1426007817-1884-7-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

fixed the build warning about comparison of pointer and integer.
end of string was being compared to NULL.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 021b863..5532a28 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1000,7 +1000,7 @@ static void sm750fb_setup(struct lynx_share * share,char * src)
             goto NO_PARAM;
         }
 
-        while((opt = strsep(&src,":")) != NULL && *opt != NULL){
+        while((opt = strsep(&src,":")) != NULL && *opt != 0){
 			pr_err("opt=%s\n",opt);
 			pr_err("src=%s\n",src);
 
-- 
1.8.1.2

