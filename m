From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: vga16fb: blank screen with Intel
	GM965/GL960 on HP 2510p	notebook
Date: Sat, 22 Mar 2008 17:58:18 +0100
Message-ID: <20080322165817.GD13703@deprecation.cyrius.com>
References: <20080321163944.GA22068@deprecation.cyrius.com>
	<1206119016.26934.516.camel@koto.keithp.com>
	<20080322112548.GB3022@deprecation.cyrius.com>
	<1206204017.26934.554.camel@koto.keithp.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jd72d-0005Ed-Ue for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 09:58:01 -0700
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jd72X-0004vq-OQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 09:57:54 -0700
Content-Disposition: inline
In-Reply-To: <1206204017.26934.554.camel@koto.keithp.com>
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
To: Keith Packard <keith.packard@intel.com>
Cc: Frans Pop <elendil@planet.nl>, linux-fbdev-devel@lists.sourceforge.net

* Keith Packard <keith.packard@intel.com> [2008-03-22 09:40]:
> > The BIOS is ROM F.0A 02/16/2008 and Video BIOS 1471
> That's newer than the one I have; one wonders if they broke something...

Do you think you can try that version?

> Can you use vesafb instead of vga16fb? That should be far more reliable.

vesafb is built into the Debian kernel, so presumably that works.
I've no idea why debian-installer loads vga16fb.  Frans, any idea?
-- 
Martin Michlmayr
http://www.cyrius.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
