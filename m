From: Kronos <kronos@people.it>
Subject: [PATCH][RFC][0/3] mode attribute in sysfs tree
Date: Tue, 15 Jun 2004 19:21:38 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040615172138.GA8823@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaKJ8-0004Bs-Gh
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 13:13:22 -0700
Received: from mail-relay-2.tiscali.it ([212.123.84.92])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BaKJ7-0003kQ-MO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 13:13:21 -0700
Received: from dreamland.darkstar.lan (82.84.177.6) by mail-relay-2.tiscali.it (7.0.028)
        id 40CF218E00010A4C for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 19:21:30 +0200
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi,
I played with sysfs for a while, this is the result. Note that is a RFC,
the code is not meant for inclusion.

The patch a "mode" attribute to each fb device. This attribute is not
writable (yet). The attribute show the current video mode in the form
<xres>x<yres>-<bpp>@<refresh>.

This interface is simple and usable by the user but it's not possible to
pass a detailed mode using a fb_var_screeninfo (like the ioctl). It may
be worth adding another attribute (binary) - say "mode_detailed" - that
deals with fb_var_screeninfo and not with strings.

This is how sysfs tree looks like:

kronos@notebook:~$ tree /sys/class/graphics
/sys/class/graphics
`-- fb0
    |-- dev
    `-- mode

1 directory, 2 files

And the output is the following:
kronos@notebook:~$ cat /sys/class/graphics/fb0/mode
1024x768-16@58

Note that 58 is really 60Hz, I'm having problems with the approx.
Does anyone have a better method to calculate the refresh rate?

The patch is composed by 2 parts: the first add a class_device field to
the struct fb_info. In this way modules can attach attributes to this
class_device. The problem with the current code is that class_dev is
initialized in register_framebuffer so you can use it only after current
fb is registered. This happens because with the class_simple interface
it's not possibile to split the creation of the class_device and its
insertion into the hierarchy (this is possible with normal class_device
interface though).

Another problem is that the driver's private modedb is not available,
so the code will search only standard modedb (using fb_find_mode).
This issue can be solved adding a "modedb" field to the struct fb_info. 
Of course drivers can ignore my macro and create their own "mode" attribute
where they do whatever they want, but I don't like this solution very much.

The second patch add the function that does the real work (fb_show_mode)
and a helper macro that helps in the creation of the "mode" attribute.
It's similar to other *_ATTR macros in device.h, and you can use like this:

static FB_MODE_ATTR(my_mode_attr);
...
class_device_create_file(my_fb_info->class_dev, &my_mode_attr);

Finally there's a patch that shows the usage the attribute (with sisfb).
Compile and boot tested on my notebook.

I'll send patches in reply to this mail.

Comments?

Luca
-- 
Home: http://kronoz.cjb.net
Il piu` bel momento dell'amore e` quando ci si illude che duri per 
sempre; il piu` brutto, quando ci si accorge che dura da troppo.


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
