From: John Zielinski <grim@undead.cc>
Subject: Re: Running frame buffer programs using a VGA
 console?
Date: Thu, 27 Nov 2003 21:07:00 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FC6ADC4.4090002@undead.cc>
References: <Pine.GSO.4.21.0311271109100.19234-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APY2T-00051N-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 18:07:21 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1APY2S-0004TW-LL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Nov 2003 18:07:20 -0800
In-Reply-To: <Pine.GSO.4.21.0311271109100.19234-100000@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>On Thu, 27 Nov 2003, John Zielinski wrote:
>  
>
>>Silly question.  Is it actually possible to run a fb program like fbtest 
>>if your console is the VGA console?  I tried it but the fb driver 
>>doesn't seem to switch modes.
>>    
>>
>
>No, you cannot. You need an active frame buffer device driver.
>
>  
>

I have the low level radeon fb driver in the kernel and it initializes 
like usual, but I turned off the frame buffer console option.   I was 
wondering if the frame buffer programs can run like this.  If not then I 
won't have to worry about that kind of configuration when working on fb 
programs.

John





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
