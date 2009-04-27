From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: fbcmap: non working tests on
	unsigned	cmap->start
Date: Mon, 27 Apr 2009 13:58:17 +0200
Message-ID: <49F59DD9.6010903@gmail.com>
References: <49EDD799.8060607@gmail.com>
	<20090423134110.51ea8df2.akpm@linux-foundation.org>
	<20090423214738.GF7134@sci.fi> <49F4519F.4090003@gmail.com>
	<20090426131505.GG7134@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LyPTX-0001Il-LT
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Apr 2009 11:58:19 +0000
Received: from ey-out-1920.google.com ([74.125.78.144])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LyPTW-0004xQ-9Y for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Apr 2009 11:58:19 +0000
Received: by ey-out-1920.google.com with SMTP id 13so413554eye.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 27 Apr 2009 04:58:17 -0700 (PDT)
In-Reply-To: <20090426131505.GG7134@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Roel Kluin <roel.kluin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

Ville Syrj=E4l=E4 wrote:
> On Sun, Apr 26, 2009 at 02:20:47PM +0200, Roel Kluin wrote:
>> cmap->start is unsigned,

>>> On Thu, Apr 23, 2009 at 01:41:10PM -0700, Andrew Morton wrote:
>>>> argh.
>>>>
>>>> - Perhaps userspace can kill the kernel by sending a "negative"
>>>>   `start'.  Removing the test will make it even less likely that we'll
>>>>   fix this bug.
>>> Shouldn't happen. 'start' is used as the starting index for the hardware
>>> palette, 'start+len-1' is the last index. All drivers should already ch=
eck
>>> the passed values since the maximum index depends on the display mode.
>>> And I suppose the worst thing that could happen if the driver fails to
>>> check the values would be incorrect colors.

> You would rather need something like
> 'if (start+len > 1 << max(red.len, green.len, blue.len, transp.len))'

what do you mean with `red.len'? is that `info->var.red.length'?

> and a check to make sure that start+len doesn't overflow.
> =

> Oh and I guess it should also check that the visual is pseudocolor or
> directcolor.

I am fairly new so please review carefully.

Not yet signed off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index f53b9f1..b34e74e 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -249,6 +249,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct =
fb_info *info)
 {
 	int rc, size =3D cmap->len * sizeof(u16);
 	struct fb_cmap umap;
+	__u32 rgba_max =3D 0;
 =

 	memset(&umap, 0, sizeof(struct fb_cmap));
 	rc =3D fb_alloc_cmap(&umap, cmap->len, cmap->transp !=3D NULL);
@@ -261,13 +262,27 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struc=
t fb_info *info)
 		rc =3D -EFAULT;
 		goto out;
 	}
+
+	if (cmap->start + cmap->len < cmap->start) {
+		rc =3D -EINVAL;
+		goto out;
+	}
+
 	umap.start =3D cmap->start;
 	if (!lock_fb_info(info)) {
 		rc =3D -ENODEV;
 		goto out;
 	}
-	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
-				!info->fbops->fb_setcmap)) {
+
+	rgba_max =3D max(info->var.red.length, info->var.green.length);
+	rgba_max =3D max(rgba_max, info->var.blue.length);
+	rgba_max =3D max(rgba_max, info->var.transp.length);
+
+	if (cmap->start + cmap->len > 1 << rgba_max ||
+			!(info->fbops->fb_setcolreg ||
+				info->fbops->fb_setcmap) ||
+			!(info->fix.visual =3D=3D FB_VISUAL_PSEUDOCOLOR ||
+				info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR)) {
 		rc =3D -EINVAL;
 		goto out1;
 	}

---------------------------------------------------------------------------=
---
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
