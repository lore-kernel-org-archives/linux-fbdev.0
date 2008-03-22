From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: vga16fb: blank screen with Intel
	GM965/GL960 on HP 2510p	notebook
Date: Sat, 22 Mar 2008 12:25:48 +0100
Message-ID: <20080322112548.GB3022@deprecation.cyrius.com>
References: <20080321163944.GA22068@deprecation.cyrius.com>
	<1206119016.26934.516.camel@koto.keithp.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jd1rB-0000WL-06 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 04:25:49 -0700
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jd1r9-0006Eq-MK
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 04:25:48 -0700
Content-Disposition: inline
In-Reply-To: <1206119016.26934.516.camel@koto.keithp.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

* Keith Packard <keith.packard@intel.com> [2008-03-21 10:03]:
> I have the same machine and the debian install worked for me. Perhaps
> your BIOS has configured the chip in a way that prevents VGA graphics
> mode from working?

I don't see anything in the BIOS that would be obviously related to
VGA.  Any idea what to look for?

Here's also some more information:

Before it switches to framebuffer, I see the following on the console:

PCI: BIOS Bug: MCFG area at f8000000 is not E820-reserved
PCI: Not using MMCONFIG.

The BIOS is ROM F.0A 02/16/2008 and Video BIOS 1471

-- 
Martin Michlmayr
http://www.cyrius.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
