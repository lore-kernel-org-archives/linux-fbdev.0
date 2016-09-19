From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Mon, 19 Sep 2016 18:16:31 +0000
Subject: Re: [PATCH v3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1474308991.2668.24.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1474236417-27150-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1474236417-27150-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tomi,

I thought I'd let you, Tomi, (and all the others) know what the patch
does:

There is currently a single scrollback buffer (vgacon_scrollback) that
contains the text of the current console. When you switch the console it
is cleared and re-used for the new console.
My patch simply replaced the single scrollback buffer with an array of
scrollback buffers. One for each console.

A quick shout out to everybody else: Tomi told me today that he is
currently short on time to review this patch, so any Reviewed-by or
Tested-by would be very appreciated.

Bye,

Manuel


On Mo, 2016-09-19 at 00:06 +0200, Manuel Schölling wrote:
> Add a scrollback buffers for each VGA console. The benefit is that
> the scrollback history is not flushed when switching between consoles
> but is persistent.
> The buffers are allocated on demand when a new console is opened.
> 
> It always annoys me when I switch back to a console and I can just
> read half of an error backtrace. This should fix issues like these.
> 
> This breaks tools like clear_console that rely on flushing the
> scrollback history by switching back and forth between consoles
> which is why this feature is disabled by default.
> Use the escape sequence \e[3J instead for flushing the buffer.
> 
> Signed-off-by: Manuel Schölling <manuel.schoelling@gmx.de>
> ---
> Changes in v3:
>   - Add config option for this feature
>   - Fallback to old scrollback buffer if kcalloc() fails
>   - Remove ioctl() call again and add documentation about existing
>     escape sequence to flush the scrollback buffer
> Changes in v2:
>   - Add ioctl() call to flush scrollback buffer
>   - (Patch v2 was not labeled as such, sorry)
> ---
>  drivers/video/console/Kconfig  |  23 +++++-
>  drivers/video/console/vgacon.c | 160 +++++++++++++++++++++++++++--------------
>  2 files changed, 128 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 38da6e2..67e52f0 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -43,9 +43,26 @@ config VGACON_SOFT_SCROLLBACK_SIZE
>         range 1 1024
>         default "64"
>         help
> -         Enter the amount of System RAM to allocate for the scrollback
> -	 buffer.  Each 64KB will give you approximately 16 80x25
> -	 screenfuls of scrollback buffer
> +	  Enter the amount of System RAM to allocate for scrollback
> +	  buffers of VGA consoles. Each 64KB will give you approximately
> +	  16 80x25 screenfuls of scrollback buffer.
> +
> +config VGACON_SOFT_SCROLLBACK_FOR_EACH_CONSOLE
> +	bool "Persistent Scrollback History for each console"
> +	depends on VGACON_SOFT_SCROLLBACK
> +	default n
> +	help
> +	  Say Y here if for each VGA console a scrollback buffer should
> +	  be allocated. The scrollback history will persist when switching
> +	  between consoles. If you say N here, scrollback is only supported
> +	  for the active VGA console and scrollback history will be flushed
> +	  when switching between consoles.
> +
> +	  This breaks legacy versions of tools like clear_console which
> +	  might cause security issues.
> +	  Use the escape sequence \e[3J instead if this feature is activated.
> +
> +	  If you use a RAM-constrained system, say N here.
>  
>  config MDA_CONSOLE
>  	depends on !M68K && !PARISC && ISA
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index 1157661..e70e8fe 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -1,5 +1,5 @@
>  /*
> - *  linux/drivers/video/vgacon.c -- Low level VGA based console driver
> + *  linux/drivers/video/console/vgacon.c -- Low level VGA based console driver
>   *
>   *	Created 28 Sep 1997 by Geert Uytterhoeven
>   *
> @@ -181,70 +181,125 @@ static inline void vga_set_mem_top(struct vc_data *c)
>  
>  #ifdef CONFIG_VGACON_SOFT_SCROLLBACK
>  /* software scrollback */
> -static void *vgacon_scrollback;
> -static int vgacon_scrollback_tail;
> -static int vgacon_scrollback_size;
> -static int vgacon_scrollback_rows;
> -static int vgacon_scrollback_cnt;
> -static int vgacon_scrollback_cur;
> -static int vgacon_scrollback_save;
> -static int vgacon_scrollback_restore;
> -
> -static void vgacon_scrollback_init(int pitch)
> +struct vgacon_scrollback_info {
> +	void *data;
> +	int tail;
> +	int size;
> +	int rows;
> +	int cnt;
> +	int cur;
> +	int save;
> +	int restore;
> +};
> +static struct vgacon_scrollback_info *vgacon_scrollback_cur;
> +#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_FOR_EACH_CONSOLE
> +static struct vgacon_scrollback_info vgacon_scrollbacks[MAX_NR_CONSOLES];
> +#else
> +static struct vgacon_scrollback_info vgacon_scrollbacks[1];
> +#endif
> +
> +static void vgacon_scrollback_reset(size_t reset_size)
>  {
> -	int rows = CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024/pitch;
> -
> -	if (vgacon_scrollback) {
> -		vgacon_scrollback_cnt  = 0;
> -		vgacon_scrollback_tail = 0;
> -		vgacon_scrollback_cur  = 0;
> -		vgacon_scrollback_rows = rows - 1;
> -		vgacon_scrollback_size = rows * pitch;
> +	if (vgacon_scrollback_cur->data && reset_size > 0)
> +		memset(vgacon_scrollback_cur->data, 0, reset_size);
> +
> +	vgacon_scrollback_cur->cnt  = 0;
> +	vgacon_scrollback_cur->tail = 0;
> +	vgacon_scrollback_cur->cur  = 0;
> +}
> +
> +static void vgacon_scrollback_init(int vc_num)
> +{
> +	int pitch = vga_video_num_columns * 2;
> +	size_t size = CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
> +	int rows = size/pitch;
> +	void *data;
> +
> +	data = kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024, GFP_NOWAIT);
> +	if (data) {
> +		vgacon_scrollbacks[vc_num].data = data;
> +		vgacon_scrollback_cur = &vgacon_scrollbacks[vc_num];
> +
> +		vgacon_scrollback_cur->rows = rows - 1;
> +		vgacon_scrollback_cur->size = rows * pitch;
> +
> +		vgacon_scrollback_reset(0);
> +	} else {
> +		pr_warn("VGAcon: failed to allocate memory for scrollback. Trying to reuse previous buffer.\n");
> +		/* Leave vgacon_scrollback_cur untouched but reset its content */
> +		vgacon_scrollback_reset(size);
>  	}
>  }
>  
> +static void vgacon_switch_scrollback(int vc_num)
> +{
> +#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_FOR_EACH_CONSOLE
> +	if (!vgacon_scrollbacks[vc_num].data)
> +		vgacon_scrollback_init(vc_num);
> +	else
> +		vgacon_scrollback_cur = &vgacon_scrollbacks[vc_num];
> +#else
> +	vc_num = 0;
> +
> +	if (!vgacon_scrollbacks[vc_num].data)
> +		vgacon_scrollback_init(vc_num);
> +	else {
> +		size_t size = CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
> +
> +		vgacon_scrollback_reset(size);
> +	}
> +#endif
> +}
> +
>  static void vgacon_scrollback_startup(void)
>  {
> -	vgacon_scrollback = kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024, GFP_NOWAIT);
> -	vgacon_scrollback_init(vga_video_num_columns * 2);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(vgacon_scrollbacks); ++i)
> +		vgacon_scrollbacks[i].data = NULL;
> +
> +	vgacon_scrollback_cur = &vgacon_scrollbacks[0];
> +	vgacon_scrollback_init(0);
>  }
>  
>  static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
>  {
>  	void *p;
>  
> -	if (!vgacon_scrollback_size || c->vc_num != fg_console)
> +	if (!vgacon_scrollback_cur->data || !vgacon_scrollback_cur->size)
>  		return;
>  
>  	p = (void *) (c->vc_origin + t * c->vc_size_row);
>  
>  	while (count--) {
> -		scr_memcpyw(vgacon_scrollback + vgacon_scrollback_tail,
> +		scr_memcpyw(vgacon_scrollback_cur->data +
> +			    vgacon_scrollback_cur->tail,
>  			    p, c->vc_size_row);
> -		vgacon_scrollback_cnt++;
> +
> +		vgacon_scrollback_cur->cnt++;
>  		p += c->vc_size_row;
> -		vgacon_scrollback_tail += c->vc_size_row;
> +		vgacon_scrollback_cur->tail += c->vc_size_row;
>  
> -		if (vgacon_scrollback_tail >= vgacon_scrollback_size)
> -			vgacon_scrollback_tail = 0;
> +		if (vgacon_scrollback_cur->tail >= vgacon_scrollback_cur->size)
> +			vgacon_scrollback_cur->tail = 0;
>  
> -		if (vgacon_scrollback_cnt > vgacon_scrollback_rows)
> -			vgacon_scrollback_cnt = vgacon_scrollback_rows;
> +		if (vgacon_scrollback_cur->cnt > vgacon_scrollback_cur->rows)
> +			vgacon_scrollback_cur->cnt = vgacon_scrollback_cur->rows;
>  
> -		vgacon_scrollback_cur = vgacon_scrollback_cnt;
> +		vgacon_scrollback_cur->cur = vgacon_scrollback_cur->cnt;
>  	}
>  }
>  
>  static void vgacon_restore_screen(struct vc_data *c)
>  {
> -	vgacon_scrollback_save = 0;
> +	vgacon_scrollback_cur->save = 0;
>  
> -	if (!vga_is_gfx && !vgacon_scrollback_restore) {
> +	if (!vga_is_gfx && !vgacon_scrollback_cur->restore) {
>  		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
>  			    c->vc_screenbuf_size > vga_vram_size ?
>  			    vga_vram_size : c->vc_screenbuf_size);
> -		vgacon_scrollback_restore = 1;
> -		vgacon_scrollback_cur = vgacon_scrollback_cnt;
> +		vgacon_scrollback_cur->restore = 1;
> +		vgacon_scrollback_cur->cur = vgacon_scrollback_cur->cnt;
>  	}
>  }
>  
> @@ -258,41 +313,41 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
>  		return;
>  	}
>  
> -	if (!vgacon_scrollback)
> +	if (!vgacon_scrollback_cur->data)
>  		return;
>  
> -	if (!vgacon_scrollback_save) {
> +	if (!vgacon_scrollback_cur->save) {
>  		vgacon_cursor(c, CM_ERASE);
>  		vgacon_save_screen(c);
> -		vgacon_scrollback_save = 1;
> +		vgacon_scrollback_cur->save = 1;
>  	}
>  
> -	vgacon_scrollback_restore = 0;
> -	start = vgacon_scrollback_cur + lines;
> +	vgacon_scrollback_cur->restore = 0;
> +	start = vgacon_scrollback_cur->cur + lines;
>  	end = start + abs(lines);
>  
>  	if (start < 0)
>  		start = 0;
>  
> -	if (start > vgacon_scrollback_cnt)
> -		start = vgacon_scrollback_cnt;
> +	if (start > vgacon_scrollback_cur->cnt)
> +		start = vgacon_scrollback_cur->cnt;
>  
>  	if (end < 0)
>  		end = 0;
>  
> -	if (end > vgacon_scrollback_cnt)
> -		end = vgacon_scrollback_cnt;
> +	if (end > vgacon_scrollback_cur->cnt)
> +		end = vgacon_scrollback_cur->cnt;
>  
> -	vgacon_scrollback_cur = start;
> +	vgacon_scrollback_cur->cur = start;
>  	count = end - start;
> -	soff = vgacon_scrollback_tail - ((vgacon_scrollback_cnt - end) *
> -					 c->vc_size_row);
> +	soff = vgacon_scrollback_cur->tail - (c->vc_size_row *
> +					 (vgacon_scrollback_cur->cnt - end));
>  	soff -= count * c->vc_size_row;
>  
>  	if (soff < 0)
> -		soff += vgacon_scrollback_size;
> +		soff += vgacon_scrollback_cur->size;
>  
> -	count = vgacon_scrollback_cnt - start;
> +	count = vgacon_scrollback_cur->cnt - start;
>  
>  	if (count > c->vc_rows)
>  		count = c->vc_rows;
> @@ -306,13 +361,13 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
>  
>  		count *= c->vc_size_row;
>  		/* how much memory to end of buffer left? */
> -		copysize = min(count, vgacon_scrollback_size - soff);
> -		scr_memcpyw(d, vgacon_scrollback + soff, copysize);
> +		copysize = min(count, vgacon_scrollback_cur->size - soff);
> +		scr_memcpyw(d, vgacon_scrollback_cur->data + soff, copysize);
>  		d += copysize;
>  		count -= copysize;
>  
>  		if (count) {
> -			scr_memcpyw(d, vgacon_scrollback, count);
> +			scr_memcpyw(d, vgacon_scrollback_cur->data, count);
>  			d += count;
>  		}
>  
> @@ -325,6 +380,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
>  #define vgacon_scrollback_startup(...) do { } while (0)
>  #define vgacon_scrollback_init(...)    do { } while (0)
>  #define vgacon_scrollback_update(...)  do { } while (0)
> +#define vgacon_switch_scrollback(...)  do { } while (0)
>  
>  static void vgacon_restore_screen(struct vc_data *c)
>  {
> @@ -839,7 +895,7 @@ static int vgacon_switch(struct vc_data *c)
>  			vgacon_doresize(c, c->vc_cols, c->vc_rows);
>  	}
>  
> -	vgacon_scrollback_init(c->vc_size_row);
> +	vgacon_switch_scrollback(c->vc_num);
>  	return 0;		/* Redrawing not needed */
>  }
>  


