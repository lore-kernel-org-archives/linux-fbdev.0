From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 21:00:21 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408F0225.4000408@undead.cc>
References: <Pine.LNX.4.44.0404280039460.23153-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdRA-0002UM-60
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 18:00:32 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BIdR9-00022z-Sv
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 18:00:32 -0700
In-Reply-To: <Pine.LNX.4.44.0404280039460.23153-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:

>No. Look the logic should go from the upper VT layer to the lower driver 
>to accomplish something. Not the reverse.
>
>struct vc_data -> native console driver structure --> fbdev
>
>  
>
The problem with that is how would something like fbset work in that 
situation?   The current way of selecing number of rows/columns through 
the vt layer and hoping for the best in what mode you actually get is 
way too limited to be the only mechanism.

Don't misunderstand me here.  I do want to be able to tell the vt to 
switch to 1024x768@85-32 and have it propagate down and set the right 
mode.  This shouldn't be a problem once we get a mechanism in place to 
load a user's mode database into the kernel at run time.  Then the 
timings will be exactly what I want when I say 1024x768@85-32.

>Not.
>
>fbdev --> native console driver --> struct vc_data.
>
>  
>
But how do I fiddle with this to get things just right in the first 
place?   Right now that requires the the reversed path starting at the 
fbdev shown immediately above. 

What we need is a vt call that says I'm switching to 1024 x 768 with 
this mode data that I wan't to pass down to the fbdev.  That way the vt 
adjusts it's row/column settings based on the font size and then passes 
the mode data down.  That's how the fbset (and other) mode tuning 
utilities should work and should only be used by mode tuning utilities.  
Once the user is happy they would include their tuned mode in their 
database for other apps to use.

All other apps should use the generic vt call to ask for 1024x768 at 
85Hz in 32bpp and the kernel would give them the mode from the users 
database.


>This was the way it uses to be. If this is the case then I suggest we 
>write our own vt.c and vt_ioctl.c for the fbcon layer. We shouldn't even
>use struct vc_data then. In fact each fbdev driver should be independent 
>console drivers. That is how 2.4.X was. Each driver was nearly its own 
>console driver. We need to go one way or the other. 
>

I like your way, from vt down to the fbdev.  I just want a mechanism for 
fbset and other mode tuning utilities to work.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
