From: Lior Balkohen <balkohen@gmail.com>
Subject: porting a driver to the new fbdev api - part 2
Date: Sun, 11 Sep 2005 14:03:38 +0200
Message-ID: <196b7d3105091105032ec2e67f@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEQYj-0001gC-PK
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 05:03:45 -0700
Received: from nproxy.gmail.com ([64.233.182.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EEQYi-0000sj-Mt
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 05:03:45 -0700
Received: by nproxy.gmail.com with SMTP id n15so764418nfc
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 11 Sep 2005 05:03:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

ok, apparently no attachments allowed in the list, so i'm sending the
source in plain.

/*  Xilleon 220 frame buffer driver
 *
 *  Copyright (C) 2002 MontaVista Software Inc.
 *
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/tty.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <asm/uaccess.h>
#include <linux/fb.h>
#include <linux/ioctl.h>
#include <linux/init.h>
#include <linux/pci.h>
#include <asm/io.h>

#include <video/fbcon.h>
#include <video/fbcon-mfb.h>
#include <video/fbcon-cfb16.h>
#include <video/fbcon-cfb24.h>
#include <video/fbcon-cfb32.h>

struct x220fb_config {
=09unsigned int fb_offset;
=09struct fb_var_screeninfo var;
};

#define X220_MAGIC 0xD8
#define FBIO_X220_CONFIG      _IOW (X220_MAGIC, 1, struct x220fb_config)
#define FBIO_X220_WAIT_ACLREQ _IOR (X220_MAGIC, 2, struct fb_var_screeninfo=
)
#define FBIO_X220_SET_DMS     _IOW (X220_MAGIC, 3, int)

// FIXME: just a guess and shouldn't be here
#define X220_MEM_BASE 0

#define X220_MODULE_NAME "X220FB"
#define PFX X220_MODULE_NAME

#define X220_DEBUG

#ifdef X220_DEBUG
#define dbg(format, arg...) \
    printk(KERN_DEBUG "%s: " format "\n" , __func__, ## arg)
#else
#define dbg(format, arg...) do {} while (0)
#endif
#define err(format, arg...) printk(KERN_ERR PFX ": " format "\n" , ## arg)
#define info(format, arg...) printk(KERN_INFO PFX ": " format "\n" , ## arg=
)
#define warn(format, arg...) printk(KERN_WARNING PFX ": " format "\n" , ## =
arg)
#define emerg(format, arg...) printk(KERN_EMERG PFX ": " format "\n" , ## a=
rg)

#define CMAPSIZE 16
#define arraysize(x)=09(sizeof(x)/sizeof(*(x)))

/* command line data, set in x220fb_setup() */
static char __initdata fontname[40] =3D { 0 };
static int accel =3D 0;
static int nodms =3D 0;

static const char *mode_option __initdata =3D NULL;

struct x220fb_par {
        struct fb_var_screeninfo var;

=09ssize_t fb_size;
=09int fb_order;

=09int line_length;  // in bytes
};

typedef enum {
=09IDLE =3D 0,
=09WAIT_IN_PROGRESS,
=09MODE_CHANGE_IN_PROGRESS
} x220fb_state_t;
=09

struct x220fb_info {
        struct fb_info_gen gen;
=09struct x220fb_par curpar;
=09struct x220fb_par reqpar;
        struct display disp;

        void *      fb_addr_virt;
        phys_addr_t fb_addr_phys;

=09int fake_offset;
=09x220fb_state_t state;
=09int dms;
=09
=09wait_queue_head_t aclreq_wait;
=09wait_queue_head_t setpar_wait;
        struct semaphore ioctl_sem;
        struct semaphore setpar_sem;
=09
=09struct {
=09=09unsigned red;
=09=09unsigned green;
=09=09unsigned blue;
=09=09unsigned alpha;
=09} palette[256];
};

static struct x220fb_info *fb_x220;

static char x220fb_name[16] =3D X220_MODULE_NAME;

static union {
#ifdef FBCON_HAS_CFB16
=09u16 cfb16[CMAPSIZE];
#endif
#ifdef FBCON_HAS_CFB24
=09u32 cfb24[CMAPSIZE];
#endif
#ifdef FBCON_HAS_CFB32
=09u32 cfb32[CMAPSIZE];
#endif
} fbcon_cmap;

static const struct fb_var_screeninfo x220_default_var =3D {
=09640, 480, 640, 480, 0, 0, 16, 0,
=09{0}, {0}, {0}, {0},
=090, FB_ACTIVATE_NOW, -1, -1, 0,
=090, 0, 0, 0, 0, 0, 0,
=090, FB_VMODE_NONINTERLACED
};

/*
 * These are just for documentation purposes - linux fb doesn't
 * distinguish between the different broadcast standards.
 */
#define FB_SYNC_PS2   0 // VGA
#define FB_SYNC_HD    FB_SYNC_BROADCAST
#define FB_SYNC_NTSC  FB_SYNC_BROADCAST
#define FB_SYNC_PAL   FB_SYNC_BROADCAST
#define FB_SYNC_SECAM FB_SYNC_BROADCAST

static const struct {
=09u32 xres;
=09u32 yres;
=09u32 vmode; // only holds interlaced vs. progressive info
=09u32 sync;  // only holds PS2 vs. brodcast info
}  acl_modes[] =3D {
=09{  640,  480, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
=09{  720,  480, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
=09{  720,  576, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
=09{  800,  600, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
=09{ 1024,  768, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
=09{ 1280,  720, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
=09{ 1920, 1080, FB_VMODE_INTERLACED   , FB_SYNC_PS2   },
=09{  720,  480, FB_VMODE_INTERLACED   , FB_SYNC_HD    },
=09{  720,  480, FB_VMODE_NONINTERLACED, FB_SYNC_HD    },
=09{  960,  540, FB_VMODE_NONINTERLACED, FB_SYNC_HD    },
=09{ 1280,  720, FB_VMODE_NONINTERLACED, FB_SYNC_HD    },
=09{ 1920, 1080, FB_VMODE_INTERLACED   , FB_SYNC_HD    },
=09{  720,  480, FB_VMODE_INTERLACED   , FB_SYNC_NTSC  },
=09{  720,  576, FB_VMODE_INTERLACED   , FB_SYNC_PAL   },
=09{  720,  576, FB_VMODE_INTERLACED   , FB_SYNC_SECAM }
};

=09
/* Interface used by the world */
int x220fb_init(void);
int x220fb_setup(char *options);

/* Hardware Specific Routines */
static int x220fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
=09=09=09u_long arg, int con, struct fb_info *info);
static void x220fb_detect (void);
static int x220fb_encode_fix (struct fb_fix_screeninfo *fix, const void *pa=
r,
=09=09=09=09struct fb_info_gen *info);
static int x220fb_decode_var (const struct fb_var_screeninfo *var, void *pa=
r,
=09=09=09=09struct fb_info_gen *info);
static int x220fb_encode_var (struct fb_var_screeninfo *var, const void *pa=
r,
=09=09=09=09struct fb_info_gen *info);
static void x220fb_get_par (void *par, struct fb_info_gen *info);
static void x220fb_set_par (const void *par, struct fb_info_gen *info);
static int x220fb_getcolreg (unsigned regno, unsigned *red, unsigned *green=
,
=09=09=09       unsigned *blue, unsigned *transp,
=09=09=09       struct fb_info *info);
static int x220fb_setcolreg (unsigned regno, unsigned red, unsigned green,
                            unsigned blue, unsigned transp,
=09=09=09       struct fb_info *info);
static int x220fb_pan_display (const struct fb_var_screeninfo *var,
=09=09=09=09 struct fb_info_gen *info);
static int x220fb_blank (int blank_mode, struct fb_info_gen *info);
static void x220fb_set_disp (const void *par, struct display *disp,
=09=09=09       struct fb_info_gen *info);

/* function table of the above functions */
static struct fb_ops x220fb_ops =3D {
        owner:          THIS_MODULE,
        fb_get_fix:     fbgen_get_fix,
        fb_get_var:     fbgen_get_var,
        fb_set_var:     fbgen_set_var,
        fb_get_cmap:    fbgen_get_cmap,
        fb_set_cmap:    fbgen_set_cmap,
        fb_pan_display: fbgen_pan_display,
        fb_ioctl:       x220fb_ioctl,
};

/* function table of the above functions */
static struct fbgen_hwswitch x220fb_hwswitch =3D
{
        x220fb_detect,
        x220fb_encode_fix,
        x220fb_decode_var,
        x220fb_encode_var,
        x220fb_get_par,
        x220fb_set_par,
        x220fb_getcolreg,
        x220fb_setcolreg,
        x220fb_pan_display,
        x220fb_blank,
        x220fb_set_disp
};


static void set_color_bitfields(struct fb_var_screeninfo *var)
{
=09switch (var->bits_per_pixel) {
=09case 16:=09/* ARGB1555 */
=09=09var->transp.offset =3D 15;
=09=09var->transp.length =3D 1;
=09=09var->red.offset =3D 10;
=09=09var->red.length =3D 5;
=09=09var->green.offset =3D 5;
=09=09var->green.length =3D 5;
=09=09var->blue.offset =3D 0;
=09=09var->blue.length =3D 5;
=09=09break;
=09case 32:=09/* ARGB 8888 */
=09=09var->transp.offset =3D 24;
=09=09var->transp.length =3D 8;
=09=09var->red.offset =3D 16;
=09=09var->red.length =3D 8;
=09=09var->green.offset =3D 8;
=09=09var->green.length =3D 8;
=09=09var->blue.offset =3D 0;
=09=09var->blue.length =3D 8;
=09=09break;
=09}

=09var->red.msb_right =3D 0;
=09var->green.msb_right =3D 0;
=09var->blue.msb_right =3D 0;
=09var->transp.msb_right =3D 0;
}


static void calc_par(struct x220fb_par *par,
=09=09     const struct fb_var_screeninfo *var)
{
=09memset(par, 0, sizeof(struct x220fb_par));

=09par->line_length =3D
=09=09var->xres_virtual * ((var->bits_per_pixel + 7) >> 3);
=09par->line_length =3D (par->line_length + 127) & ~127;

=09par->fb_size =3D par->line_length * var->yres_virtual;

=09par->fb_order =3D 0;
=09while (par->fb_size > (PAGE_SIZE * (1 << par->fb_order)))
=09=09par->fb_order++;

=09par->var =3D *var;

=09par->var.width =3D par->var.height =3D -1;
=09/* no virtual display support (no panning/scrolling) */
=09par->var.vmode &=3D FB_VMODE_MASK;
=09par->var.xoffset =3D par->var.yoffset =3D 0;
=09par->var.xres_virtual =3D par->var.xres;
=09par->var.yres_virtual =3D par->var.yres;
=09/* no accels */
=09par->var.accel_flags =3D 0;
=09par->var.sync &=3D FB_SYNC_BROADCAST;
=09
=09set_color_bitfields(&par->var);
}


static void x220fb_detect (void)
{
=09dbg("");
}


static int x220fb_encode_fix(struct fb_fix_screeninfo *fix,
=09=09=09=09const void* _par,
=09=09=09=09struct fb_info_gen* _info)
{
        struct x220fb_par *par =3D (struct x220fb_par *) _par;
        struct x220fb_info *info =3D (struct x220fb_info *) _info;
=09struct fb_var_screeninfo* var =3D &par->var;

=09down(&info->setpar_sem);

=09dbg("");

=09memset(fix, 0, sizeof(struct fb_fix_screeninfo));
=09strcpy(fix->id, x220fb_name);

=09fix->smem_start =3D info->fb_addr_phys;
=09fix->smem_len =3D par->fb_size;
=09fix->type =3D FB_TYPE_PACKED_PIXELS;
=09fix->type_aux =3D 0;
        fix->visual =3D (var->bits_per_pixel <=3D 8) ?
=09=09FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
=09fix->ywrapstep =3D 0;
=09fix->xpanstep =3D 1;
=09fix->ypanstep =3D 1;
=09fix->line_length =3D par->line_length;

=09up(&info->setpar_sem);

=09return 0;
}



static int x220fb_decode_var(const struct fb_var_screeninfo *var,
=09=09=09     void *_par,
=09=09=09     struct fb_info_gen *_info)
{
        struct x220fb_par *par =3D (struct x220fb_par *) _par;
        struct x220fb_info *info =3D (struct x220fb_info *) _info;
        struct fb_var_screeninfo *curvar =3D &info->curpar.var;
=09int i;
=09
=09dbg("");

=09if (!info->dms) {
=09=09if (var->xres !=3D curvar->xres ||
=09=09    var->yres !=3D curvar->yres) {
=09=09=09dbg("resolution doesn't match");
=09=09=09return -EINVAL;
=09=09}
=09=09
=09=09if ((var->vmode & FB_VMODE_MASK) !=3D
=09=09    (curvar->vmode & FB_VMODE_MASK)) {
=09=09=09dbg("interlace mode doesn't match");
=09=09=09return -EINVAL;
=09=09}
=09=09
=09=09if ((var->sync & FB_SYNC_BROADCAST) !=3D curvar->sync) {
=09=09=09dbg("sync mode doesn't match");
=09=09=09return -EINVAL;
=09=09}

=09=09if (var->bits_per_pixel !=3D curvar->bits_per_pixel) {
=09=09=09dbg("color depth doesn't match");
=09=09=09return -EINVAL;
=09=09}
=09}
=09
=09for (i=3D0; i < sizeof(acl_modes)/sizeof(acl_modes[0]); i++) {
=09=09if (var->xres =3D=3D acl_modes[i].xres &&
=09=09    var->yres =3D=3D acl_modes[i].yres &&
=09=09    (var->vmode & FB_VMODE_MASK) =3D=3D acl_modes[i].vmode &&
=09=09    (var->sync & FB_SYNC_BROADCAST) =3D=3D acl_modes[i].sync)
=09=09=09break;
=09}
=09if (i >=3D sizeof(acl_modes)/sizeof(acl_modes[0])) {
=09=09dbg("unsupported mode: %s %dx%d%c",
=09=09    (var->sync & FB_SYNC_BROADCAST) ? "Broadcast" : "VGA",
=09=09    var->xres, var->yres,
=09=09    (var->vmode & FB_VMODE_INTERLACED) ? 'i' : 'p');
=09=09return -EINVAL;
=09}

=09if (var->bits_per_pixel !=3D 32 && var->bits_per_pixel !=3D 16) {
=09=09dbg("unsupported color depth: %d bpp", var->bits_per_pixel);
=09=09return -EINVAL;
=09}
=09
=09calc_par(par, var);

=09if (!info->dms) {
=09=09/*
=09=09 *  check memory limit
=09=09 */
=09=09if (par->line_length * par->var.yres_virtual > par->fb_size) {
=09=09=09dbg("not enough video memory for res %dx%d-%dbpp!",
=09=09=09    par->var.xres_virtual, par->var.yres_virtual,
=09=09=09    par->var.bits_per_pixel);
=09=09=09return -ENOMEM;
=09=09}
=09}
=09
=09return 0;
}


static int  x220fb_encode_var(struct fb_var_screeninfo *var,
=09=09=09=09const void *par,
=09=09=09=09struct fb_info_gen *info)
{
=09dbg("");

=09*var =3D ((struct x220fb_par *)par)->var;
=09return 0;
}


static void x220fb_set_disp(const void *_par, struct display *disp,
=09=09=09      struct fb_info_gen *_info)
{
        struct x220fb_par *par =3D (struct x220fb_par *) _par;
        struct x220fb_info *info =3D (struct x220fb_info *) _info;

=09down(&info->setpar_sem);

=09dbg("");

=09disp->screen_base =3D (char *)info->fb_addr_virt;

=09switch (par->var.bits_per_pixel) {
#ifdef FBCON_HAS_CFB16
=09case 16:
=09=09disp->dispsw =3D &fbcon_cfb16;
=09=09disp->dispsw_data =3D fbcon_cmap.cfb16;
=09=09break;
#endif
#ifdef FBCON_HAS_CFB24
=09case 24:
=09=09disp->dispsw =3D &fbcon_cfb24;
=09=09disp->dispsw_data =3D fbcon_cmap.cfb24;
=09=09break;
#endif
#ifdef FBCON_HAS_CFB32
=09case 32:
=09=09disp->dispsw =3D &fbcon_cfb32;
=09=09disp->dispsw_data =3D fbcon_cmap.cfb32;
=09=09break;
#endif
=09default:
=09=09disp->dispsw =3D &fbcon_dummy;
=09=09disp->dispsw_data =3D NULL;
=09=09break;
=09}

=09up(&info->setpar_sem);
}



/*
 *  Blank the display.
 *
 * 0 unblank, 1 blank, 2 no vsync, 3 no hsync, 4 off
 */
static int x220fb_blank(int mode, struct fb_info_gen *_info)
{
=09/* not supported */
=09dbg("");
=09return -EINVAL;
}


/* get current video mode */
static void x220fb_get_par (void *_par, struct fb_info_gen *_info)
{
        struct x220fb_par *par =3D (struct x220fb_par *) _par;
        struct x220fb_info *info =3D (struct x220fb_info *) _info;

=09down(&info->setpar_sem);
=09dbg("");
        *par =3D info->curpar;
=09up(&info->setpar_sem);
}


static void x220fb_set_par(const void *_par, struct fb_info_gen *_info)
{
        struct x220fb_par *par =3D (struct x220fb_par *) _par;
        struct x220fb_info *info =3D (struct x220fb_info *) _info;
=09struct fb_var_screeninfo *curvar =3D &info->curpar.var;
=09struct fb_var_screeninfo *newvar =3D &par->var;
=09DECLARE_WAITQUEUE(wait, current);

=09dbg("%dx%d-%dbpp", newvar->xres, newvar->yres, newvar->bits_per_pixel);

=09if (!info->dms)
=09=09return;
=09
=09down(&info->setpar_sem);

=09if (newvar->xres !=3D curvar->xres ||
=09    newvar->yres !=3D curvar->yres ||
=09    newvar->bits_per_pixel !=3D curvar->bits_per_pixel) {
=09=09
=09=09if (info->state !=3D WAIT_IN_PROGRESS) {
=09=09=09dbg("invalid state (no daemon listening?)");
=09=09=09*par =3D info->curpar;
=09=09=09up(&info->setpar_sem);
=09=09=09return;
=09=09}
=09=09
=09=09/* wakeup ACL daemon waiting for a request... */
=09=09if (waitqueue_active(&info->aclreq_wait)) {
=09=09=09dbg("waking ACL daemon");
=09=09=09wake_up(&info->aclreq_wait);
=09=09}
=09=09
=09=09/* and give the daemon the requested par */
=09=09info->reqpar =3D *par;

=09=09dbg("waiting for ACL daemon to program mode");

=09=09/* now sleep waiting for ACL to complete the mode */
=09=09add_wait_queue(&info->setpar_wait, &wait);
=09=09__set_current_state(TASK_INTERRUPTIBLE);
=09=09schedule();
=09=09remove_wait_queue(&info->setpar_wait, &wait);
=09=09set_current_state(TASK_RUNNING);
=09=09dbg("ACL daemon done programming mode");
=09=09
=09=09/*
=09=09 * the requested mode may not have succeeded,
=09=09 * make sure we return the actual current mode
=09=09 * to the caller.
=09=09 */
=09=09*par =3D info->curpar;
=09}

=09up(&info->setpar_sem);
}


static int x220fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
=09=09=09  u_long arg, int con, struct fb_info *_info)
{
=09int fbidx =3D GET_FB_IDX(inode->i_rdev);
=09int dms_enb_dis, ret =3D 0;
        struct x220fb_info *info =3D (struct x220fb_info *) _info;
        struct fb_var_screeninfo *var;
        struct x220fb_par *curpar =3D &info->curpar;
=09struct x220fb_config cfg;
=09DECLARE_WAITQUEUE(wait, current);
=09extern int set_all_vcs(int, struct fb_ops *,
=09=09=09       struct fb_var_screeninfo *var,
=09=09=09       struct fb_info *);

=09/*
=09 * this mutex prevents reentrancy while sleeping in
=09 * WAIT_ACLREQ.
=09 */
=09down(&info->ioctl_sem);

=09dbg("");

=09switch (cmd) {
=09case FBIO_X220_SET_DMS:
=09=09/*
=09=09 * changing the DMS flag at weird times can
=09=09 * screw-up the mode-change state machine
=09=09 * (it should ony be done when info->state =3D IDLE),
=09=09 * but since only the daemon uses these custom
=09=09 * ioctls, and we must trust the daemon, we'll
=09=09 * allow it always.
=09=09 */
=09=09if (get_user(dms_enb_dis, (int *)(arg))) {
=09=09=09ret =3D -EFAULT;
=09=09=09break;
=09=09}
=09=09info->dms =3D dms_enb_dis;
=09=09info("Dynamic Mode Selection is %s",
=09=09     info->dms ? "ON" : "OFF");
=09=09break;
=09case FBIO_X220_CONFIG:
=09=09if (info->dms && info->state !=3D MODE_CHANGE_IN_PROGRESS) {
=09=09=09dbg("hey daemon, you're doing something stupid!");
=09=09=09ret =3D -EINVAL;
=09=09=09break;
=09=09}
=09=09=09
=09=09if (copy_from_user(&cfg, (void *)arg,
=09=09=09=09   sizeof(struct x220fb_config))) {
=09=09=09err("fault in copy_from_user");
=09=09=09ret =3D -EFAULT;
=09=09=09break;
=09=09}
=09=09
=09=09if (info->fake_offset) {
=09=09=09free_pages((unsigned long)info->fb_addr_virt,
=09=09=09=09   curpar->fb_order);
=09=09=09info->fake_offset =3D 0;
=09=09} else if (info->fb_addr_virt)
=09=09=09iounmap(info->fb_addr_virt);
=09=09
=09=09var =3D &cfg.var;
=09=09calc_par(curpar, var);

=09=09info->fb_addr_phys =3D X220_MEM_BASE + cfg.fb_offset;
=09=09info->fb_addr_virt =3D ioremap(info->fb_addr_phys,
=09=09=09=09=09     curpar->fb_size);
=09=09if (info->dms) {
=09=09=09/* wakeup FB app waiting for set_par to complete */
=09=09=09if (waitqueue_active(&info->setpar_wait)) {
=09=09=09=09dbg("CONFIG: waking FB app");
=09=09=09=09wake_up(&info->setpar_wait);
=09=09=09}
=09=09} else {
=09=09=09if (var->activate & FB_ACTIVATE_ALL)
=09=09=09=09set_all_vcs(fbidx, _info->fbops,
=09=09=09=09=09    var, _info);
=09=09=09else
=09=09=09=09_info->fbops->fb_set_var(var,
=09=09=09=09=09=09=09 PROC_CONSOLE(_info),
=09=09=09=09=09=09=09 _info);
=09=09}

=09=09// mode change cycle is complete, back to IDLE
=09=09info->state =3D IDLE;
=09=09info("CONFIG: FB at 0x%08x, mapped to %p, size %d",
=09=09     (u32)info->fb_addr_phys,
=09=09     info->fb_addr_virt,
=09=09     (int)curpar->fb_size);
=09=09info("CONFIG: mode set to %dx%d-%dbpp",
=09=09     var->xres, var->yres, var->bits_per_pixel);
=09=09break;
=09case FBIO_X220_WAIT_ACLREQ:
=09=09if (info->dms) {
=09=09=09if (info->state !=3D IDLE) {
=09=09=09=09dbg("hey daemon, you're doing "
=09=09=09=09    "something stupid!");
=09=09=09=09ret =3D -EINVAL;
=09=09=09=09break;
=09=09=09}
=09=09=09
=09=09=09dbg("WAIT_ACLREQ: waiting...");
=09=09=09info->state =3D WAIT_IN_PROGRESS;
=09=09=09add_wait_queue(&info->aclreq_wait, &wait);
=09=09=09__set_current_state(TASK_INTERRUPTIBLE);
=09=09=09schedule();
=09=09=09remove_wait_queue(&info->aclreq_wait, &wait);
=09=09=09set_current_state(TASK_RUNNING);
=09=09=09if (signal_pending(current)) {
=09=09=09=09info->state =3D IDLE;
=09=09=09=09ret =3D -ERESTARTSYS;
=09=09=09=09break;
=09=09=09}
=09=09=09dbg("WAIT_ACLREQ: got a request");

=09=09=09info->state =3D MODE_CHANGE_IN_PROGRESS;

=09=09=09/*
=09=09=09 * a framebuffer app has issued a set var, waking
=09=09=09 * us up. Return the requested var (to ACL daemon).
=09=09=09 */
=09=09=09if (copy_to_user((void *) arg,
=09=09=09=09=09 &info->reqpar.var,
=09=09=09=09=09 sizeof(struct fb_var_screeninfo))) {
=09=09=09=09err("fault in copy_to_user");
=09=09=09=09ret =3D -EFAULT;
=09=09=09}
=09=09} else {
=09=09=09ret =3D -EINVAL;
=09=09}

=09=09break;
=09default:
=09=09ret =3D -EINVAL;
=09}
=09
        up(&info->ioctl_sem);
=09return ret;
}


static int x220fb_getcolreg(unsigned regno, unsigned *red, unsigned *green,
=09=09=09      unsigned *blue, unsigned *transp,
=09=09=09      struct fb_info *_info)
{
        struct x220fb_info *info =3D (struct x220fb_info *) _info;

=09//dbg("");

        if (regno > 255)
                return 1;

        *red    =3D info->palette[regno].red << 10;
        *green  =3D info->palette[regno].green << 10;
        *blue   =3D info->palette[regno].blue << 10;
        *transp =3D info->palette[regno].alpha << 10;

        return 0;
}


static int x220fb_setcolreg(unsigned regno, unsigned red, unsigned green,
=09=09=09      unsigned blue, unsigned transp,
=09=09=09      struct fb_info *_info)
{
=09struct x220fb_info *info =3D (struct x220fb_info *) _info;
=09struct x220fb_par* par =3D &info->curpar;
=09
=09//dbg("");

=09if (regno > 255)
=09=09return -EINVAL;

        info->palette[regno].red =3D red >> 10;
        info->palette[regno].green =3D green >> 10;
        info->palette[regno].blue =3D blue >> 10;
        info->palette[regno].alpha =3D transp >> 10;

=09switch (par->var.bits_per_pixel) {
#ifdef FBCON_HAS_CFB16
=09case 16:
=09=09if(regno < CMAPSIZE)
=09=09=09fbcon_cmap.cfb16[regno] =3D
=09=09=09=09((red & 0xf800) >> 0) |
=09=09=09=09((green & 0xf800) >> 5) |
=09=09=09=09((blue & 0xf800) >> 11);
=09=09break;
#endif
#ifdef FBCON_HAS_CFB24
=09case 24:
=09=09if (regno < CMAPSIZE)
=09=09=09fbcon_cmap.cfb24[regno] =3D
=09=09=09=09((red & 0xff00) << 8) |
=09=09=09=09((green & 0xff00)) |
=09=09=09=09((blue & 0xff00) >> 8);
=09=09break;
#endif
#ifdef FBCON_HAS_CFB32
=09case 32:
=09=09if(regno < CMAPSIZE)
=09=09=09// FIXME: what about transp
=09=09=09fbcon_cmap.cfb32[regno] =3D
=09=09=09=09((red & 0xff00) >> 8) |
=09=09=09=09((green & 0xff00)) |
=09=09=09=09((blue & 0xff00) << 8);
=09=09break;
#endif
=09default:=20
=09=09break;
=09}

=09return 0;
}


static int x220fb_pan_display (const struct fb_var_screeninfo *var,
=09=09=09=09 struct fb_info_gen *info)
{
=09/* not supported */
=09dbg("");

=09return -EINVAL;
}


/*
 *  Initialisation
 */
int __init x220fb_init(void)
{
=09struct x220fb_info *p =3D NULL;
=09struct fb_var_screeninfo *var;
=09
=09fb_x220 =3D p =3D
=09=09(struct x220fb_info *) kmalloc(sizeof(*p), GFP_ATOMIC);
=09if(p=3D=3DNULL)
=09=09return -ENOMEM;
=09memset(p, 0, sizeof(*p));

=09init_waitqueue_head(&p->aclreq_wait);
=09init_waitqueue_head(&p->setpar_wait);
=09init_MUTEX(&p->setpar_sem);
=09init_MUTEX(&p->ioctl_sem);

=09info("Xilleon 220 Framebuffer Driver");

        /* set up a few more things, register framebuffer driver etc */
        p->gen.parsize =3D sizeof (struct x220fb_par);
        p->gen.fbhw =3D &x220fb_hwswitch;

=09strcpy(p->gen.info.modename, "ATI ");=20
=09strcat(p->gen.info.modename, x220fb_name);
=09p->gen.info.changevar =3D NULL;
=09p->gen.info.node =3D -1;

=09p->gen.info.fbops =3D &x220fb_ops;
=09p->gen.info.disp =3D &p->disp;
=09p->gen.info.switch_con =3D &fbgen_switch;
=09p->gen.info.updatevar =3D &fbgen_update_var;
=09p->gen.info.blank =3D &fbgen_blank;
=09p->gen.info.flags =3D FBINFO_FLAG_DEFAULT;

=09calc_par(&p->curpar, &x220_default_var);
=09var =3D &p->curpar.var;
=09
=09/* TODO: explain this crap */
=09p->fb_addr_virt =3D (void *)__get_free_pages(GFP_KERNEL,
=09=09=09=09=09=09   p->curpar.fb_order);
=09p->fb_addr_phys =3D virt_to_phys(p->fb_addr_virt);
=09p->fake_offset =3D 1;
=09info("Initial framebuffer at 0x%08x, mapped to %p, size %d",
=09     (u32)p->fb_addr_phys,
=09     p->fb_addr_virt,
=09     (int)p->curpar.fb_size);
=09
        if (fbgen_do_set_var(&p->curpar.var, 1, &p->gen)) {
                err("boot video mode failed");
                goto ret_enxio;
        }

        p->disp.var =3D p->curpar.var;
        fbgen_set_disp(-1, &p->gen);
        fbgen_install_cmap(0, &p->gen);

=09if (register_framebuffer(&p->gen.info) < 0) {
=09=09goto ret_enxio;
=09}

=09if (!nodms)
=09=09p->dms =3D 1;

=09return 0;

 ret_enxio:
=09kfree(p);
=09iounmap(p->fb_addr_virt);
=09return -ENXIO;
}


#ifdef MODULE

static void __exit x220fb_exit(void)
{
=09unregister_framebuffer(&(fb_x220->gen.info));
=09iounmap(fb_x220->fb_addr_virt);
=09kfree(fb_x220);
}

module_init(x220fb_init);
module_exit(x220fb_exit);

MODULE_PARM(font, "s");
MODULE_PARM_DESC(font, "Specifies a compiled-in font (default=3Dnone)");
MODULE_PARM(accel, "i");
MODULE_PARM_DESC(accel, "Enables hardware acceleration (default=3D0)");
MODULE_PARM(nodms, "i");
MODULE_PARM_DESC(nodms, "Disables dynamic mode selection (default=3D0)");

#else

int x220fb_setup(char *options)
{
=09char *this_opt;
=09
=09if (!options || !*options)
=09=09return 1;

=09for (this_opt =3D strtok(options, ","); this_opt;
=09     this_opt =3D strtok(NULL, ",")) {
=09=09if (!strncmp(this_opt, "font:", 5)) {
=09=09=09strcpy(fontname, this_opt+5);
=09=09} else if (!strncmp(this_opt, "accel", 5)) {
=09=09=09accel =3D 1;
=09=09} else if (!strncmp(this_opt, "nodms", 3)) {
=09=09=09nodms =3D 1;
=09=09} else {
=09=09=09mode_option =3D this_opt;
=09=09}
=09}
=09
=09return 0;
}

#endif /* MODULE */


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
