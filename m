From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: MagicGraph 256AV framebuffer & kernel 2.5.21: problems
Date: Sat, 15 Jun 2002 21:15:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020615191535.GA1617@casa.fluido.as>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl ([62.163.205.17] helo=mail.fluido.as)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17JJ1Z-0002lu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Jun 2002 12:15:49 -0700
Received: from fluido by mail.fluido.as with local (Exim 4.02)
	id 17JJ1L-0001VM-00
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Jun 2002 21:15:35 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

I had sent this message to the old list... This must have been the
reason I did not see any echo to it... ;-)

I hope I have better luck now.

----- Forwarded message from "Carlo E. Prelz" <fluido@fluido.as> -----

From: "Carlo E. Prelz" <fluido@fluido.as>
Date: Thu, 13 Jun 2002 13:16:07 +0200
To: linux-fbdev@vuser.vu.union.edu
Subject: [linux-fbdev] MagicGraph 256AV framebuffer & kernel 2.5.21: problems

My oldish Sony Vaio, whose video subsystem identifies itself as
follows:

00:0a.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 20) (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 805d
        Flags: medium devsel, IRQ 3
        Memory at fd000000 (32-bit, prefetchable) [size=16M]
        Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
        Memory at fec00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 1

and which prints FB-related info at boot in this way:

 PCI: Found IRQ 3 for device 00:0a.0
 neofb: mapped io at c480d000
 Panel is a 1024x768 color TFT display
 neofb: mapped framebuffer at c4a0e000
 neofb v0.3.3: 2560kB VRAM, using 1024x768, 48.361kHz, 60Hz
 Console: switching to colour frame buffer device 128x48
 fb0: MagicGraph 256AV frame buffer device

has a curious behaviour in console mode. It seems that all output is
shifted 1 line downwards: when using a program that handles the screen
(mc, emacs) the topmost line is not used for display, while in normal
console, whenever print has to happen to the bottom line, printout is
not seen and scrolling does not take place. Changing virtual console
(ALT-rightArrow followed by ALT-leftArrow, for example) rebuilds the
right output.

This did not happen with kernel 2.5.19 and neovb v0.3.2. I expect it
must be something trivial, but I do not know where to put my hands... 

Carlo

----- End forwarded message -----

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
