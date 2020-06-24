From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 24 Jun 2020 14:57:19 +0000
Subject: [PATCH 6/8] backlight: backlight: Supply description for function args in existing Kerneldocs
Message-Id: <20200624145721.2590327-7-lee.jones@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Andrew Zabolotny <zap@homelink.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jamey Hicks <jamey.hicks@hp.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

Kerneldoc syntax is used, but not complete.  Descriptions required.

Prevents warnings like:

 drivers/video/backlight/backlight.c:329: warning: Function parameter or member 'reason' not described in 'backlight_force_update'
 drivers/video/backlight/backlight.c:354: warning: Function parameter or member 'props' not described in 'backlight_device_register'

Cc: <stable@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jamey Hicks <jamey.hicks@hp.com>
Cc: Andrew Zabolotny <zap@homelink.ru>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 92d80aa0c0ef1..744ba58488e01 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -320,6 +320,7 @@ ATTRIBUTE_GROUPS(bl_device);
  * backlight_force_update - tell the backlight subsystem that hardware state
  *   has changed
  * @bd: the backlight device to update
+ * @reason: reason for update
  *
  * Updates the internal state of the backlight in response to a hardware event,
  * and generate a uevent to notify userspace
@@ -344,6 +345,7 @@ EXPORT_SYMBOL(backlight_force_update);
  * @devdata: an optional pointer to be stored for private driver use. The
  *   methods may retrieve it by using bl_get_data(bd).
  * @ops: the backlight operations structure.
+ * @props: pointer to backlight's properties structure.
  *
  * Creates and registers new backlight device. Returns either an
  * ERR_PTR() or a pointer to the newly allocated device.
-- 
2.25.1
