From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 24 Dec 2003 12:45:11 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072230310.739.25.camel@gaston>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>
	 <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc>
	 <1070410792.21174.83.camel@gaston>  <3FE8CCE3.4010709@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYy5j-00069t-ST
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 17:45:39 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AYy5j-0004s5-DT
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 17:45:39 -0800
In-Reply-To: <3FE8CCE3.4010709@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> Here's a patch that fixed things on my machine.  I found it by trial and 
> error since I don't have a hardware reference document and the code is a 
> little confusing to me.  I don't know if this is the root cause or just 
> a fix for the symptoms.  Changing the u16's to u32's fixed the verticle 
> grille appearance and most of the color corruption.  Commenting out that 
> small block of code fixed the rest of the color problems.
> 
> I have a few questions.  Why are we going through the palette instead of 
> just writing the proper directcolor/truecolor bitvalues for that color?  
> Does that have to do with the disabled HW acceleration code?   Or is it 
> because the hw palette color components are 8 bits wide so the displayed 
> colors are more accurate?
> 
> And the code that I commented out, why is it accesing palette array 
> elements that have been set on a previous call or haven't been set yet?  
> Why is it trying to compensate for the wider green field when we're 
> programming 8 bit values to the hw palette?
> 
> My understanding of the low level video hardware control is very limited 
> beyond standard VGA register programming so I'm hoping to learn 
> something with all my questions.  :)
> 

Intersting. The pseudo palette thing might have to be u32 indeed, I have
to double check. That sounds like a typical misdesign crap vs. endian
assuming a given value can be accessed via any size is a little endian
"feature" that doesn't work on BE.

The HW palette stuff for 16 bits is fine afaik (well, i wrote it ;), and it
works for XFree. What color problems do you have fixed when you comment
it out ?

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
