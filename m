From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Tue, 23 Dec 2003 21:54:57 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE90001.3080207@undead.cc>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>	 <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc>	 <1070410792.21174.83.camel@gaston>  <3FE8CCE3.4010709@undead.cc> <1072230310.739.25.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYzB5-000840-0A
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 18:55:15 -0800
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AYzB4-0002CT-HM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 18:55:14 -0800
In-Reply-To: <1072230310.739.25.camel@gaston>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>Intersting. The pseudo palette thing might have to be u32 indeed, I have
>to double check. That sounds like a typical misdesign crap vs. endian
>assuming a given value can be accessed via any size is a little endian
>"feature" that doesn't work on BE.
>  
>

Except that this machine is LE.  Perhaps the software blit routine is 
writing the entire 32 bit value to the frambuffer?

>The HW palette stuff for 16 bits is fine afaik (well, i wrote it ;), and it
>works for XFree. What color problems do you have fixed when you comment
>it out ?
>  
>

With the commented code left in or just the OUTREG's commented:

Black        ->   Black
Blue         ->   Cyan
Green        ->   Black
Cyan         ->   Blue
Red          ->   Brown
Magenta      ->   Lt Green
Brown        ->   Brown
Lt Gray      ->   Lt Green
Dk Grey      ->   Dk Purple
Lt Blue      ->   Lt Blue
Lt Green     ->   Dk Purple
Lt Cyan      ->   Lt Blue
Lt Red       ->   Lt Red
Lt Magenta   ->   Lt Magenta
Yellow       ->   Lt Red
White        ->   Lt Magenta


With the OUTREG's left in and the "green =" line commented out:

Black        ->   Black
Blue         ->   Cyan
Green        ->   Black
Cyan         ->   Blue
Red          ->   Brown
Magenta      ->   Lt Green
Brown        ->   Brown
Lt Gray      ->   Lt Green
Dk Gray      ->   Dk Gray
Lt Blue      ->   Lt Blue
Lt Green     ->   Lt Green
Lt Cyan      ->   Lt Cyan
Lt Red       ->   Lt Red
Lt Magenta   ->   Lt Magenta
Yellow       ->   Yellow
White        ->   White


John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
