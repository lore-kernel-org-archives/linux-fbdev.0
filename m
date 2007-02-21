From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Thu, 22 Feb 2007 07:43:26 +0800
Message-ID: <1172101406.4217.16.camel@daplas>
References: <ephv35$4i3$1@sea.gmane.org>
	<20070128160831.fb51347f.akpm@osdl.org>
	<21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	<20070128162907.370f5476.akpm@osdl.org>
	<21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	<cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
	<20070130203301.GA15067@dreamland.darkstar.lan>
	<20070204201713.GA12867@dreamland.darkstar.lan>
	<Pine.LNX.4.64.0702062034380.9224@pentafluge.infradead.org>
	<cb7bb73a0702061508x767882dcia1b13f85d898b6e7@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK14k-0002fR-9e for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:40:43 -0800
Received: from nz-out-0506.google.com ([64.233.162.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK14i-0002rP-1m
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:40:41 -0800
Received: by nz-out-0506.google.com with SMTP id i11so4195668nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 15:40:39 -0800 (PST)
In-Reply-To: <cb7bb73a0702061508x767882dcia1b13f85d898b6e7@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Luca Tettamanti <kronos@people.it>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Dave Airlie <airlied@gmail.com>

On Wed, 2007-02-07 at 00:08 +0100, Giuseppe Bilotta wrote: 
> On 2/6/07, James Simmons <jsimmons@infradead.org> wrote:
> >
> > If you can find post the manufacturer and model number we can place it on
> > the backlist in fbmon. Also we should figure out what is wrong and fix it.
> 
> It's the UltraSharp UXGA display that used to come with Dell Inspiron
> 8200, 15" with a resolution of 1600x1200. I've been looking all around
> for more info on it, but the only things I could find were posts that
> remarked the problems Windows nVidia drivers have with some of these
> (no image when running at 1600x1200), and other posts about banded
> gradients with Windows drivers on Radeon video cards (but I get banded
> gradients also win my nVidia card, on Linux, regardless of which
> driver I use, binary, nv or nouveau).
> 
> As mentioned in another post in this thread, I can't get any info out
> of the i2c busses, because even when I have them available (i.e. after
> loading nvidiafb) I get XXXX all around (on all three of them).
> Suggestions on how to get the information welcome.

Is this the same monitor you posted here?

http://marc.theaimsgroup.com/?l=linux-kernel&m=112807065616218&w=2

If yes, we already have the manufacturer and model code. The main
problem is that the EDID of this display has no sync range (H: 75-75kHz
and V: 60-60Hz).  Extending Hsync from 30-75kHz as a fix to the EDID
block shouldn't be too hard.

I already have a patch for this which I forgot to send to you
before :-).  If you can confirm that this is still the same hardware,
I'll send you a test patch

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
