From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Fb rotation 2.6.x
Date: Tue, 15 Mar 2005 00:58:27 -0800 (PST)
Message-ID: <20050315085827.56051.qmail@web53603.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DB7so-0007dh-MU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 00:58:34 -0800
Received: from web53603.mail.yahoo.com ([206.190.37.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DB7so-0007Ii-0N
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 00:58:34 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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

Hi All,

We have added the code for hardware rotation in the
framebuffer driver for omap242x processor from TI
[2.6.x kernel]. 

It has been reported to work on 2.4.x.

But when I had made it changed for 2.6.x follwoing
behaviour is seen:

1. When I rotate the framebuffer ( Linux logo screen)
by 180 degree then it shows only Linux logo image for
a second only and then it disappears.

2. Whereas while doing in 90 degree rotation, it shows
the black square of Linux logo size on the 270 degree
rotation position. 

The reasons we found are as below:

-----------------snip-----------------
That is because in 2.4, the fb_display's var structure
is updated by the driver - which we do consistently.
In 2.6, on the other hand, the fb_info's var structure
is
updated by the driver, and all the fb_displays are
updated by either fb_mem or fb_con - which I think is
not done correctly. Also the set_par function is
called so many times - I don't understand why.

What is happening is that, first, fb_info's var
structure is updated, which rotates the display. But
this var does not get passed to the current
fb_display's var. Then when the fbcon_switch function
is called, the current fb_display's var settings are
affected - which 'unrotates' the display.

We have to see if any other driver has rotation
support and how they are implementing it. Otherwise,
most probably fb_con needs fixing, I think.
-----------------snip-----------------

Log of sequence in which functions are being called in
driver when we issue FBIOPUT_VSCREENINFO, with xres,
yres, xoffset, yoffset and rotate variables value.

-------long output for 180 degree rotation----

omap24xxfb_check_var: Enter
omap24xxfb_check_mode: Enter
omap24xxfb_check_mode: Exit
var_to_depth: Enter
omap24xxfb_check_var: Exit
omap24xxfb_set_par: Enter
var_to_depth: Enter
omap24xxfb_change_mode: Enter
omap24xxfb_change_mode: Exit
horizontal_sync_freq: Enter
pixels_per_clock: Enter
pixels_per_clock: Exit
horizontal_sync_freq: Exit
vertical_sync_freq: Enter
horizontal_sync_freq: Enter
pixels_per_clock: Enter
pixels_per_clock: Exit
horizontal_sync_freq: Exit
vertical_sync_freq: Exit
var_to_depth: Enter
omap24xxfb_set_sms_rotation: Enter
omap24xxfb_set_sms_rotation: Exit
omap24xxfb_write_state: Enter
omap24xxfb_disable: Enter
omap24xxfb_disable: Exit
omap24xxfb_enable: Enter
wait_for_go: Enter
wait_for_go: Exit
omap24xxfb_enable: Exit
omap24xxfb_write_state: Exit
omap24xxfb_set_par: Exit
omap24xxfb_pan_display: Enter
omap24xxfb_pan_display: Exit
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_check_var: Enter
omap24xxfb_check_mode: Enter
omap24xxfb_check_mode: Exit
var_to_depth: Enter
omap24xxfb_check_var: Exit
omap24xxfb_set_par: Enter
var_to_depth: Enter
omap24xxfb_change_mode: Enter
omap24xxfb_change_mode: Exit
horizontal_sync_freq: Enter
pixels_per_clock: Enter
pixels_per_clock: Exit
horizontal_sync_freq: Exit
vertical_sync_freq: Enter
horizontal_sync_freq: Enter
pixels_per_clock: Enter
pixels_per_clock: Exit
horizontal_sync_freq: Exit
vertical_sync_freq: Exit
var_to_depth: Enter
omap24xxfb_set_sms_rotation: Enter
omap24xxfb_set_sms_rotation: Exit
omap24xxfb_write_state: Enter
omap24xxfb_disable: Enter
omap24xxfb_disable: Exit
omap24xxfb_enable: Enter
wait_for_go: Enter
wait_for_go: Exit
omap24xxfb_enable: Exit
omap24xxfb_write_state: Exit
omap24xxfb_set_par: Exit
omap24xxfb_pan_display: Enter
omap24xxfb_pan_display: Exit
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_pan_display: Enter
omap24xxfb_pan_display: Exit
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_pan_display: Enter
omap24xxfb_pan_display: Exit
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_pan_display: Enter
omap24xxfb_pan_display: Exit
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
omap24xxfb_setcolreg: Enter
---------lon output ends--------

Above output is generated when I call my test
application with 180 degree rotation. You can see that
set_par is called many times, why?

Let me know what changes I need to do in fb driver, so
that I can remove the effect.

Let me know if you guys need more info/driver source?

---Komal Shah


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search. 
http://info.mail.yahoo.com/mail_250


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
