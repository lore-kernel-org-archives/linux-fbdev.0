From: Sasha Levin <sashal@kernel.org>
Date: Fri, 14 Feb 2020 15:41:27 +0000
Subject: [PATCH AUTOSEL 5.5 095/542] backlight: qcom-wled: Fix unsigned comparison to zero
Message-Id: <20200214154854.6746-95-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Kiran Gunda <kgunda@codeaurora.org>, Chen Zhou <chenzhou10@huawei.com>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Lee Jones <lee.jones@linaro.org>

From: Chen Zhou <chenzhou10@huawei.com>

[ Upstream commit 7af43a76695db71a57203793fb9dd3c81a5783b1 ]

Fixes coccicheck warning:
./drivers/video/backlight/qcom-wled.c:1104:5-15:
	WARNING: Unsigned expression compared with zero: string_len > 0

The unsigned variable string_len is assigned a return value from the call
to of_property_count_elems_of_size(), which may return negative error code.

Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Kiran Gunda <kgunda@codeaurora.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/qcom-wled.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index d46052d8ff415..3d276b30a78c9 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -956,8 +956,8 @@ static int wled_configure(struct wled *wled, int version)
 	struct wled_config *cfg = &wled->cfg;
 	struct device *dev = wled->dev;
 	const __be32 *prop_addr;
-	u32 size, val, c, string_len;
-	int rc, i, j;
+	u32 size, val, c;
+	int rc, i, j, string_len;
 
 	const struct wled_u32_opts *u32_opts = NULL;
 	const struct wled_u32_opts wled3_opts[] = {
-- 
2.20.1
