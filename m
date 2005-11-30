From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: atyfb & lockups
Date: Wed, 30 Nov 2005 07:48:25 +0100
Message-ID: <438D4B39.5090208@t-online.de>
References: <1133329905.16726.69.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhLl3-0002Uu-GD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 22:48:01 -0800
Received: from mailout11.sul.t-online.com ([194.25.134.85])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhLl3-0006Mh-4g
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 22:48:01 -0800
In-Reply-To: <1133329905.16726.69.camel@gaston>
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
To: linux-fbdev-devel@lists.sourceforge.net


>I have an old PowerBook Wallstreet I here with a Rage LT-G. I've been
>booting it from Open Firmware instead of MacOS lately (thus didn't give
>a chance to the MacOS driver to do it's own tweaking of the chip) and
>the machine has been reliably locking up on me. Solid lockups. I finally
>figured out that the lockups appear to be atyfb related and that booting
>with video=atyfb:noaccel fixes it.
>It seems that when it's lockup, the whole machine is down, that is it
>won't take interrupts to get to the xmon low level debugger nor
>anything, thus I suspect the PCI is locked up.
>  
>
Well, there are other possibilities.

When does the lockup occure?  Immediately when booting? Later? During 
start of 
xdm/kdm? Random?

>Are there any ideas of where to look for the source of the problem ?
>
>  
>

I would start to investigate the case by instrumenting and extending the 
fb_sync code.
Try to include code there that resets the chip and switches to the 
noaccel counterparts of the
accelerated functions when a timeout occures. That way you should have a 
chance to resume.
Is the timeout counter ok? Maybe you should decrease/increase it.   If 
switching to
the noaccel function works, include a register dump before resetting the 
chip, use show_trace()
etc for further debugging.

cu,
 knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
