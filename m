From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <notro@tronnes.org>
Date: Thu, 22 Jan 2015 19:55:36 +0000
Subject: Re: fbcon gives mirrored fonts on monochrome display
Message-Id: <54C155B8.1040403@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54C145B8.6080204@tronnes.org>
In-Reply-To: <54C145B8.6080204@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Geert,

Den 22.01.2015 20:44, skrev Geert Uytterhoeven:
> Hi Noralf,
>
> On Thu, Jan 22, 2015 at 7:47 PM, Noralf Tr=C3=B8nnes <notro@tronnes.org> =
wrote:
>> I'm playing with a SSD1306 128x64 monochrome display and fbcon gives me
>> mirrored fonts and some extra lines.
>> fbdev config:
>>    info->var.bits_per_pixel =3D 1;
>>    info->fix.visual =3D FB_VISUAL_MONO10;
>>    info->var.red.length =3D 1;
>>    info->var.red.offset =3D 0;
>>    info->var.green.length =3D 1;
>>    info->var.green.offset =3D 0;
>>    info->var.blue.length =3D 1;
>>    info->var.blue.offset =3D 0;
>> Uses: sys_fillrect, sys_copyarea, sys_imageblit (and deferred_io)
>>
>> System: Raspberry Pi, ARM, Linux 3.18.3
>>
>> Does anyone see what this might be?
> What's the value on CONFIG_FB_CFB_REV_PIXELS_IN_BYTE in your .config?
$ zgrep CONFIG_FB_CFB_REV_PIXELS_IN_BYTE /proc/config.gz
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set

> Does your driver set FB_NONSTD_REV_PIX_IN_B?
No it doesn't. I also tried setting it now, with no effect:
info->var.nonstd =3D FB_NONSTD_REV_PIX_IN_B;

