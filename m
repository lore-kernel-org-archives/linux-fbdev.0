From: Sasha Levin <sashal@kernel.org>
Date: Wed, 13 Nov 2019 01:55:50 +0000
Subject: [PATCH AUTOSEL 4.14 083/115] fbdev: sbuslib: integer overflow in sbusfb_ioctl_helper()
Message-Id: <20191113015622.11592-83-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mathieu Malaterre <malat@debian.org>, dri-devel@lists.freedesktop.org, Philippe Ombredanne <pombredanne@nexb.com>, Dan Carpenter <dan.carpenter@oracle.com>, Peter Malone <peter.malone@gmail.com>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e5017716adb8aa5c01c52386c1b7470101ffe9c5 ]

The "index + count" addition can overflow.  Both come directly from the
user.  This bug leads to an information leak.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Peter Malone <peter.malone@gmail.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sbuslib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index 90c51330969c2..01a7110e61a76 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -171,7 +171,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		    get_user(ublue, &c->blue))
 			return -EFAULT;
 
-		if (index + count > cmap->len)
+		if (index > cmap->len || count > cmap->len - index)
 			return -EINVAL;
 
 		for (i = 0; i < count; i++) {
-- 
2.20.1
