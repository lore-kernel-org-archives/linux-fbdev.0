From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Mon, 30 Jun 2014 06:59:55 +0000
Subject: Re: [PATCH 5/5] drm/i915: Kick out vga console
Message-Id: <20140630065955.GD7687@nuc-i3427.alporthouse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401980308-5116-1-git-send-email-daniel.vetter@ffwll.ch>
 <1401980308-5116-5-git-send-email-daniel.vetter@ffwll.ch>
 <1602327.OGkKxHtt2b@grover> <3945293.Jtp4nyZMfX@grover>
In-Reply-To: <3945293.Jtp4nyZMfX@grover>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-fbdev@vger.kernel.org, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Herrmann <dh.herrmann@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Sat, Jun 28, 2014 at 11:55:19PM -0400, Ed Tomlinson wrote:
> On Saturday 28 June 2014 15:28:22 Ed Tomlinson wrote:
> 
> Resend without html krud which causes list to bounce the message.
> 
> > Hi
> > 
> > This commit ( a4de05268e674e8ed31df6348269e22d6c6a1803 ) hangs my boot with 3.16-git.  Reverting it lets the boot proceed. 
> > 
> > I have an i7 with a built-in i915 and an pcie r7 260x.  The R7 is the primary console.  The i915 is initialized
> > but does not have a physical display attached.
> > 
> > With the patch applied the boot stops at the messages:
> > 
> > [drm] Memory usable by graphics device = 2048M
> > [drm] Replacing VGA console driver

The issue looks like that we are ripping out the radeon fb_con whilst it
is active and that upsets everyone. In which case, I think the
compromise is:


diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
index 5f44581..4915f1d 100644
--- a/drivers/gpu/drm/i915/i915_dma.c
+++ b/drivers/gpu/drm/i915/i915_dma.c
@@ -1439,18 +1439,20 @@ static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
 #else
 static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
 {
-       int ret;
+       int ret = 0;
 
        DRM_INFO("Replacing VGA console driver\n");
 
        console_lock();
-       ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
-       if (ret = 0) {
-               ret = do_unregister_con_driver(&vga_con);
-
-               /* Ignore "already unregistered". */
-               if (ret = -ENODEV)
-                       ret = 0;
+       if (con_is_bound(&vga_con)) {
+               ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
+               if (ret = 0) {
+                       ret = do_unregister_con_driver(&vga_con);
+
+                       /* Ignore "already unregistered". */
+                       if (ret = -ENODEV)
+                               ret = 0;
+               }
        }
        console_unlock();

-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
