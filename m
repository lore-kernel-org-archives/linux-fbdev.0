From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Linux Intel FB Question
Date: Tue, 15 Apr 2003 13:20:00 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030415112000.GA6351@iliana>
References: <20030415101313.98196.qmail@web41613.mail.yahoo.com> <Pine.GSO.4.21.0304151307110.26578-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp1.wanadoo.fr ([193.252.22.25] helo=mwinf0604.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 195OU3-000297-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Apr 2003 04:20:15 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0304151307110.26578-100000@vervain.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Justin Ducote <justinduc@yahoo.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Apr 15, 2003 at 01:09:12PM +0200, Geert Uytterhoeven wrote:
> On Tue, 15 Apr 2003, Justin Ducote wrote:
> > 1.) what is the syntax of the video line, I have seen
> > all kinds of examples on the net like:
> > 
> > "video=radeonfb:mode:1024x768-60@8"
> > "video=radeonfb:mode:1024x768-8@60"
> > "video=mode:1024x768-8@60"
> > "video=mode:1024x768-60@8"
> > "video=mode:1024x768"
> > 
> > sometimes with the drivername, sometimes without,
> > someimtes with a hypen and then the refresh rate
> > followed by a pound and then an @ symbol then the bpp
> > and vice versa. 
> > 
> > Is there a standardized syntax for the video line ? Do
> > you have to include the word "mode" what is the order
> > of information you have to provide, etc... 
> > 
> > How are these values interpreted and what order does
> > it read these values in ? What ist he format for
> > specifying pixel depth and refresh rate, etc. 
> 
> See linux/Documentation/fb/modedb.txt.
> 
> > And is it possible to use vga= and video= together? 
> > 
> > video=radeonfb and then vga=792 
> 
> I don't think that's very useful.

Its not possible to have vesafb on one card and anothe fb on anther card
then ?

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
