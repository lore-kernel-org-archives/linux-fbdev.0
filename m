From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: status
Date: Mon, 25 Nov 2002 18:47:06 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211251832200.22897-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0211232203340.20022-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0211232203340.20022-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux/m68k <linux-m68k@lists.linux-m68k.org>


> > Geert is busy porting the Amigia driver to the new api. That means all the 
> > ilbm, iplan stuff will go away :-) 
> 
> I have first code for amifb, but it doesn't work yet, due to other problems
> with 2.5.x on Amiga. I hope to fix these tomorrow...

Yeah!!!

> Besides, we still need someone to take care of the Atari 2-byte interleaved
> bitplanes (iplan2p*), since I don't have the hardware, and am not 100% sure 
> how they work. But reviving 2.5.x on Atari will be even harder...

   Me neither. But there is a way to find out. A trick I used to figure 
out the hga framebuffer lay out. Build just the fbdev layer without fbcon. 
Then do a write to /dev/fbX to see what happens. 
   The way I have fbdev now is when you open /dev/fb0 the hardware mode is 
set. When you close the /dev/fb the hardware goes back to text mode. I did 
it this way so you could insmod the driver and NOT change the hardware 
state. Also fb_open is the function register_framebuffer needs just before 
take_over_console happens. The other benifiet is if X dies that uses 
/dev/fb to set it modes then the file will be closed automatically and teh 
hardware state will be set to a sane state. This is for the case of vgacon 
with fbdev. WHat about from fbco? Well that is easy since fb_open passes a 
falg to let us knwo if it is from userland for fbcon.

P.S
   It appears fbcon is totally broken in BK. I'm using the above trick to 
test the code. Tonight I'm going to work on making fbcon completely 
modular. Yeah!!!!



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
