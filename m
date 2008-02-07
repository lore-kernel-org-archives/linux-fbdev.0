From: krzysztof.h1@poczta.fm
Subject: Re: mode_option or mode parameter (was: i810fb
	module parameter 'mode_option' inconsistent with other
	framebuffer modules)
Date: 07 Feb 2008 08:21:14 +0100
Message-ID: <20080207072114.628B197A810@f43.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JN1Ti-0001r1-Dp for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 23:47:26 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JN1Th-00014p-1F
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 23:47:26 -0800
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
To: Alain Kalker <miki@dds.nl>, linux-fbdev-devel@lists.sourceforge.net, Randy Dunlap <rdunlap@xenotime.net>, krzysztof.h1@poczta.fm, jsimmons@infradead.org, adaplas@gmail.com

Alain Kalker napisa=B3(a):
>
> I would like to propose instead to make the "mode& / mode_option"
> parameter name optional for all drivers where possible. This will
> greatly simplify framebuffer driver loading by the boot scripts, which
> currently cannot easily identify drivers needing either parameter name.
>

Just for conirmation:

so the current solution should be to add "mode_option" for drivers using
ModeDB and for all drivers to be able to accept resolution without any
parameter name?

Regards,
Krzysztof



----------------------------------------------------------------------
Wyjatkowe pioro Andrzeja Mleczki! =

Licytuj! >>> http://link.interia.pl/f1cf2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
