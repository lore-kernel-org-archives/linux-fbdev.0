From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 06 Mar 2003 00:34:27 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046882019.1289.223.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303051644080.23176-100000@vervain.sonytel.be> 
	<3E661EE3.8060108@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qbpQ-0007H3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 08:33:12 -0800
In-Reply-To: <3E661EE3.8060108@winischhofer.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 23:59, Thomas Winischhofer wrote:
> Geert Uytterhoeven wrote:
> > On Wed, 5 Mar 2003, Thomas Winischhofer wrote:
> > 
> >>Antonino Daplas wrote:
> >>
> >>>>Ack. Is 16 fuzzy enough, what do you think?
> >>>
> >>>I think you should only accept modes where the difference is a fraction
> >>>of a character width or height.  A difference more than that and
> >>>clear_margins() will not work correctly.  
> >>
> >>How do I - from a low level fb driver - determine the character size?
> > 
> > 
> > You cannot. That's called fbcon-fbdev separation.
> 
> My question was, basically, meant ironic.
> 
> But this is funny: You tell me that the difference should not exceed the 
> fraction of a character, but it is impossible to find out how wide/tall 
> characters are.
> 
> Guys, that won't work. I have to deal with LCD displays and TV output as 
> well (not to say "mainly") and I can't just set up odd modes like 
> 800x592, or mode resolutions based on calculations with any possible odd 
> font dimension.
> 

Yes, using stty is indeed limited.  This was implemented because midway
during development, when fbdev was completely separated from fbcon,
there was no way to resize the window at all.  The first solution was to
use stty, better it than none at all.  It did confuse a lot of people,
especially since not all drivers support changing the resolution without
help from the user.

Anyway, I have already brought fbset support back in my local copy :-)
As I've mentioned, I'll just wait for more replies to the "Feature
Freeze?" thread, and I'll submit a test patch.  

Tony

> Thomas
> 
> -- 
> Thomas Winischhofer
> Vienna/Austria
> mailto:thomas@winischhofer.net            http://www.winischhofer.net/
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
> for complex code. Debugging C/C++ programs can leave you feeling lost and 
> disoriented. TotalView can help you find your way. Available on major UNIX 
> and Linux platforms. Try it free. www.etnus.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
