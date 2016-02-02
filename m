From: Kai Ruhnau <kai.ruhnau@target-sg.com>
Date: Tue, 02 Feb 2016 08:43:04 +0000
Subject: RE: [PATCH] fbdev: ssd1307fb: Fix activating the charge pump on ssd1306
Message-Id: <AM2PR02MB037110CD69158B142DD396E1C5DF0@AM2PR02MB0371.eurprd02.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454339039-4976-1-git-send-email-kai.ruhnau@target-sg.com>
In-Reply-To: <1454339039-4976-1-git-send-email-kai.ruhnau@target-sg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi,

I just saw that the same thing was already fixed by Julian in November, sor=
ry for doubling this.

Best regards
Kai


-----Original Message-----
From: Kai Ruhnau
Sent: Montag, 1. Februar 2016 16:04
To: plagnioj@jcrosoft.com; tomi.valkeinen@ti.com
Cc: niederp@physik.uni-kl.de; linux-fbdev@vger.kernel.org; Kai Ruhnau <kai.=
ruhnau@target-sg.com>
Subject: [PATCH] fbdev: ssd1307fb: Fix activating the charge pump on ssd1306

The charge pump is activated by sending 0x14 where the higher bit is
always 1 and the lower bit actually toggles it.

Signed-off-by: Kai Ruhnau <kai.ruhnau@target-sg.com>
---
 drivers/video/fbdev/ssd1307fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index fa34808..20d249f 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -285,7 +285,7 @@ static void ssd1307fb_deferred_io(struct fb_info *info,
 static int ssd1307fb_init(struct ssd1307fb_par *par)
 {
        int ret;
-       u32 precharge, dclk, com_invdir, compins;
+       u32 precharge, dclk, com_invdir, compins, chargepump;

        if (par->device_info->need_pwm) {
                par->pwm =3D pwm_get(&par->client->dev, NULL);
@@ -388,8 +388,8 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
        if (ret < 0)
                return ret;

-       ret =3D ssd1307fb_write_cmd(par->client,
-               (par->device_info->need_chargepump & 0x1 << 2) & 0x14);
+       chargepump =3D 0x10 | (par->device_info->need_chargepump & 0x1) << =
2;
+       ret =3D ssd1307fb_write_cmd(par->client, chargepump);
        if (ret < 0)
                return ret;

--
2.4.3

--
Kai Ruhnau
Software Manager
T:+49 202 769302 19

Target Systemelektronik GmbH & Co. KG
Heinz-Fangman-Stra=DFe 4
42287 Wuppertal

Amtsgericht Wuppertal HRA 23898
Pers=F6nlich haftende Gesellschafterin
Target Systemelektronik Beteiligungs GmbH
Heinz-Fangman-Stra=DFe 4, 42287 Wuppertal
Amtsgericht Wuppertal HRB 25346
Gesch=E4ftsf=FChrer: J=FCrgen Stein
--
--
Kai Ruhnau
Software Manager
T:+49 202 769302 19

Target Systemelektronik GmbH & Co. KG
Heinz-Fangman-Stra=DFe 4
42287 Wuppertal

Amtsgericht Wuppertal HRA 23898
Pers=F6nlich haftende Gesellschafterin
Target Systemelektronik Beteiligungs GmbH
Heinz-Fangman-Stra=DFe 4, 42287 Wuppertal
Amtsgericht Wuppertal HRB 25346
Gesch=E4ftsf=FChrer: J=FCrgen Stein
--
