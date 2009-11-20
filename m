From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date: Fri, 20 Nov 2009 13:16:28 +0000
Subject: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video mode
Message-Id: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On drivers using drm_fb_helper's in fb_ops it is not possible to change
video mode, because of different var->pixclock evaluation:

int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
			    struct fb_info *info)
{
[...]
	if (var->pixclock = -1 || !var->pixclock)
		return -EINVAL;
[...]

int drm_fb_helper_set_par(struct fb_info *info)
{
[...]
	if (var->pixclock != -1) {
		DRM_ERROR("PIXEL CLCOK SET\n");
		return -EINVAL;
	}
[...]

One of these evaluations will fail regardless of pixclock value.

P.S. check CLCOK spelling :)

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
