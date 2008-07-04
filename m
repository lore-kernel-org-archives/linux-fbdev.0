From: Keith Williams <espian@linuxinstruments.com>
Subject: Enabling Hardware acceleration in existing
	framebuffer driver
Date: Fri, 04 Jul 2008 11:56:02 -0400
Message-ID: <486E4812.5070803@linuxinstruments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEne8-0002S4-KU for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 08:56:28 -0700
Received: from host5.the-web-host.com ([209.239.32.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KEne7-0000NB-9X
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 08:56:28 -0700
Received: from [127.0.0.1] (fw.hemocleanse.com [72.12.202.234])
	by host5.the-web-host.com (8.12.11.20060614/8.12.9) with ESMTP id
	m64FuOHO025039 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 4 Jul 2008 11:56:25 -0400
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi, all,

I have an embedded board with a s1d13506 epson display chip.  There is a 
s1d13xxxfb driver that was written for the '806 that generally works 
well for the '506.

The '506 does have some 2D hardware acceleration capabilities.  Last 
night I wrote a fillrect routine as an initial test of how much 
performance improvement I could potentially see from enabling acceleration.

However, neither DirectFB nor fbset is picking up on the enabled 
acceleration.  I'm not sure if there is something more that I need to do.

Below are portions of the driver that I modified:

        info->par = default_par;
        info->fbops = &s1d13xxxfb_fbops;
        info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN | 
FBINFO_HWACCEL_FILLRECT;

--The above should set the fb_info flags to show that fillrect 
acceleration is available


void s1d13xxxfb_fillrect (struct fb_info *p, const struct fb_fillrect *rect)
{
        u32 destination_address;
        struct s1d13xxxfb_par *par = p->par;

        if (p->state != FBINFO_STATE_RUNNING)
                return;

        destination_address = (((rect->dy)*480*2)+(rect->dx)*2);

                s1d13xxxfb_writereg(par, S1DREG_BBLT_DST_START0, 
(destination_address & 0xff));
                s1d13xxxfb_writereg(par, S1DREG_BBLT_DST_START1, 
((destination_address >> 8) & 0xff));
                s1d13xxxfb_writereg(par, S1DREG_BBLT_DST_START2, 
((destination_address >> 16) & 0xff));

/// SNIP ///

--This is the beginning of the fillrect acceleration routine (right now 
just hardcoded for my particular set-up)



/* framebuffer information structures */

static struct fb_ops s1d13xxxfb_fbops = {
        .owner          = THIS_MODULE,
        .fb_set_par     = s1d13xxxfb_set_par,
        .fb_setcolreg   = s1d13xxxfb_setcolreg,
        .fb_blank       = s1d13xxxfb_blank,

        .fb_pan_display = s1d13xxxfb_pan_display,

        /* to be replaced by any acceleration we can */
        .fb_fillrect    = s1d13xxxfb_fillrect,
        .fb_copyarea    = cfb_copyarea,
        .fb_imageblit   = cfb_imageblit,
};

--This is I've added the s1d13xxxfb_fillrect to the fb_ops structure.

Is there anything else that I need to do?

Thanks for any insight.

Keith



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
