From: Heiko Schocher <hs@denx.de>
Date: Thu, 11 Jun 2015 09:24:41 +0000
Subject: Re: video, sm501: add OF binding to support SM501
Message-Id: <557953D9.6080202@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150610155132.GK10549@mwanda>
In-Reply-To: <20150610155132.GK10549@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello Dan,

Am 10.06.2015 17:51, schrieb Dan Carpenter:
> Hello Heiko Schocher,
>
> The patch 4295f9bf74a8: "video, sm501: add OF binding to support
> SM501" from Jan 26, 2011, leads to the following static checker
> warning:
>
> 	drivers/video/fbdev/sm501fb.c:1958 sm501fb_probe()
> 	warn: strcpy() 'cp' of unknown size might be too large for 'fb_mode'
>
> drivers/video/fbdev/sm501fb.c
>      46  static char *fb_mode =3D "640x480-16@60";
>
> 	[ snip ]
>
>    1953                  info->pdata =3D &sm501fb_def_pdata;
>    1954                  if (np) {
>    1955                          /* Get EDID */
>    1956                          cp =3D of_get_property(np, "mode", &len);
>    1957                          if (cp)
>    1958                                  strcpy(fb_mode, cp);
>
> I don't know anything about this hardware but there might be a mode
> longer than "640x480-16@60"?

Hmm... I just used it with this resolution, but you are right, the
datasheet says "200 MHz DAC support 1280=D71024 resolution" ... so, in
this case fb_mode would be to short ... I propose such a fix:

$ git diff
diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 9e74e8f..2e57f2e 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -43,7 +43,9 @@

  #include "edid.h"

-static char *fb_mode =3D "640x480-16@60";
+static char *fb_default_mode =3D "640x480-16@60";
+static char fb_mode[20];
+static char *fb_mode_cmdline;
  static unsigned long default_bpp =3D 16;

  static struct fb_videomode sm501_default_mode =3D {
@@ -1963,6 +1965,11 @@ static int sm501fb_probe(struct platform_device *pde=
v)
                                 if (info->edid_data)
                                         found =3D 1;
                         }
+               } else {
+                       if (fb_mode_cmdline)
+                               strcpy(fb_mode, fb_mode_cmdline);
+                       else
+                               strcpy(fb_mode, fb_default_mode);
                 }
  #endif
                 if (!found) {
@@ -2230,7 +2237,7 @@ static struct platform_driver sm501fb_driver =3D {

  module_platform_driver(sm501fb_driver);

-module_param_named(mode, fb_mode, charp, 0);
+module_param_named(mode, fb_mode_cmdline, charp, 0);
  MODULE_PARM_DESC(mode,
         "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
  module_param_named(bpp, default_bpp, ulong, 0);

What do you think? If this is OK from your side, I can post this patch
"officially" ...

bye,
Heiko
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
