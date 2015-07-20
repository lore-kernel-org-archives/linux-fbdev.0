From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Mon, 20 Jul 2015 20:46:47 +0000
Subject: likely signedness bug in drm and nvidia drivers
Message-Id: <87fv4io8ug.fsf@rasmusvillemoes.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Antonino Daplas <adaplas@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

The files

  drivers/gpu/drm/nouveau/nv50_fbcon.c
  drivers/gpu/drm/nouveau/nvc0_fbcon.c
  drivers/video/fbdev/nvidia/nv_accel.c

all contain a right-shift of ~0 (aka -1) - just grep for '~0 >>'. gcc
always does arithmetic right shift of signed types, which means that the
result is always -1 again [type promotion/conversion doesn't kick in
until after the shift subexpression has been evaluated], independent of
the second operand. I can hardly believe that is intended (the result is
used as a mask, which thus consists of all 1s). If these are indeed
bugs, the patch is obvious (just make the literal an unsigned 0).

Rasmus
