From: Colin King <colin.king@canonical.com>
Date: Thu, 14 Nov 2019 17:27:20 +0000
Subject: [PATCH][next] video: hyperv: hyperv_fb: fix indentation issue
Message-Id: <20191114172720.322023-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <sashal@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a block of statements that are indented
too deeply, remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/hyperv_fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 4cd27e5172a1..5fcf4bdf85ab 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -582,8 +582,8 @@ static int synthvid_get_supported_resolution(struct hv_device *hdev)
 	t = wait_for_completion_timeout(&par->wait, VSP_TIMEOUT);
 	if (!t) {
 		pr_err("Time out on waiting resolution response\n");
-			ret = -ETIMEDOUT;
-			goto out;
+		ret = -ETIMEDOUT;
+		goto out;
 	}
 
 	if (msg->resolution_resp.resolution_count = 0) {
-- 
2.20.1
