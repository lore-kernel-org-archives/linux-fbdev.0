From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Move softcursor out of fbdev to fbcon
Date: Thu, 28 Jul 2005 02:50:39 +0800
Message-ID: <42E7D77F.6020005@gmail.com>
References: <42E73C6E.1090205@gmail.com> <9e473391050727073269e33a44@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxqzR-00085I-PK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 11:50:49 -0700
Received: from wproxy.gmail.com ([64.233.184.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DxqzR-0007B2-EO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 11:50:50 -0700
Received: by wproxy.gmail.com with SMTP id i3so247807wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Jul 2005 11:50:43 -0700 (PDT)
In-Reply-To: <9e473391050727073269e33a44@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl wrote:
> On 7/27/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
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
> 
> What does start/stop do?

Wrong choice of words, this is just an example.  But start() should tell
the driver that the cursor is going to be used, and perhaps do some locking (so
another app does not try to grab the device).  It can also return the
capabilities of the cursor: maximum dimensions, color depth of image,
caps such as alpha, transparency, etc.  stop() will release the cursor.

> 
>> No need to pass all variables to just, say, move the cursor to x,y.
>>
>> And the next step is to eliminate all fbcon-specific fields from
>> fb_info to another structure, such as fb_imageblit, fb_fillrect,
>> fb_cursor, fb_copyarea.  We'll have a smaller kernel size for
>> if fbcon is not enabled.
> 
> It has always bugged me that there was no real interface between
> fbconsole and fbdev. For example I tried to write a wrapper for DRM so
> that fbconsole could use DRM for accelerated console. But fbconsole is
> so tied into the fbdev data structures writing the wrapper required me
> to build most of an fbdev driver. I shouldn't need to do that,
> fbconsole should not be poking at fb_info, it should use an API for
> making changes.

Yes. I think I'm planning to do that in small steps. I'm thinking first of
separating all fbcon-specific fields and place them in another structure,
ie, fbcon_info.  This struct will be registered separately from fb_info,
and only if fbcon is enabled.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
