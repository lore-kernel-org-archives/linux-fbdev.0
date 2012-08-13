From: Wang YanQing <udknight@gmail.com>
Date: Mon, 13 Aug 2012 10:02:32 +0000
Subject: [PATCH] video:uvesafb: check the return value of kzalloc
Message-Id: <20120813100232.GA16363@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, spock@gentoo.org


Michal maybe forgot it merely, we should add code
to check the return value of kzalloc to make the
code more robust.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 drivers/video/uvesafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index b0e2a42..2f8f82d 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -659,6 +659,8 @@ static int __devinit uvesafb_vbe_getedid(struct uvesafb_ktask *task,
 	task->t.flags = TF_BUF_RET | TF_BUF_ESDI;
 	task->t.buf_len = EDID_LENGTH;
 	task->buf = kzalloc(EDID_LENGTH, GFP_KERNEL);
+	if (!task->buf)
+		return -ENOMEM;
 
 	err = uvesafb_exec(task);
 
-- 
1.7.11.1.116.g8228a23
