From: kbuild test robot <lkp@intel.com>
Date: Mon, 29 Oct 2018 13:56:45 +0000
Subject: Re: [PATCH] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <201810292146.8VJDEevV%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181029130232.31661-1-prarit@redhat.com>
In-Reply-To: <20181029130232.31661-1-prarit@redhat.com>
To: linux-fbdev@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prarit,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sof-driver-fuweitax/master]
[also build test ERROR on v4.19 next-20181029]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Prarit-Bhargava/fbcon-Silence-fbcon-logo-on-quiet-boots/20181029-211617
base:   https://github.com/fuweitax/linux master
config: m68k-multi_defconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_prepare_logo':
   drivers/video/fbdev/core/fbcon.c:680:13: error: invalid storage class for function 'set_blitting_type'
    static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
                ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:680:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
    ^~~~~~
   drivers/video/fbdev/core/fbcon.c:690:12: error: invalid storage class for function 'fbcon_invalid_charcount'
    static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:698:12: error: invalid storage class for function 'con2fb_acquire_newinfo'
    static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:734:12: error: invalid storage class for function 'con2fb_release_oldinfo'
    static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:780:13: error: invalid storage class for function 'con2fb_init_display'
    static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
                ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:825:12: error: invalid storage class for function 'set_con2fb_map'
    static int set_con2fb_map(int unit, int newidx, int user)
               ^~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:882:12: error: invalid storage class for function 'var_to_display'
    static int var_to_display(struct display *disp,
               ^~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:906:13: error: invalid storage class for function 'display_to_var'
    static void display_to_var(struct fb_var_screeninfo *var,
                ^~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:925:20: error: invalid storage class for function 'fbcon_startup'
    static const char *fbcon_startup(void)
                       ^~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1036:13: error: invalid storage class for function 'fbcon_init'
    static void fbcon_init(struct vc_data *vc, int init)
                ^~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1183:13: error: invalid storage class for function 'fbcon_free_font'
    static void fbcon_free_font(struct display *p, bool freefont)
                ^~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1191:13: error: invalid storage class for function 'set_vc_hi_font'
    static void set_vc_hi_font(struct vc_data *vc, bool set);
                ^~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1193:13: error: invalid storage class for function 'fbcon_deinit'
    static void fbcon_deinit(struct vc_data *vc)
                ^~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_deinit':
>> drivers/video/fbdev/core/fbcon.c:1229:3: error: implicit declaration of function 'set_vc_hi_font'; did you mean 'seq_path_root'? [-Werror=implicit-function-declaration]
      set_vc_hi_font(vc, false);
      ^~~~~~~~~~~~~~
      seq_path_root
   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_prepare_logo':
   drivers/video/fbdev/core/fbcon.c:1262:13: error: invalid storage class for function 'fbcon_clear'
    static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
                ^~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1300:13: error: invalid storage class for function 'fbcon_putcs'
    static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
                ^~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1313:13: error: invalid storage class for function 'fbcon_putc'
    static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
                ^~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1321:13: error: invalid storage class for function 'fbcon_clear_margins'
    static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
                ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1330:13: error: invalid storage class for function 'fbcon_cursor'
    static void fbcon_cursor(struct vc_data *vc, int mode)
                ^~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1365:13: error: invalid storage class for function 'fbcon_set_disp'
    static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
                ^~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1433:24: error: invalid storage class for function 'ywrap_up'
    static __inline__ void ywrap_up(struct vc_data *vc, int count)
                           ^~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1452:24: error: invalid storage class for function 'ywrap_down'
    static __inline__ void ywrap_down(struct vc_data *vc, int count)
                           ^~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1471:24: error: invalid storage class for function 'ypan_up'
    static __inline__ void ypan_up(struct vc_data *vc, int count)
                           ^~~~~~~
   drivers/video/fbdev/core/fbcon.c:1495:24: error: invalid storage class for function 'ypan_up_redraw'
    static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
                           ^~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1519:24: error: invalid storage class for function 'ypan_down'
    static __inline__ void ypan_down(struct vc_data *vc, int count)
                           ^~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1543:24: error: invalid storage class for function 'ypan_down_redraw'
    static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
                           ^~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1567:13: error: invalid storage class for function 'fbcon_redraw_softback'
    static void fbcon_redraw_softback(struct vc_data *vc, struct display *p,
                ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1660:13: error: invalid storage class for function 'fbcon_redraw_move'
    static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
                ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1694:13: error: invalid storage class for function 'fbcon_redraw_blit'
    static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
                ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1744:13: error: invalid storage class for function 'fbcon_redraw'
    static void fbcon_redraw(struct vc_data *vc, struct display *p,
                ^~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1799:20: error: invalid storage class for function 'fbcon_softback_note'
    static inline void fbcon_softback_note(struct vc_data *vc, int t,
                       ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:1824:13: error: invalid storage class for function 'fbcon_scroll'
    static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
                ^~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2028:13: error: invalid storage class for function 'fbcon_bmove'
    static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
                ^~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2051:13: error: invalid storage class for function 'fbcon_bmove_rec'
    static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int sx,
                ^~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2093:13: error: invalid storage class for function 'updatescrollmode'
    static void updatescrollmode(struct display *p,
                ^~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2140:12: error: invalid storage class for function 'fbcon_resize'
    static int fbcon_resize(struct vc_data *vc, unsigned int width,
               ^~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2186:12: error: invalid storage class for function 'fbcon_switch'
    static int fbcon_switch(struct vc_data *vc)
               ^~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2325:13: error: invalid storage class for function 'fbcon_generic_blank'
    static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
                ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2350:12: error: invalid storage class for function 'fbcon_blank'
    static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
               ^~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2392:12: error: invalid storage class for function 'fbcon_debug_enter'
    static int fbcon_debug_enter(struct vc_data *vc)
               ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2405:12: error: invalid storage class for function 'fbcon_debug_leave'
    static int fbcon_debug_leave(struct vc_data *vc)
               ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2416:12: error: invalid storage class for function 'fbcon_get_font'
    static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
               ^~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2468:13: error: invalid storage class for function 'set_vc_hi_font'
    static void set_vc_hi_font(struct vc_data *vc, bool set)
                ^~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2528:12: error: invalid storage class for function 'fbcon_do_set_font'
    static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
               ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2579:12: error: invalid storage class for function 'fbcon_copy_font'
    static int fbcon_copy_font(struct vc_data *vc, int con)
               ^~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:2601:12: error: invalid storage class for function 'fbcon_set_font'
    static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
               ^~~~~~~~~~~~~~

vim +1229 drivers/video/fbdev/core/fbcon.c

e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1190  
8aac7f34 drivers/video/console/fbcon.c Takashi Iwai       2017-01-11 @1191  static void set_vc_hi_font(struct vc_data *vc, bool set);
8aac7f34 drivers/video/console/fbcon.c Takashi Iwai       2017-01-11  1192  
^1da177e drivers/video/console/fbcon.c Linus Torvalds     2005-04-16  1193  static void fbcon_deinit(struct vc_data *vc)
^1da177e drivers/video/console/fbcon.c Linus Torvalds     2005-04-16  1194  {
^1da177e drivers/video/console/fbcon.c Linus Torvalds     2005-04-16  1195  	struct display *p = &fb_display[vc->vc_num];
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1196  	struct fb_info *info;
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1197  	struct fbcon_ops *ops;
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1198  	int idx;
ae128786 drivers/video/console/fbcon.c Dave Airlie        2013-01-24  1199  	bool free_font = true;
^1da177e drivers/video/console/fbcon.c Linus Torvalds     2005-04-16  1200  
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1201  	idx = con2fb_map[vc->vc_num];
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1202  
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1203  	if (idx == -1)
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1204  		goto finished;
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1205  
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1206  	info = registered_fb[idx];
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1207  
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1208  	if (!info)
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1209  		goto finished;
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1210  
ae128786 drivers/video/console/fbcon.c Dave Airlie        2013-01-24  1211  	if (info->flags & FBINFO_MISC_FIRMWARE)
ae128786 drivers/video/console/fbcon.c Dave Airlie        2013-01-24  1212  		free_font = false;
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1213  	ops = info->fbcon_par;
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1214  
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1215  	if (!ops)
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1216  		goto finished;
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1217  
6ca8dfd7 drivers/video/console/fbcon.c Jiri Slaby         2016-06-23  1218  	if (con_is_visible(vc))
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1219  		fbcon_del_cursor_timer(info);
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1220  
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1221  	ops->flags &= ~FBCON_FLAGS_INIT;
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1222  finished:
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1223  
ae128786 drivers/video/console/fbcon.c Dave Airlie        2013-01-24  1224  	fbcon_free_font(p, free_font);
e6637d54 drivers/video/console/fbcon.c Mika Kuoppala      2013-04-22  1225  	if (free_font)
e6637d54 drivers/video/console/fbcon.c Mika Kuoppala      2013-04-22  1226  		vc->vc_font.data = NULL;
ae128786 drivers/video/console/fbcon.c Dave Airlie        2013-01-24  1227  
8aac7f34 drivers/video/console/fbcon.c Takashi Iwai       2017-01-11  1228  	if (vc->vc_hi_font_mask)
8aac7f34 drivers/video/console/fbcon.c Takashi Iwai       2017-01-11 @1229  		set_vc_hi_font(vc, false);
8aac7f34 drivers/video/console/fbcon.c Takashi Iwai       2017-01-11  1230  
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1231  	if (!con_is_bound(&fb_con))
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1232  		fbcon_exit();
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1233  
e614b18d drivers/video/console/fbcon.c Antonino A. Daplas 2006-06-26  1234  	return;
^1da177e drivers/video/console/fbcon.c Linus Torvalds     2005-04-16  1235  }
^1da177e drivers/video/console/fbcon.c Linus Torvalds     2005-04-16  1236  

:::::: The code at line 1229 was first introduced by commit
:::::: 8aac7f34369726d1a158788ae8aff3002d5eb528 fbcon: Fix vc attr at deinit

:::::: TO: Takashi Iwai <tiwai@suse.de>
:::::: CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qXQfr1gj8AAY47Ijlf8HnAIuobrOAAA=

--k+w/mQv8wyuph6w0--
