From: krzysztof.h1@poczta.fm
Subject: Re: mode_option or mode parameter (was: i810fb
	module parameter 'mode_option' inconsistent with other
	framebuffer modules)
Date: 05 Feb 2008 13:40:29 +0100
Message-ID: <20080205124029.620C01B00DA@f41.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMN6K-0000Ks-2t for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 04:40:36 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JMN6H-0000Pj-LW
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 04:40:36 -0800
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
To: Alain Kalker <miki@dds.nl>, krzysztof.h1@poczta.fm, jsimmons@infradead.org, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, 463129@bugs.debian.org

Alain Kalker napisa=B3:

> >From Documentation/fb/modedb.txt:
> ---
> When a frame buffer device receives a video=3D option it doesn't know, it
> should consider that to be a video mode option. If no frame buffer
> device is specified in a video=3D option, fbmem considers that to be a
> global video mode option.
> =

> Valid mode specifiers (mode_option argument):
> ...
> =

> >From this I believe that "mode_option" is the standard way, It also
> indicates that the parameter name itself is optional, but I am not sure
> if there is an overall Linux standard for indicating optional parameter
> names.
> =


If the mode_option is the correct one please email Andrew Morton to remove =
the patch I made for i810fb.
I will fix drivers which use the "mode" option.

> =

> P.S.: Krzysztof, maybe it would be a good idea to update fbmode.txt
> too, as there are now many more framebuffer drivers which support video
> mode naming.
> =

> =


I'll update it with every driver I reworked.

Regards,
Krzysztof


Pogoda na najblizsze dni.
Sprawdz >>> http://link.interia.pl/f1ce1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
