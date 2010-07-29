From: Ondrej Zary <linux@rainbow-software.org>
Date: Thu, 29 Jul 2010 20:40:54 +0000
Subject: [PATCH] cyber2000fb: fix console in truecolor modes
Message-Id: <201007292240.55525.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201007282159.19583.linux@rainbow-software.org>
In-Reply-To: <201007282159.19583.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Return value was not set to 0 in setcolreg() with truecolor modes. This causes
fb_set_cmap() to abort after first color, resulting in blank palette - and
blank console in 24bpp and 32bpp modes.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.35-rc3-/drivers/video/cyber2000fb.c	2010-07-29 22:27:28.000000000 +0200
+++ linux-2.6.35-rc3/drivers/video/cyber2000fb.c	2010-07-29 22:29:04.000000000 +0200
@@ -392,6 +392,7 @@ cyber2000fb_setcolreg(u_int regno, u_int
 		pseudo_val |= convert_bitfield(red, &var->red);
 		pseudo_val |= convert_bitfield(green, &var->green);
 		pseudo_val |= convert_bitfield(blue, &var->blue);
+		ret = 0;
 		break;
 	}
 


-- 
Ondrej Zary
