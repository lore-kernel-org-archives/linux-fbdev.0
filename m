From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Wed, 14 Jan 2015 16:38:30 +0000
Subject: RE: SSD1306 OLED driver
Message-Id: <BAY176-W4599C404BBB6DA5E337CB5D3410@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Greet,

>>
>>> pattern. Am I missing something.
>>
>> That's because that test requires 16 colors, although these aren't used.
>>
>> If you change ".numcolors =16" to ".numcolors =3D 2" in tests/test010.c,
>> it should at least draw some text, but the colors may be of as it
>> failed to install
>> the 16-color console pallette.
>>
> Thanks for your response, I did try with setting .numcolors =3D 2 but it =
doesnt help
> neither I still don=92t see 'Hello World' on the oled.
>
Sorry for back to back mails.

Is there any graphics library to draw text ? can directfb be used ?

Here is the verbose output of fbtest:
# ./fbtest -f /dev/fb0 -v -d
fb_init()
fb_open()
fb_get_var()
fb_get_fix()
fb_map()
fb_start =3D 0, fb_offset =3D 0, fb_len =3D 4000
fb_save()
fb_clear()
Using drawops cfb16 (16 bpp packed pixels)
clut_create_rgbcube(): RGB 8x8x8
Available visuals:
=A0 Monochrome
=A0 Grayscale 32
=A0 Truecolor 5:6:5:0
Using visops truecolor
Running all tests
Running test test001
test001: PASSED
Running test test002
test002: PASSED
Running test test003
test003: PASSED
Running test test004
test004: PASSED
Running test test005
clut_create_rgbcube(): RGB 8x8x8
test005: PASSED
Running test test006
test006: PASSED
Running test test007
Visual 6 not supported
Running test test008
test008: PASSED
Running test test009
Screen size too small for this test
Not applicable
Running test test010
test010: PASSED
Running test test011
No support for virtual screen and panning
Running test test012
Benchmarking... 10x10 squares: 70.19 Mpixels/s
Benchmarking... 20x20 squares: 163.23 Mpixels/s
Benchmarking... 50x50 squares: 451.62 Mpixels/s
test012: PASSED
fb_cleanup()
fb_restore()
fb_unmap()
fb_set_var()
fb_get_var()
fb_get_fix()
fb_close()

Thanks & Regards,
Sagar
 		 	   		  