From: daeinki <inki.dae@samsung.com>
Date: Wed, 22 Jun 2011 06:04:23 +0000
Subject: Re: Some questions about DRM(Direct Rendering Manager)
Message-Id: <4E0185E7.8020708@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4E016EDC.30200@samsung.com>
In-Reply-To: <4E016EDC.30200@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

below is additional comments.

daeinki =BE=B4 =B1=DB:
> Hi all,
>=20
> I'm writing Samsung SoC based DRM framework and this one includes FIMD
> and HDMI driver as hardware dependent modules. and for now, encoder,
> connector, crtc and fb module has been materialized almost. but I'm
> contending with  framebuffer setting issue(created fb_info should be
> registered to linux framebuffer through register_framebuffer() or not)as
> default framebuffer at booting time.
>=20
> at drm_fb_helper_single_fb_probe() of drm_fb_helper.c file, fb_helper's
> fb_probe callback is called and this one creates new framebuffer and
> returns a value more then 0 if true. internally, this process creates an
> fb_info object and drm_framebuffer and then drm_framebuffer would be
> added to mode_config.fb_list of the drm_device.
>
it's my mistake. return value is 0 if true, nonzero otherwise.

> a value returned, new_fb is used to decide that it calls
> register_framebuffer() or drm_fb_helper_set_par(). at this point, I am
> confused it's a good way to call register_framebuffer() otherwise
> drm_fb_helper_set_par(). if register_framebuffer() is called then I
> guess drm_fb_helper_set_par() or drm_crtc_helper_set_config() should be
> called somewhere subsequently to apply this one to real hardware because
> previous process is just for maintaining data logically.(not set up data
> to h/w)
>=20
> it's a right way to call register_framebuffer() and then
> drm_fb_helper_set_par() or drm_crtc_helper_set_config()? otherwise just
> only drm_fb_helper_set_par() or drm_crtc_helper_set_config() ignoring
> register_framebuffer()? and what is the purpose of using
> register_framebuffer()?
>=20
I understood that if fb_probe() callback is fail then fb_info object is
registered to linux framebuffer through register_framebuffer()
otherwise(if true) hardware configuration would be completed by
drm_fb_helper_set_par() so the reason of using register_framebuffer() is
that the case of failing fb_probe() callback, it is for drawing on only
linux framebuffer. is it right?

> In my case, first, register_framebuffer() is called and then if desired
> default crtc id is matched with drm_fb_helper->crtc_info[0 ~ n].crtc_id,
> it gets mode_set of drm_fb_helper->crtc_info[n] and then  it calls
> drm_crtc_helper_set_config(mode_set). at this time, all the hardware
> configurations would be completed.
>=20
> thank you in advance.
>=20
> Best Regards
> Inki Dae.
>=20

