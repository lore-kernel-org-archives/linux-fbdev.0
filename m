From: krzysztof.h1@poczta.fm
Subject: Re: mode_option or mode parameter (was: i810fb
	module parameter 'mode_option' inconsistent with other
	framebuffer modules)
Date: 06 Feb 2008 08:15:16 +0100
Message-ID: <20080206071517.14FE52E5CE4@f27.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMeqS-0008B0-9S for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 23:37:29 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JMeqQ-0007z3-MT
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 23:37:24 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Randy Dunlap <rdunlap@xenotime.net>, linux-fbdev-devel@lists.sourceforge.net, krzysztof.h1@poczta.fm, jsimmons@infradead.org, adaplas@gmail.com

Randy Dunlap napisa=B3(a):
> On 05 Feb 2008 08:08:10 +0100 krzysztof.h1@poczta.fm wrote:
> =

> > Hi,
> > =

> > Few days ago, a bug was reported that the i810fb uses "mode_option"
> parameters while other framebuffers uses the "mode" parameter to set
> initial mode. It was spotted later that some drivers uses "mode_option",
> some uses "mode" and some does use none.
> > =

> > I want to ask what is a correct way. I can rework at least some of the
> drivers to a standard way, but I don't know what the standard is.
> =

> Hi,
> Hopefully one of the fbdev driver developers will know for sure.
> =

> I would (do) say that "mode_option" is being redundant.  Yes, it's
> an option, but we don't usually name options (in other parts of the
> kernel) with an _option suffix.  Sure, the variable could be called
> >mode_option>, but the userspace name should just be "mode".  IMHO.
> =


I and Alain Kalker (who originally filled the bug report) decided to proceed
with mode_option parameter because it is stated in documentation, fb driver
skeleton and more drivers then the mode option. It seems that the mode
option is used in newer drivers (drivers added later).

We want to preserve what older fbdev developers decided some time ago. =

Personaly, I am not sure one way is much better then the other one. =

The problem is that it is not one way.

The first step is to fix the mess with different option names, so to add
the mode_option parameter to drivers which do not support it or support the
mode parameter.

> Please keep Documentation/fb/modedb.txt updated if you make any
> relevant changes.
> =


Yes, of course.

Regards,
Krzysztof


----------------------------------------------------------------------
Wyjatkowe pioro Andrzeja Mleczki! =

Licytuj! >>> http://link.interia.pl/f1cf2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
