From: Risto Suominen <risto.suominen@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb: hide cursor in graphics mode
Date: Mon, 23 Feb 2009 08:53:57 +0200
Message-ID: <46e1c7760902222253p34a714bao5c06b0ad4d779337@mail.gmail.com>
References: <46e1c7760901230433i3045f273oa109ce97e790bca3@mail.gmail.com>
	 <46e1c7760901240649v1e45bbb1v8c9997f236a3ec4c@mail.gmail.com>
	 <46e1c7760902101337qe239336n9ef2652a47f89aed@mail.gmail.com>
	 <46e1c7760902101350r5a04d076j49cc611a843e6429@mail.gmail.com>
	 <20090211142409.b88c577e.akpm@linux-foundation.org>
	 <46e1c7760902121312o1476e734xc1fc1d6e11ce4d2e@mail.gmail.com>
	 <20090213210635.d094ffc8.krzysztof.h1@poczta.fm>
	 <20090222081517.567a29bd.krzysztof.h1@poczta.fm>
	 <46e1c7760902220125l61700421gc4045ca10ea4dd10@mail.gmail.com>
	 <20090222164052.dd5442c4.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753218AbZBWGyT@vger.kernel.org>
In-Reply-To: <20090222164052.dd5442c4.krzysztof.h1@poczta.fm>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: adaplas@pol.net, Andrew Morton <akpm@linux-foundation.org>, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Krzysztof, my patch is basically the same as yours. I already tried
to send it to Xorg mailing list, but did not receive any feedback.

Risto

If virtual resolution is higher than the screen (as in atyfb), and yoffset
given by the framebuffer driver happens to be non-zero (fbcon changes it on-
the-fly), Xfbdev places its image starting above the displayed part of the
framebuffer. This patch makes sure that the whole picture is visible.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
The testing is done on version 1.1.1 and linux kernel version 2.6.18.

--- a/hw/kdrive/fbdev/fbdev.c.org       2006-07-05 21:31:39.000000000 +0300
+++ b/hw/kdrive/fbdev/fbdev.c   2009-01-18 15:42:06.000000000 +0200
@@ -215,6 +215,8 @@ fbdevScreenInitialize (KdScreenInfo *scr

     /* Now get the new screeninfo */
     ioctl (priv->fd, FBIOGET_VSCREENINFO, &priv->var);
+    /* We can get anything into yoffset if fbcon is active */
+    priv->var.yoffset = 0;
     depth = priv->var.bits_per_pixel;
     gray = priv->var.grayscale;
