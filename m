From: Antonino Daplas <adaplas@pol.net>
Subject: Re: How can I test my console driver?
Date: 11 Mar 2003 20:59:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047387515.984.44.camel@localhost.localdomain>
References: <1047376355.5640.5.camel@cambridge.braddahead>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sjPD-0002Ez-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 05:02:56 -0800
In-Reply-To: <1047376355.5640.5.camel@cambridge.braddahead>
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

On Tue, 2003-03-11 at 17:52, Alex Bennee wrote:
> I sent this to lkml but it probably got missed in the volume of mail.
> Can anyone point me anything that describes how I could test my console
> driver. Would it be the same approach for example as testing the vfb
> frame buffer driver?
> 
> -----Forwarded Message-----
> > Hi,
> > 
> > I'm writting a console driver for an embedded system for which the
> > hardware isn't quite ready yet. As a result I'm building on a PC with a
> > quickly hacked up proc interface so I can test the logic before the
> > final hardware.
> > 
> > On loading the module my code does the following:
> > 
> >     take_over_console(&sh_con, MAX_NR_CONSOLES - 1, MAX_NR_CONSOLES - 1,
> > 1);
> > 
> > Which I understand should associate my new console driver with the last
> > system console (63 in this case). Then to test the console output I do:
> > 
> >     echo "this is a test string" > /dev/vc/63
> > 

I think the above will not work.  You can only have 1 active console at
a time, so all inputs to an inactive console will be buffered.  Only
when you switch to that particular console that all pending commands
will be flushed. 

Why not just use take_over_console() with first and last equal to a tty
you can switch to?  If something bad happens, just switch to a working
console.

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
