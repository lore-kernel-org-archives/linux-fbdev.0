From: Boris Bezlaj <boris@gajba.net>
Subject: Re: vertical stripes under OpenFirmware and offb
Date: Sun, 6 Apr 2003 20:34:33 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030406183433.GA929@gajba.net>
References: <20030328110528.GA2403@gajba.net> <Pine.LNX.4.44.0304022311440.3919-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.g-kabel.si ([193.189.173.117])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 192Eyd-0007Q6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 06 Apr 2003 11:34:48 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304022311440.3919-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, Apr 02, 2003 at 11:12:45PM +0100, James Simmons wrote:
> 
> > could anyone explain what kind of misconfiguration of framebuffer in OpenFirmware
> > or in general would cause the vertical stripes effect? White stripes, width about the
> > same as the width of characters and some garbage pixels between lines on black background.
> > If the white stripes would stick together, the screen with letters would look in order.
> 
> Which kernel are you using? What is configuration?
>  
Stock 2.4 kernels with video=imsttfb:vmode:12 boot parameters. I need to
modify the DAC type detection for the IMS to work properly..original
wrongly detects IBM ramdac.. PCI ID's are used wrongly i suppose.

Otherwise if i use offb i get the above mentioned effects as OF does not
initialize the dac..so i belive.

OF device node: IMS,tt128mb8

lspci output:
01:0f.0 Class 0380: 10e0:9128 (rev 01)
        Flags: bus master, medium devsel, latency 32, IRQ 29
        Memory at 90000000 (32-bit, prefetchable) [size=16M]
        Expansion ROM at 92000000 [disabled] [size=64K]

ON CHIP INFO:

IMS TT 128M8 rev 3.6

Chip: Twin Turbo 128+
I2C 0174
IMS 9130 <-- note: PCI ID says 9128
NNM 9644 (two triangles on end..)
WE 15680
MALAYSIA

DAC chip: VIDEO ( TexasInstruments logo)
TVP 3030
-220PPA
6049027  69AE20W

> A IMS card user. Could you try out the imsttfb driver as well. I liek to 
> know how well it works in 2.5.X.

I promise i will 8) As soon as i get it to compile/boot properly.

And thanks for looking after the driver..the meintainer seems to be on a
very looong vacations :(

-- 

  Boris


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
