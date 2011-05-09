From: Roger Leigh <rleigh@codelibre.net>
Date: Mon, 09 May 2011 18:08:25 +0000
Subject: [bug] drmfb does not set physical screen dimensions
Message-Id: <20110509180825.GM13524@codelibre.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OE2a2PUdqti0gBVO"
List-Id: <linux-fbdev.vger.kernel.org>
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>


--OE2a2PUdqti0gBVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

drivers/gpu/drm/drm_fb_helper.c is not setting width and height
in struct fb_var_screeninfo.  drm_fb_helper_fill_var sets them to -1
rather than using the real values:
        info->var.height =3D -1;
        info->var.width =3D -1;

Since the physical dimensions are most likely known from the monitor
EDID, it would be ideal if this could be set here.  If not, it might
be nice to assume a default of 96dpi and compute the size based upon
the current resolution (so applications don't need to implement
fallbacks when unset).  On my hardware the radeon driver certainly
does have this information.

This information is needed in order to do accurate font rendering and
drawing.  It's available in X, and it would be great if it was also
available using the framebuffer.

I've also attached a small patch to fbset to allow reporting of the
current state in fb_var_screeninfo such as resolution, size, depth etc.
Could be extended to report more info if desired.
I'm not entirely sure who is best to submit this to, so my apologies
if this is not you.

I've included the dri and fbdev lists because I'm not sure if it's
specific to the drmfb code or the generic framebuffer code.  Likewise
if you set a default 96dpi size, I'm not sure if it's a generic issue
or specific to drmfb.


Thanks,
Roger


diff -urN /tmp/fbset-2.1/fbset.c ./fbset.c
--- /tmp/fbset-2.1/fbset.c	2011-05-09 18:47:47.000000000 +0100
+++ ./fbset.c	2011-05-09 18:46:32.142945642 +0100
@@ -281,7 +281,8 @@
 static struct VideoMode *FindVideoMode(const char *name);
 static void ModifyVideoMode(struct VideoMode *vmode);
 static void DisplayVModeInfo(struct VideoMode *vmode);
-static void DisplayFBInfo(struct fb_fix_screeninfo *fix);
+static void DisplayFBInfo(struct fb_fix_screeninfo *fix,
+			  struct fb_var_screeninfo *var);
 static int FillScanRates(struct VideoMode *vmode);
 static void Usage(void) __attribute__ ((noreturn));
 int main(int argc, char *argv[]);
@@ -758,7 +759,8 @@
      *  Display the Frame Buffer Device Information
      */
=20
-static void DisplayFBInfo(struct fb_fix_screeninfo *fix)
+static void DisplayFBInfo(struct fb_fix_screeninfo *fix,
+			  struct fb_var_screeninfo *var)
 {
     int i;
=20
@@ -845,6 +847,16 @@
 	puts(Accelerators[i].name);
     else
 	printf("Unknown (%d)\n", fix->accel);
+
+    printf("    Dimensions  : %dx%d pixels", var->xres, var->yres);
+    if (var->width !=3D -1 && var->height !=3D -1)
+      printf(" (%dx%d mm)", var->width, var->height);
+    putc('\n', stdout);
+    printf("    Virtual     : %dx%d pixels\n", var->xres_virtual, var->yre=
s_virtual);
+    printf("    Offset      : %dx%d pixels\n", var->xoffset, var->yoffset);
+    printf("    Bits/Pixel  : %d\n", var->bits_per_pixel);
+    if (var->grayscale)
+      printf("    Graylevels  : %d\n", var->grayscale);
 }
=20
=20
@@ -1101,7 +1113,7 @@
 	if (Opt_verbose)
 	    puts("Getting further frame buffer information");
 	GetFixScreenInfo(fh, &fix);
-	DisplayFBInfo(&fix);
+	DisplayFBInfo(&fix, &var);
     }
=20
     /*

--=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--OE2a2PUdqti0gBVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3ILZkACgkQVcFcaSW/uEjQ8gCfa00mLh1vPGY8aE6zgiPygDdW
iHwAoLOqLg8fYjnjdMVjnuFC3POmwfwc
=2d35
-----END PGP SIGNATURE-----

--OE2a2PUdqti0gBVO--
