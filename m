From: Prarit Bhargava <prarit@redhat.com>
Date: Mon, 12 Nov 2018 13:52:49 +0000
Subject: Re: [kbuild-all] [PATCH] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <ef9e3455-dc05-b8ef-e5c8-59c31fcb119a@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181029130232.31661-1-prarit@redhat.com>
 <201810292146.8VJDEevV%fengguang.wu@intel.com>
 <e5a22c84-3384-4b7f-ebec-1521d3609988@redhat.com>
 <616a7178-a10b-de5c-0579-663433dba931@intel.com>
In-Reply-To: <616a7178-a10b-de5c-0579-663433dba931@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rong Chen <rong.a.chen@intel.com>, kbuild test robot <lkp@intel.com>
Cc: Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Thierry Reding <treding@nvidia.com>, kbuild-all@01.org



On 11/11/2018 10:18 PM, Rong Chen wrote:
> 
> 
> On 10/29/2018 11:15 PM, Prarit Bhargava wrote:
>>
>> On 10/29/2018 09:56 AM, kbuild test robot wrote:
>>> Hi Prarit,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on sof-driver-fuweitax/master]
>>> [also build test ERROR on v4.19 next-20181029]
>>> [if your patch is applied to the wrong git tree, please drop us a note to
>>> help improve the system]
>>>
>>> url:   
>>> https://github.com/0day-ci/linux/commits/Prarit-Bhargava/fbcon-Silence-fbcon-logo-on-quiet-boots/20181029-211617
>>>
>>> base:   https://github.com/fuweitax/linux master
>>> config: m68k-multi_defconfig (attached as .config)
>>> compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>>> reproduce:
>>>          wget
>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
>>> ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # save the attached .config to linux build tree
>>>          GCC_VERSION=7.2.0 make.cross ARCH=m68k
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     drivers/video/fbdev/core/fbcon.c: In function 'fbcon_prepare_logo':
>>>     drivers/video/fbdev/core/fbcon.c:680:13: error: invalid storage class for
>>> function 'set_blitting_type'
>>>      static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
>>>                  ^~~~~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:680:1: warning: ISO C90 forbids mixed
>>> declarations and code [-Wdeclaration-after-statement]
>>>      static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
>>>      ^~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:690:12: error: invalid storage class for
>>> function 'fbcon_invalid_charcount'
>>>      static int fbcon_invalid_charcount(struct fb_info *info, unsigned
>>> charcount)
>>>                 ^~~~~~~~~~~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:698:12: error: invalid storage class for
>>> function 'con2fb_acquire_newinfo'
>>>      static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
>>>                 ^~~~~~~~~~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:734:12: error: invalid storage class for
>>> function 'con2fb_release_oldinfo'
>>>      static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info
>>> *oldinfo,
>>>                 ^~~~~~~~~~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:780:13: error: invalid storage class for
>>> function 'con2fb_init_display'
>>>      static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
>>>                  ^~~~~~~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:825:12: error: invalid storage class for
>>> function 'set_con2fb_map'
>>>      static int set_con2fb_map(int unit, int newidx, int user)
>>>                 ^~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:882:12: error: invalid storage class for
>>> function 'var_to_display'
>>>      static int var_to_display(struct display *disp,
>>>                 ^~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:906:13: error: invalid storage class for
>>> function 'display_to_var'
>>>      static void display_to_var(struct fb_var_screeninfo *var,
>>>                  ^~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:925:20: error: invalid storage class for
>>> function 'fbcon_startup'
>>>      static const char *fbcon_startup(void)
>>>                         ^~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:1036:13: error: invalid storage class
>>> for function 'fbcon_init'
>>>      static void fbcon_init(struct vc_data *vc, int init)
>>>                  ^~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:1183:13: error: invalid storage class
>>> for function 'fbcon_free_font'
>>>      static void fbcon_free_font(struct display *p, bool freefont)
>>>                  ^~~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:1191:13: error: invalid storage class
>>> for function 'set_vc_hi_font'
>>>      static void set_vc_hi_font(struct vc_data *vc, bool set);
>>>                  ^~~~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c:1193:13: error: invalid storage class
>>> for function 'fbcon_deinit'
>>>      static void fbcon_deinit(struct vc_data *vc)
>>>                  ^~~~~~~~~~~~
>>>     drivers/video/fbdev/core/fbcon.c: In function 'fbcon_deinit':
>>>>> drivers/video/fbdev/core/fbcon.c:1229:3: error: implicit declaration of
>>>>> function 'set_vc_hi_font'; did you mean 'seq_path_root'?
>>>>> [-Werror=implicit-function-declaration]
>>>        set_vc_hi_font(vc, false);
>>>        ^~~~~~~~~~~~~~
>> Hmm ... this doesn't look like anything that is at fault with my patch.
>>
>> There's a lot of warnings here, and perhaps another fix is required to make
>> sure that the configs are set correctly?  I can certainly take a look in
>> another patch but AFAICT this isn't an issue with my patch.
> 
> Please accept my apologies for taking your time, we will look into it.
> 

Rong, it turns out that this was a bug in my patch.  I have posted a new
patch that resolves the above compile issue.

P.

> Best Regards,
> Rong Chen
