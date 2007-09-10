From: aherrman@arcor.de
Subject: Re: [PATCH 2/4] radeonfb: add new module
	parameter to force PLL calculation
Date: Tue, 11 Sep 2007 00:20:12 +0200
Message-ID: <20070910222012.GB5155@devil>
References: <20070904105908.GF7320@devil>
	<1188913589.5972.150.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUrax-00086x-Gh for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 15:19:06 -0700
Received: from mail-in-08.arcor-online.net ([151.189.21.48])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IUraw-00017w-7U
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 15:19:03 -0700
Content-Disposition: inline
In-Reply-To: <1188913589.5972.150.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Sep 04, 2007 at 03:46:29PM +0200, Benjamin Herrenschmidt wrote:
> I don't like those tunables. First we should get a look at what values
> we obtain from the BIOS. Could be something with the parsing of ATOM
> BIOS. In any case, we might be able to detect we got wrong values or use
> subsystem vendor/device ID to blacklist.

So what should I looking for?
Here is the diff of the radeonfb kernel messages between 
(-)nopllcalc and (+)forcing pll calculation with my patch:

   vSync_width: 4
   clock: 7350
 Setting up default mode based on panel info
-hStart = 672, hEnd = 712, hTotal = 824
-vStart = 404, vEnd = 408, vTotal = 437
-h_total_disp = 0x4f0066           hsync_strt_wid = 0x5029a
-v_total_disp = 0x18f01b4          vsync_strt_wid = 0x40193
+hStart = 1312, hEnd = 1352, hTotal = 1464
+vStart = 804, vEnd = 808, vTotal = 837
+h_total_disp = 0x9f00b6           hsync_strt_wid = 0x5051a
+v_total_disp = 0x31f0344          vsync_strt_wid = 0x40323
 pixclock = 13605
 freq = 7350
-Console: switching to colour frame buffer device 80x25
+freq = 7350, PLL min = 20000, PLL max = 40000
+ref_div = 6, ref_clk = 1432, output_freq = 29400
+ref_div = 6, ref_clk = 1432, output_freq = 29400
+post div = 0x2
+fb_div = 0x7b
+ppll_div_3 = 0x2007b
+Console: switching to colour frame buffer device 160x50
 radeonfb (0000:01:05.0): ATI Radeon 5975 "Yu"
 radeonfb_pci_register END

"nopllcalc" results in a console 80x25 but forcing pll calculation gives
the expected result.

BTW, I am a little surprised that the display doesn't blank without
my patch as it used to in the past ...

  Oops, PCI ID 0x5975 was already added with commit
  b5f2f4d1a6d7efde39cfb5e1d034981c69f2214c

I guess I have to repeat some testing with both the older commit and my patch(es)
to sort out what is really needed to support my RS482/0x5975.


Regards,

Andreas


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
