From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 04 Mar 2013 12:58:19 +0000
Subject: [PATCH -v3 11/23] video/uvesafb: rename random32() to prandom_u32()
Message-Id: <1362401911-14074-12-git-send-email-akinobu.mita@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362401911-14074-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1362401911-14074-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Michal Januszewski <spock@gentoo.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

Use more preferable function name which implies using a pseudo-random
number generator.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Michal Januszewski <spock@gentoo.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---

No change from v2

 drivers/video/uvesafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index b75db01..0d0a43c 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -166,7 +166,7 @@ static int uvesafb_exec(struct uvesafb_ktask *task)
 	memcpy(&m->id, &uvesafb_cn_id, sizeof(m->id));
 	m->seq = seq;
 	m->len = len;
-	m->ack = random32();
+	m->ack = prandom_u32();
 
 	/* uvesafb_task structure */
 	memcpy(m + 1, &task->t, sizeof(task->t));
-- 
1.8.1.2

