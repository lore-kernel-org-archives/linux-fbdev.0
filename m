From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Fri, 07 Mar 2003 13:08:58 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E688BDA.8080506@winischhofer.net>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rGhw-00058z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 04:12:13 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Alright: I tested the newest fbdev patch.

1) Boot logo support: Does not compile, misses a script "p??tologo" or 
anything like that.

2) Changed sisfb to accept practically any mode, but it now adapts to 
the next larger supported mode if no exact mode based on rows and cols 
is found. Previously, this adaption was limited to 16 pixels.

stty does not work at all now, because fbcon's fbcon_resize() checks the 
returned var from fb_set_var if the mode is off more than one character 
in height and width - and returns EINVAL in this case.

Since stty calles the console code twice if rows and cols are provided, 
this fails miserably, because the first attempt (which for example 
requests 800x768 if switching from 1024x768 to 800x600) fails.

So I changed fbcon from

	if(err || width != var.xres/fw || height != var.yres/fh)

to

	if(err)

and now it works.

However, there is still (at least) one problem within the console layer.

With my patch, I can now have a console of for instance 128x20 
characters, on a 1024x768 screen. Scrolling mostly works, but sometimes 
console seems to forget to pan. I can't reproduce this on purpose, but 
printing eg. a directory with ls works in 90% of the cases (=scrolls 
correctly), but prints text beyond the current amount of rows in the 
remaining 10% of the cases. If I press enter until the last line of the 
console is on the very bottom of the 1024x768 screen, then it remembers 
its amount of rows and pans correctly.

For estethical reasons, I would also recommend changing the order or 
panning and character drawing. Now, the characters seem to be drawn 
first, and panning is done later. That causes some flickering sometimes, 
and with a console smaller than the screen resolution (eg. screen is 
1024x768, console uses only 20 rows), text is shown below the 20th row 
for a fraction of a second before the panning is done.

I will send the current sisfb code to James later today. (It also fixes
some non-fbdev-related mode switching problems on some Asus laptops)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
