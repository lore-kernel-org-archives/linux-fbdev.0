From: James Kimble <jkimble@one.net>
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04onColdfire running 2.6.25)
Date: Wed, 12 Nov 2008 23:47:32 -0500
Message-ID: <491BB164.2020203@one.net>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>
	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
	<49199EE3.5090101@cetrtapot.si>
	<1210.137.237.242.125.1226419828.squirrel@webmail.nuvox.net>
	<491A930F.2040507@cetrtapot.si>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkimble@one.net>) id 1L0U7M-0003kG-Mf
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 04:47:44 +0000
Received: from smtp-out5.atlngahp.sys.nuvox.net ([70.43.63.23]
	helo=smtp05.atlngahp.sys.nuvox.net)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L0U7L-0008Hl-7X
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 04:47:44 +0000
In-Reply-To: <491A930F.2040507@cetrtapot.si>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Cc: linux-fbdev-devel@lists.sourceforge.net


In looking at your driver (which I think is a lot better organized than 
the general one that came with the kernel by the way) I see that you're 
doing a whole string of:

                                            ~~~~~~~~~~
    device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x12);
    device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x14);
    device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x16);
                                             ~~~~~~~~~~      

In  s1d13706fb_init(). I didn't do any of this my driver. Is this needed 
for any purpose other than to allow easy access to change the values in 
these registers in user space?

I was able to port your driver to the values and registers used by my 
device and the behavior is virtually the same as with my driver. Screen 
is initialized, I can see the color palette get set and the panel 
enable. Everything boots up fine but none of my user space applications 
work. The first time I try to write to a register or video memory I get 
a seg fault.

This has got to be some kind of memory configuration issue. I've moved 
the CS configuration for this device to different memory locations but 
it doesn't change the behavior. I'm setting things up in U-Boot in 
exactly the same way I had been setting them up in Colilo for the 2.6.10 
kernel (where everything worked).

I'm really stuck. If anyone has any ideas or suggestions I'd really 
appreciate your thoughts.

Thanks for your attention...


Hinko Kocevar wrote:
> jkimble@one.net wrote:
>   
>> I thought it looked OK because it looks the same as the flexCAN stuff.
>> However I just noticed that flexCAN has a .0 and .1 whereas the s1d13 are
>> both .0. Yeah, I hope an expert weighs in on this because I'm not sure
>> now.
>>
>> I didn't get your attachement.
>>
>>     
>
> Maybe I forgot to attach it :P
> Here it is.
>
>
> HTH,
> HK
>
>
>   


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
