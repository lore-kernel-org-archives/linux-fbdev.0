From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH][RFC][0/3] mode attribute in sysfs tree
Date: Wed, 16 Jun 2004 10:43:28 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406161043.28807.adaplas@hotpop.com>
References: <20040615172138.GA8823@dreamland.darkstar.lan>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaQOV-0005n6-7C
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 19:43:19 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaQOU-0002kb-P7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 19:43:18 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 22CE360E3A2
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Jun 2004 02:05:23 +0000 (UTC)
In-Reply-To: <20040615172138.GA8823@dreamland.darkstar.lan>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Kronos <kronos@people.it>, linux-fbdev-devel@lists.sourceforge.net

On Wednesday 16 June 2004 01:21, Kronos wrote:

I still haven't seen the rest of your patch.  I assume you have 3 more pending.

> Hi,
> I played with sysfs for a while, this is the result. Note that is a RFC,
> the code is not meant for inclusion.
>
> The patch a "mode" attribute to each fb device. This attribute is not
> writable (yet). The attribute show the current video mode in the form
> <xres>x<yres>-<bpp>@<refresh>.
>
> This interface is simple and usable by the user but it's not possible to
> pass a detailed mode using a fb_var_screeninfo (like the ioctl). It may
> be worth adding another attribute (binary) - say "mode_detailed" - that
> deals with fb_var_screeninfo and not with strings.
>
> This is how sysfs tree looks like:
>
> kronos@notebook:~$ tree /sys/class/graphics
> /sys/class/graphics
> `-- fb0
>
>     |-- dev
>
>     `-- mode
>
> 1 directory, 2 files
>
> And the output is the following:
> kronos@notebook:~$ cat /sys/class/graphics/fb0/mode
> 1024x768-16@58
>
> Note that 58 is really 60Hz, I'm having problems with the approx.
> Does anyone have a better method to calculate the refresh rate?

refresh = hfreq/vtotal

where:
	hfreq = pixclock/htotal
	pixclock = in Hz
	htotal = xres + left_margin + right_margin + hsync_len
	vtotal = yres + upper_margin + lower_margin + vsync_len

The above is not an approximation, but should give the actual refresh rate, 
assuming the driver properly normalized all variables in fb_var_screeninfo.

>
> The patch is composed by 2 parts: the first add a class_device field to
> the struct fb_info. In this way modules can attach attributes to this
> class_device. The problem with the current code is that class_dev is
> initialized in register_framebuffer so you can use it only after current
> fb is registered. This happens because with the class_simple interface
> it's not possibile to split the creation of the class_device and its
> insertion into the hierarchy (this is possible with normal class_device
> interface though).
>
> Another problem is that the driver's private modedb is not available,
> so the code will search only standard modedb (using fb_find_mode).
> This issue can be solved adding a "modedb" field to the struct fb_info.

We already have info->monspecs.modedb. If driver has DDC/EDID support, it
can run fb_edid_to_monspecs() in fbmon.c.  Of course, info->monspecs.edid 
is valid only for the monitor.  This can still be further filtered against the 
capability of graphics card.
 
Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
