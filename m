From: =?ISO-8859-1?Q?Pattrick_H=FCper?= <pattyh@gmx.net>
Subject: Re: [PATCH] notify fbcon if framebuffer registered
Date: Tue, 02 Mar 2004 21:42:58 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4044F1D2.3050609@gmx.net>
References: <Pine.LNX.4.44.0403021720240.18264-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyGwR-0007hp-L5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 12:56:39 -0800
Received: from mailout04.sul.t-online.com ([194.25.134.18])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyGju-0001Ce-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 12:43:42 -0800
In-Reply-To: <Pine.LNX.4.44.0403021720240.18264-100000@phoenix.infradead.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,

thanks for your reply!

>Is your driver built as a module? That is the only way that could happen 
>that I know of. The new behavior is that the fbdev device doesn't not 
>automatically take over the console. You use the app con2fb to do that.
>The reason was so developers could debug there drivers easily. Alot of 
>times there is a bug in the xxfb_init code and you end up with a blank 
>display. Very hard to work with. Also some fbdev drivers can work with 
>vgacon. So you could run a fbdev app on vgacon!!! In this case you don't 
>want the fbdev device changing the hardware. 
>   Actually you don't really need fbcon for embedded devices except for 
>debugging output. If your device is embedded and without fbcon you can 
>call fb_set_var before you register the device.
>
>  
>
The driver is not compiled as a module, but still fb_console_init runs 
before mq11xxfb_init, originally i just called fb_console_init from 
within my probe function which worked but was a very ugly way to go, so 
i came up with the framebuffer_register notification, and since i saw 
that you added event_notifications in kernel 2.6.3, i adapted my 
notification and thought i could send you the patch.
It works perfectly for me, sicne my main problem is, that i dont have a 
serial cable and can only login to my device thru infrared serial port 
which only starts when linuxrc of initrd is running, thus i needed a way 
to see kernel messages and the fb seemed an easy way to do that. Thats 
what i needed the patch for, and it works perfectly for me, i dont need 
to call any applications, just as soon as my (statically compiled) fb is 
registered, the fbcon comes up and shows me the boot messages.
I agree that it is only needed for debugging output, thats all i 
currently need it for.

>>This patch could come in handy for hotplug events :-) We would also need a 
>>unregister event. The only thing is you have to do some filtering here.
>>Say you have a multi-head system. If question you have is do you want to 
>>register this device to the fbcon system. The second question is to which 
>>VCs do you map this device. In fbcon you have a map for that. I have to 
>>think about how to do that. Your patch is a great start. I just need to 
>>go over the different possible cases we can have.
>> 
>>    
>>
I'm very glad if you can use the patch, actually i am not very deep into 
the internals of the fbcon, i just saw, that by calling 
take_over_console, i can reach my goal, i did not think about any 
complications or problems, since i dont know enough about the fbcon.

Regards, Patty


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
