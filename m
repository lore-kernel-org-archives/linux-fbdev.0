From: Dave Airlie <airlied@gmail.com>
Date: Sat, 21 Nov 2009 04:27:18 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
In-Reply-To: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Fri, Nov 20, 2009 at 11:16 PM, Paulius Zaleckas
<paulius.zaleckas@gmail.com> wrote:
> Hi,
>
> On drivers using drm_fb_helper's in fb_ops it is not possible to change
> video mode, because of different var->pixclock evaluation:
>
> int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct fb_info *in=
fo)
> {
> [...]
> =A0 =A0 =A0 =A0if (var->pixclock =3D -1 || !var->pixclock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> [...]
>
> int drm_fb_helper_set_par(struct fb_info *info)
> {
> [...]
> =A0 =A0 =A0 =A0if (var->pixclock !=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRM_ERROR("PIXEL CLCOK SET\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> [...]
>
> One of these evaluations will fail regardless of pixclock value.
>

At the moment the problem with fbset is what to do with it in the
dual head case. Currently we create an fb console that is lowest
common size of the two heads and set native modes on both,

Now if a user runs fbset, I'm not sure what the right answer is,
a) pick a head in advance via sysfs maybe and set it on that.
b) try and set the mode on both heads cloned (what to do if
there is no common mode is another issue).

Dave.

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day=
=20
trial. Simplify your report design, integration and deployment - and focus =
on=20
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
