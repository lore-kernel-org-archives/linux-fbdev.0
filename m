From: Andrew Walrond <andrew@walrond.org>
Subject: Re: ATI Rage XL on x86_64
Date: Thu, 27 Jan 2005 14:54:03 +0000
Message-ID: <200501271454.03706.andrew@walrond.org>
References: <200501260910.14102.andrew@walrond.org> <20050126105459.GA13231@sci.fi> <200501261209.46735.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
  boundary="Boundary-00=_LCQ+BH+K9hgW83i"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CuB2L-0004MF-Pa
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Jan 2005 06:54:21 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CuB2J-0004Gv-BB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Jan 2005 06:54:22 -0800
Received: from [62.24.231.115] (helo=orac.walrond.org)
	by cenedra.walrond.org with esmtp (Exim 4.34)
	id 1CuB23-0000v6-R9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Jan 2005 14:54:08 +0000
In-Reply-To: <200501261209.46735.andrew@walrond.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

--Boundary-00=_LCQ+BH+K9hgW83i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Wednesday 26 January 2005 12:09, Andrew Walrond wrote:
>
> When I try video=atyfb:1024x768-8@60, I get even less output:
>
>  atyfb: using auxiliary register aperture
>  atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
>  atyfb: 8M SDRAM (2:1) (32-bit) 29.498928 MHz XTAL, 230MHz PLL, 83 MHz MCLK
> 63MHz XCLK
>  atyfb: fb0: ATY Mach64 frame buffer device on PCI
>
> In all cases, the screen blanks for a moment during boot, then reppears in
> original 80x25 format.

FYI I have resolved this issue.

I had CONFIG_FRAMEBUFFER_CONSOLE=m

in the kernel config. I think the frambuffer code was working fine (explaining 
the screen blanking during boot), but then the console subsystem 
reconfiguring the display back to text mode.

Changing to CONFIG_FRAMEBUFFER_CONSOLE=y fixed this.

This is obviously a 'gotcha' to remember for the future, but perhaps also a 
candidate for further thought, since all subsequent use of the fb device (for 
graphics) produced a corrupt display.

Andrew Walrond

--Boundary-00=_LCQ+BH+K9hgW83i
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:10pt;font-family:Bitstream Vera Sans">
<p>On Wednesday 26 January 2005 12:09, Andrew Walrond wrote:</p>
<p>&gt;</p>
<p>&gt; When I try video=atyfb:1024x768-8@60, I get even less output:</p>
<p>&gt;</p>
<p>&gt;  atyfb: using auxiliary register aperture</p>
<p>&gt;  atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]</p>
<p>&gt;  atyfb: 8M SDRAM (2:1) (32-bit) 29.498928 MHz XTAL, 230MHz PLL, 83 MHz MCLK</p>
<p>&gt; 63MHz XCLK</p>
<p>&gt;  atyfb: fb0: ATY Mach64 frame buffer device on PCI</p>
<p>&gt;</p>
<p>&gt; In all cases, the screen blanks for a moment during boot, then reppears in</p>
<p>&gt; original 80x25 format.</p>
<p></p>
<p>FYI I have resolved this issue.</p>
<p></p>
<p>I had CONFIG_FRAMEBUFFER_CONSOLE=m</p>
<p></p>
<p>in the kernel config. I think the frambuffer code was working fine (explaining the screen blanking during boot), but then the console subsystem reconfiguring the display back to text mode.</p>
<p></p>
<p>Changing to CONFIG_FRAMEBUFFER_CONSOLE=y fixed this.</p>
<p></p>
<p>This is obviously a 'gotcha' to remember for the future, but perhaps also a candidate for further thought, since all subsequent use of the fb device (for graphics) produced a corrupt display.</p>
<p></p>
<p>Andrew Walrond</p>
<p></p>
</body></html>
--Boundary-00=_LCQ+BH+K9hgW83i--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
