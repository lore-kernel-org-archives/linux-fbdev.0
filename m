From: Antonino Daplas <adaplas@pol.net>
Subject: Re: status
Date: 23 Nov 2002 03:57:16 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1038005868.13181.34.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0211221902540.5899-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SMxJATfUb8mh16kQdsff"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0211221902540.5899-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-SMxJATfUb8mh16kQdsff
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-11-23 at 00:04, James Simmons wrote:
> 

> > 1. optimized putcs to speed up scrolling by 2-3x.  (it's a small patch
> > but it already outperforms fb-2.4 especially at high color depths).
> > Compared with the previous patch I submitted, this change is
> > non-intrusive, so no other changes are required.
> >
> > 2. vga16fb imageblit that supports drawing of the penguin (vga-4-planes
> > only)
> > 
> > 3. logo drawing for directcolor visuals.
> 
> Please send me those patches ASAP!!! I will linclude them right away.
>  
Okay.  Instead of patches, I'll just attach a file with the targeted
functions which you can choose to cut and paste or modify as you see
fit.  

vga16fb_imageblit in vga16fb.c
fbcon_show_logo in fbcon.c
fbcon_accel_putcs in fbcon-accel.c




--=-SMxJATfUb8mh16kQdsff
Content-Disposition: attachment; filename=changes.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=changes.txt; charset=UTF-8

/*
 * James,=20
 *
 * fbcon_pixmap is where we construct the individual characters
 * into a single combined bitmap before submitting in one burst
 * to imageblit.
 *=20
 * Since you removed fbcon_accel_setup already, fbcon_pixmap
 * can be statically allocated (max xres * max fontheight/8) which
 * should be 4096 for a 2048 xres and a fontheight of 16.  8192 may
 * be safer number.
 *
 * Also dynamic allocation segfaults when we do a kfree and hardware=20
 * is still processing contents. This is where fb_sync() will be useful.
 */


static u8 *fbcon_pixmap =3D NULL;

void fbcon_accel_setup(struct display *p)
{
	if (fbcon_pixmap !=3D NULL) {
		if (p->fb_info->fbops->fb_sync)
			p->fb_info->fbops->fb_sync(p->fb_info);
		kfree(fbcon_pixmap);
		fbcon_pixmap =3D NULL;
	}
	fbcon_pixmap =3D kmalloc(fontheight(p) *=20
			     (p->fb_info->var.xres_virtual + 7)/8,=20
			     GFP_KERNEL);=20

	p->next_line =3D p->fb_info->fix.line_length;
	p->next_plane =3D 0;
}


void fbcon_accel_putcs(struct vc_data *vc, struct display *p,
		       const unsigned short *s, int count, int yy, int xx)
{
	struct fb_info *info =3D p->fb_info;
	unsigned short charmask =3D p->charmask;
	unsigned int width =3D ((fontwidth(p) + 7) >> 3);
	struct fb_image image;
	unsigned int cellsize =3D fontheight(p) * width;
	u16 c =3D scr_readw(s);

	image.fg_color =3D attr_fgcol(p, c);
	image.bg_color =3D attr_bgcol(p, c);
	image.dx =3D xx * fontwidth(p);
	image.dy =3D yy * fontheight(p);
	image.height =3D fontheight(p);
	image.depth =3D 1;

	if (!(fontwidth(p) & 7) && fbcon_pixmap !=3D NULL) {
		unsigned int pitch =3D width * count, i, j;
		char *src, *dst, *dst0;

		dst0 =3D fbcon_pixmap;
		image.width =3D fontwidth(p) * count;
		image.data =3D fbcon_pixmap;
		while (count--) {
			src =3D p->fontdata + (scr_readw(s++) & charmask) * cellsize;
			dst =3D dst0;
			for (i =3D image.height; i--; ) {
				for (j =3D 0; j < width; j++)=20
					dst[j] =3D *src++;
				dst +=3D pitch;
			}
			dst0 +=3D width;
		}
		info->fbops->fb_imageblit(info, &image);
	}
	else {
		image.width =3D fontwidth(p);
		while (count--) {
			image.data =3D p->fontdata +
				(scr_readw(s++) & charmask) * cellsize;
			info->fbops->fb_imageblit(info, &image);
			image.dx +=3D fontwidth(p);
		}
	}
}


/*
 * fbcon_show_logo that supports drawing using fb_imageblit.  All packed
 * pixel formats (truecolor, directcolor, pseudocolor) should now be
 * supported.  It also supports logo drawing with vga-4-planes as pseudocol=
or
 * at 4 bpp.
 */
static int __init fbcon_show_logo( void )
{
    struct display *p =3D &fb_display[fg_console]; /* draw to vt in foregro=
und */
    struct fb_info *info =3D p->fb_info;
#ifdef CONFIG_FBCON_ACCEL   =20
    struct fb_image image;
    u32 *palette =3D NULL, *saved_palette =3D NULL;
    char *logo_new =3D NULL;
#else=20
    int line =3D p->next_line, x1, y1;
    unsigned char *dst, *src;
#endif
    int depth =3D info->var.bits_per_pixel;
    unsigned char *fb =3D info->screen_base;
    unsigned char *logo;
    int i, j, n, x;
    int logo_depth, done =3D 0;

    /* Return if the frame buffer is not mapped */
    if (!fb)
	return 0;
=09
    /*
     * Set colors if visual is PSEUDOCOLOR and we have enough colors, or fo=
r
     * DIRECTCOLOR
     * We don't have to set the colors for the 16-color logo, since that lo=
go
     * uses the standard VGA text console palette
     */
    if ((info->fix.visual =3D=3D FB_VISUAL_PSEUDOCOLOR && depth >=3D 8) ||
	(info->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR && depth >=3D 24))
	for (i =3D 0; i < LINUX_LOGO_COLORS; i +=3D n) {
	    n =3D LINUX_LOGO_COLORS - i;
	    if (n > 16)
		/* palette_cmap provides space for only 16 colors at once */
		n =3D 16;
	    palette_cmap.start =3D 32 + i;
	    palette_cmap.len   =3D n;
	    for( j =3D 0; j < n; ++j ) {
		palette_cmap.red[j]   =3D (linux_logo_red[i+j] << 8) |
					linux_logo_red[i+j];
		palette_cmap.green[j] =3D (linux_logo_green[i+j] << 8) |
					linux_logo_green[i+j];
		palette_cmap.blue[j]  =3D (linux_logo_blue[i+j] << 8) |
					linux_logo_blue[i+j];
	    }
	    fb_set_cmap(&palette_cmap, 1, info);
	}
=09
    if (depth >=3D 8) {
	logo =3D linux_logo;
	logo_depth =3D 8;
    }
    else if (depth >=3D 4) {
	logo =3D linux_logo16;
	logo_depth =3D 4;
    }
    else {
	logo =3D linux_logo_bw;
	logo_depth =3D 1;
    }
  =20
#if defined(CONFIG_FBCON_ACCEL)
	if (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||=20
	    (info->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR && depth >=3D 24)) {
		unsigned char mask[9] =3D { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
		unsigned char redmask, greenmask, bluemask;
		int redshift, greenshift, blueshift;

		/*
	 	 * We have to create a temporary palette since console palette is only
		 * 16 colors long.
	 	 */
		palette =3D kmalloc(256 * 4, GFP_KERNEL);
		if (palette =3D=3D NULL)
			return (LOGO_H + fontheight(p) - 1) / fontheight(p);

		if (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) {
			/* Bug: Doesn't obey msb_right ... (who needs that?) */
			redmask   =3D mask[info->var.red.length   < 8 ? info->var.red.length   :=
 8];
			greenmask =3D mask[info->var.green.length < 8 ? info->var.green.length :=
 8];
			bluemask  =3D mask[info->var.blue.length  < 8 ? info->var.blue.length  :=
 8];
			redshift   =3D info->var.red.offset   - (8 - info->var.red.length);
			greenshift =3D info->var.green.offset - (8 - info->var.green.length);
			blueshift  =3D info->var.blue.offset  - (8 - info->var.blue.length);


			for ( i =3D 0; i < LINUX_LOGO_COLORS; i++) {
				palette[i+32] =3D (safe_shift((linux_logo_red[i]   & redmask), redshift=
) |
						 safe_shift((linux_logo_green[i] & greenmask), greenshift) |
						 safe_shift((linux_logo_blue[i]  & bluemask), blueshift));
			}
		}
		else {
			redshift =3D info->var.red.offset;
			greenshift =3D info->var.green.offset;
			blueshift =3D info->var.blue.offset;

			for (i =3D 32; i < LINUX_LOGO_COLORS; i++)=20
				palette[i] =3D i << redshift | i << greenshift | i << blueshift;
		}
		saved_palette =3D info->pseudo_palette;
		info->pseudo_palette =3D palette;
	}
	else if (info->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR && depth >=3D 12 &&=
 depth < 24) {
		logo_new =3D kmalloc(LOGO_W * LOGO_H, GFP_KERNEL);
		if (logo_new =3D=3D NULL)
			return (LOGO_H + fontheight(p) - 1) / fontheight(p);

		logo =3D logo_new;
		for (i =3D 0; i < (LOGO_W * LOGO_H)/2; i++) {
			logo_new[i*2] =3D linux_logo16[i] >> 4;
			logo_new[(i*2)+1] =3D linux_logo16[i] & 0xf;
		}
	}=20
	image.width =3D LOGO_W;
	image.height =3D LOGO_H;
	image.depth =3D depth;
	image.data =3D logo;
	image.dy =3D 0;
#endif
=20
    for (x =3D 0; x < num_online_cpus() * (LOGO_W + 8) &&
    	 x < info->var.xres - (LOGO_W + 8); x +=3D (LOGO_W + 8)) {
#if defined (CONFIG_FBCON_ACCEL)
	image.dx =3D x;
	info->fbops->fb_imageblit(info, &image);
	done =3D 1;
#endif
#if defined(CONFIG_FBCON_AFB) || defined(CONFIG_FBCON_ILBM) || \
    defined(CONFIG_FBCON_IPLAN2P2) || defined(CONFIG_FBCON_IPLAN2P4) || \
    defined(CONFIG_FBCON_IPLAN2P8)
	if (depth >=3D 2 && (info->fix.type =3D=3D FB_TYPE_PLANES ||
			   info->fix.type =3D=3D FB_TYPE_INTERLEAVED_PLANES)) {
	    /* planes (normal or interleaved), with color registers */
	    int bit;
	    unsigned char val, mask;
	    int plane =3D p->next_plane;

#if defined(CONFIG_FBCON_IPLAN2P2) || defined(CONFIG_FBCON_IPLAN2P4) || \
    defined(CONFIG_FBCON_IPLAN2P8)
	    int line_length =3D info->fix.line_length;

	    /* for support of Atari interleaved planes */
#define MAP_X(x)	(line_length ? (x) : ((x) & ~1)*depth + ((x) & 1))
#else
#define MAP_X(x)	(x)
#endif
	    /* extract a bit from the source image */
#define	BIT(p,pix,bit)	(p[pix*logo_depth/8] & \
			 (1 << ((8-((pix*logo_depth)&7)-logo_depth) + bit)))
	=09
	    src =3D logo;
	    for( y1 =3D 0; y1 < LOGO_H; y1++ ) {
		for( x1 =3D 0; x1 < LOGO_LINE; x1++, src +=3D logo_depth ) {
		    dst =3D fb + y1*line + MAP_X(x/8+x1);
		    for( bit =3D 0; bit < logo_depth; bit++ ) {
			val =3D 0;
			for( mask =3D 0x80, i =3D 0; i < 8; mask >>=3D 1, i++ ) {
			    if (BIT( src, i, bit ))
				val |=3D mask;
			}
			*dst =3D val;
			dst +=3D plane;
		    }
		}
	    }
=09
	    /* fill remaining planes */
	    if (depth > logo_depth) {
		for( y1 =3D 0; y1 < LOGO_H; y1++ ) {
		    for( x1 =3D 0; x1 < LOGO_LINE; x1++ ) {
			dst =3D fb + y1*line + MAP_X(x/8+x1) + logo_depth*plane;
			for( i =3D logo_depth; i < depth; i++, dst +=3D plane )
			    *dst =3D 0x00;
		    }
		}
	    }
	    done =3D 1;
	    break;
	}
#endif
#if defined(CONFIG_FBCON_MFB) || defined(CONFIG_FBCON_AFB) || \
    defined(CONFIG_FBCON_ILBM) || defined(CONFIG_FBCON_HGA)

	if (depth =3D=3D 1 && (info->fix.type =3D=3D FB_TYPE_PACKED_PIXELS ||
			   info->fix.type =3D=3D FB_TYPE_PLANES ||
			   info->fix.type =3D=3D FB_TYPE_INTERLEAVED_PLANES)) {

	    /* monochrome */
	    unsigned char inverse =3D p->inverse || info->fix.visual =3D=3D FB_VIS=
UAL_MONO01
		? 0x00 : 0xff;

	    int is_hga =3D !strncmp(info->modename, "HGA", 3);
	    /* can't use simply memcpy because need to apply inverse */
	    for( y1 =3D 0; y1 < LOGO_H; y1++ ) {
		src =3D logo + y1*LOGO_LINE;
		if (is_hga)
		    dst =3D fb + (y1%4)*8192 + (y1>>2)*line + x/8;
		else
		    dst =3D fb + y1*line + x/8;
		for( x1 =3D 0; x1 < LOGO_LINE; ++x1 )
		    fb_writeb(*src++ ^ inverse, dst++);
	    }
	    done =3D 1;
	}
#endif
#if defined(CONFIG_FBCON_VGA_PLANES)
	if (depth =3D=3D 4 && info->fix.type =3D=3D FB_TYPE_VGA_PLANES) {
		outb_p(1,0x3ce); outb_p(0xf,0x3cf);
		outb_p(3,0x3ce); outb_p(0,0x3cf);
		outb_p(5,0x3ce); outb_p(0,0x3cf);

		src =3D logo;
		for (y1 =3D 0; y1 < LOGO_H; y1++) {
			for (x1 =3D 0; x1 < LOGO_W / 2; x1++) {
				dst =3D fb + y1*line + x1/4 + x/8;

				outb_p(0,0x3ce);
				outb_p(*src >> 4,0x3cf);
				outb_p(8,0x3ce);
				outb_p(1 << (7 - x1 % 4 * 2),0x3cf);
				fb_readb (dst);
				fb_writeb (0, dst);

				outb_p(0,0x3ce);
				outb_p(*src & 0xf,0x3cf);
				outb_p(8,0x3ce);
				outb_p(1 << (7 - (1 + x1 % 4 * 2)),0x3cf);
				fb_readb (dst);
				fb_writeb (0, dst);

				src++;
			}
		}
		done =3D 1;
	}
#endif
    }
  =20
#if defined (CONFIG_FBCON_ACCEL)
	if (palette !=3D NULL)
		kfree(palette);
	if (saved_palette !=3D NULL)
		info->pseudo_palette =3D saved_palette;
	if (logo_new !=3D NULL)
		kfree(logo_new);
#endif
    /* Modes not yet supported: packed pixels with depth !=3D 8 (does such =
a
     * thing exist in reality?) */

    return done ? (LOGO_H + fontheight(p) - 1) / fontheight(p) : 0 ;
}


/*
 * The following is a vga imageblit that supports bitmaps greater than
 * 8 pixels wide and logo drawing in vga-4-planes.
 *
 * I haven't made any changes to the other VGA formats.  No hardware.
 */

void vga_imageblit_expand(struct fb_info *info, struct fb_image *image)
{
	char *where =3D info->screen_base + (image->dx/8) +=20
		image->dy * info->fix.line_length;
	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
	u8 *cdat =3D image->data, *dst;
	int x, y;

	switch (info->fix.type) {
		case FB_TYPE_VGA_PLANES:
			if (info->fix.type_aux =3D=3D FB_AUX_VGA_PLANES_VGA4) {
				if (par->isVGA) {
					setmode(2);
					setop(0);
					setsr(0xf);
					setcolor(image->fg_color);
					selectmask();

					setmask(0xff);
					writeb(image->bg_color, where);
					rmb();
					readb(where); /* fill latches */
					setmode(3);
					wmb();
					for (y =3D 0; y < image->height; y++) {
						dst =3D where;
						for (x =3D image->width/8; x--;)=20
							writeb(*cdat++, dst++);
						where +=3D info->fix.line_length;
					}
					wmb();
				} else {
					setmode(0);
					setop(0);
					setsr(0xf);
					setcolor(image->bg_color);
					selectmask();

					setmask(0xff);
					for (y =3D 0; y < image->height; y++) {
						dst =3D where;
						for (x=3Dimage->width/8; x--;){
							rmw(dst);
							setcolor(image->fg_color);
							selectmask();
							if (*cdat) {
								setmask(*cdat++);
								rmw(dst++);
							}
						}
						where +=3D info->fix.line_length;
					}
				}
			} else=20
				vga_8planes_imageblit(info, image);
			break;
#ifdef FBCON_HAS_VGA
		case FB_TYPE_TEXT:
			break;
#endif
		case FB_TYPE_PACKED_PIXELS:
		default:
			cfb_imageblit(info, image);
			break;
	}
}

void vga_imageblit_color(struct fb_info *info, struct fb_image *image)=20
{
	/*
	 * Draw logo=20
	 */
	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
	char *where =3D info->screen_base + image->dy * info->fix.line_length +=20
		image->dx/8;
	char *cdat =3D image->data, *dst;
	int x, y;

	switch (info->fix.type) {
	case FB_TYPE_VGA_PLANES:
		if (info->fix.type_aux =3D=3D FB_AUX_VGA_PLANES_VGA4 &&
		    par->isVGA) {
			setsr(0xf);
			setop(0);
			setmode(0);
		=09
			for (y =3D 0; y < image->height; y++) {
				for (x =3D 0; x < image->width/2; x++) {
					dst =3D where + x/4;

					setcolor(*cdat >> 4);
					selectmask();
					setmask(1 << (7 - x % 4 * 2));
					fb_readb(dst);
					fb_writeb(0, dst);

					setcolor(*cdat & 0xf);
					selectmask();
					setmask(1 << (7 - (1 + x % 4 * 2)));
					fb_readb(dst);
					fb_writeb(0, dst);

					cdat++;
				}
				where +=3D info->fix.line_length;
			}
		}
		break;
	case FB_TYPE_PACKED_PIXELS:
		cfb_imageblit(info, image);
		break;
	default:
		break;
	}
}
			=09
void vga16fb_imageblit(struct fb_info *info, struct fb_image *image)
{
	if (image->depth =3D=3D 1)
		vga_imageblit_expand(info, image);
	else if (image->depth =3D=3D info->var.bits_per_pixel)
		vga_imageblit_color(info, image);
}


--=-SMxJATfUb8mh16kQdsff--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
