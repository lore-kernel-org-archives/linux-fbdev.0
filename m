From: Sasha Levin <sashal@kernel.org>
Date: Wed, 13 Nov 2019 01:59:16 +0000
Subject: [PATCH AUTOSEL 4.9 52/68] backlight: lm3639: Unconditionally call led_classdev_unregister
Message-Id: <20191113015932.12655-52-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>, Lee Jones <lee.jones@linaro.org>

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 7cea645ae9c5a54aa7904fddb2cdf250acd63a6c ]

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

drivers/video/backlight/lm3639_bl.c:403:14: warning: address of
'pchip->cdev_torch' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (&pchip->cdev_torch)
        ~~   ~~~~~~~^~~~~~~~~~
drivers/video/backlight/lm3639_bl.c:405:14: warning: address of
'pchip->cdev_flash' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (&pchip->cdev_flash)
        ~~   ~~~~~~~^~~~~~~~~~
2 warnings generated.

These statements have been present since 2012, introduced by
commit 0f59858d5119 ("backlight: add new lm3639 backlight
driver"). Given that they have been called unconditionally since
then presumably without any issues, removing the always true if
statements to fix the warnings without any real world changes.

Link: https://github.com/ClangBuiltLinux/linux/issues/119
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3639_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index cd50df5807ead..086611c7bc03c 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -400,10 +400,8 @@ static int lm3639_remove(struct i2c_client *client)
 
 	regmap_write(pchip->regmap, REG_ENABLE, 0x00);
 
-	if (&pchip->cdev_torch)
-		led_classdev_unregister(&pchip->cdev_torch);
-	if (&pchip->cdev_flash)
-		led_classdev_unregister(&pchip->cdev_flash);
+	led_classdev_unregister(&pchip->cdev_torch);
+	led_classdev_unregister(&pchip->cdev_flash);
 	if (pchip->bled)
 		device_remove_file(&(pchip->bled->dev), &dev_attr_bled_mode);
 	return 0;
-- 
2.20.1
