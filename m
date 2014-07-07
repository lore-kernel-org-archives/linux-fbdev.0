From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 07 Jul 2014 12:26:54 +0000
Subject: Re: [Intel-gfx] [PATCH 5/5] drm/i915: Kick out vga console
Message-Id: <20140707122654.GQ5821@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401980308-5116-1-git-send-email-daniel.vetter@ffwll.ch>
 <20140630065955.GD7687@nuc-i3427.alporthouse.com>
 <20140707084826.GH5821@phenom.ffwll.local>
 <1974170.pJAPFfvtjC@grover>
In-Reply-To: <1974170.pJAPFfvtjC@grover>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-fbdev@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Mon, Jul 07, 2014 at 06:45:49AM -0400, Ed Tomlinson wrote:
> Daniel,
> 
> I am not quite sure I understand what you want me to test?
> Do you want me to try it without:
> 
> > > +               if (ret = 0) {
> > > +                       ret = do_unregister_con_driver(&vga_con);

Below the diff of what I mean.
-Daniel


diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
index 5e583a1838f8..bd8517151479 100644
--- a/drivers/gpu/drm/i915/i915_dma.c
+++ b/drivers/gpu/drm/i915/i915_dma.c
@@ -1466,12 +1466,13 @@ static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
 #else
 static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
 {
-	int ret;
+	int ret = 0;
 
 	DRM_INFO("Replacing VGA console driver\n");
 
 	console_lock();
-	ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
+	if (con_is_bound(&vga_con))
+		ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
 	if (ret = 0) {
 		ret = do_unregister_con_driver(&vga_con);
 
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
