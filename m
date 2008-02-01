From: krzysztof.h1@poczta.fm
Subject: Re: [Bugme-new] [Bug 9847] New: i810fb: module
	parameter 'mode_option' inconsistent with other framebuffer modules
Date: 01 Feb 2008 08:01:30 +0100
Message-ID: <20080201070131.27F842BD8B5@f25.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1804289383-1201849290=:34918"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKpu7-0003KX-3d for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 23:01:39 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JKpu5-0008N7-41
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 23:01:38 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, miki@dds.nl
Cc: jsimmons@infradead.org, adaplas@gmail.com

--0-1804289383-1201849290=:34918
Content-Type: TEXT/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

> On Tue, 29 Jan 2008 21:02:39 -0800 (PST) bugme-daemon@bugzilla.kernel.org=
=0A> wrote:=0A> > Problem Description: While all other framebuffer modules =
use the option=0A> > "mode=3D..." to specify a modedb-style video mode, i81=
0fb uses the=0A> non-standard=0A> > "mode_option=3D..." =0A=0AThe attached =
patch should fix it.=0A--=0A=0AFrom: Krzysztof Helt <krzysztof.h1@wp.pl>=0A=
=0AThis patch changes the option "mode_option" into "mode".=0A=0ASigned-off=
-by: Krzysztof Helt <krzysztof.h1@wp.pl>=0A=0A---=0A=0AIf the patch below i=
s mangled by my web based email client please use the attached one.=0A=0ATh=
e patch was done against 2.6.24-git9.=0A=0A=0Adiff -urp linux-ref/drivers/v=
ideo/i810/i810_main.c linux-pc/drivers/video/i810/i810_main.c=0A--- linux-r=
ef/drivers/video/i810/i810_main.c=092008-01-24 23:58:37.000000000 +0100=0A+=
++ linux-pc/drivers/video/i810/i810_main.c=092008-01-31 20:43:56.000000000 =
+0100=0A@@ -132,7 +132,7 @@ static struct pci_driver i810fb_driver =3D=0A =
=09.resume   =3D     i810fb_resume,=0A };=0A =0A-static char *mode_option _=
_devinitdata =3D NULL;=0A+static char *mode     __devinitdata;=0A static in=
t vram       __devinitdata =3D 4;=0A static int bpp        __devinitdata =
=3D 8;=0A static int mtrr       __devinitdata;=0A@@ -1891,7 +1891,7 @@ i810=
_allocate_pci_resource(struct i810fb=0A =0A static void __devinit i810fb_fi=
nd_init_mode(struct fb_info *info)=0A {=0A-=09struct fb_videomode mode;=0A+=
=09struct fb_videomode mode_new;=0A =09struct fb_var_screeninfo var;=0A =09=
struct fb_monspecs *specs =3D &info->monspecs;=0A =09int found =3D 0;=0A@@ =
-1902,7 +1902,7 @@ static void __devinit i810fb_find_init_m=0A #endif=0A =
=0A =09INIT_LIST_HEAD(&info->modelist);=0A-=09memset(&mode, 0, sizeof(struc=
t fb_videomode));=0A+=09memset(&mode_new, 0, sizeof(struct fb_videomode));=
=0A =09var =3D info->var;=0A #ifdef CONFIG_FB_I810_I2C=0A =09i810_create_i2=
c_busses(par);=0A@@ -1928,23 +1928,23 @@ static void __devinit i810fb_find_=
init_m=0A =0A =09=09if (xres && yres) {=0A =09=09=09if ((m =3D fb_find_best=
_mode(&var, &info->modelist))) {=0A-=09=09=09=09mode =3D *m;=0A+=09=09=09=
=09mode_new =3D *m;=0A =09=09=09=09found  =3D 1;=0A =09=09=09}=0A =09=09}=
=0A =0A =09=09if (!found) {=0A =09=09=09m =3D fb_find_best_display(&info->m=
onspecs, &info->modelist);=0A-=09=09=09mode =3D *m;=0A+=09=09=09mode_new =
=3D *m;=0A =09=09=09found =3D 1;=0A =09=09}=0A =0A-=09=09fb_videomode_to_va=
r(&var, &mode);=0A+=09=09fb_videomode_to_var(&var, &mode_new);=0A =09}=0A #=
endif=0A-=09if (mode_option)=0A-=09=09fb_find_mode(&var, info, mode_option,=
 specs->modedb,=0A-=09=09=09     specs->modedb_len, (found) ? &mode : NULL,=
=0A+=09if (mode)=0A+=09=09fb_find_mode(&var, info, mode, specs->modedb,=0A+=
=09=09=09     specs->modedb_len, (found) ? &mode_new : NULL,=0A =09=09=09  =
   info->var.bits_per_pixel);=0A =0A =09info->var =3D var;=0A@@ -1998,7 +19=
98,7 @@ static int __devinit i810fb_setup(char *=0A =09=09else if (!strncmp=
(this_opt, "ddc3", 4))=0A =09=09=09ddc3 =3D 3;=0A =09=09else=0A-=09=09=09mo=
de_option =3D this_opt;=0A+=09=09=09mode =3D this_opt;=0A =09}=0A =09return=
 0;=0A }=0A@@ -2202,8 +2202,8 @@ MODULE_PARM_DESC(dcolor, "use DirectColo=
=0A =09=09 " (default =3D 0 =3D TrueColor)");=0A module_param(ddc3, bool, 0=
);=0A MODULE_PARM_DESC(ddc3, "Probe DDC bus 3 (default =3D 0 =3D no)");=0A-=
module_param(mode_option, charp, 0);=0A-MODULE_PARM_DESC(mode_option, "Spec=
ify initial video mode");=0A+module_param(mode, charp, 0);=0A+MODULE_PARM_D=
ESC(mode, "Specify initial video mode");=0A =0A MODULE_AUTHOR("Tony A. Dapl=
as");=0A MODULE_DESCRIPTION("Framebuffer device for the Intel 810/815 and"=
=0A

----------------------------------------------------------------------

Lezac w wannie skorzystala z ...
Kliknij >>> http://link.interia.pl/f1ce9 

--0-1804289383-1201849290=:34918
Content-Type: APPLICATION/octet-stream
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <i810mode.diff464FB066@9248905.3DE9663C>
Content-Disposition: ATTACHMENT; FILENAME="i810-mode.diff"

diff -urp linux-ref/drivers/video/i810/i810_main.c linux-pc/drivers/video/i=
810/i810_main.c=0A--- linux-ref/drivers/video/i810/i810_main.c=092008-01-24=
 23:58:37.000000000 +0100=0A+++ linux-pc/drivers/video/i810/i810_main.c=092=
008-01-31 20:43:56.000000000 +0100=0A@@ -132,7 +132,7 @@ static struct pci_=
driver i810fb_driver =3D=0A =09.resume   =3D     i810fb_resume,=0A };=0A =
=0A-static char *mode_option __devinitdata =3D NULL;=0A+static char *mode  =
   __devinitdata;=0A static int vram       __devinitdata =3D 4;=0A static i=
nt bpp        __devinitdata =3D 8;=0A static int mtrr       __devinitdata;=
=0A@@ -1891,7 +1891,7 @@ i810_allocate_pci_resource(struct i810fb=0A =0A st=
atic void __devinit i810fb_find_init_mode(struct fb_info *info)=0A {=0A-=09=
struct fb_videomode mode;=0A+=09struct fb_videomode mode_new;=0A =09struct =
fb_var_screeninfo var;=0A =09struct fb_monspecs *specs =3D &info->monspecs;=
=0A =09int found =3D 0;=0A@@ -1902,7 +1902,7 @@ static void __devinit i810f=
b_find_init_m=0A #endif=0A =0A =09INIT_LIST_HEAD(&info->modelist);=0A-=09me=
mset(&mode, 0, sizeof(struct fb_videomode));=0A+=09memset(&mode_new, 0, siz=
eof(struct fb_videomode));=0A =09var =3D info->var;=0A #ifdef CONFIG_FB_I81=
0_I2C=0A =09i810_create_i2c_busses(par);=0A@@ -1928,23 +1928,23 @@ static v=
oid __devinit i810fb_find_init_m=0A =0A =09=09if (xres && yres) {=0A =09=09=
=09if ((m =3D fb_find_best_mode(&var, &info->modelist))) {=0A-=09=09=09=09m=
ode =3D *m;=0A+=09=09=09=09mode_new =3D *m;=0A =09=09=09=09found  =3D 1;=0A=
 =09=09=09}=0A =09=09}=0A =0A =09=09if (!found) {=0A =09=09=09m =3D fb_find=
_best_display(&info->monspecs, &info->modelist);=0A-=09=09=09mode =3D *m;=
=0A+=09=09=09mode_new =3D *m;=0A =09=09=09found =3D 1;=0A =09=09}=0A =0A-=
=09=09fb_videomode_to_var(&var, &mode);=0A+=09=09fb_videomode_to_var(&var, =
&mode_new);=0A =09}=0A #endif=0A-=09if (mode_option)=0A-=09=09fb_find_mode(=
&var, info, mode_option, specs->modedb,=0A-=09=09=09     specs->modedb_len,=
 (found) ? &mode : NULL,=0A+=09if (mode)=0A+=09=09fb_find_mode(&var, info, =
mode, specs->modedb,=0A+=09=09=09     specs->modedb_len, (found) ? &mode_ne=
w : NULL,=0A =09=09=09     info->var.bits_per_pixel);=0A =0A =09info->var =
=3D var;=0A@@ -1998,7 +1998,7 @@ static int __devinit i810fb_setup(char *=
=0A =09=09else if (!strncmp(this_opt, "ddc3", 4))=0A =09=09=09ddc3 =3D 3;=
=0A =09=09else=0A-=09=09=09mode_option =3D this_opt;=0A+=09=09=09mode =3D t=
his_opt;=0A =09}=0A =09return 0;=0A }=0A@@ -2202,8 +2202,8 @@ MODULE_PARM_D=
ESC(dcolor, "use DirectColo=0A =09=09 " (default =3D 0 =3D TrueColor)");=0A=
 module_param(ddc3, bool, 0);=0A MODULE_PARM_DESC(ddc3, "Probe DDC bus 3 (d=
efault =3D 0 =3D no)");=0A-module_param(mode_option, charp, 0);=0A-MODULE_P=
ARM_DESC(mode_option, "Specify initial video mode");=0A+module_param(mode, =
charp, 0);=0A+MODULE_PARM_DESC(mode, "Specify initial video mode");=0A =0A =
MODULE_AUTHOR("Tony A. Daplas");=0A MODULE_DESCRIPTION("Framebuffer device =
for the Intel 810/815 and"=0A
--0-1804289383-1201849290=:34918
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--0-1804289383-1201849290=:34918
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--0-1804289383-1201849290=:34918--
