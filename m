From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 24 Dec 2003 19:55:12 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FEA3570.6050905@undead.cc>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>	 <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc>	 <1070410792.21174.83.camel@gaston>  <3FE8CCE3.4010709@undead.cc>	 <1072230310.739.25.camel@gaston>  <3FE90001.3080207@undead.cc>	 <1072236683.739.32.camel@gaston>  <3FE919E1.7050609@undead.cc>	 <1072242753.820.41.camel@gaston> <3FE92BFD.8020104@undead.cc>	 <Pine.GSO.4.58.0312241309040.1638@waterleaf.sonytel.be>	 <3FEA064F.9020303@undead.cc> <1072305863.15477.15.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZJmj-0001jk-LS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 16:55:29 -0800
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZJmj-00056i-6l
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 16:55:29 -0800
In-Reply-To: <1072305863.15477.15.camel@gaston>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>64 but with only green mattering above 32 iirc, look what XFree does.
>  
>

Good.  I'll make a patch for fbtest then.

>If XFree/fbdev works, then the fbdev is ok :)
>  
>

I'll have to look at the XFree code then to see what they're up to.  
There's a lot of extra dac updates going on that just get overwritten 
again.  If you look at my simulation  you can see that all the updates 
by the second set of OUTREGs gets overwritten by the first set later 
on.    I even disabled the second set in my kernel for 16 bit modes and 
everything still looks the same.   That code is probably there for a 
reason.  I'm just trying to figure out why.  :)

>>PARM: 00    R: 00 (Par:00)  G: 00 (Par:00)  B: 00 (Par:00)  
>>OUT1: 00    R: 00 (Pal:00)  G: 00 (Par:00)  B: 00 (Pal:00)  
>>OUT2: 00    R: 00 (Par:00)  G: 00 (Pal:00)  B: 00 (Par:00)  
>>
>>PARM: 01    R: 01 (Par:01)  G: 01 (Par:01)  B: 01 (Par:01)  
>>OUT1: 04    R: 00 (Pal:00)  G: 01 (Par:01)  B: 00 (Pal:00)  
>>*** Palette green 02 read uninitialized data ***
>>OUT2: 08    R: 01 (Par:01)  G: !! (Pal:02)  B: 01 (Par:01)  
>>
>>PARM: 02    R: 02 (Par:02)  G: 02 (Par:02)  B: 02 (Par:02)  
>>OUT1: 08    R: 01 (Pal:01)  G: 02 (Par:02)  B: 01 (Pal:01)  
>>*** Palette green 04 read uninitialized data ***
>>OUT2: 10    R: 02 (Par:02)  G: !! (Pal:04)  B: 02 (Par:02)  
>>    
>>

As you can see, the dac register 08 is written on the second call by the 
second set of OUTREGs (OUT2:) and then overwritten by the first on the 
third call to the function (OUT1).   It's also grabbing a value for the 
green component from palette array index 2 which hasn't beet updated yet 
(that's what the !! means).  I'm just curious why it's doing this and 
what special case requires it....

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
