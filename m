From: Guillem Jover <guillem@debian.org>
Subject: [PATCH 1/7] fbset: update fb.h from linux 2.6.18
Date: Mon, 9 Oct 2006 05:23:36 +0300
Message-ID: <20061009022336.GA9011@zulo.hadrons.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWlcQ-0007gm-CS for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 20:15:54 -0700
Received: from 159.red-81-184-118.user.auna.net ([81.184.118.159]
	helo=pulsar.hadrons.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GWlcO-0004O9-Lb
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 20:15:54 -0700
Received: from guillem by pulsar.hadrons.org with local (Exim 4.50)
	id 1GWkqQ-00067O-8U for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 04:26:18 +0200
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This is a serie of patches coming from the Debian package that I
should have sent upstream long ago. I'm sending them anyway now,
even if supposedly fbset has to be replaced with fbutils, as there
hasn't been any release of it either since 1999.

This first one, updates fb.h to the latest kernel release. I've
removed the stuff inside __KERNEL__ as it's not useful anyway from
userland.

regards,
guillem

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset_01_kernel_fb.h.patch"

--- fb.h	1999-06-23 17:09:48.000000000 +0300
+++ fb.h	2006-10-09 03:08:22.000000000 +0300
@@ -5,12 +5,8 @@
 
 /* Definitions of frame buffers						*/
 
-#define FB_MAJOR	29
-
-#define FB_MODES_SHIFT		5	/* 32 modes per framebuffer */
-#define FB_NUM_MINORS		256	/* 256 Minors               */
-#define FB_MAX			(FB_NUM_MINORS / (1 << FB_MODES_SHIFT))
-#define GET_FB_IDX(node)	(MINOR(node) >> FB_MODES_SHIFT)
+#define FB_MAJOR		29
+#define FB_MAX			32	/* sufficient for now */
 
 /* ioctls
    0x46 is 'F'								*/
@@ -20,12 +16,22 @@
 #define FBIOGETCMAP		0x4604
 #define FBIOPUTCMAP		0x4605
 #define FBIOPAN_DISPLAY		0x4606
+#define FBIO_CURSOR            _IOWR('F', 0x08, struct fb_cursor)
 /* 0x4607-0x460B are defined below */
 /* #define FBIOGET_MONITORSPEC	0x460C */
 /* #define FBIOPUT_MONITORSPEC	0x460D */
 /* #define FBIOSWITCH_MONIBIT	0x460E */
 #define FBIOGET_CON2FBMAP	0x460F
 #define FBIOPUT_CON2FBMAP	0x4610
+#define FBIOBLANK		0x4611		/* arg: 0 or vesa level + 1 */
+#define FBIOGET_VBLANK		_IOR('F', 0x12, struct fb_vblank)
+#define FBIO_ALLOC              0x4613
+#define FBIO_FREE               0x4614
+#define FBIOGET_GLYPH           0x4615
+#define FBIOGET_HWCINFO         0x4616
+#define FBIOPUT_MODEINFO        0x4617
+#define FBIOGET_DISPINFO        0x4618
+
 
 #define FB_TYPE_PACKED_PIXELS		0	/* Packed Pixels	*/
 #define FB_TYPE_PLANES			1	/* Non interleaved planes */
@@ -73,14 +79,61 @@
 #define FB_ACCEL_MATROX_MGAG100	20	/* Matrox G100 (Productiva G100) */
 #define FB_ACCEL_MATROX_MGAG200	21	/* Matrox G200 (Myst, Mill, ...) */
 #define FB_ACCEL_SUN_CG14	22	/* Sun cgfourteen		 */
-#define FB_ACCEL_SUN_BWTWO	23	/* Sun bwtwo			 */
-#define FB_ACCEL_SUN_CGTHREE	24	/* Sun cgthree			 */
-#define FB_ACCEL_SUN_TCX	25	/* Sun tcx			 */
-#define FB_ACCEL_MATROX_MGAG400	26	/* Matrox G400			 */
+#define FB_ACCEL_SUN_BWTWO	23	/* Sun bwtwo			*/
+#define FB_ACCEL_SUN_CGTHREE	24	/* Sun cgthree			*/
+#define FB_ACCEL_SUN_TCX	25	/* Sun tcx			*/
+#define FB_ACCEL_MATROX_MGAG400	26	/* Matrox G400			*/
+#define FB_ACCEL_NV3		27	/* nVidia RIVA 128              */
+#define FB_ACCEL_NV4		28	/* nVidia RIVA TNT		*/
+#define FB_ACCEL_NV5		29	/* nVidia RIVA TNT2		*/
+#define FB_ACCEL_CT_6555x	30	/* C&T 6555x			*/
+#define FB_ACCEL_3DFX_BANSHEE	31	/* 3Dfx Banshee			*/
+#define FB_ACCEL_ATI_RAGE128	32	/* ATI Rage128 family		*/
+#define FB_ACCEL_IGS_CYBER2000	33	/* CyberPro 2000		*/
+#define FB_ACCEL_IGS_CYBER2010	34	/* CyberPro 2010		*/
+#define FB_ACCEL_IGS_CYBER5000	35	/* CyberPro 5000		*/
+#define FB_ACCEL_SIS_GLAMOUR    36	/* SiS 300/630/540              */
+#define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
+#define FB_ACCEL_ATI_RADEON	38	/* ATI Radeon family		*/
+#define FB_ACCEL_I810           39      /* Intel 810/815                */
+#define FB_ACCEL_SIS_GLAMOUR_2  40	/* SiS 315, 650, 740		*/
+#define FB_ACCEL_SIS_XABRE      41	/* SiS 330 ("Xabre")		*/
+#define FB_ACCEL_I830           42      /* Intel 830M/845G/85x/865G     */
+#define FB_ACCEL_NV_10          43      /* nVidia Arch 10               */
+#define FB_ACCEL_NV_20          44      /* nVidia Arch 20               */
+#define FB_ACCEL_NV_30          45      /* nVidia Arch 30               */
+#define FB_ACCEL_NV_40          46      /* nVidia Arch 40               */
+#define FB_ACCEL_XGI_VOLARI_V	47	/* XGI Volari V3XT, V5, V8      */
+#define FB_ACCEL_XGI_VOLARI_Z	48	/* XGI Volari Z7                */
+#define FB_ACCEL_NEOMAGIC_NM2070 90	/* NeoMagic NM2070              */
+#define FB_ACCEL_NEOMAGIC_NM2090 91	/* NeoMagic NM2090              */
+#define FB_ACCEL_NEOMAGIC_NM2093 92	/* NeoMagic NM2093              */
+#define FB_ACCEL_NEOMAGIC_NM2097 93	/* NeoMagic NM2097              */
+#define FB_ACCEL_NEOMAGIC_NM2160 94	/* NeoMagic NM2160              */
+#define FB_ACCEL_NEOMAGIC_NM2200 95	/* NeoMagic NM2200              */
+#define FB_ACCEL_NEOMAGIC_NM2230 96	/* NeoMagic NM2230              */
+#define FB_ACCEL_NEOMAGIC_NM2360 97	/* NeoMagic NM2360              */
+#define FB_ACCEL_NEOMAGIC_NM2380 98	/* NeoMagic NM2380              */
+
+#define FB_ACCEL_SAVAGE4        0x80	/* S3 Savage4                   */
+#define FB_ACCEL_SAVAGE3D       0x81	/* S3 Savage3D                  */
+#define FB_ACCEL_SAVAGE3D_MV    0x82	/* S3 Savage3D-MV               */
+#define FB_ACCEL_SAVAGE2000     0x83	/* S3 Savage2000                */
+#define FB_ACCEL_SAVAGE_MX_MV   0x84	/* S3 Savage/MX-MV              */
+#define FB_ACCEL_SAVAGE_MX      0x85	/* S3 Savage/MX                 */
+#define FB_ACCEL_SAVAGE_IX_MV   0x86	/* S3 Savage/IX-MV              */
+#define FB_ACCEL_SAVAGE_IX      0x87	/* S3 Savage/IX                 */
+#define FB_ACCEL_PROSAVAGE_PM   0x88	/* S3 ProSavage PM133           */
+#define FB_ACCEL_PROSAVAGE_KM   0x89	/* S3 ProSavage KM133           */
+#define FB_ACCEL_S3TWISTER_P    0x8a	/* S3 Twister                   */
+#define FB_ACCEL_S3TWISTER_K    0x8b	/* S3 TwisterK                  */
+#define FB_ACCEL_SUPERSAVAGE    0x8c    /* S3 Supersavage               */
+#define FB_ACCEL_PROSAVAGE_DDR  0x8d	/* S3 ProSavage DDR             */
+#define FB_ACCEL_PROSAVAGE_DDRK 0x8e	/* S3 ProSavage DDR-K           */
 
 struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */
-	char *smem_start;		/* Start of frame buffer mem */
+	unsigned long smem_start;	/* Start of frame buffer mem */
 					/* (physical address) */
 	__u32 smem_len;			/* Length of frame buffer mem */
 	__u32 type;			/* see FB_TYPE_*		*/
@@ -90,10 +143,11 @@ struct fb_fix_screeninfo {
 	__u16 ypanstep;			/* zero if no hardware panning  */
 	__u16 ywrapstep;		/* zero if no hardware ywrap    */
 	__u32 line_length;		/* length of a line in bytes    */
-	char *mmio_start;		/* Start of Memory Mapped I/O   */
+	unsigned long mmio_start;	/* Start of Memory Mapped I/O   */
 					/* (physical address) */
 	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
-	__u32 accel;			/* Type of acceleration available */
+	__u32 accel;			/* Indicate to driver which	*/
+					/*  specific chip/card we have	*/
 	__u16 reserved[3];		/* Reserved for future compatibility */
 };
 
@@ -120,8 +174,10 @@ struct fb_bitfield {
 #define FB_ACTIVATE_VBL	       16	/* activate values on next vbl  */
 #define FB_CHANGE_CMAP_VBL     32	/* change colormap on vbl	*/
 #define FB_ACTIVATE_ALL	       64	/* change all VCs on this fb	*/
+#define FB_ACTIVATE_FORCE     128	/* force apply even when no change*/
+#define FB_ACTIVATE_INV_MODE  256       /* invalidate videomode */
 
-#define FB_ACCELF_TEXT		1	/* text mode acceleration */
+#define FB_ACCELF_TEXT		1	/* (OBSOLETE) see fb_info.flags and vc_mode */
 
 #define FB_SYNC_HOR_HIGH_ACT	1	/* horizontal sync high active	*/
 #define FB_SYNC_VERT_HIGH_ACT	2	/* vertical sync high active	*/
@@ -141,6 +197,17 @@ struct fb_bitfield {
 #define FB_VMODE_SMOOTH_XPAN	512	/* smooth xpan possible (internally used) */
 #define FB_VMODE_CONUPDATE	512	/* don't update x/yoffset	*/
 
+/*
+ * Display rotation support
+ */
+#define FB_ROTATE_UR      0
+#define FB_ROTATE_CW      1
+#define FB_ROTATE_UD      2
+#define FB_ROTATE_CCW     3
+
+#define PICOS2KHZ(a) (1000000000UL/(a))
+#define KHZ2PICOS(a) (1000000000UL/(a))
+
 struct fb_var_screeninfo {
 	__u32 xres;			/* visible resolution		*/
 	__u32 yres;
@@ -164,7 +231,7 @@ struct fb_var_screeninfo {
 	__u32 height;			/* height of picture in mm    */
 	__u32 width;			/* width of picture in mm     */
 
-	__u32 accel_flags;		/* acceleration flags (hints)	*/
+	__u32 accel_flags;		/* (OBSOLETE) see fb_info.flags */
 
 	/* Timing: All values in pixclocks, except pixclock (of course) */
 	__u32 pixclock;			/* pixel clock in ps (pico seconds) */
@@ -176,7 +243,8 @@ struct fb_var_screeninfo {
 	__u32 vsync_len;		/* length of vertical sync	*/
 	__u32 sync;			/* see FB_SYNC_*		*/
 	__u32 vmode;			/* see FB_VMODE_*		*/
-	__u32 reserved[6];		/* Reserved for future compatibility */
+	__u32 rotate;			/* angle we rotate counter clockwise */
+	__u32 reserved[5];		/* Reserved for future compatibility */
 };
 
 struct fb_cmap {
@@ -193,305 +261,111 @@ struct fb_con2fbmap {
 	__u32 framebuffer;
 };
 
-struct fb_monspecs {
-	__u32 hfmin;			/* hfreq lower limit (Hz) */
-	__u32 hfmax; 			/* hfreq upper limit (Hz) */
-	__u16 vfmin;			/* vfreq lower limit (Hz) */
-	__u16 vfmax;			/* vfreq upper limit (Hz) */
-	unsigned dpms : 1;		/* supports DPMS */
-};
-
-#ifdef __KERNEL__
-
-#include <linux/fs.h>
-
-
-struct fb_info;
-struct fb_info_gen;
-struct vm_area_struct;
-struct file;
-
-    /*
-     *  Frame buffer operations
-     */
-
-struct fb_ops {
-    /* open/release and usage marking */
-    int (*fb_open)(struct fb_info *info, int user);
-    int (*fb_release)(struct fb_info *info, int user);
-    /* get non settable parameters */
-    int (*fb_get_fix)(struct fb_fix_screeninfo *fix, int con,
-		      struct fb_info *info); 
-    /* get settable parameters */
-    int (*fb_get_var)(struct fb_var_screeninfo *var, int con,
-		      struct fb_info *info);		
-    /* set settable parameters */
-    int (*fb_set_var)(struct fb_var_screeninfo *var, int con,
-		      struct fb_info *info);		
-    /* get colormap */
-    int (*fb_get_cmap)(struct fb_cmap *cmap, int kspc, int con,
-		       struct fb_info *info);
-    /* set colormap */
-    int (*fb_set_cmap)(struct fb_cmap *cmap, int kspc, int con,
-		       struct fb_info *info);
-    /* pan display */
-    int (*fb_pan_display)(struct fb_var_screeninfo *var, int con,
-			  struct fb_info *info);
-    /* perform fb specific ioctl */
-    int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
-		    unsigned long arg, int con, struct fb_info *info);
-    /* perform fb specific mmap */
-    int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
-    /* switch to/from raster image mode */
-    int (*fb_rasterimg)(struct fb_info *info, int start);
-};
-
-
-   /*
-    *    This is the interface between the low-level console driver and the
-    *    low-level frame buffer device
-    */
-
-struct display {
-    /* Filled in by the frame buffer device */
-
-    struct fb_var_screeninfo var;   /* variable infos. yoffset and vmode */
-				    /* are updated by fbcon.c */
-    struct fb_cmap cmap;            /* colormap */
-    char *screen_base;              /* pointer to top of virtual screen */    
-				    /* (virtual address) */
-    int visual;
-    int type;                       /* see FB_TYPE_* */
-    int type_aux;                   /* Interleave for interleaved Planes */
-    u_short ypanstep;               /* zero if no hardware ypan */
-    u_short ywrapstep;              /* zero if no hardware ywrap */
-    u_long line_length;             /* length of a line in bytes */
-    u_short can_soft_blank;         /* zero if no hardware blanking */
-    u_short inverse;                /* != 0 text black on white as default */
-    struct display_switch *dispsw;  /* low level operations */
-    void *dispsw_data;		    /* optional dispsw helper data */
-
-#if 0
-    struct fb_fix_cursorinfo fcrsr;
-    struct fb_var_cursorinfo *vcrsr;
-    struct fb_cursorstate crsrstate;
-#endif
-
-    /* Filled in by the low-level console driver */
-
-    struct vc_data *conp;           /* pointer to console data */
-    struct fb_info *fb_info;        /* frame buffer for this console */
-    int vrows;                      /* number of virtual rows */
-    unsigned short cursor_x;	    /* current cursor position */
-    unsigned short cursor_y;
-    int fgcol;                      /* text colors */
-    int bgcol;
-    u_long next_line;               /* offset to one line below */
-    u_long next_plane;              /* offset to next plane */
-    u_char *fontdata;               /* Font associated to this display */
-    unsigned short _fontheightlog;
-    unsigned short _fontwidthlog;
-    unsigned short _fontheight;
-    unsigned short _fontwidth;
-    int userfont;                   /* != 0 if fontdata kmalloc()ed */
-    u_short scrollmode;             /* Scroll Method */
-    short yscroll;                  /* Hardware scrolling */
-    unsigned char fgshift, bgshift;
-    unsigned short charmask;	    /* 0xff or 0x1ff */
-};
-
-
-struct fb_info {
-   char modename[40];			/* default video mode */
-   kdev_t node;
-   int flags;
-#define FBINFO_FLAG_MODULE	1	/* Low-level driver is a module */
-   struct fb_ops *fbops;
-   struct fb_monspecs monspecs;
-   struct display *disp;		/* initial display variable */
-   struct vc_data *display_fg;		/* Console visible on this display */
-   char fontname[40];			/* default font name */
-   int (*changevar)(int);		/* tell console var has changed */
-   int (*switch_con)(int, struct fb_info*);
-					/* tell fb to switch consoles */
-   int (*updatevar)(int, struct fb_info*);
-					/* tell fb to update the vars */
-   void (*blank)(int, struct fb_info*);	/* tell fb to (un)blank the screen */
-					/* arg = 0: unblank */
-					/* arg > 0: VESA level (arg-1) */
-
-   /* From here on everything is device dependent */
-};
-
-#ifdef MODULE
-#define FBINFO_FLAG_DEFAULT	FBINFO_FLAG_MODULE
-#else
-#define FBINFO_FLAG_DEFAULT	0
-#endif
-
-    /*
-     *  This structure abstracts from the underlying hardware. It is not
-     *  mandatory but used by the `generic' frame buffer operations.
-     *  Read drivers/video/skeletonfb.c for more information.
-     */
-
-struct fbgen_hwswitch {
-    void (*detect)(void);
-    int (*encode_fix)(struct fb_fix_screeninfo *fix, const void *par,
-		      struct fb_info_gen *info);
-    int (*decode_var)(const struct fb_var_screeninfo *var, void *par,
-		      struct fb_info_gen *info);
-    int (*encode_var)(struct fb_var_screeninfo *var, const void *par,
-		      struct fb_info_gen *info);
-    void (*get_par)(void *par, struct fb_info_gen *info);
-    void (*set_par)(const void *par, struct fb_info_gen *info);
-    int (*getcolreg)(unsigned regno, unsigned *red, unsigned *green,
-		     unsigned *blue, unsigned *transp, struct fb_info *info);
-    int (*setcolreg)(unsigned regno, unsigned red, unsigned green,
-		     unsigned blue, unsigned transp, struct fb_info *info);
-    int (*pan_display)(const struct fb_var_screeninfo *var,
-		       struct fb_info_gen *info);
-    int (*blank)(int blank_mode, struct fb_info_gen *info);
-    void (*set_disp)(const void *par, struct display *disp,
-		     struct fb_info_gen *info);
-};
-
-struct fb_info_gen {
-    struct fb_info info;
-
-    /* Entries for a generic frame buffer device */
-    /* Yes, this starts looking like C++ */
-    u_int parsize;
-    struct fbgen_hwswitch *fbhw;
-
-   /* From here on everything is device dependent */
-};
-
-    /*
-     *  `Generic' versions of the frame buffer device operations
-     */
-
-extern int fbgen_get_fix(struct fb_fix_screeninfo *fix, int con,
-			 struct fb_info *info);
-extern int fbgen_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info);
-extern int fbgen_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info);
-extern int fbgen_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info);
-extern int fbgen_set_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info);
-extern int fbgen_pan_display(struct fb_var_screeninfo *var, int con,
-			     struct fb_info *info);
-extern int fbgen_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, unsigned long arg, int con,
-		       struct fb_info *info);
-
-    /*
-     *  Helper functions
-     */
-
-extern int fbgen_do_set_var(struct fb_var_screeninfo *var, int isactive,
-			    struct fb_info_gen *info);
-extern void fbgen_set_disp(int con, struct fb_info_gen *info);
-extern void fbgen_install_cmap(int con, struct fb_info_gen *info);
-extern int fbgen_update_var(int con, struct fb_info *info);
-extern int fbgen_switch(int con, struct fb_info *info);
-extern void fbgen_blank(int blank, struct fb_info *info);
-
-
-struct fb_videomode {
-    const char *name;
-    struct fb_var_screeninfo var;
-};
-
-
-/* drivers/char/fbmem.c */
-extern int register_framebuffer(struct fb_info *fb_info);
-extern int unregister_framebuffer(const struct fb_info *fb_info);
-extern int fbmon_valid_timings(u_int pixclock, u_int htotal, u_int vtotal,
-			       const struct fb_info *fb_info);
-extern int fbmon_dpms(const struct fb_info *fb_info);
-
-
-extern int num_registered_fb;
-extern struct fb_info *registered_fb[FB_MAX];
-extern char con2fb_map[MAX_NR_CONSOLES];
-
-/* drivers/video/fbcon.c */
-extern struct display fb_display[MAX_NR_CONSOLES];
-
-/* drivers/video/fbcmap.c */
-extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);
-extern void fb_copy_cmap(struct fb_cmap *from, struct fb_cmap *to,
-			 int fsfromto);
-extern int fb_get_cmap(struct fb_cmap *cmap, int kspc,
-		       int (*getcolreg)(u_int, u_int *, u_int *, u_int *,
-					u_int *, struct fb_info *),
-		       struct fb_info *fb_info);
-extern int fb_set_cmap(struct fb_cmap *cmap, int kspc,
-		       int (*setcolreg)(u_int, u_int, u_int, u_int, u_int,
-					struct fb_info *),
-		       struct fb_info *fb_info);
-extern struct fb_cmap *fb_default_cmap(int len);
-extern void fb_invert_cmaps(void);
-
 /* VESA Blanking Levels */
-#define VESA_NO_BLANKING	0
-#define VESA_VSYNC_SUSPEND	1
-#define VESA_HSYNC_SUSPEND	2
-#define VESA_POWERDOWN		3
-
-#endif /* __KERNEL__ */
-
-#if 1
-
-#define FBCMD_GET_CURRENTPAR	0xDEAD0005
-#define FBCMD_SET_CURRENTPAR	0xDEAD8005
-
-#endif
-
-
-#if 1 /* Preliminary */
-
-   /*
-    *    Hardware Cursor
-    */
-
-#define FBIOGET_FCURSORINFO     0x4607
-#define FBIOGET_VCURSORINFO     0x4608
-#define FBIOPUT_VCURSORINFO     0x4609
-#define FBIOGET_CURSORSTATE     0x460A
-#define FBIOPUT_CURSORSTATE     0x460B
-
-
-struct fb_fix_cursorinfo {
-	__u16 crsr_width;		/* width and height of the cursor in */
-	__u16 crsr_height;		/* pixels (zero if no cursor)	*/
-	__u16 crsr_xsize;		/* cursor size in display pixels */
-	__u16 crsr_ysize;
-	__u16 crsr_color1;		/* colormap entry for cursor color1 */
-	__u16 crsr_color2;		/* colormap entry for cursor color2 */
-};
-
-struct fb_var_cursorinfo {
-	__u16 width;
-	__u16 height;
-	__u16 xspot;
-	__u16 yspot;
-	__u8 data[1];			/* field with [height][width]        */
+#define VESA_NO_BLANKING        0
+#define VESA_VSYNC_SUSPEND      1
+#define VESA_HSYNC_SUSPEND      2
+#define VESA_POWERDOWN          3
+
+
+enum {
+	/* screen: unblanked, hsync: on,  vsync: on */
+	FB_BLANK_UNBLANK       = VESA_NO_BLANKING,
+
+	/* screen: blanked,   hsync: on,  vsync: on */
+	FB_BLANK_NORMAL        = VESA_NO_BLANKING + 1,
+
+	/* screen: blanked,   hsync: on,  vsync: off */
+	FB_BLANK_VSYNC_SUSPEND = VESA_VSYNC_SUSPEND + 1,
+
+	/* screen: blanked,   hsync: off, vsync: on */
+	FB_BLANK_HSYNC_SUSPEND = VESA_HSYNC_SUSPEND + 1,
+
+	/* screen: blanked,   hsync: off, vsync: off */
+	FB_BLANK_POWERDOWN     = VESA_POWERDOWN + 1
+};
+
+#define FB_VBLANK_VBLANKING	0x001	/* currently in a vertical blank */
+#define FB_VBLANK_HBLANKING	0x002	/* currently in a horizontal blank */
+#define FB_VBLANK_HAVE_VBLANK	0x004	/* vertical blanks can be detected */
+#define FB_VBLANK_HAVE_HBLANK	0x008	/* horizontal blanks can be detected */
+#define FB_VBLANK_HAVE_COUNT	0x010	/* global retrace counter is available */
+#define FB_VBLANK_HAVE_VCOUNT	0x020	/* the vcount field is valid */
+#define FB_VBLANK_HAVE_HCOUNT	0x040	/* the hcount field is valid */
+#define FB_VBLANK_VSYNCING	0x080	/* currently in a vsync */
+#define FB_VBLANK_HAVE_VSYNC	0x100	/* verical syncs can be detected */
+
+struct fb_vblank {
+	__u32 flags;			/* FB_VBLANK flags */
+	__u32 count;			/* counter of retraces since boot */
+	__u32 vcount;			/* current scanline position */
+	__u32 hcount;			/* current scandot position */
+	__u32 reserved[4];		/* reserved for future compatibility */
+};
+
+/* Internal HW accel */
+#define ROP_COPY 0
+#define ROP_XOR  1
+
+struct fb_copyarea {
+	__u32 dx;
+	__u32 dy;
+	__u32 width;
+	__u32 height;
+	__u32 sx;
+	__u32 sy;
+};
+
+struct fb_fillrect {
+	__u32 dx;	/* screen-relative */
+	__u32 dy;
+	__u32 width;
+	__u32 height;
+	__u32 color;
+	__u32 rop;
+};
+
+struct fb_image {
+	__u32 dx;		/* Where to place image */
+	__u32 dy;
+	__u32 width;		/* Size of image */
+	__u32 height;
+	__u32 fg_color;		/* Only used when a mono bitmap */
+	__u32 bg_color;
+	__u8  depth;		/* Depth of the image */
+	const char *data;	/* Pointer to image data */
+	struct fb_cmap cmap;	/* color map info */
 };
 
-struct fb_cursorstate {
-	__s16 xoffset;
-	__s16 yoffset;
-	__u16 mode;
-};
-
-#define FB_CURSOR_OFF		0
-#define FB_CURSOR_ON		1
-#define FB_CURSOR_FLASH		2
+/*
+ * hardware cursor control
+ */
 
-#endif /* Preliminary */
+#define FB_CUR_SETIMAGE 0x01
+#define FB_CUR_SETPOS   0x02
+#define FB_CUR_SETHOT   0x04
+#define FB_CUR_SETCMAP  0x08
+#define FB_CUR_SETSHAPE 0x10
+#define FB_CUR_SETSIZE	0x20
+#define FB_CUR_SETALL   0xFF
+
+struct fbcurpos {
+	__u16 x, y;
+};
+
+struct fb_cursor {
+	__u16 set;		/* what to set */
+	__u16 enable;		/* cursor on/off */
+	__u16 rop;		/* bitop operation */
+	const char *mask;	/* cursor mask bits */
+	struct fbcurpos hot;	/* cursor hot spot */
+	struct fb_image	image;	/* Cursor image */
+};
+
+#ifdef CONFIG_FB_BACKLIGHT
+/* Settings for the generic backlight code */
+#define FB_BACKLIGHT_LEVELS	128
+#define FB_BACKLIGHT_MAX	0xFF
+#endif
 
 #endif /* _LINUX_FB_H */

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--ZPt4rx8FFjLCG7dd--
