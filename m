From: =?ISO-8859-1?Q?Noralf_Tr=F8nnes?= <notro@tronnes.org>
Date: Thu, 22 Jan 2015 18:47:20 +0000
Subject: fbcon gives mirrored fonts on monochrome display
Message-Id: <54C145B8.6080204@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi,

I'm playing with a SSD1306 128x64 monochrome display and fbcon gives me=20
mirrored fonts and some extra lines.
Running fbtest gives me the expected output.

fbtest dump: http://tronnes.org/downloads/fbtest.png

fbcon dump: http://tronnes.org/downloads/fbcon.png
The text should have been:
Raspbian GNU/Lin

raspberrypi logi

fbcon font:VGA8x8: http://tronnes.org/downloads/fbcon8x8.png

ProFont6x11 gives indecipherable text lines:=20
http://tronnes.org/downloads/fbcon6x11.png

fbdev config:
   info->var.bits_per_pixel =3D 1;
   info->fix.visual =3D FB_VISUAL_MONO10;
   info->var.red.length =3D 1;
   info->var.red.offset =3D 0;
   info->var.green.length =3D 1;
   info->var.green.offset =3D 0;
   info->var.blue.length =3D 1;
   info->var.blue.offset =3D 0;
Uses: sys_fillrect, sys_copyarea, sys_imageblit (and deferred_io)

System: Raspberry Pi, ARM, Linux 3.18.3

Does anyone see what this might be?


Regards,
Noralf Tr=F8nnes

