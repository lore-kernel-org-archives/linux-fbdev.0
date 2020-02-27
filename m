From: Walter Harms <wharms@bfs.de>
Date: Thu, 27 Feb 2020 11:15:55 +0000
Subject: AW: [PATCH][V2] backlight: sky81452: insure while loop does not allow negative array indexing
Message-Id: <cb14e57edc1c4f3a81b0aef6f1099b9c@bfs.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200226195826.6567-1-colin.king@canonical.com>
In-Reply-To: <20200226195826.6567-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>, Bryan Wu <cooloney@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

hi all,
i would suggest converting this in to a more common for() loop.
Programmers are bad in counting backwards. that kind of bug is 
common.

re,
 wh
________________________________________
Von: kernel-janitors-owner@vger.kernel.org <kernel-janitors-owner@vger.kernel.org> im Auftrag von Colin King <colin.king@canonical.com>
Gesendet: Mittwoch, 26. Februar 2020 20:58
An: Lee Jones; Daniel Thompson; Jingoo Han; Bartlomiej Zolnierkiewicz; Gyungoh Yoo; Bryan Wu; dri-devel@lists.freedesktop.org; linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
Betreff: [PATCH][V2] backlight: sky81452: insure while loop does not allow negative array indexing

From: Colin Ian King <colin.king@canonical.com>

In the unlikely event that num_entry is zero, the while loop
pre-decrements num_entry to cause negative array indexing into the
array sources. Fix this by iterating only if num_entry >= 0.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: f705806c9f35 ("backlight: Add support Skyworks SKY81452 backlight driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: fix typo in commit subject line

---
 drivers/video/backlight/sky81452-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 2355f00f5773..f456930ce78e 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -200,7 +200,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
                }

                pdata->enable = 0;
-               while (--num_entry)
+               while (--num_entry >= 0)
                        pdata->enable |= (1 << sources[num_entry]);
 
              int i;
                for(i=0;i<num_entry;i++)
                         pdata->enable |= (1 << sources[i]);

        }

--
2.25.0
