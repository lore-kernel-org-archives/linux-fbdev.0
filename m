From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 12:00:35 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207051141590.25589-100000@www.transvirtual.com>
References: <20020705193923.G27920@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QYJw-0003CW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 12:00:44 -0700
In-Reply-To: <20020705193923.G27920@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Fri, Jul 05, 2002 at 11:32:51AM -0700, James Simmons wrote:
> > > James, you're OTT here.
> >
> > I apologize I'm sorry. I did get upset. Its just this has been discussed
> > time and time again. It gets annoying after awhile and it stopped me from
> > completing the fbdev changes in the last development series. I don't want
> > that again.

> _I_ didn't stop your fbdev changes.

I know that. In fact you where one of my best supporters of my ideas. You
defended my ideas against the others who where against it. This I am most
grateful for.

> You stopped them yourself when other
> driver maintainers didn't comply with your ill-timed request.

I didn't want to break their drivers. I still don't. I like to avoid it as
much as possible.

> And that's the situation today.  If you want to carry on this slagging
> match... but its not getting either of us anywhere.

   No I don't either. I'm claimed down and I'm thinking straight again.
Unfortunely email doesn't show this. Sorry about the misunderstanding
here.
   All I want to do is seperate out the console code and redundent
stuff. To make fbdev work without fbcon. You can see the bonus here.
   This is the first step. Once that is out of the way I like to see the
internals AND externals change for fbdev. I'm no big fan of var and fix
being seperate. Plus there is abunch of other things. But this is for the
next developement tree. So once 2.6 comes out I like to start on these
changes right away. Since I see you have a strong opinon (which is a good
thing) I want to here your input on how the next generation of fbdev/dri
drivers should be.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
