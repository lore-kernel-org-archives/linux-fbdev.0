From: jsimmons@pentafluge.infradead.org
Subject: Re: [PATCH 1/4][RESEND][FBDEV]: Core fbcon fixes
Date: Thu, 24 Jun 2004 01:14:25 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406240112270.609@pentafluge.infradead.org>
References: <200406220638.34214.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdHsv-0002JK-TB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 17:14:33 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdHst-00020v-Cg
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 17:14:32 -0700
In-Reply-To: <200406220638.34214.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Wow. That is a big patch. I will loook it over. I had some ideas I like to 
try myslef. I like to have you be able to map the fbdevs to teh correct 
VCs at boot time. If one is modular as soon as you load that module it 
maps to fbcon automatically :-) Like in 2.4.X.


On Tue, 22 Jun 2004, Antonino A. Daplas wrote:

> Hi James, Andrew
> 
> This patch fixes the following bugs/regressions for fbcon:
> 
> 1. Initialize and update global arrays used by fbcon during initialization
> and and by set_con2fbmap code.  Otherwise, it's possible the crash the 
> machine as in the following code:
> 
> modprobe fbdev1
> modprobe fbdev2
> rmmod fbdev1
> modprobe fbcon
> 
> 2. Fixed screen corruption (white rectangle) at initial mode setting
> plaguing cards with VGA cores and with VGA console enabled. This
> also includes vga16fb.
> 
> 3. Improved fbcon_startup/fbcon_init code.  
> 
> 4. Fixed set_con2fbmap code -- should support multiple devices mapped to
> different consoles.
> 
> Please apply.
> 
> Diff is against linux-2.6.7-mm1
> 
> Tony
> 
> Signed-off-by: Antonino A. Daplas <adaplas@pol.net>
> 
>  drivers/video/console/fbcon.c |  385 +++++++++++++++++++++++++++++-------------
>  drivers/video/fbmem.c         |    9
>  include/linux/fb.h            |    1
>  3 files changed, 279 insertions(+), 116 deletions(-)
> 
> diff -Naur linux-2.6.7-mm1-orig/drivers/video/console/fbcon.c linux-2.6.7-mm1/drivers/video/console/fbcon.c
> --- linux-2.6.7-mm1-orig/drivers/video/console/fbcon.c	2004-06-22 13:43:25.000000000 +0000
> +++ linux-2.6.7-mm1/drivers/video/console/fbcon.c	2004-06-22 14:03:11.229920440 +0000
> @@ -118,6 +118,9 @@
>  /* font data */
>  static char fontname[40];
>  
> +/* current fb_info */
> +static int info_idx =  -1;
> +
>  #define REFCOUNT(fd)	(((int *)(fd))[-1])
>  #define FNTSIZE(fd)	(((int *)(fd))[-2])
>  #define FNTCHARCNT(fd)	(((int *)(fd))[-3])
> @@ -165,6 +168,8 @@
>  static int fbcon_font_op(struct vc_data *vc, struct console_font_op *op);
>  static int fbcon_set_palette(struct vc_data *vc, unsigned char *table);
>  static int fbcon_scrolldelta(struct vc_data *vc, int lines);
> +void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
> +			 int bottom_only);
>  
>  
>  /*
> @@ -177,6 +182,7 @@
>  static __inline__ void ypan_down(struct vc_data *vc, int count);
>  static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int sx,
>  			    int dy, int dx, int height, int width, u_int y_break);
> +static void fbcon_set_disp(struct fb_info *info, struct vc_data *vc);
>  
>  #ifdef CONFIG_MAC
>  /*
> @@ -194,9 +200,14 @@
>  static void fb_flashcursor(void *private)
>  {
>  	struct fb_info *info = (struct fb_info *) private;
> +	struct vc_data *vc = NULL;
> +
> +	if (info->currcon != -1)
> +		vc = vc_cons[info->currcon].d;
>  
> -	if (!info || info->state != FBINFO_STATE_RUNNING ||
> -	    info->cursor.rop == ROP_COPY)
> +	if (info->state != FBINFO_STATE_RUNNING || 
> +	    info->cursor.rop == ROP_COPY || !vc || !CON_IS_VISIBLE(vc)
> +	    || registered_fb[(int) con2fb_map[vc->vc_num]] != info)
>  		return;
>  	acquire_console_sem();
>  	info->cursor.enable ^= 1;
> @@ -218,17 +229,12 @@
>  }
>  #endif
>  	
> -static void cursor_timer_handler(unsigned long dev_addr);
> -
> -static struct timer_list cursor_timer =
> -		TIMER_INITIALIZER(cursor_timer_handler, 0, 0);
> -
>  static void cursor_timer_handler(unsigned long dev_addr)
>  {
>  	struct fb_info *info = (struct fb_info *) dev_addr;
>  	
> -	schedule_work(&info->queue);	
> -	mod_timer(&cursor_timer, jiffies + HZ/5);
> +	schedule_work(&info->queue);
> +	mod_timer(&info->cursor_timer, jiffies + HZ/5);
>  }
>  
>  int __init fb_console_setup(char *this_opt)
> @@ -285,6 +291,28 @@
>  
>  __setup("fbcon=", fb_console_setup);
>  
> +static int search_fb_in_map(int idx)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_NR_CONSOLES; i++) { 
> +		if (con2fb_map[i] == idx)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static int search_for_mapped_con(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_NR_CONSOLES; i++) {
> +		if (con2fb_map[i] != -1) 
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  /**
>   *	set_con2fb_map - map console to frame buffer device
>   *	@unit: virtual console number to map
> @@ -296,12 +324,74 @@
>  int set_con2fb_map(int unit, int newidx)
>  {
>  	struct vc_data *vc = vc_cons[unit].d;
> +	int oldidx = con2fb_map[unit];
> +	struct fb_info *info = registered_fb[newidx];
> +	struct fb_info *oldinfo = registered_fb[oldidx];
> +	int found;
> +
> +	if (!search_for_mapped_con()) {
> +		info_idx = newidx;
> +		fb_console_init();
> +		return 0;
> +	}
>  
> +	if (oldidx == newidx)
> +		return 0;
>  	if (!vc)
> -		return -ENODEV;
> +	    return -ENODEV;
> +	found = search_fb_in_map(newidx);
> +
> +	acquire_console_sem();
>  	con2fb_map[unit] = newidx;
> -	fbcon_is_default = (vc->vc_sw == &fb_con) ? 1 : 0;
> -	return take_over_console(&fb_con, unit, unit, fbcon_is_default);
> +	if (!found) {
> +		if (!try_module_get(info->fbops->owner)) {
> +			release_console_sem();
> +			return -ENODEV;
> +		}
> +		if (info->fbops->fb_open && info->fbops->fb_open(info, 0)) {
> +			module_put(info->fbops->owner);
> +			release_console_sem();
> +			return -ENODEV;
> +		}
> +	}
> +
> +	/* 
> +	 * If old fb is not mapped to any of the consoles,
> +	 * fbcon should release it.
> +	 */
> +	if (oldinfo && !search_fb_in_map(oldidx)) {
> +		int err;
> +
> +		if (info->queue.func == fb_flashcursor)  
> +			del_timer_sync(&oldinfo->cursor_timer);
> +		if (oldinfo->fbops->fb_release) {
> +			err = oldinfo->fbops->fb_release(oldinfo, 0);
> +			if (err) {
> +				con2fb_map[unit] = oldidx;
> +				release_console_sem();
> +				return err;
> +			}
> +		}
> +		module_put(oldinfo->fbops->owner);
> +	}
> +	info->currcon = -1;
> +	if (!found) {
> +		if (!info->queue.func || info->queue.func == fb_flashcursor) {
> +			if (!info->queue.func)
> +				INIT_WORK(&info->queue, fb_flashcursor, info);
> +			
> +			init_timer(&info->cursor_timer);
> +			info->cursor_timer.function = cursor_timer_handler;
> +			info->cursor_timer.expires = jiffies + HZ / 5;
> +			info->cursor_timer.data = (unsigned long ) info;
> +			add_timer(&info->cursor_timer);
> +		}
> +	}	
> +	if (info->fbops->fb_set_par)
> +		info->fbops->fb_set_par(info);
> +	fbcon_set_disp(info, vc);
> +	release_console_sem();
> +	return 0;
>  }
>  
>  /*
> @@ -443,9 +533,8 @@
>  	struct vc_data *vc = vc_cons[fg_console].d;
>  	struct font_desc *font = NULL;
>  	struct module *owner;
> -	struct fb_info *info;
> -	static int done = 0;
> -	int cols, rows;
> +	struct fb_info *info = NULL;
> +	int rows, cols;
>  	int irqres;
>  
>  	irqres = 1;
> @@ -453,20 +542,24 @@
>  	 *  If num_registered_fb is zero, this is a call for the dummy part.
>  	 *  The frame buffer devices weren't initialized yet.
>  	 */
> -	if (!num_registered_fb || done)
> +	if (!num_registered_fb || info_idx == -1)
>  		return display_desc;
> -	done = 1;
> -
> -	info = registered_fb[0];	
> -	if (!info)	return NULL;
> +	/* 
> +	 * Instead of blindly using registered_fb[0], we use info_idx, set by
> +	 * fb_console_init(); 
> +	 */
> +	info = registered_fb[info_idx];
> +	if (!info)
> +		return NULL;
>  	info->currcon = -1;
>  	
>  	owner = info->fbops->owner;
>  	if (!try_module_get(owner))
>  		return NULL;
> -	if (info->fbops->fb_open && info->fbops->fb_open(info, 0))
> +	if (info->fbops->fb_open && info->fbops->fb_open(info, 0)) {
>  		module_put(owner);
> -	
> +		return NULL;
> +	}
>  	if (info->fix.type != FB_TYPE_TEXT) {
>  		if (fbcon_softback_size) {
>  			if (!softback_buf) {
> @@ -503,16 +596,9 @@
>  		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
>  	}
>  
> -	/*
> -	 * We must always set the mode. The mode of the previous console
> -	 * driver could be in the same resolution but we are using different
> -	 * hardware so we have to initialize the hardware.
> -	 */
> -	if (info->fbops->fb_set_par)
> -		info->fbops->fb_set_par(info);
> -	cols = info->var.xres/vc->vc_font.width;
> -	rows = info->var.yres/vc->vc_font.height;
> -	vc_resize(vc->vc_num, cols, rows);
> +	cols = info->var.xres / vc->vc_font.width;
> +	rows = info->var.yres / vc->vc_font.height;
> +	vc_resize(vc->vc_num, cols, rows); 
>  
>  	DPRINTK("mode:   %s\n", info->fix.id);
>  	DPRINTK("visual: %d\n", info->fix.visual);
> @@ -585,10 +671,12 @@
>  	 * default timer to flash the cursor. */
>  	if (!info->queue.func) {
>  		INIT_WORK(&info->queue, fb_flashcursor, info);
> -		
> -		cursor_timer.expires = jiffies + HZ / 5;
> -		cursor_timer.data = (unsigned long ) info;
> -		add_timer(&cursor_timer);
> +
> +		init_timer(&info->cursor_timer);
> +		info->cursor_timer.function = cursor_timer_handler;
> +		info->cursor_timer.expires = jiffies + HZ / 5;
> +		info->cursor_timer.data = (unsigned long ) info;
> +		add_timer(&info->cursor_timer);
>  	}
>  	return display_desc;
>  }
> @@ -600,28 +688,31 @@
>  	struct display *t, *p = &fb_display[vc->vc_num];
>  	int display_fg = (*default_mode)->vc_num;
>  	int logo = 1, rows, cols, charcnt = 256;
> -	unsigned short *save = NULL, *r, *q;
>  	int cap = info->flags;
>  
> +	if (info_idx == -1 || info == NULL)
> +	    return;
>  	if (vc->vc_num != display_fg || (info->flags & FBINFO_MODULE) ||
>  	    (info->fix.type == FB_TYPE_TEXT))
>  		logo = 0;
>  
> -	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
> +	/* reset wrap/pan */
> +	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
>  
>  	/* If we are not the first console on this
>  	   fb, copy the font from that console */
>  	t = &fb_display[display_fg];
> -	vc->vc_font.width = (*default_mode)->vc_font.width;
> -	vc->vc_font.height = (*default_mode)->vc_font.height;
> -	vc->vc_font.data = p->fontdata = t->fontdata;
> -	p->userfont = t->userfont;
> -	if (p->userfont) {
> -		REFCOUNT(p->fontdata)++;
> -		charcnt = FNTCHARCNT(p->fontdata);
> +	if (!vc->vc_font.data) {
> +		vc->vc_font.data = p->fontdata = t->fontdata;
> +		vc->vc_font.width = (*default_mode)->vc_font.width;
> +		vc->vc_font.height = (*default_mode)->vc_font.height;
> +		p->userfont = t->userfont;
> +		if (p->userfont) 
> +			REFCOUNT(p->fontdata)++;
> +		con_copy_unimap(vc->vc_num, display_fg);
>  	}
> -	con_copy_unimap(vc->vc_num, display_fg);
> -
> +	if (p->userfont)
> +		charcnt = FNTCHARCNT(p->fontdata);
>  	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
>  	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
>  	if (charcnt == 256) {
> @@ -634,85 +725,63 @@
>  
>  	cols = info->var.xres / vc->vc_font.width;
>  	rows = info->var.yres / vc->vc_font.height;
> -	vc_resize(vc->vc_num, cols, rows);
> -
> -	if ((cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED))
> -		p->scrollmode = SCROLL_ACCEL;
> -	else /* default to something safe */
> -		p->scrollmode = SCROLL_REDRAW;
>  
>  	/*
>  	 *  ++guenther: console.c:vc_allocate() relies on initializing
>  	 *  vc_{cols,rows}, but we must not set those if we are only
>  	 *  resizing the console.
>  	 */
> -	if (init) {
> +	if (!init) {
>  		vc->vc_cols = cols;
>  		vc->vc_rows = rows;
> +	} else {
> +	    	vc_resize(vc->vc_num, cols, rows);
>  	}
>  
> +	if ((cap & FBINFO_HWACCEL_COPYAREA) && 
> +	    !(cap & FBINFO_HWACCEL_DISABLED))
> +		p->scrollmode = SCROLL_ACCEL;
> +	else /* default to something safe */
> +		p->scrollmode = SCROLL_REDRAW;
> +
> +	/*
> +	 * We must always set the mode. The mode of the previous console
> +	 * driver could be in the same resolution but we are using different
> +	 * hardware so we have to initialize the hardware.
> +	 * 
> +	 * We need to do it in fbcon_init() to prevent screen corruption.
> +	 */
> +
> +	if (CON_IS_VISIBLE(vc) && info->fbops->fb_set_par)
> +		info->fbops->fb_set_par(info);
>  	if (logo) {
>  		/* Need to make room for the logo */
> -		int cnt;
> -		int step;
> -
>  		logo_height = fb_prepare_logo(info);
>  		logo_lines = (logo_height + vc->vc_font.height - 1) /
>  			     vc->vc_font.height;
> -		q = (unsigned short *) (vc->vc_origin +
> -					vc->vc_size_row * rows);
> -		step = logo_lines * cols;
> -		for (r = q - logo_lines * cols; r < q; r++)
> -			if (scr_readw(r) != vc->vc_video_erase_char)
> -				break;
> -		if (r != q && rows >= rows + logo_lines) {
> -			save = kmalloc(logo_lines * cols * 2, GFP_KERNEL);
> -			if (save) {
> -				scr_memsetw(save, vc->vc_video_erase_char,
> -					    logo_lines * cols * 2);
> -				r = q - step;
> -				for (cnt = 0; cnt < logo_lines; cnt++, r += cols)
> -					scr_memcpyw(save + cnt * cols, r, 2 * cols);
> -				r = q;
> -			}
> -		}
> -		if (r == q) {
> -			/* We can scroll screen down */
> -			r = q - step - cols;
> -			for (cnt = rows - logo_lines; cnt > 0; cnt--) {
> -				scr_memcpyw(r + step, r, vc->vc_size_row);
> -				r -= cols;
> -			}
> -			if (!save) {
> -				vc->vc_y += logo_lines;
> -				vc->vc_pos += logo_lines * vc->vc_size_row;
> -			}
> -		}
> -		scr_memsetw((unsigned short *) vc->vc_origin,
> -			    vc->vc_video_erase_char,
> -			    vc->vc_size_row * logo_lines);
>  
> -		if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
> +		if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == 
> +		    KD_TEXT) {
>  			accel_clear_margins(vc, info, 0);
>  			update_screen(vc->vc_num);
>  		}
> -		if (save) {
> -			q = (unsigned short *) (vc->vc_origin +
> -						vc->vc_size_row *
> -						rows);
> -			scr_memcpyw(q, save, logo_lines * cols * 2);
> -			vc->vc_y += logo_lines;
> -			vc->vc_pos += logo_lines * vc->vc_size_row;
> -			kfree(save);
> -		}
>  		if (logo_lines > vc->vc_bottom) {
>  			logo_shown = -1;
>  			printk(KERN_INFO
> -			       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
> +			       "fbcon_init: disable boot-logo (boot-logo "
> +			       "bigger than screen).\n");
>  		} else {
>  			logo_shown = -2;
>  			vc->vc_top = logo_lines;
>  		}
> +		update_region(fg_console,
> +			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
> +			      vc->vc_size_row * (vc->vc_bottom -
> +						 vc->vc_top) / 2);
> +		scr_memsetw((unsigned short *) vc->vc_origin,
> +			    vc->vc_video_erase_char,
> +			    vc->vc_size_row * logo_lines);
> +
>  	}
>  
>  	if (vc->vc_num == display_fg && softback_buf) {
> @@ -730,7 +799,9 @@
>  static void fbcon_deinit(struct vc_data *vc)
>  {
>  	struct display *p = &fb_display[vc->vc_num];
> -
> +	
> +	if (info_idx != -1)
> +	    return;
>  	fbcon_free_font(p);
>  }
>  
> @@ -925,7 +996,8 @@
>  			cursor.set |= FB_CUR_SETHOT;
>  		}
>  
> -		if ((cursor.set & FB_CUR_SETSIZE) || ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)) {
> +		if ((cursor.set & FB_CUR_SETSIZE) || ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)
> +		    || info->cursor.mask == NULL) {
>  			char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
>  			int cur_height, size, i = 0;
>  
> @@ -984,6 +1056,57 @@
>  	return 0;
>  }
>  
> +static void fbcon_set_disp(struct fb_info *info, struct vc_data *vc)
> +{
> +	struct display *p = &fb_display[vc->vc_num], *t;
> +	struct vc_data **default_mode = vc->vc_display_fg;
> +	int display_fg = (*default_mode)->vc_num;
> +	int rows, cols, charcnt = 256;
> +
> +	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
> +	t = &fb_display[display_fg];
> +	if (!vc->vc_font.data) {
> +		vc->vc_font.data = p->fontdata = t->fontdata;
> +		vc->vc_font.width = (*default_mode)->vc_font.width;
> +		vc->vc_font.height = (*default_mode)->vc_font.height;
> +		p->userfont = t->userfont;
> +		if (p->userfont) 
> +			REFCOUNT(p->fontdata)++;
> +		con_copy_unimap(vc->vc_num, display_fg);
> +	}
> +	if (p->userfont)
> +		charcnt = FNTCHARCNT(p->fontdata);
> +
> +	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
> +	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
> +	if (charcnt == 256) {
> +		vc->vc_hi_font_mask = 0;
> +	} else {
> +		vc->vc_hi_font_mask = 0x100;
> +		if (vc->vc_can_do_color)
> +			vc->vc_complement_mask <<= 1;
> +	}
> +	cols = info->var.xres / vc->vc_font.width;
> +	rows = info->var.yres / vc->vc_font.height;
> +	vc_resize(vc->vc_num, cols, rows);
> +	if (CON_IS_VISIBLE(vc)) {
> +		update_screen(vc->vc_num);
> +		if (softback_buf) { 
> +			int l = fbcon_softback_size / vc->vc_size_row;
> +
> +			if (l > 5)
> +				softback_end = softback_buf + l * 
> +					vc->vc_size_row;
> +			else {
> +				/* Smaller scrollback makes no sense, and 0 
> +				   would screw the operation totally */
> +				softback_top = 0;
> +			}
> +		}
> +	}
> +	switch_screen(fg_console); 
> +}
> +
>  static __inline__ void ywrap_up(struct vc_data *vc, int count)
>  {
>  	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
> @@ -1537,6 +1660,7 @@
>  {
>  	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
>  	struct display *p = &fb_display[vc->vc_num];
> +	int i;
>  
>  	if (softback_top) {
>  		int l = fbcon_softback_size / vc->vc_size_row;
> @@ -1563,6 +1687,20 @@
>  	}
>  	if (info)
>  		info->var.yoffset = p->yscroll = 0;
> +
> +	/* 
> +	 * FIXME: If we have multiple fbdev's loaded, we need to
> +	 * update all info->currcon.  Perhaps, we can place this
> +	 * in a centralized structure, but this might break some
> +	 * drivers.
> +	 *
> +	 * info->currcon = vc->vc_num;
> +	 */
> +	for (i = 0; i < FB_MAX; i++) {
> +		if (registered_fb[i] != NULL)
> +			registered_fb[i]->currcon = vc->vc_num;
> +	}
> +
>   	fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
>  	switch (p->scrollmode) {
>  	case SCROLL_WRAP:
> @@ -1580,15 +1718,23 @@
>  	scrollback_max = 0;
>  	scrollback_current = 0;
>  
> -	info->currcon = vc->vc_num;
> -	
>  	update_var(vc->vc_num, info);
>  	fbcon_set_palette(vc, color_table); 	
>  
>  	if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
>  		accel_clear_margins(vc, info, 0);
>  	if (logo_shown == -2) {
> +		struct fb_fillrect rect;
> +		int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
> +
>  		logo_shown = fg_console;
> +		rect.color = attr_bgcol_ec(bgshift, vc);
> +		rect.rop = ROP_COPY;
> +		rect.dx = rect.dy = 0;
> +		rect.width = info->var.xres;
> +		rect.height = logo_lines * vc->vc_font.height;
> +		info->fbops->fb_fillrect(info, &rect);
> +
>  		/* This is protected above by initmem_freed */
>  		fb_show_logo(info);
>  		update_region(fg_console,
> @@ -2186,6 +2332,7 @@
>  
>  	update_screen(vc->vc_num);
>  }
> +
>  static int fbcon_event_notify(struct notifier_block *self, 
>  			      unsigned long action, void *data)
>  {
> @@ -2199,6 +2346,7 @@
>  		fbcon_resumed(info);
>  		break;
>  	}
> +
>  	return 0;
>  }
>  
> @@ -2229,27 +2377,42 @@
>  	.con_resize             = fbcon_resize,
>  };
>  
> -static struct notifier_block fbcon_event_notifer = {
> +static struct notifier_block fbcon_event_notifier = {
>  	.notifier_call	= fbcon_event_notify,
>  };
> -
>  static int fbcon_event_notifier_registered;
>  
>  int __init fb_console_init(void)
>  {
> -	int err;
> +	int err, i;
>  
> +	for (i = 0; i < MAX_NR_CONSOLES; i++)
> +		con2fb_map[i] = -1;
> +	
>  	if (!num_registered_fb)
>  		return -ENODEV;
>  
> +	if (info_idx == -1) {
> +		for (i = 0; i < FB_MAX; i++) {
> +			if (registered_fb[i] != NULL) {
> +				info_idx = i;
> +				break;
> +			}
> +		}
> +	}
> +	for (i = first_fb_vc; i <= last_fb_vc; i++) 
> +		con2fb_map[i] = info_idx;
>  	err = take_over_console(&fb_con, first_fb_vc, last_fb_vc,
>  				fbcon_is_default);
> -	if (err)
> +	if (err) {
> +		for (i = first_fb_vc; i <= last_fb_vc; i++) {
> +			con2fb_map[i] = -1;
> +		}
>  		return err;
> -
> +	}
>  	acquire_console_sem();
>  	if (!fbcon_event_notifier_registered) {
> -		fb_register_client(&fbcon_event_notifer);
> +		fb_register_client(&fbcon_event_notifier);
>  		fbcon_event_notifier_registered = 1;
>  	} 
>  	release_console_sem();
> @@ -2262,7 +2425,7 @@
>  {
>  	acquire_console_sem();
>  	if (fbcon_event_notifier_registered) {
> -		fb_unregister_client(&fbcon_event_notifer);
> +		fb_unregister_client(&fbcon_event_notifier);
>  		fbcon_event_notifier_registered = 0;
>  	}
>  	release_console_sem();
> diff -Naur linux-2.6.7-mm1-orig/drivers/video/fbmem.c linux-2.6.7-mm1/drivers/video/fbmem.c
> --- linux-2.6.7-mm1-orig/drivers/video/fbmem.c	2004-06-22 13:43:12.000000000 +0000
> +++ linux-2.6.7-mm1/drivers/video/fbmem.c	2004-06-22 14:03:03.965024872 +0000
> @@ -1104,11 +1104,10 @@
>  #endif /* CONFIG_KMOD */
>  		if (!registered_fb[con2fb.framebuffer])
>  		    return -EINVAL;
> -		if (con2fb.console != 0)
> -			set_con2fb_map(con2fb.console-1, con2fb.framebuffer);
> -		else
> -			fb_console_init();		
> -		return 0;
> +		if (con2fb.console > 0 && con2fb.console < MAX_NR_CONSOLES)
> +			return set_con2fb_map(con2fb.console-1,
> +					      con2fb.framebuffer);
> +		return -EINVAL;
>  #endif	/* CONFIG_FRAMEBUFFER_CONSOLE */
>  	case FBIOBLANK:
>  		acquire_console_sem();
> diff -Naur linux-2.6.7-mm1-orig/include/linux/fb.h linux-2.6.7-mm1/include/linux/fb.h
> --- linux-2.6.7-mm1-orig/include/linux/fb.h	2004-06-22 13:43:59.000000000 +0000
> +++ linux-2.6.7-mm1/include/linux/fb.h	2004-06-22 14:03:23.871998552 +0000
> @@ -539,6 +539,7 @@
>  	struct fb_monspecs monspecs;	/* Current Monitor specs */
>  	struct fb_cursor cursor;	/* Current cursor */	
>  	struct work_struct queue;	/* Framebuffer event queue */
> +	struct timer_list cursor_timer; /* Cursor timer */
>  	struct fb_pixmap pixmap;	/* Image hardware mapper */
>  	struct fb_pixmap sprite;	/* Cursor hardware mapper */
>  	struct fb_cmap cmap;		/* Current cmap */
> 
> 
> 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
