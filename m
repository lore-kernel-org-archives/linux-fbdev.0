From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Move softcursor out of fbdev to fbcon
Date: Thu, 28 Jul 2005 10:12:16 +0800
Message-ID: <42E83F00.2060403@gmail.com>
References: <42E73C6E.1090205@gmail.com> <Pine.LNX.4.56.0507272302500.3729@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dxxsn-0005jI-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 19:12:25 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dxxsn-0007YF-Bx
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 19:12:25 -0700
Received: by wproxy.gmail.com with SMTP id 63so324713wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Jul 2005 19:12:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0507272302500.3729@pentafluge.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:
>> The changelog says it all. This is a modification of Jon's patch, but
>> I have moved softcursor.c to the console directory.  Also I removed
>> the "select FB_SOFTCURSOR" from video/Kconfig and made the compilation
>> of softcursor unconditional, if framebuffer console is enabled.
>>
>> I don't think the fb_cursor hook is usable by other programs, so we
>> should just restrict this hook for fbcon use only.  For userspace cursor
>> support, we need a new one.  But instead of one function, I believe
>> it's better to provide several.  Ie, something like below:
>>
>> fbcursor_show()         
>> fbcursor_move()
>> fbcursor_loadimage()
>> fbcursor_loadpalette()
>> fbcursor_start()
>> fbcursor_stop() 
>>
>> No need to pass all variables to just, say, move the cursor to x,y.
>>
>> And the next step is to eliminate all fbcon-specific fields from
>> fb_info to another structure, such as fb_imageblit, fb_fillrect,
>> fb_cursor, fb_copyarea.  We'll have a smaller kernel size for
>> if fbcon is not enabled.
>>
>> Comments?
> 
> Its way to big and gross. Please keep it simple!!!!!! 

Actually, it's the other way around. Functions should do just one thing.
In contrast, our fb_cursor() function is doing all of the above
and more.  Breaking up fb_cursor() into several may have a bit of a
memory overhead, but the end result is more efficient code.  Do you really
want the user app to pass the quite large struct fb_cursor to the kernel just
to move the cursor?  Or is it better just to pass two integers, x and y?

Remember, what I'm proposing is an API that is usable by userspace and other
kernel modules, and only if the driver supports a hardware cursor.  The current
fb_cursor() used by fbcon can remain, if that is what you want. Because
fb_cursor() was designed for fbcon (as with all of the fb_* drawing functions),
they can never be used by other modules without a lot of pain.

Tony 




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
