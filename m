From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Some questions
Date: Wed, 05 Mar 2003 13:18:03 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E65EAFB.7020208@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qXtG-00029c-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 04:20:54 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

I am currently porting the SiS framebuffer driver to the - more or less
- new API. Better late than never :)

Anyway, during this, I noticed some issues: (I am using stock 2.5.63 for
development, no fbdev patches)

1) Sisfb currently does not work if compiled statically into the kernel.
(It works as a module if fbcon is a module, too). If sisfb and fbcon are
the kernel, the mode switch occures but the only thing I see is a white
rectangle at the left egde of the screen, vertically centered, with some
flashing grey dots. I almost looks like text mode output while in
graphics mode, or - better - if fbcon assumes a font size of 1 pixel.
Finally, it seems to oops, but I can't say that for sure because I don't
see anything (and I unfortunately don't have a serial console available).

Can anybody confirm that this (ie both low level driver and fbcon in
kernel) is supposed to work in 2.5.63 (making it a bug in my sisfb
implementation)? Did I perhaps miss anything, like a kernel parameter to
activate fbcon or similar?

2) If both sisfb and fbcon are modules, everything works s supposed when
first modprobing sisfb and then fbcon. Upon modprobing fbcon, the mode
switch occures and I see a graphical console (with a white rectangle of
the size of the previous console size which vanishes upon pressing enter).

However, I could not manage to gain a graphical console if sisfb is a
module, but fbcon is in the kernel. Is this combination supposed to
work? If so, how?

3) The resizing using stty is - how do I put this - slightly imperfect.
I don't know how you fbdev folks do it, but I am not used to think in
row/col categories, but *resolutions* instead. Apart from this - IMHO a
bit annoying - inconvenience, this method has further issues:

a) Calculating the desired mode resolution my simply multiplying the
rows/cols by the font size very often results in odd modes like 800x592.
This even when using a standard 8x16 font, not thinking of situations
where for instance 12x22 fonts are used. How is the low level driver
supposed to handle this?

To temporarily overcome this, I implemented a somewhat fuzzy mode
identification routine, searching for modes with resolutions within a
range of [desired res] - [desired res + 16]. But I can't imagine this
being the Real Thing.

b) The call to fb_set_var() inside fbcon_resize() is checked for errors,
but not the call to fbcon_resize() from within fbcon_switch(). This
leads to catastrophic drawing errors if the requested mode is not
supported by the low level driver.

c) fbcon_resize() only changes var.xres and var.yres, leaving everything
else - var.pixclock, for instance - alone. fb_set_var() just calles the
driver's check_var() routine and then set_par(). How is the low level
driver supposed to behave in this situation, especially considering the
unchanged pixclock?

d) Starting with a mode of 1024x768 and resizing to 800x600 using stty
works after all (see a)), but only if I execute stty twice. The desired
mode the low level driver receives at the first attempt is 800x768.
Could this be related to an outdated or buggy stty, calling the console
code twice if rows and cols are specified at the same time...?

3) About y panning: In the 2.4 version of sisfb, I simply forced the
console to do y panning (unless positively disabled by the user) by
"patching" yres_virtual to the maximum, depending on the available video
memory. I am allowed to do that with the 2.5 API? (The rivafb code makes
be believe so...)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
