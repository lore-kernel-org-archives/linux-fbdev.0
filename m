From: John Zielinski <grim@undead.cc>
Subject: Re: fbdev upstream
Date: Wed, 24 Dec 2003 15:40:35 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE9F9C3.20605@undead.cc>
References: <3FD6C52C.7090906@undead.cc>  <3FDBB97F.4070207@undead.cc> <1072254049.739.61.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZFoL-0002Zf-TM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 12:40:53 -0800
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZFoL-0001T2-Df
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 12:40:53 -0800
In-Reply-To: <1072254049.739.61.camel@gaston>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>Good catch. I merged that in my tree (I use a different version of
>the client notification mecanism though, I don't like much the
>version that James pushed).
>  
>

Yeah.  That has caused a lot of headaches for me as well.  The fact that 
a vt row/col change triggers a fb resolution change which calls the vt  
resize routine again is just begging for an infinite loop.  Just one 
calculation mistake of just one pixel in one of  a dozen equations will 
trigger this loop.  That's what the above bug does as well.  The other 
major problem with it is that it only changes var.xres and var.yres and 
none of the other timings so the monitor won't sync anymore.

One item on my to do list is to make a separate fb_var_screeninfo for 
each vt so that we know what mode to switch back to when we switch vt's 
or come back from X or a fb graphical program.

>Since James vanished, I intend to take the most obvious bug fixes
>and driver updates from his tree into mine, test them, and then
>submit them one by one to Andrew Morton for 2.6.x inclusion.
>  
>

I'll keep posting any bugs I discover.  Maybe you can post a message 
here whenever you've got a new version to test so that the other testers 
on the list and myself can try it out.  I'm running fbcon on the radeon 
machine but I went back to VGA for the nvidia machines as the hardware 
cursor bug makes it unusable for any kind of text editing work.  I'll 
switch back on those machines when that bug is squashed.

>I do not intend, at least in a first step, to take the sysfs
>stuffs as the structure lifetime changes are fairly invasive and
>happened to break a bunch of things. Once all the rest is merged
>up, we can look into it again in more detail, isolated from the
>other bunch of changes.
>  
>

Agreed.  Let's get what we have rock solid before we try to break it 
again.  :)

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
