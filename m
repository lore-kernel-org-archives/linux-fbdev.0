From: Justin Ducote <justinduc@yahoo.com>
Subject: Re: Linux Intel FB Question
Date: Tue, 15 Apr 2003 03:13:13 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030415101313.98196.qmail@web41613.mail.yahoo.com>
References: <Pine.GSO.4.21.0304151018030.26578-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 195OHo-0006dn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Apr 2003 04:07:36 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0p/8.8.6) with ESMTP id NAA24490
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Apr 2003 13:06:56 +0200 (MET DST)
In-Reply-To: <Pine.GSO.4.21.0304151018030.26578-100000@vervain.sonytel.be>
ReSent-To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.GSO.4.21.0304151307070.26578@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>

Hi Geert! 

> `vga=' is a way to tell the early boot code in the
> kernel (before the actual
> Linux kernel is started) to change the video mode
> using the BIOS.
> 
> `video=' is a way to pass initialization parameters
> to a frame buffer device
> driver, or to just specific the default video mode
> (yes, `video=1024x768-24@60'
> is OK).
> 
> Since vesafb relies on the BIOS setting up the
> correct video mode, the second
> method won't work with vesafb.
> 
> Gr{oetje,eeting}s,

Ok, I have a few more questions. I think I understand
a lot better now but:

1.) what is the syntax of the video line, I have seen
all kinds of examples on the net like:

"video=radeonfb:mode:1024x768-60@8"
"video=radeonfb:mode:1024x768-8@60"
"video=mode:1024x768-8@60"
"video=mode:1024x768-60@8"
"video=mode:1024x768"

sometimes with the drivername, sometimes without,
someimtes with a hypen and then the refresh rate
followed by a pound and then an @ symbol then the bpp
and vice versa. 

Is there a standardized syntax for the video line ? Do
you have to include the word "mode" what is the order
of information you have to provide, etc... 

How are these values interpreted and what order does
it read these values in ? What ist he format for
specifying pixel depth and refresh rate, etc. 

And is it possible to use vga= and video= together? 

video=radeonfb and then vga=792 

then my question is how does it know what refresh rate
and what pixed depth to use if you only use "vga=792"
?

I think I am close to having this figured out

Thanks for all the help
Justin


__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
