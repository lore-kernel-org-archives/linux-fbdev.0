From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 09 Oct 2018 13:30:34 +0000
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Message-Id: <20181009133036eucas1p1d83ef6809a5696d6e2de1f3406afeeba~b897iNlSV1315713157eucas1p1e@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
        <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
        <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
        <CGME20181009002056epcas5p24207204c9e65e8f34382de6672adb993@epcas5p2.samsung.com>
        <20181009002031.GU3587@dragon>
        <20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c@eucas1p2.samsung.com>
        <bfbfd490-3872-2fd9-e088-3add596b987c@ysoft.com>
        <CAOMZO5DdV9Sm9z6wX8e4LTvbokjnOMqtgOJQOvVvysVvzaBKGw@mail.gmail.com>
        <221a185c-19fc-cc89-49b1-aa77fb1f0e41@ysoft.com>
In-Reply-To: <221a185c-19fc-cc89-49b1-aa77fb1f0e41@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Cc: Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


On 10/09/2018 03:18 PM, Vokáč Michal wrote:
> On 9.10.2018 14:36, Fabio Estevam wrote:
>> Hi Michal,
>>
>> On Tue, Oct 9, 2018 at 5:30 AM Vokáč Michal <Michal.Vokac@ysoft.com> wrote:
>>
>>> Sorry for the inconvenience :( Lesson learned..
>>>
>>> So in other words (no offense): broken drivers need to stay broken because
>>> users may already get used to the broken behavior?
>>
>> In order to keep the old dtb's working you could introduce a new
>> property (like reset-gpio-active-low, for example).
>>
>> Then the driver behavior can be made untouched for the old dtb's and
>> only new dtb's with this new property would have the correct GPIO
>> reset behavior.
> 
> Thank you very much Fabio!
> I saw these xxx-active-low/high properties in many device tree
> sources wondering why the heck people use them when they could
> use GPIO_ACTIVE_LOW/HIGH. And this is the explanation.
> 
> And I feel like an idiot once again: git grep -l "reset-active-low"
> first hit is:
> 
>   Documentation/devicetree/bindings/display/ssd1307fb.txt
> 
> Oooops.
> The weird thing is that usage of reset-active-low is documented
> in the example but it is not implemented.
> 
> So the patch no.2 should be reverted and patch no.3 not applied at all.

OK, I've applied the patch below to fbdev-for-next tree.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From 64f83a816b27c7b5e026a74ecb5c61dbabfae997 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 9 Oct 2018 15:18:42 +0200
Subject: [PATCH] Revert "video: ssd1307fb: Do not hard code active-low reset
 sequence"

This reverts commit 9827f26374fb85e1811f2adbcc25c8a3992dbe7f.

On 10/09/2018 02:20 AM, Shawn Guo wrote:

> Well, it means the change breaks the ABI between kernel and device tree,
> e.g. the new kernel will not work with existing/installed DTBs.

Revert the change until DTB compatibility issue is resolved.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 3b361bc..4061a20 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -667,10 +667,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	if (par->reset) {
 		/* Reset the screen */
-		gpiod_set_value_cansleep(par->reset, 1);
-		udelay(4);
 		gpiod_set_value_cansleep(par->reset, 0);
 		udelay(4);
+		gpiod_set_value_cansleep(par->reset, 1);
+		udelay(4);
 	}
 
 	if (par->vbat_reg) {
-- 
1.9.1
