From: John Zielinski <grim@undead.cc>
Subject: Re: fbutils
Date: Mon, 22 Dec 2003 17:12:06 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE76C36.8080508@undead.cc>
References: <3FE649BF.30501@undead.cc> <200312222342.15265.alex.kern@gmx.de> <Pine.GSO.4.58.0312221718380.838@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYYHn-0001ja-Ig
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Dec 2003 14:12:23 -0800
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AYYHn-0002tl-1m
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Dec 2003 14:12:23 -0800
In-Reply-To: <Pine.GSO.4.58.0312221718380.838@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexander Kern <alex.kern@gmx.de>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>On Mon, 22 Dec 2003, Alexander Kern wrote:
>  
>
>>Am Montag, 22. Dezember 2003 02:32 schrieb John Zielinski:
>>    
>>
>>>Here's a patch to get fbutils from the CVS working if anyone else wants
>>>to play around with them.
>>>      
>>>
>
>Thanks John!
>  
>
>  
>
No problem. 

>I started fbutils in 1999, but I never finished it.
>
>In fact I never thought anyone would finish it ;-)
>  
>
>
It was either that or keep rebooting every time I wanted to play with 
some video mode settings.  :)  

That patch basically got it to the functional stage.  The command line 
options work and all sections of the database file can now be used.  
Changing resolutions doesn't quite work because of some kernel bugs I 
mentioned before and having a different resolution on each virtual 
terminal is also broken in the kernel.  With a working fbset I can look 
into these bugs now.

Hopefully by tonight I'll have another patch ready with the rest of the 
changes I've made to fbutils.  I've made the help text match the actual 
command line arguments and I'm getting the last of them to work.  After 
that patch we can put it in the finished category.

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
