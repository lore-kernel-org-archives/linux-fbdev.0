From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: How can I test my console driver?
Date: 11 Mar 2003 14:28:18 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047392898.2262.4.camel@cambridge.braddahead>
References: <1047376355.5640.5.camel@cambridge.braddahead>
	 <1047387515.984.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from nimbus19.internetters.co.uk ([209.61.216.65])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18skk0-0005pK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 06:28:28 -0800
In-Reply-To: <1047387515.984.44.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-03-11 at 12:59, Antonino Daplas wrote:
> On Tue, 2003-03-11 at 17:52, Alex Bennee wrote:
> > > <snip>
> > > On loading the module my code does the following:
> > > 
> > >     take_over_console(&sh_con, MAX_NR_CONSOLES - 1, MAX_NR_CONSOLES - 1,
> > > 1);
> > > 
> > > Which I understand should associate my new console driver with the last
> > > system console (63 in this case). Then to test the console output I do:
> > > 
> > >     echo "this is a test string" > /dev/vc/63
> > > 
> 
> I think the above will not work.  You can only have 1 active console at
> a time, so all inputs to an inactive console will be buffered.  Only
> when you switch to that particular console that all pending commands
> will be flushed. 
> 
> Why not just use take_over_console() with first and last equal to a tty
> you can switch to?  If something bad happens, just switch to a working
> console.

I tried that. It seems the first time I do a Ctrl-Alt-5 (for example) I
loose the ability to use my keyboard. The only way I can recover
anything is to re-boot my machine. This strikes me as a little odd as I
thought the console was soley interested in output.

Is there anyway to write unbuffered output to the console? After all the
only way I'm going to know anything is working is through dmesg and/or
the screen image I read from my debugging proc interface.

-- 
Alex, homepage: http://www.bennee.com/~alex/

The soul would have no rainbow had the eyes no tears.



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
