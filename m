From: kbuild test robot <lkp@intel.com>
Date: Mon, 29 Oct 2018 13:57:45 +0000
Subject: Re: [PATCH] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <201810292123.KJeIDWKl%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181029130232.31661-1-prarit@redhat.com>
In-Reply-To: <20181029130232.31661-1-prarit@redhat.com>
To: linux-fbdev@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prarit,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sof-driver-fuweitax/master]
[also build test ERROR on v4.19 next-20181029]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Prarit-Bhargava/fbcon-Silence-fbcon-logo-on-quiet-boots/20181029-211617
base:   https://github.com/fuweitax/linux master
config: i386-randconfig-x005-201843 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_prepare_logo':
>> drivers/video/fbdev/core/fbcon.c:655:13: error: invalid storage class for function 'set_blitting_type'
    static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
                ^~~~~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:655:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
    ^~~~~~
>> drivers/video/fbdev/core/fbcon.c:669:12: error: invalid storage class for function 'fbcon_invalid_charcount'
    static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
               ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:698:12: error: invalid storage class for function 'con2fb_acquire_newinfo'
    static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
               ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:734:12: error: invalid storage class for function 'con2fb_release_oldinfo'
    static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
               ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:780:13: error: invalid storage class for function 'con2fb_init_display'
    static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
                ^~~~~~~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:825:12: error: invalid storage class for function 'set_con2fb_map'
    static int set_con2fb_map(int unit, int newidx, int user)
               ^~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:882:12: error: invalid storage class for function 'var_to_display'
    static int var_to_display(struct display *disp,
               ^~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:906:13: error: invalid storage class for function 'display_to_var'
    static void display_to_var(struct fb_var_screeninfo *var,
                ^~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:925:20: error: invalid storage class for function 'fbcon_startup'
    static const char *fbcon_startup(void)
                       ^~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:1036:13: error: invalid storage class for function 'fbcon_init'
    static void fbcon_init(struct vc_data *vc, int init)
                ^~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:1183:13: error: invalid storage class for function 'fbcon_free_font'
    static void fbcon_free_font(struct display *p, bool freefont)
                ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:1191:13: error: invalid storage class for function 'set_vc_hi_font'
    static void set_vc_hi_font(struct vc_data *vc, bool set);
                ^~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:1193:13: error: invalid storage class for function 'fbcon_deinit'
    static void fbcon_deinit(struct vc_data *vc)
                ^~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_deinit':
>> drivers/video/fbdev/core/fbcon.c:1229:3: error: implicit declaration of function 'set_vc_hi_font'; did you mean 'set_page_zone'? [-Werror=implicit-function-declaration]
      set_vc_hi_font(vc, false);
      ^~~~~~~~~~~~~~
      set_page_zone
   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_prepare_logo':
>> drivers/video/fbdev/core/fbcon.c:1262:13: error: invalid storage class for function 'fbcon_clear'
    static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
                ^~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:1300:13: error: invalid storage class for function 'fbcon_putcs'
    static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
                ^~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:1313:13: error: invalid storage class for function 'fbcon_putc'
    static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
                ^~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:1321:13: error: invalid storage class for function 'fbcon_clear_margins'
    static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
                ^~~~~~~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:1330:13: error: invalid storage class for function 'fbcon_cursor'
    static void fbcon_cursor(struct vc_data *vc, int mode)
                ^~~~~~~~~~~~

vim +/set_blitting_type +655 drivers/video/fbdev/core/fbcon.c

^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  653  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  654  #ifdef CONFIG_FB_TILEBLITTING
b73deed3 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09 @655  static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  656  {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  657  	struct fbcon_ops *ops = info->fbcon_par;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  658  
b73deed3 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  659  	ops->p = &fb_display[vc->vc_num];
ab767201 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-13  660  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  661  	if ((info->flags & FBINFO_MISC_TILEBLITTING))
b73deed3 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  662  		fbcon_set_tileops(vc, info);
e4fc2761 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  663  	else {
b73deed3 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  664  		fbcon_set_rotation(info);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  665  		fbcon_set_bitops(ops);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  666  	}
e4fc2761 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  667  }
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  668  
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08 @669  static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  670  {
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  671  	int err = 0;
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  672  
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  673  	if (info->flags & FBINFO_MISC_TILEBLITTING &&
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  674  	    info->tileops->fb_get_tilemax(info) < charcount)
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  675  		err = 1;
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  676  
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  677  	return err;
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  678  }
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  679  #else
b73deed3 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  680  static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  681  {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  682  	struct fbcon_ops *ops = info->fbcon_par;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  683  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  684  	info->flags &= ~FBINFO_MISC_TILEBLITTING;
b73deed3 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  685  	ops->p = &fb_display[vc->vc_num];
b73deed3 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  686  	fbcon_set_rotation(info);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  687  	fbcon_set_bitops(ops);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  688  }
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  689  
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  690  static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  691  {
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  692  	return 0;
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  693  }
38b4982c drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  694  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  695  #endif /* CONFIG_MISC_TILEBLITTING */
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  696  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  697  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16 @698  static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  699  				  int unit, int oldidx)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  700  {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  701  	struct fbcon_ops *ops = NULL;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  702  	int err = 0;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  703  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  704  	if (!try_module_get(info->fbops->owner))
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  705  		err = -ENODEV;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  706  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  707  	if (!err && info->fbops->fb_open &&
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  708  	    info->fbops->fb_open(info, 0))
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  709  		err = -ENODEV;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  710  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  711  	if (!err) {
a39bc34e drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  712  		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  713  		if (!ops)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  714  			err = -ENOMEM;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  715  	}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  716  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  717  	if (!err) {
a1e533ec drivers/video/console/fbcon.c    Jean-Philippe Brucker     2016-02-15  718  		ops->cur_blink_jiffies = HZ / 5;
6c789357 drivers/video/fbdev/core/fbcon.c Kees Cook                 2017-11-10  719  		ops->info = info;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  720  		info->fbcon_par = ops;
d1baa4ff drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  721  
d1baa4ff drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  722  		if (vc)
b73deed3 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  723  			set_blitting_type(vc, info);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  724  	}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  725  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  726  	if (err) {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  727  		con2fb_map[unit] = oldidx;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  728  		module_put(info->fbops->owner);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  729  	}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  730  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  731  	return err;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  732  }
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  733  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16 @734  static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  735  				  struct fb_info *newinfo, int unit,
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  736  				  int oldidx, int found)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  737  {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  738  	struct fbcon_ops *ops = oldinfo->fbcon_par;
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  739  	int err = 0, ret;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  740  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  741  	if (oldinfo->fbops->fb_release &&
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  742  	    oldinfo->fbops->fb_release(oldinfo, 0)) {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  743  		con2fb_map[unit] = oldidx;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  744  		if (!found && newinfo->fbops->fb_release)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  745  			newinfo->fbops->fb_release(newinfo, 0);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  746  		if (!found)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  747  			module_put(newinfo->fbops->owner);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  748  		err = -ENODEV;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  749  	}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  750  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  751  	if (!err) {
88fb2c6e drivers/video/console/fbcon.c    Antonino A. Daplas        2005-09-09  752  		fbcon_del_cursor_timer(oldinfo);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  753  		kfree(ops->cursor_state.mask);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  754  		kfree(ops->cursor_data);
7a966fbd drivers/video/console/fbcon.c    Masami Ichikawa           2014-04-23  755  		kfree(ops->cursor_src);
e4fc2761 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  756  		kfree(ops->fontbuffer);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  757  		kfree(oldinfo->fbcon_par);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  758  		oldinfo->fbcon_par = NULL;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  759  		module_put(oldinfo->fbops->owner);
dd0314f7 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-07  760  		/*
dd0314f7 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-07  761  		  If oldinfo and newinfo are driving the same hardware,
dd0314f7 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-07  762  		  the fb_release() method of oldinfo may attempt to
dd0314f7 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-07  763  		  restore the hardware state.  This will leave the
dd0314f7 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-07  764  		  newinfo in an undefined state. Thus, a call to
dd0314f7 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-07  765  		  fb_set_par() may be needed for the newinfo.
dd0314f7 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-07  766  		*/
5f4dc28b drivers/video/console/fbcon.c    Keith Packard             2014-01-20  767  		if (newinfo && newinfo->fbops->fb_set_par) {
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  768  			ret = newinfo->fbops->fb_set_par(newinfo);
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  769  
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  770  			if (ret)
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  771  				printk(KERN_ERR "con2fb_release_oldinfo: "
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  772  					"detected unhandled fb_set_par error, "
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  773  					"error code %d\n", ret);
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  774  		}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  775  	}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  776  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  777  	return err;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  778  }
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  779  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16 @780  static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  781  				int unit, int show_logo)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  782  {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  783  	struct fbcon_ops *ops = info->fbcon_par;
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  784  	int ret;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  785  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  786  	ops->currcon = fg_console;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  787  
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  788  	if (info->fbops->fb_set_par && !(ops->flags & FBCON_FLAGS_INIT)) {
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  789  		ret = info->fbops->fb_set_par(info);
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  790  
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  791  		if (ret)
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  792  			printk(KERN_ERR "con2fb_init_display: detected "
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  793  				"unhandled fb_set_par error, "
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  794  				"error code %d\n", ret);
0fcf6ada drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  795  	}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  796  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  797  	ops->flags |= FBCON_FLAGS_INIT;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  798  	ops->graphics = 0;
d1baa4ff drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  799  	fbcon_set_disp(info, &info->var, unit);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  800  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  801  	if (show_logo) {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  802  		struct vc_data *fg_vc = vc_cons[fg_console].d;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  803  		struct fb_info *fg_info =
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  804  			registered_fb[con2fb_map[fg_console]];
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  805  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  806  		fbcon_prepare_logo(fg_vc, fg_info, fg_vc->vc_cols,
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  807  				   fg_vc->vc_rows, fg_vc->vc_cols,
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  808  				   fg_vc->vc_rows);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  809  	}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  810  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  811  	update_screen(vc_cons[fg_console].d);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  812  }
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  813  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  814  /**
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  815   *	set_con2fb_map - map console to frame buffer device
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  816   *	@unit: virtual console number to map
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  817   *	@newidx: frame buffer index to map virtual console to
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  818   *      @user: user request
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  819   *
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  820   *	Maps a virtual console @unit to a frame buffer device
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  821   *	@newidx.
054430e7 drivers/video/console/fbcon.c    Dave Airlie               2013-01-25  822   *
054430e7 drivers/video/console/fbcon.c    Dave Airlie               2013-01-25  823   *	This should be called with the console lock held.
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  824   */
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16 @825  static int set_con2fb_map(int unit, int newidx, int user)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  826  {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  827  	struct vc_data *vc = vc_cons[unit].d;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  828  	int oldidx = con2fb_map[unit];
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  829  	struct fb_info *info = registered_fb[newidx];
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  830  	struct fb_info *oldinfo = NULL;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  831   	int found, err = 0;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  832  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  833  	if (oldidx == newidx)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  834  		return 0;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  835  
32b98bf8 drivers/video/console/fbcon.c    Dave Airlie               2010-12-21  836  	if (!info)
e614b18d drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  837  		return -EINVAL;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  838  
32b98bf8 drivers/video/console/fbcon.c    Dave Airlie               2010-12-21  839  	if (!search_for_mapped_con() || !con_is_bound(&fb_con)) {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  840  		info_idx = newidx;
054430e7 drivers/video/console/fbcon.c    Dave Airlie               2013-01-25  841  		return do_fbcon_takeover(0);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  842  	}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  843  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  844  	if (oldidx != -1)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  845  		oldinfo = registered_fb[oldidx];
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  846  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  847  	found = search_fb_in_map(newidx);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  848  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  849  	con2fb_map[unit] = newidx;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  850  	if (!err && !found)
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  851   		err = con2fb_acquire_newinfo(vc, info, unit, oldidx);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  852  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  853  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  854  	/*
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  855  	 * If old fb is not mapped to any of the consoles,
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  856  	 * fbcon should release it.
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  857  	 */
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  858   	if (!err && oldinfo && !search_fb_in_map(oldidx))
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  859   		err = con2fb_release_oldinfo(vc, oldinfo, info, unit, oldidx,
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  860   					     found);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  861  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  862   	if (!err) {
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  863   		int show_logo = (fg_console == 0 && !user &&
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  864   				 logo_shown != FBCON_LOGO_DONTSHOW);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  865  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  866   		if (!found)
88fb2c6e drivers/video/console/fbcon.c    Antonino A. Daplas        2005-09-09  867   			fbcon_add_cursor_timer(info);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  868   		con2fb_map_boot[unit] = newidx;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  869   		con2fb_init_display(vc, info, unit, show_logo);
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  870  	}
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  871  
e614b18d drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  872  	if (!search_fb_in_map(info_idx))
e614b18d drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  873  		info_idx = newidx;
e614b18d drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  874  
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  875   	return err;
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  876  }
^1da177e drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  877  

:::::: The code at line 655 was first introduced by commit
:::::: b73deed32d08740bdbf5f4aab43d988e4d135d95 [PATCH] fbcon: Sanitize fbcon

:::::: TO: Antonino A. Daplas <adaplas@gmail.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7kLSoBmQnZojyTF+oW6SGy6hL/h/l0G7ILDXAQA=

--gBBFr7Ir9EOA20Yy--
