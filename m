From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: FB_EVENT (blank and unblank?)
Date: Sun, 28 Nov 2004 00:59:02 -0000
Message-ID: <02cc01c4d4e5$75e4e170$0f01a8c0@max>
References: <41A36DA5.8090200@fujitsu-siemens.com> <200411280643.14171.adaplas@hotpop.com> <027d01c4d4dd$19fe65a0$0f01a8c0@max> <200411280824.01338.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYDPE-0001gT-QE
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 16:59:12 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CYDP4-0003rU-P7
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 16:59:12 -0800
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
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas:
>> My Issue: I have a backlight driver that shares no code with the
>> framebuffer driver - the hardware is totally separate. I have there 
>> written
>> them as two spate drivers which seems to make sense. The problem is that
>> there is no method to communicate blanking to the external backlight 
>> driver
>> (which is all it needs to know about). Obviously I can add links between
>
> Of course there is.  Your backlight driver does a
> register_backlight_controllers().  Then your fb driver does a
> set_backlight_enable(!blank) in its xxxfb_blank implementation.

Yes, you could do that. I was trying to look for a method than meant no 
specific action by the framebuffer driver was required. It shouldn't have to 
care if a backlight is present or not...

On the other hand, the console system shouldn't have to either. Hence the 
suggestion that blank and unblank events are added. It may be there's a 
layer of backlight glue added to the drivers/video directory 
drivers/video/backlight? that catches those events and calls 
set_backlight_enable(!blank) and provides functions  like 
register_backlight_controllers().

>> The Other Issue: There is no common method to access and control 
>> backlight
>
> Not yet, but if the powermac backlight support is extended, then we 
> suddenly
> have a common method.  Right now, pmac's backlight support has this as
> exportable symbols:
>
> set_backlight_enable()
> get_backlight_enable()
> set_backlight_level()
> get_backlight_level()
>
> And all of the above calls specific hooks to the backlight driver.

I agree that would go part of the way towards a common method (the other 
part being a sysfs representation or similar). That sysfs representation 
could even be provided by backlight "core" in drivers/video/backlight?.

> We don't have a common architecture yet for backlight control, and I don't
> know where this is really going.  Anyone here have more info?

I'd be interested to know the current position...

Richard 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
