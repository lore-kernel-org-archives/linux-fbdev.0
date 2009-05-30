From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bugme-new] [Bug 13285] New: INTELFB:
 Colors display incorrectly
Date: Sat, 30 May 2009 13:58:33 +0200
Message-ID: <20090530135833.6a2c1bb2.krzysztof.h1@poczta.fm>
References: <bug-13285-10286@http.bugzilla.kernel.org/>
	<20090512151934.d7e6c54e.akpm@linux-foundation.org>
	<20090517081743.92002707.krzysztof.h1@poczta.fm>
	<20090516231932.2e02647b.akpm@linux-foundation.org>
	<20090517123032.2b8bad00.krzysztof.h1@poczta.fm>
	<a5d587fb0905170807j4cf60ce7ucf675cc6161e7850@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a5d587fb0905170807j4cf60ce7ucf675cc6161e7850@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Michal Suchanek <hramrach@centrum.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, samanddeanus@yahoo.com, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The intelfb driver sets color map depending on currently active pipe. However, if an LVDS 
display is attached (like in laptop) the active pipe variable is never set. The default value is 
PIPE_A and can be wrong.
Set up the pipe variable during driver initialization after hardware state was read.

Also, the detection of the active display (and hence the pipe) is wrong. The pipes are assigned
to so called planes. Both pipes are always enabled on my laptop but only one plane is enabled
(the plane A for the CRT or the plane B for the LVDS). Change active pipe detection code
to take into account a status of the plane assigned to each pipe.

The problem is visible in the 8 bpp mode if colors above 15 are used. The first 16 color
entries are displayed correctly.

The graphics chip description is here (G45 vol. 3):
http://intellinuxgraphics.org/documentation.html

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
The second version of the fix to this problem. Now, it is much more sophisticated
based on the knowledge gained from documentation available at http://intellinuxgraphics.org/.

It does not change a default behaviour (assumed pipe A) for all cases except the case that only 
the plane assigned to the pipe B is active. It is enough to fix the issue for me.

Please test it.

diff -urp linux-ref/drivers/video/intelfb/intelfbdrv.c linux-2.6.30-rc7/drivers/video/intelfb/intelfbdrv.c
--- linux-ref/drivers/video/intelfb/intelfbdrv.c	2009-05-23 23:47:00.000000000 +0200
+++ linux-2.6.30-rc7/drivers/video/intelfb/intelfbdrv.c	2009-05-29 07:37:27.000000000 +0200
@@ -874,6 +874,9 @@ static int __devinit intelfb_pci_registe
 	if (bailearly == 18)
 		bailout(dinfo);
 
+	/* read active pipe */
+	dinfo->pipe = intelfbhw_active_pipe(&dinfo->save_state);
+
 	/* Cursor initialisation */
 	if (dinfo->hwcursor) {
 		intelfbhw_cursor_init(dinfo);
diff -urp linux-ref/drivers/video/intelfb/intelfbhw.c linux-2.6.30-rc7/drivers/video/intelfb/intelfbhw.c
--- linux-ref/drivers/video/intelfb/intelfbhw.c	2009-05-23 23:47:00.000000000 +0200
+++ linux-2.6.30-rc7/drivers/video/intelfb/intelfbhw.c	2009-05-29 07:42:06.000000000 +0200
@@ -469,6 +469,32 @@ void intelfbhw_do_blank(int blank, struc
 }
 
 
+/* Check which pipe is connected to an active display plane. */
+int intelfbhw_active_pipe(const struct intelfb_hwstate *hw)
+{
+	int pipe = -1;
+
+	/* keep old default behaviour - prefer PIPE_A */
+	if (hw->disp_b_ctrl & DISPPLANE_PLANE_ENABLE) {
+		pipe = (hw->disp_b_ctrl >> DISPPLANE_SEL_PIPE_SHIFT);
+		pipe &= PIPE_MASK;
+		if (unlikely(pipe == PIPE_A))
+			return PIPE_A;
+	}
+	if (hw->disp_a_ctrl & DISPPLANE_PLANE_ENABLE) {
+		pipe = (hw->disp_a_ctrl >> DISPPLANE_SEL_PIPE_SHIFT);
+		pipe &= PIPE_MASK;
+		if (likely(pipe == PIPE_A))
+			return PIPE_A;
+	}
+	/* Impossible that no pipe is selected - return PIPE_A */
+	WARN_ON(pipe == -1);
+	if (unlikely(pipe == -1))
+		pipe = PIPE_A;
+
+	return pipe;
+}
+
 void intelfbhw_setcolreg(struct intelfb_info *dinfo, unsigned regno,
 			 unsigned red, unsigned green, unsigned blue,
 			 unsigned transp)
@@ -1019,7 +1045,7 @@ int intelfbhw_mode_to_hw(struct intelfb_
 			 struct intelfb_hwstate *hw,
 			 struct fb_var_screeninfo *var)
 {
-	int pipe = PIPE_A;
+	int pipe = intelfbhw_active_pipe(hw);
 	u32 *dpll, *fp0, *fp1;
 	u32 m1, m2, n, p1, p2, clock_target, clock;
 	u32 hsync_start, hsync_end, hblank_start, hblank_end, htotal, hactive;
@@ -1033,12 +1059,6 @@ int intelfbhw_mode_to_hw(struct intelfb_
 	/* Disable VGA */
 	hw->vgacntrl |= VGA_DISABLE;
 
-	/* Check whether pipe A or pipe B is enabled. */
-	if (hw->pipe_a_conf & PIPECONF_ENABLE)
-		pipe = PIPE_A;
-	else if (hw->pipe_b_conf & PIPECONF_ENABLE)
-		pipe = PIPE_B;
-
 	/* Set which pipe's registers will be set. */
 	if (pipe == PIPE_B) {
 		dpll = &hw->dpll_b;
@@ -1262,7 +1282,6 @@ int intelfbhw_mode_to_hw(struct intelfb_
 int intelfbhw_program_mode(struct intelfb_info *dinfo,
 			   const struct intelfb_hwstate *hw, int blank)
 {
-	int pipe = PIPE_A;
 	u32 tmp;
 	const u32 *dpll, *fp0, *fp1, *pipe_conf;
 	const u32 *hs, *ht, *hb, *vs, *vt, *vb, *ss;
@@ -1272,7 +1291,7 @@ int intelfbhw_program_mode(struct intelf
 	u32 src_size_reg;
 	u32 count, tmp_val[3];
 
-	/* Assume single pipe, display plane A, analog CRT. */
+	/* Assume single pipe */
 
 #if VERBOSE > 0
 	DBG_MSG("intelfbhw_program_mode\n");
@@ -1283,15 +1302,9 @@ int intelfbhw_program_mode(struct intelf
 	tmp |= VGA_DISABLE;
 	OUTREG(VGACNTRL, tmp);
 
-	/* Check whether pipe A or pipe B is enabled. */
-	if (hw->pipe_a_conf & PIPECONF_ENABLE)
-		pipe = PIPE_A;
-	else if (hw->pipe_b_conf & PIPECONF_ENABLE)
-		pipe = PIPE_B;
+	dinfo->pipe = intelfbhw_active_pipe(hw);
 
-	dinfo->pipe = pipe;
-
-	if (pipe == PIPE_B) {
+	if (dinfo->pipe == PIPE_B) {
 		dpll = &hw->dpll_b;
 		fp0 = &hw->fpb0;
 		fp1 = &hw->fpb1;
diff -urp linux-ref/drivers/video/intelfb/intelfbhw.h linux-2.6.30-rc7/drivers/video/intelfb/intelfbhw.h
--- linux-ref/drivers/video/intelfb/intelfbhw.h	2009-05-23 23:47:00.000000000 +0200
+++ linux-2.6.30-rc7/drivers/video/intelfb/intelfbhw.h	2009-05-29 07:43:54.000000000 +0200
@@ -604,5 +604,6 @@ extern void intelfbhw_cursor_reset(struc
 extern int intelfbhw_enable_irq(struct intelfb_info *dinfo);
 extern void intelfbhw_disable_irq(struct intelfb_info *dinfo);
 extern int intelfbhw_wait_for_vsync(struct intelfb_info *dinfo, u32 pipe);
+extern int intelfbhw_active_pipe(const struct intelfb_hwstate *hw);
 
 #endif /* _INTELFBHW_H */



----------------------------------------------------------------------
Kup wlasne mieszkanie za 33 tys. zl.
Sprawdz >>> http://link.interia.pl/f21a3


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
