From: John Zielinski <grim@undead.cc>
Subject: Re: Framebuffer fbtest issues
Date: Wed, 26 Nov 2003 22:39:42 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FC571FE.7000900@undead.cc>
References: <200311261215.05761.hetz@softier.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APD0X-0000ba-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Nov 2003 19:39:57 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1APD0W-0004x3-PZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Nov 2003 19:39:56 -0800
In-Reply-To: <200311261215.05761.hetz@softier.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Hetz Ben Hamo wrote:

>On some machines, running the fbtest might take a bit of pause and then the demos
>will run, so you might want to launch the fbtest with: ./fbtest -d -v
>  
>

I got that pause when running it as well.  Seems that the memcpy from 
video memory is what causes this.  Do you (or anyone else on the list) 
know why reading video memory takes so long?  I have a Radeon 9200 on an 
ASUS A7V133 motherboard.

I modified fbtest so that it doesn't bother saving or restoring if the 
console was in KD_TEXT as it will get restored by the console anyways.  
This go rid of the pause.  I'll post those patches once I test it with 
the normal VGA console.

John






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
