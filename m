From: Alain Kalker <miki@dds.nl>
Subject: Re: mode_option or mode parameter (was: i810fb
	module parameter	'mode_option' inconsistent with other
	framebuffer modules)
Date: Tue, 05 Feb 2008 13:09:46 +0100
Message-ID: <1202213386.5357.40.camel@localhost>
References: <20080205070810.9BF9D1B00D8@f41.poczta.interia.pl>
	<1202211756.5357.31.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMMci-0005ck-Lg for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 04:10:00 -0800
Received: from spalding.dds.nl ([85.17.178.135])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JMMcg-0000S9-Q6
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 04:10:00 -0800
In-Reply-To: <1202211756.5357.31.camel@localhost>
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
To: krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, 463129@bugs.debian.org, adaplas@gmail.com

On Tue, 2008-02-05 at 12:42 +0100, Alain Kalker wrote:
> P.S.: Krzysztof, maybe it would be a good idea to update fbmode.txt
> too, as there are now many more framebuffer drivers which support video
> mode naming.

I have to rephrase that, the situation is much more complicated (sigh).
The only pattern I see is that drivers which support ModeDB (e.g.
i810fb) use the parameter name 'video_mode' which can then be optional,
while others (e.g. cirrusfb) use hardcoded video modes and _require_ the
parameter name to be present, which must then be called 'mode'.

Kind regards,

Alain

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
