From: "Tony" <adaplas@hotpop.com>
Subject: RE: Bug in software cursor flash code, when align!=1?
Date: Sun, 21 Sep 2003 19:50:28 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <000601c38036$8d2f9140$9317b1cb@bom>
References: <20030915083820.GA22164@zensonic.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A12dP-00082I-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 04:44:11 -0700
Received: from babyruth.hotpop.com ([204.57.55.14])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A12dP-0005ax-1M
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Sep 2003 04:44:11 -0700
Received: from hotpop.com (kubrick.hotpop.com [204.57.55.16])
	by babyruth.hotpop.com (Postfix) with SMTP id F3CAA21E9CF
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 11:39:09 +0000 (UTC)
In-Reply-To: <20030915083820.GA22164@zensonic.dk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: "Thomas S. Iversen" <zensonic@zensonic.dk>, linux-fbdev-devel@lists.sourceforge.net

> Being puzzled by the fact that my software cursor did not work when
> everything else worked with my accelerated routines I tried
> to investigate
> where the problem was located. This being when scan_align!=1 which
> my accel routines need.
>

There are two main problems with the software cursor code in
drivers/video/softcursor.c:

1.  First, because it uses info->fbops->fb_imageblit(), this means that
the source data must be in info->pixmap structure, and secondly, it must
use info->pixmap.{in|out}buf methods when moving data from one location
to another.

2. Secondly, and you assessed it correctly, is that info->cursor.image
is always byte aligned, and so will not work with accelerated imageblit
routines which has scanline alignment requirements other than 1.

Below is updated code that will transfer (and pad) the final cursor
image data from info->cursor.image to info->pixmap.  It is of course
less optimal than current code, but it should be consistent with current
usage of fb_imageblit(). I'm typing the code on the fly, so no
guarantees though that it will compile, much less, work.  But the main
idea is there.

Tony

int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
{
	unsigned int scan_align = info->pixmap.scan_align - 1;
	unsigned int buf_align = info->pixmap.buf_align - 1;
	u8 *dst = (u8 *) info->cursor.image.data;
	u8 *s, *d;
	unsigned int i, size, p, pitch;

	/* p is the source pitch which is always byte aligned */
	p = (info->cursor.image.width + 7) >> 3;

	/* pitch is the destination data pitch, which is padded
	   to hardware requirements */
	pitch = p + scan_align;
	pitch &= ~scan_align;
	size = pitch * info->cursor.image.height + buf_align;
	size &= ~buf_align;

	if (cursor->set & FB_CUR_SETSIZE) {
 		info->cursor.image.height = cursor->image.height;
 		info->cursor.image.width = cursor->image.width;
 	}

 	if (cursor->set & FB_CUR_SETPOS) {
	info->cursor.image.dx = cursor->image.dx;
 		info->cursor.image.dy = cursor->image.dy;
 	}

 	if (cursor->set & FB_CUR_SETHOT)
 		info->cursor.hot = cursor->hot;

 	if (cursor->set & FB_CUR_SETCMAP) {
 		if (cursor->image.depth == 1) {
 			info->cursor.image.bg_color = cursor->image.bg_color;
 			info->cursor.image.fg_color = cursor->image.fg_color;
 		} else {
 			if (cursor->image.cmap.len)
 				fb_copy_cmap(&cursor->image.cmap, &info->cursor.image.cmap, 0);
		}
		info->cursor.image.depth = cursor->image.depth;
 	}

 	if (cursor->set & FB_CUR_SETSHAPE) {
 		switch (info->cursor.rop) {
 		case ROP_XOR:
 			for (i = 0; i < size; i++)
 				dst[i] ^= info->cursor.mask[i];
			break;
 		case ROP_COPY:
 		default:
 			for (i = 0; i < size; i++)
 				dst[i] &= info->cursor.mask[i];
			break;
 		}
 	}

 	if (!info->cursor.enable) {
 		for (i = 0; i < size; i++)
 			dst[i] ^= info->cursor.mask[i];
 	}

	/* Once cursor image processing is finished, start transferring
	   data to pixmap */

	/* First, get a chunk from scratch memory... */
	d = fb_get_buffer_offset(info, &info->pixmap, size);
	s = dst;

	/* ... then move data to scratch memory ... */
	for (i = info->cursor.image.height; i--; ) {
		info->pixmap.outbuf(info, d, s, p)
		d += pitch;
		s += p;
	}

	/* ... draw the cursor ... */
 	if (info->cursor.image.data)
 		info->fbops->fb_imageblit(info, d);

	/* ... tell fb we're done. */
	atomic_dec(info->pixmap.count);
	smb_mb__after_atomic_dec();

 	return 0;
}





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
