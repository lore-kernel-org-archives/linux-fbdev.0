From: Greg KH <greg@kroah.com>
Date: Mon, 19 Mar 2012 23:26:00 +0000
Subject: Re: Howto consolidate xgifb (staging) with sisfb
Message-Id: <20120319232600.GA6386@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203200002.40429.PeterHuewe@gmx.de>
In-Reply-To: <201203200002.40429.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Tue, Mar 20, 2012 at 12:02:39AM +0100, Peter H=FCwe wrote:
> Hi,
>=20
> I'm currently trying to improve the xgifb driver from staging a bit and m=
y=20
> final goal is to probably merge this driver with the sis driver (as both =
card=20
> families seem to have a lot in common).
>=20
> However I'm a little bit unsure how to proceed here.
>=20
> e.g. the sis and the xgifb driver have some nearly duplicated functions i=
n=20
> common, e.g.
> static void XGIfb_bpp_to_var(struct xgifb_video_info *xgifb_info, 			    =
=20
> struct fb_var_screeninfo *var)
> http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/staging.git;a=3Dblob;f=
=3Ddrivers/staging/xgifb/XGI_main_26.c;hb=3DHEAD#l769
>=20
> and=20
> static void sisfb_bpp_to_var(struct sis_video_info *ivideo, struct=20
> fb_var_screeninfo *var)
> http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/staging.git;a=3Dblob;f=
=3Ddrivers/video/sis/sis_main.c;hb=3DHEAD#l1129
>=20
>=20
> have the same semantics. (the only difference is the _video_info struct).
>=20
> -> Is there a way the xgifb driver can call the function from sis?  (I kn=
ow=20
> it's static and not EXPORT_SYMBOL'ed)

Declare it not static and EXPORT_SYMBOL it :)

> Or how would you prepare the consolidation here ?=20
> (e.g. make the functions identical? and when the merge get's done sometim=
e=20
> simply remove the duplicate?)

How about moving things to a "library" module that both modules call
with these functions, pulling them from one of the drivers.

> And how would you proceed with functions that are nearly identical (but e=
ach=20
> function is missing some bits from the other card)
> e.g.=20
> static int sisfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct=20
> fb_info *info)
> http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/staging.git;a=3Dblob;f=
=3Ddrivers/video/sis/sis_main.c;hb=3DHEAD#l1839
> and=20
> static int XGIfb_get_fix(struct fb_fix_screeninfo *fix, int con,  struct =

> fb_info *info)
> http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/staging.git;a=3Dblob;f=
=3Ddrivers/staging/xgifb/XGI_main_26.c;hb=3DHEAD#l1365
> could be easily merged, but in which direction? Add the new code to direc=
tly=20
> to sis or 'backport' sis stuff to xgifb? or both (i.e. make them identica=
l=20
> like in the first case?)

Whatever you feel is best to do here.

greg k-h
