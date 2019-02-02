From: Yifeng Li <tomli@tomli.me>
Date: Sat, 02 Feb 2019 06:16:46 +0000
Subject: [PATCH 6/8] Documentation: fb: sm712fb: add information mainly about 2D.
Message-Id: <20190202061648.30374-7-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190202061648.30374-1-tomli@tomli.me>
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

This commits add information about 32-bit color, 2D acceleration,
as well as adding additional, general information about the hardware
and many existing problems of the sm712fb driver.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 Documentation/fb/sm712fb.txt | 123 +++++++++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 13 deletions(-)

diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.txt
index c388442edf51..906b48aa40e4 100644
--- a/Documentation/fb/sm712fb.txt
+++ b/Documentation/fb/sm712fb.txt
@@ -1,31 +1,128 @@
 What is sm712fb?
 ======== 
-This is a graphics framebuffer driver for Silicon Motion SM712 based processors.
+"sm712fb" is a graphics framebuffer driver for Silicon Motion SM710 (LynxEM),
+SM712 (LynxEM+), and SM720 (Lynx3DM, Lynx3DM+, aka. LynxEM4+) series of
+video controllers. This series of video controller is a legacy from ~1998,
+and was used on many classic, "prehistoric" laptops from 1998-2004, such as
+IBM Thinkpad S30 and 240X. It was also used on some servers, industrial
+computers, x86 and non-x86 embedded devices where only basic graphics was
+needed.
+
+Notably, Lemote YeeLoong 8089, a MIPS laptop based on the Chinese Loongson
+2F MIPS processor, is also using this chip because of hardware constraints,
+and at a time, somewhat popular in the free software community due the
+fact that it was the first laptop powered exclusively by free software,
+and it was also an inexpensive platform for non-x86 hobbyists to explore.
 
 How to use it?
 =======
 
-Switching modes is done using the video=sm712fb:... boot parameter.
-
-If you want, for example, enable a resolution of 1280x1024x24bpp you should
-pass to the kernel this command line: "video=sm712fb:0x31B".
+You should not compile-in vesafb, since SM7xx can be used in a VGA
+compatible mode, resulting conflicts with this driver. In addition,
+the VGA compatible mode was never tested by the maintainers.
 
-You should not compile-in vesafb.
+Currently, the driver supports 3 modes: 640x480, 800x600, 1024x768,
+at 16, 24 or 32-bit depth. Switching modes is done using the
+`video=sm712fb:0x___` boot parameter. If you want, for example,
+enable a resolution of 1280x1024x24bpp, you should pass to the kernel
+this command line: "video=sm712fb:0x31B".
 
-Currently supported video modes are:
+Please consult the following table for the hexadecimal codes of
+different modes.
 
 [Graphic modes]
 
-bpp | 640x480  800x600  1024x768  1280x1024
-----+--------------------------------------------
-  8 | 0x301    0x303    0x305    0x307
- 16 | 0x311    0x314    0x317    0x31A
- 24 | 0x312    0x315    0x318    0x31B
+bpp | 640x480  800x600  1024x768
+----+---------------------------
+ 16 | 0x311    0x314    0x317
+ 24 | 0x312    0x315    0x318
+ 32 | 0x329    0x32E    0x338
+
+32-bit is really 8:8:8:8, but the final 8-bit number is an "empty"
+alpha channel, it's otherwise equal to 24-bit color. However, they
+could still be useful. For example, "fbterm" supports 32-bit mode
+but not 24-bit mode.
+
+Notes about Modesetting
+============
+
+The modesetting code in sm712fb has major problems.
+
+* Switching to 8-bit color mode will result in a black screen, so
+they are removed from the list of supported graphic modes. But they
+can still be switched to on-the-fly, don't do that then!
+
+* Only a refresh rate of 60 Hz is supported.
+
+* 1024x768 with 16-bit color is not really supported, because the
+registers have been hacked by the original developer to adapt
+the 1024x600 screen on Lemote YeeLoong 8089.
+
+* If you are using a Lemote YeeLoong 8089, please remember that only
+the 1024x768 modes are guaranteed to drive the LCD panel properly.
+Other modes are meant to drive a CRT, and may drive the LCD incorrectly
+and result in a white screen with random garbage. External VGA output is
+unaffected.
+
+Due to the way registers are hardcoded, it's impossible to fix them
+without a major code rewrite. If you've been hit by these problems badly
+and really need to get them fixed, please contact the driver maintainers.
+
+2D acceleration
+=======
+
+Without 2D acceleration, the framebuffer suffers from extremely low performance,
+even scrolling a single line of text on the console required an unaccelerated
+screen redraw. Thus, 2D acceleration is enable by default. However, currently
+it's only supported on SM710/712 with Little-Endian CPUs. Big-endian and
+SM720 devices are currently not supported.
+
+2D acceleration can be controlled using the `video=sm712fb:accel:1` parameter.
+The default option, "1" activate 2D acceleration. If you have problems, you can
+set "0" to disable it. Different options can be separated by a comma, for
+example, "video=sm712fb:0x31B,accel:0" set the resolution to 1280x1024x24bpp
+while disabling the 2D acceleration.
+
+Although it has been extensively tested by the maintainer, 2D acceleration
+in 24-bit color mode may still have minor issues. If you've encounter any
+screen glitches in 24-bit mode in Linux framebuffer the framebuffer, don't
+hurry disabling it, you should try switching to 32-bit mode first, normally
+it should fix the problem. If you can reliably reproduce the screen glitches,
+please report your method to the maintainers.
 
 Missing Features
 ========
 (alias TODO list)
 
-	* 2D acceleratrion
+The following features are not implemented in this driver,
+
+	* 2D acceleration on SM720 and Big-Endian CPUs.
+	* More VGA modes.
 	* dual-head support
+	* hardware cursor support
+
+The first feature is planned to be implemented soon, but the maintainer
+does not receive any monetary or hardware support from any company or OEMs,
+and he has to purchase a test platform personally. The 1998's hardware
+still costs 200 USD+, so don't expected an ETA. If you have a Big-Endian
+platform and willing to help testing, please contact the maintainer, thanks!
+
+Other VGA modes, dual-head, or hardware cursor support should be possible to
+implement, but parts of the code must be rewritten, and there's little demand
+for them on this legacy (retro?) platform, so there's no plan to implement them.
+If you have a genuine need for them, please contact the maintainers.
+
+Maintainers
+========
+
+This driver is maintained by
+
+	* Tom Li <tomli@tomli.me>
+	* Sudip Mukherjee <sudipm.mukherjee@gmail.com>
+	* Teddy Wang <teddy.wang@siliconmotion.com>
+
+Tom Li was the last contributor of this driver who implemented 2D acceleration,
+and is the main author of this documentation, please send any bug reports or
+requests to Tom, but don't forget to CC other maintainers as well to make everyone
+be informed.
-- 
2.20.1
