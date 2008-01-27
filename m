From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 00/11] ps3av/3fb patches for 2.6.25
Date: Sun, 27 Jan 2008 02:16:59 -0800
Message-ID: <20080127021659.fb6c72a1.akpm@linux-foundation.org>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080126220139.5385f2c7.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0801271041160.10193@vixen.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JJ4a0-00078r-4m for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 02:17:36 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JJ4Zy-0006PE-Oz
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 02:17:34 -0800
In-Reply-To: <Pine.LNX.4.64.0801271041160.10193@vixen.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, adaplas@gmail.com

> On Sun, 27 Jan 2008 10:44:40 +0100 (CET) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> 	Hi Andrew,
> 
> On Sat, 26 Jan 2008, Andrew Morton wrote:
> > > On Fri, 25 Jan 2008 16:06:23 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > > Hare are the ps3av/fb patches for 2.6.25:
> > 
> > I would have to say: it's a bit late to be submitting things of this nature
> > for 2.6.25.  Given the mess everyone has made of everything there's little
> > chance that I'll be able to do a 2.6.24-mm1 so this stuff basically goes
> > into mainline without public testing.
> 
> I beg to disagree (of course :-)
> 
> I posted these patches before, about 2 months ago. Unfortunately I didn't CC
> you at that time, so they slipped under your radar.
> But the patches did receive public testing even before that, when they entered
> Geoff's ps3-linux.git tree.
> 

Should that git tree be in the -mm lineup?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
