From: John Zielinski <grim@undead.cc>
Subject: Re: fbcon & resize
Date: Sun, 23 May 2004 23:11:22 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40B167DA.9090609@undead.cc>
References: <1085360912.15281.7.camel@gaston>  <40B159B1.9050108@undead.cc> <1085366682.24948.22.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BS5sD-0001He-Dy
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 20:11:33 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BS5sC-0003rF-P5
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 20:11:32 -0700
In-Reply-To: <1085366682.24948.22.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>Well, I'm getting complaints regulary when radeonfb refuses a mode
>(via set_var) that has out of range timings instead of picking a
>closer one. I'm not fully sure this is the right way to do though...
>  
>

Out of range for the video card or the monitor?  If it's the monitor 
then provide a mechanism for updating the monitor information and that 
solves that problem.  I've seen monitors where the edid had "safe" 
values while the tech specs for the monitor had a larger range.

If it's the hardware and we go the user customizable modedb route then 
that would be part of the customization process.  If a particular mode 
didn't work then root can tweak the modelist so that it works on their 
hardware.  Regular users would then just be able to select from root's 
customized list.  As a bonus, regular users wouldn't be able to push the 
monitor beyone the limits set by root.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
