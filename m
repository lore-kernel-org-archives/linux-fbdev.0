From: Alain Kalker <miki@dds.nl>
Subject: Re: mode_option or mode parameter (was: i810fb
	module parameter	'mode_option' inconsistent with other
	framebuffer modules)
Date: Tue, 05 Feb 2008 12:42:36 +0100
Message-ID: <1202211756.5357.31.camel@localhost>
References: <20080205070810.9BF9D1B00D8@f41.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMMCb-0002sh-B2 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 03:43:04 -0800
Received: from spalding.dds.nl ([85.17.178.135])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JMMCZ-0000Va-A6
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 03:43:01 -0800
In-Reply-To: <20080205070810.9BF9D1B00D8@f41.poczta.interia.pl>
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

On Tue, 2008-02-05 at 08:08 +0100, krzysztof.h1@poczta.fm wrote:
> Hi,
> 
> Few days ago, a bug was reported that the i810fb uses "mode_option" parameters while other framebuffers uses the "mode" parameter to set initial mode. It was spotted later that some drivers uses "mode_option", some uses "mode" and some does use none.
> 
> I want to ask what is a correct way. I can rework at least some of the drivers to a standard way, but I don't know what the standard is.

With your permission, I have cc:'ed your question to my original Debian
bug report,

From Documentation/fb/modedb.txt:
---
When a frame buffer device receives a video= option it doesn't know, it
should consider that to be a video mode option. If no frame buffer
device is specified in a video= option, fbmem considers that to be a
global video mode option.

Valid mode specifiers (mode_option argument):
...

From this I believe that 'mode_option' is the standard way, It also
indicates that the parameter name itself is optional, but I am not sure
if there is an overall Linux standard for indicating optional parameter
names.

Kind regards,

Alain

P.S.: Krzysztof, maybe it would be a good idea to update fbmode.txt
too, as there are now many more framebuffer drivers which support video
mode naming.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
