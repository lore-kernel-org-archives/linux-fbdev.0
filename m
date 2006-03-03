From: Fractallyte <fractallyte@csi.com>
Subject: Re: Re: Re: atyfb, console, kernel 2.6.14 & Sony Vaio C1VE
Date: Fri, 3 Mar 2006 19:01:39 +0000
Message-ID: <f843337601bf9e23232d10976cde8648@csi.com>
References: <83d4769a9bceb571796228cb5c7534c3@csi.com> <43FF7797.7040403@gmail.com> <2b6bda73c1ef8b8d6463bbe2de83a431@csi.com> <44021879.7040806@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v622)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FFFX5-00032S-Vs
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Mar 2006 11:01:43 -0800
Received: from anchor-post-30.mail.demon.net ([194.217.242.88])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FFFX4-0003Bt-LC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Mar 2006 11:01:44 -0800
Received: from serendip.demon.co.uk ([80.176.90.177] helo=[192.168.0.4])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1FFFX2-000Epw-14
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Mar 2006 19:01:40 +0000
In-Reply-To: <44021879.7040806@gmail.com>
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


On 26 Feb 2006, at 21:07, Antonino A. Daplas wrote:

>
> Fractallyte wrote:
>
> Putting back Ville and fbdev-devel back on the CC list.
>
>> Thanks for the quick reply!
>>
>> I tried what you suggested, but it has no effect.  The interesting 
>> thing
>> is that the BIOS timings and geometry work perfectly in Xorg.  I've
>> tried using SVGATextMode and FBSet using these values, but neither 
>> works.
>>
>> Could it be that the display is correct (it fills up the screen, after
>> all - just stretched out), but the console just doesn't recognise it?
>
> I doubt it.  If you can run X over fbdev and you get a perfect display,
> then I would agree with you that this is a bug in the console code.

I suddenly remembered: I CAN'T run X over atyfb.  I just get a blank 
(sometimes corrupted) screen.  To run X I have to turn off atyfb in 
grub.

Amir



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
