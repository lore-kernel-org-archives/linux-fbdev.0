From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.9 bug: linux logo not displayed in vga16fb (bug found)
Date: Wed, 27 Oct 2004 05:55:45 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410270555.48087.adaplas@hotpop.com>
References: <4178CB95.7000505@linbox.com> <417E733C.2040204@linbox.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261490AbUJZVsd@vger.kernel.org>
In-Reply-To: <417E733C.2040204@linbox.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Ludovic Drolez <ludovic.drolez@linbox.com>, linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 23:54, Ludovic Drolez wrote:
> Ludovic Drolez wrote:
> > Hi !
> >
> > I used to have a nice vga boot logo with my 2.6.7 kernel, but with the
> > 2.6.9, my
> > boot logo has disappeared (same .config)...
> > It seems to switch to VGA, and some space is reserved for the logo, but
> > it is not displayed.
> > The logo appears with vesafb.
>
> I made a few diffs between my old working 2.6.7 kernel and the 2.6.9 and
> found something interesting in fbmem.c:
>

Should be fixed in the mm tree or the latest bk snapshot. Or you can try this
very patch.

Tony

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/vga16fb.c linux-2.6.9-rc1-mm4/drivers/video/vga16fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/vga16fb.c	2004-09-07 21:18:35.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/vga16fb.c	2004-09-07 21:30:39.059300648 +0800
@@ -1306,7 +1306,7 @@ void vga16fb_imageblit(struct fb_info *i
 {
 	if (image->depth == 1)
 		vga_imageblit_expand(info, image);
-	else if (image->depth <= info->var.bits_per_pixel)
+	else
 		vga_imageblit_color(info, image);
 }
 
