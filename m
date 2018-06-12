From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 12 Jun 2018 16:32:34 +0000
Subject: Re: [PATCH 18/21] udlfb: allow reallocating the framebuffer
Message-Id: <alpine.LRH.2.02.1806121230320.1848@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144225.463043082@twibright.com>
 <201806040247.iosxtl0E%fengguang.wu@intel.com>
In-Reply-To: <201806040247.iosxtl0E%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org, kbuild-all@01.org, Dave Airlie <airlied@redhat.com>



On Mon, 4 Jun 2018, kbuild test robot wrote:

> Hi Mikulas,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on drm/drm-next]
> [also build test WARNING on v4.17-rc7 next-20180601]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Mikulas-Patocka/USB-DisplayLink-patches/20180603-233013

What is it really complaining about? That URL shows 404 Not Found and this 
email has no warnings at all.

> base:   git://people.freedesktop.org/~airlied/linux.git drm-next
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> 
> vim +1198 drivers/video/fbdev/udlfb.c
> 
>   1171	
>   1172	/*
>   1173	 * Assumes &info->lock held by caller
>   1174	 * Assumes no active clients have framebuffer open
>   1175	 */
>   1176	static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info, u32 new_len)
>   1177	{
>   1178		u32 old_len = info->fix.smem_len;
> > 1179		unsigned char *old_fb = info->screen_base;
>   1180		unsigned char *new_fb;
>   1181		unsigned char *new_back = NULL;
>   1182	
>   1183		new_len = PAGE_ALIGN(new_len);
>   1184	
>   1185		if (new_len > old_len) {
>   1186			/*
>   1187			 * Alloc system memory for virtual framebuffer
>   1188			 */
>   1189			new_fb = vmalloc(new_len);
>   1190			if (!new_fb) {
>   1191				dev_err(info->dev, "Virtual framebuffer alloc failed\n");
>   1192				return -ENOMEM;
>   1193			}
>   1194			memset(new_fb, 0xff, new_len);
>   1195	
>   1196			if (info->screen_base) {
>   1197				memcpy(new_fb, old_fb, old_len);
> > 1198				dlfb_deferred_vfree(dlfb, info->screen_base);
>   1199			}
>   1200	
>   1201			info->screen_base = new_fb;
>   1202			info->fix.smem_len = new_len;
>   1203			info->fix.smem_start = (unsigned long) new_fb;
>   1204			info->flags = udlfb_info_flags;
>   1205	
>   1206			/*
>   1207			 * Second framebuffer copy to mirror the framebuffer state
>   1208			 * on the physical USB device. We can function without this.
>   1209			 * But with imperfect damage info we may send pixels over USB
>   1210			 * that were, in fact, unchanged - wasting limited USB bandwidth
>   1211			 */
>   1212			if (shadow)
>   1213				new_back = vzalloc(new_len);
>   1214			if (!new_back)
>   1215				dev_info(info->dev,
>   1216					 "No shadow/backing buffer allocated\n");
>   1217			else {
>   1218				dlfb_deferred_vfree(dlfb, dlfb->backing_buffer);
>   1219				dlfb->backing_buffer = new_back;
>   1220			}
>   1221		}
>   1222		return 0;
>   1223	}
>   1224	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
