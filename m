From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev: fix the fb_find_nearest_mode()
 function
Date: Fri, 14 Oct 2005 08:18:08 +0800
Message-ID: <434EF940.9020608@gmail.com>
References: <20051009092949.GA9610@spock.one.pl> <434A249F.4060503@gmail.com> <20051013193650.GA17760@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQDHb-0005Y4-TD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Oct 2005 17:18:47 -0700
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EQDHa-0007e8-DU
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Oct 2005 17:18:47 -0700
Received: by zproxy.gmail.com with SMTP id 14so579305nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Oct 2005 17:18:33 -0700 (PDT)
In-Reply-To: <20051013193650.GA17760@spock.one.pl>
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
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Michal Januszewski wrote:
> On Mon, Oct 10, 2005 at 04:21:51PM +0800, Antonino A. Daplas wrote:
> 
>>> diff -Nurp fbdev-orig/drivers/video/modedb.c fbdev/drivers/video/modedb.c
>>> --- fbdev-orig/drivers/video/modedb.c	2005-10-08 23:14:29.000000000 +0200
>>> +++ fbdev/drivers/video/modedb.c	2005-10-09 01:25:16.000000000 +0200
>>> @@ -663,6 +663,7 @@ void fb_var_to_videomode(struct fb_video
>>>  {
>>>  	u32 pixclock, hfreq, htotal, vtotal;
>>>  
>>> +	mode->refresh = 0;
>> Any reason why you need to set mode->refresh to 0?
> 
> This is something I had to use in a driver I'm currently working on and
> I thought it might be a good idea to include it in the patch I sent.
> 
> The thing is, if the var struct has the pixclock field set to 0,
> mode->refresh is left untouched, which could mean that it's either
> set to a random value or to an invalid refresh rate coming from a
> previously processed videomode (in case the fb_videomode struct is
> reused).

Ok.

> 
> I actually dealt with modes with var->pixclock == 0, and it always resulted
> in a getting U:<xres>x<yres>-<random> in /sys/class/graphics/fb0/modes.
> 
> In case you're wondering why would anyone ever need to have
> var->pixclock set to 0 -- I was using it to denote modes with a default
> refresh rate set by the hardware (well, the Video BIOS to be more
> specific). Please let me know is this is very wrong, but I just didn't
> see any other way of doing it.

No, it's not wrong. But it is preferrable to have a nonzero value in
var->pixclock (whether calculated or via a VBE function call).

Still, I agree with you to initialize mode->refresh to zero (or perhaps
-1 to to denote a divide by zero) for these cases.

Tony
 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
