From: simran singhal <singhalsimran0@gmail.com>
Date: Mon, 27 Feb 2017 18:26:26 +0000
Subject: [PATCH 3/5] staging: rtl8712: Remove unnecessary else after return
Message-Id: <1488219268-3006-3-git-send-email-singhalsimran0@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488219268-3006-1-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1488219268-3006-1-git-send-email-singhalsimran0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, outreachy-kernel@googlegroups.com

This patch fixes the checkpatch warning that else is not generally
useful after a break or return.

This was done using Coccinelle:
@@
expression e2;
statement s1;
@@
if(e2) { ... return ...; }
-else
         s1

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 8836b31..3062167 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -411,8 +411,7 @@ static int netdev_open(struct net_device *pnetdev)
 			goto netdev_open_error;
 		if (!padapter->dvobjpriv.inirp_init)
 			goto netdev_open_error;
-		else
-			padapter->dvobjpriv.inirp_init(padapter);
+		padapter->dvobjpriv.inirp_init(padapter);
 		r8712_set_ps_mode(padapter, padapter->registrypriv.power_mgnt,
 				  padapter->registrypriv.smart_ps);
 	}
-- 
2.7.4

