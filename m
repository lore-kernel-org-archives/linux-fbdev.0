From: John Zielinski <grim@undead.cc>
Subject: Re: Sane behavior of fbset
Date: Fri, 18 Jun 2004 09:31:40 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D2EEBC.1040507@undead.cc>
References: <200406180945.12444.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbJTF-0004E1-Rz
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:31:53 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BbJTD-0001dB-W1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:31:52 -0700
In-Reply-To: <200406180945.12444.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino A. Daplas wrote:

>1.  Revert to 2.4 behavior.  This is easy to add since fbdev already has a notifier 
>support. (I already have working code for this). Of course, stty will still work.
>
>  
>
Definitely #1.   The functionality is very easy to add to the kernel as 
most of it is already in place.

>2.  Make the set_var ioctl return immediately if the vc_mode of the current display is 
>KD_TEXT. Basically, fbset becomes an informational utility only. I don't know the 
>repercussions of this with userland fb applications though.
>
>  
>
Several people have already started doing work adding fb mode changing 
to sysfs.  Fbset will most likely become a wrapper around the sysfs 
interface.

>3.  Modify fbset (and other similar utilities, if there are any) so it also issues an 
>'stty-like' call after a 'set_var' call.   
>
>  
>
Ug, please no.  That's just asking for trouble.  Now the app would have 
to figure out what the font size is so that adds a third call.  If the 
app gets the calculation between x-y -> row-col wrong then the screen 
would be messed up at best or we'd get an infinite loop at worse (like 
one of the earlier patches to the kernel did).

>Note: As mentioned by many people before, it's almost impossible to completely 
>preserve per-console mode info because of the lack of a per-display var.  So even 
>if we agree to implement #1,  it cannot completely match 2.4 behavior. Also, the lack
>of per-display var means that drivers must be able to handle mode changes without 
>any help.  James' fb_find_mode support in fbcon_resize does partly alleviate this 
>limitation.
>  
>
Several people on the list are pushing to have per-console var put back 
in.   This is a far as it should go for the 2.6.x series.  There are 
more elaborate solutions proposed for the 2.7 kernel.

John




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
