From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: New radeonfb, mostly untested
Date: Mon, 8 Sep 2003 21:05:27 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030908190527.GA1731@dreamland.darkstar.lan>
References: <1062952639.655.6.camel@gaston> <20030907230334.GA847@dreamland.darkstar.lan> <1063000866.659.9.camel@gaston>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wYev-0002WF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 19:55:14 -0700
Received: from mail-4.tiscali.it ([195.130.225.150])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wTfh-0008QF-D7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Sep 2003 14:35:41 -0700
Content-Disposition: inline
In-Reply-To: <1063000866.659.9.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Mon, Sep 08, 2003 at 08:06:07AM +0200, Benjamin Herrenschmidt ha scritto: 
> strangely enough it works here, I have to check what's wrong, I
> suspect fb_find_mode isn't getting called for me but is for you
> and it's trying to call check_var.
> 
> I'll fix that and send a new patch.

I  pulled you  patch. Now  it  doesn't oops  but  fb_find_mode is  doing
something strange. I added some printk:

Starting monitor auto detection...
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
[EDID stuff]
radeonfb: Monitor 2 type no found

We are in radeon_check_modes, just before it calls fb_find_mode:

radeonfb: mode_option: 1024x768-8@60
radeonfb: has_default_mode = 0
radeonfb: rinfo->mon1_dbsize 20
radeonfb: calling fb_find_mode
radeonfb: fb_find_mode -> 1
radeonfb: rinfo->info.var.xres = 640, rinfo->info.var.yres = 480

fb_find_mode returns  1 (which should  mean that we are  using specified
mode_option), but info.var is set to something else...
I can't see what's going wrong here.

Btw, I see that you switched  to module_param. Maybe we should leave the
setup function  (#ifndef MODULE),  otherwise the driver  won't recognise
option passed via kernel command line (video=....).
radeonfb.option=something will work, but it is a bit ugly...


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Dicono che  il cane sia  il miglior  amico dell'uomo. Secondo me  non e`
vero. Quanti dei vostri amici avete fatto castrare, recentemente?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
