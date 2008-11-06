From: "Kimble, James" <jkimble@harris.com>
Subject: Re: Epson S1D13A04 video driver
Date: Thu, 6 Nov 2008 15:52:51 -0500
Message-ID: <0AF7234EE71C18419A2CFFFB8EF9C17CD43412@cine2k1.cs.myharris.net>
References: <0AF7234EE71C18419A2CFFFB8EF9C17CD431C1@cine2k1.cs.myharris.net>
	<20081106214343.e36eb441.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkimble@harris.com>) id 1KyBqi-0001Pf-Na
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 20:53:04 +0000
Received: from mlbe2k2.cs.myharris.net ([137.237.90.89])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KyBqg-0006F6-8n for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 20:53:04 +0000
Content-class: urn:content-classes:message
In-Reply-To: <20081106214343.e36eb441.kristoffer.ericson@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net



On Thu, 6 Nov 2008 03:50:43 -0500
"Kimble, James" <jkimble@harris.com> wrote:

>On Thu, 6 Nov 2008 03:44:43 +0100
>"Kristoffer Ericson" <kristoffer.ericson@gmail.com> wrote:
>
>>On Thu, 6 Nov 2008 07:40:43 -0500
>>"Kimble, James" <jkimble@harris.com> wrote:
>
>> 
>> I'm working on project that needs to utilize the Epson S1D13A04
device
>> on a Coldfire processor based system running the Linux 2.6.25 kernel.
>> The driver I see in the kernel sources had the name of Thibaut Varene
in
>> it and he told me you are the current maintainer of this driver.
>
>I took maintainership as of 2.6.27. I've CC'ed linux-fb since thats the
>relevant mailinglist.
>

Ok. Thanks.

>> 
>> The driver in the 2.6.25 kernel supports the s1d13xxx series of chips
>> but there's a good deal of variation in this series (register
>> assignments and sizes, memory size, etc.). Can you tell me if there
is a
>> driver more specific to my chip (the S1D13A04)? I've begun the
process
>> of porting the existing driver to work with my chip but it's a pain.
I'm
>> really trying to save myself some time.
>
>Without looking at datasheets of your platform I would say that
>you would be best of sticking with the s1d13xxx driver. The reason for
>me taking maintainership is that there have been very little progress
in
>the driver for the last year and it's in need of updates. The goal
>is to make it a truly 13xxx driver.
>
>So far I've started to familiarize myself with the driver and also
>added some revision detection (it was locked to one revision). 
>
>If there is something obvious lacking in the resources supplied
>to the driver thats where I would start. Can you give some more
specific
>details on what you need?


Well, as you know the drivers history has been to be very specific to a
single chip. The driver for the 2.6.9 kernel was and the driver for the
2.6.25 kernel is also. I ported the 2.6.9 version to the 2.6.10 kernel 
and modified it to work with the S1D13A04 device. Not a lot of work but 
I definately had to get a good understanding of the frame buffer section

of the kernel (never been there before) and of this specific driver. It 
appears there's no less work to do for the very different but no less 
specific s1d13xxxfb driver in the 2.6.25 kernel. Notes in the driver 
itself indicate that though it's a driver that's general to the s1d13 
class of chips it will only work with one of the later versions. 

I would just say it would be really nice to get this driver cabable of 
handling more than one device. Not a critisism just a wish. Sigh....


>
>Best wishes
>Kristoffer
>
>> 
>> Any help or documentation you can offer would be greatly appreciated.
>
>By documentation you mean? If you are looking for examples using the
>driver you can check jornada720.c. It should give a clear picture
>of howto supply the driver with framebuffer, memory areas and also
>some register initial values.
>

Sure and it was helpful. I found that based on some searches and some
help from Geert Oyterhoeven (thanks guy). I'm well on my way to getting
the port done (I think) I was just hoping (there I go again...) that 
there might be a dead ringer I could just install and go with. I know...
at least I got some more experience with the frame buffer system....

Thanks for your time. I do appreciate it.

>> 
>> Thanks,
>> 
>> James Kimble

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
