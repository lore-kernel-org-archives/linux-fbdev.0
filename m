From: "Tony" <adaplas@hotpop.com>
Subject: RE: Re: New radeonfb, mostly untested
Date: Mon, 15 Sep 2003 08:56:07 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <000801c37b24$257b9100$ba17b1cb@bom>
References: <20030914173137.GA2971@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yhVR-0006tv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 17:46:17 -0700
Received: from babyruth.hotpop.com ([204.57.55.14])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yhVR-0003nS-Ag
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 14 Sep 2003 17:46:17 -0700
Received: from hotpop.com (kubrick.hotpop.com [204.57.55.16])
	by babyruth.hotpop.com (Postfix) with SMTP id 0989121E772
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 00:45:33 +0000 (UTC)
In-Reply-To: <20030914173137.GA2971@dreamland.darkstar.lan>
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
To: kronos@kronoz.cjb.net, James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

> void calc_mode_timings(int xres, int yres, int refresh,
> struct fb_videomode *mode)
> {
>         int dbsize = sizeof(modedb)/sizeof(modedb[0]);
>         struct fb_videomode *cur;
>         int i;
>
>         for (i = 0; i < dbsize; i++) {
>                 cur = &modedb[i];
>
>                 if (cur->xres == xres && cur->yres == yres &&
>                                      cur->refreh == refresh) {
>                         /* Yeah */
>                         mode->xres = xres;
>                         mode->yres = yres;
>                         mode->pixclock = cur->pixclock;
>                         mode->refresh = refresh;
>                         mode->left_margin = cur->left_margin;
>                         mode->right_margin = cur->right_margin;
>                         mode->upper_margin = cur->upper_margin;
>                         mode->lower_margin = cur->lower_margin;
>                         mode->hsync_len = cur->hsync_len;
>                         mode->vsync_len = cur->vsync_len;
>                         mode->vmode = cur->vmode;
>                         mode->sync = cur->sync;
>
>                         return;
>                 }
>         }
>
>         BUG();
> }
>

The bug may actually be in the following code:

static int get_std_timing(unsigned char *block, struct fb_videomode
*mode)
{
	int xres, yres = 0, refresh, ratio, i;

	xres = (block[0] + 31) * 8;
	if (xres <= 256)
		return 0;

 	ratio = (block[1] & 0xc0) >> 6;
 	switch (ratio) {
	case 0:
		yres = xres;
 		break;
	case 1:
		yres = (xres * 3)/4;
		break;
 	case 2:
 		yres = (xres * 4)/5;
		break;j
	case 3:
 		yres = (xres * 9)/16;
		break;
	}
	refresh = (block[1] & 0x3f) + 60;

 	for (i = 0; i < VESA_MODEDB_SIZE; i++) {
		if (vesa_modes[i].xres == xres &&
		    vesa_modes[i].yres == yres &&
 		    vesa_modes[i].refresh == refresh) {
 			*mode = vesa_modes[i];
			break;
 		} else {
			calc_mode_timings(xres, yres, refresh, mode);
			break;
 		}
 	}
	return 1;
}
----------------------------------

Maybe you can replace it with this:

static int get_std_timing(unsigned char *block, struct fb_videomode
*mode)
{
	int xres, yres = 0, refresh, ratio, i, j = 0;

	xres = (block[0] + 31) * 8;
	if (xres <= 256)
		return 0;

 	ratio = (block[1] & 0xc0) >> 6;
 	switch (ratio) {
	case 0:
		yres = xres;
 		break;
	case 1:
		yres = (xres * 3)/4;
		break;
 	case 2:
 		yres = (xres * 4)/5;
		break;j
	case 3:
 		yres = (xres * 9)/16;
		break;
	}
	refresh = (block[1] & 0x3f) + 60;

	/* First find standard mode from the table of VESA modes */
 	for (i = 0; i < VESA_MODEDB_SIZE; i++) {
		if (vesa_modes[i].xres == xres &&
		    vesa_modes[i].yres == yres &&
 		    vesa_modes[i].refresh == refresh) {
 			*mode = vesa_modes[i];
			j = 1;
			break;
 		}
	}

	/* If mode is not found in table, calculate using GTF */
	if (!j)
		calc_mode_timings(xres, yres, refresh, mode);

	return 1;
}

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
