From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9847] New: i810fb: module
 parameter 'mode_option' inconsistent with other framebuffer modules
Date: Fri, 1 Feb 2008 20:37:37 -0800
Message-ID: <20080201203737.141b11d1.akpm@linux-foundation.org>
References: <20080201070131.27F842BD8B5@f25.poczta.interia.pl>
	<20080131233232.a7bf51d5.akpm@linux-foundation.org>
	<1201925891.2704.25.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JLA95-0002iL-9D for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 20:38:27 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JLA93-0001wa-Tz
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 20:38:27 -0800
In-Reply-To: <1201925891.2704.25.camel@localhost>
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
To: Alain Kalker <miki@dds.nl>
Cc: jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Sat, 02 Feb 2008 05:18:10 +0100 Alain Kalker <miki@dds.nl> wrote:

> Should this be filed as a more general bug report?

It is unlikely that anyone would actually act upon such a thing, I'm afraid.
Maybe if we could come up with a single, centralised option parser
for all the drivers and then migrate individual drivers over to or
or something like that..

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
