From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Sun, 14 Sep 2003 19:31:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030914173137.GA2971@dreamland.darkstar.lan>
References: <20030912193603.GA16977@dreamland.darkstar.lan> <Pine.LNX.4.44.0309122317180.5017-100000@phoenix.infradead.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yakI-0000FD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 10:33:10 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yakI-0002sl-9v
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 14 Sep 2003 10:33:10 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309122317180.5017-100000@phoenix.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Fri, Sep 12, 2003 at 11:20:13PM +0100, James Simmons ha scritto: 
> > Also, modes  from fb_get_mode  are different from  XFree modes  so every
> > time I switch from console to X I have to re-center the screen.
> > 
> > This happens only when modedb is created from edid, not when using the
> > standard modedb.
> > 
> > Currently create_modedb is unused (the new radeon driver is the first
> > user of edid stuff) so we may be hitting a real bug.
> 
> Sounds like bugs in the code. The code was never tested before.

Look at this:

bc 1.05
Copyright 1991, 1992, 1993, 1994, 1997, 1998 Free Software Foundation,
Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.
xres=1280
yres=1024
refresh=60
hactive=xres
vactive=yres
vfreq=refresh
divisor = (1000000 - (vfreq * 550))/1000
hfreq = (yres + 1) * vfreq  * 1000;
hfreq=hfreq/divisor
c_val = (((40-20) * 128)/256 + 20)*1000
m_val = (128 * 600)/256
m_val = (m_val * 1000000)/hfreq;
duty_cycle = c_val - m_val;
hblank = (xres * duty_cycle)/(100000 - duty_cycle);
htotal = hactive+hblank
hsync_len = (htotal * 8)/100
hsync_len
137
hblank
433
duty_cycle
25283

hsync_len should be 112, so:

htotal = (112 * 100)/8
htotal
1400
hblank = htotal - hactive
hblank
120
duty_cycle = (hblank*100000 - xres)/(hblank + 1)
duty_cycle
99162

duty_cycle calculated by from fb_get_hblank_by_hfreq) is 25283
duty_cycle reversed from EDID detailed timing is 99162

I just downloaded GTF_V1R1.xls from vesa.org, now I'm downloading
gnumeric...

Until we find the bug we can change calc_mode_timings in this way:

void calc_mode_timings(int xres, int yres, int refresh, struct fb_videomode *mode)
{
        int dbsize = sizeof(modedb)/sizeof(modedb[0]);
        struct fb_videomode *cur;
        int i;

        for (i = 0; i < dbsize; i++) {
                cur = &modedb[i];

                if (cur->xres == xres && cur->yres == yres &&
                                     cur->refreh == refresh) {
                        /* Yeah */
                        mode->xres = xres;
                        mode->yres = yres;
                        mode->pixclock = cur->pixclock;
                        mode->refresh = refresh;
                        mode->left_margin = cur->left_margin;
                        mode->right_margin = cur->right_margin;
                        mode->upper_margin = cur->upper_margin;
                        mode->lower_margin = cur->lower_margin;
                        mode->hsync_len = cur->hsync_len;
                        mode->vsync_len = cur->vsync_len;
                        mode->vmode = cur->vmode;
                        mode->sync = cur->sync;

                        return;
                }
        }

        BUG();
}

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Not an editor command: Wq


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
