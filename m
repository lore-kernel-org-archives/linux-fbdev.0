From: Antonino Daplas <adaplas@pol.net>
Subject: Re: How can I test my console driver?
Date: 12 Mar 2003 04:07:48 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047407682.1033.178.camel@localhost.localdomain>
References: <1047376355.5640.5.camel@cambridge.braddahead>
	<1047387515.984.44.camel@localhost.localdomain> 
	<1047392898.2262.4.camel@cambridge.braddahead>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sq5R-0005DA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 12:10:57 -0800
In-Reply-To: <1047392898.2262.4.camel@cambridge.braddahead>
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
To: Alex Bennee <kernel-hacker@bennee.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-03-11 at 22:28, Alex Bennee wrote:
> > Why not just use take_over_console() with first and last equal to a tty
> > you can switch to?  If something bad happens, just switch to a working
> > console.
> 
> I tried that. It seems the first time I do a Ctrl-Alt-5 (for example) I
> loose the ability to use my keyboard. The only way I can recover
> anything is to re-boot my machine. This strikes me as a little odd as I
> thought the console was soley interested in output.
> 
> Is there anyway to write unbuffered output to the console? After all the
> only way I'm going to know anything is working is through dmesg and/or
> the screen image I read from my debugging proc interface.
> 

Maybe you can create dummy methods first, con_startup, con_init (used
during take_over_console), as well as the putc/s, scroll, clear, bmove,
etc.  Then you can implement them one by one and see which method
actually triggerred the lockup.

Tony 




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
