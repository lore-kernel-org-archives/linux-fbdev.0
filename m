From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 20:18:16 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408EF848.2030809@undead.cc>
References: <Pine.LNX.4.44.0404280023360.23153-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIcmO-0001ua-2q
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:18:24 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BIcmN-0004ie-LU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:18:23 -0700
In-Reply-To: <Pine.LNX.4.44.0404280023360.23153-100000@phoenix.infradead.org>
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

>Trust me. I wish the console would cleanup itself. It would take a good 
>amount of work to redo.
>  
>
I don't think it will be too much work.  Here's my line of thinking:

When booting fbcon sets all it's per VT var structures to what the 
driver returns as it's startup mode.  After that only fbset can change 
these per VT var structures by using a special flag it it's mode set 
call.  An fb program would change the mode any which way it wants which 
would change a the "current" var structure.  When that fb program ends 
or goes back the KD_TEXT then fbcon just sets the mode to what it has in 
it's var for the particular VT number.

At no point does fbcon try to save the current hardware state.  All it 
does is put things back to the way they were at boot or to what the user 
chose after boot with fbset.

Oh, almost forgot.  Changing the resolution using the console set rows 
and columns ioctl and changing resolution  would be equivilent to fbset 
changing the res and be stored in the per VT var structures as well.

Now I don't understand why this info needs to move back to the vt 
layer.  Let's say we had another console driver that ran a vector 
display or a pixel board or whatever other exotic display.  Different 
resolutions, timings, colour depths etc would not apply to those 
devices.  The laser vector type display might have stuff like the 
rotation speed of various mirrors.  (this is an example, I'm not saying 
it's a practical application).   That display would have it's own fbset 
type utility to set those things.  So the low level console driver 
should be where the mode is actually stored (again on a per VT basis).

But storing some of this info in the vc_data like you said would be 
useful when one console takes over for another then it can set it self 
up in the same general mode that the last console would be in although 
all the timings might be off.

John





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
