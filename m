From: daeinki <inki.dae@samsung.com>
Date: Wed, 22 Jun 2011 04:26:04 +0000
Subject: Some questions about DRM(Direct Rendering Manager)
Message-Id: <4E016EDC.30200@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi all,

I'm writing Samsung SoC based DRM framework and this one includes FIMD
and HDMI driver as hardware dependent modules. and for now, encoder,
connector, crtc and fb module has been materialized almost. but I'm
contending with  framebuffer setting issue(created fb_info should be
registered to linux framebuffer through register_framebuffer() or not)as
default framebuffer at booting time.

at drm_fb_helper_single_fb_probe() of drm_fb_helper.c file, fb_helper's
fb_probe callback is called and this one creates new framebuffer and
returns a value more then 0 if true. internally, this process creates an
fb_info object and drm_framebuffer and then drm_framebuffer would be
added to mode_config.fb_list of the drm_device.

a value returned, new_fb is used to decide that it calls
register_framebuffer() or drm_fb_helper_set_par(). at this point, I am
confused it's a good way to call register_framebuffer() otherwise
drm_fb_helper_set_par(). if register_framebuffer() is called then I
guess drm_fb_helper_set_par() or drm_crtc_helper_set_config() should be
called somewhere subsequently to apply this one to real hardware because
previous process is just for maintaining data logically.(not set up data
to h/w)

it's a right way to call register_framebuffer() and then
drm_fb_helper_set_par() or drm_crtc_helper_set_config()? otherwise just
only drm_fb_helper_set_par() or drm_crtc_helper_set_config() ignoring
register_framebuffer()? and what is the purpose of using
register_framebuffer()?

In my case, first, register_framebuffer() is called and then if desired
default crtc id is matched with drm_fb_helper->crtc_info[0 ~ n].crtc_id,
it gets mode_set of drm_fb_helper->crtc_info[n] and then  it calls
drm_crtc_helper_set_config(mode_set). at this time, all the hardware
configurations would be completed.

thank you in advance.

Best Regards
Inki Dae.
