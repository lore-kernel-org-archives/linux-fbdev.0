From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Another problem, seemingly coming f
Date: Wed, 16 Oct 2002 16:25:20 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4C636B97ED1@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: Quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181p7G-0003P7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 07:25:43 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Ville Syrjaelae <syrjala@sci.fi>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 16 Oct 02 at 11:59, Ville Syrj=E4l=E4 wrote:

> On Wed, Oct 16, 2002 at 09:00:27AM +0200, Petr Vandrovec wrote:
> > Ah, these ones... What pixclocks do you use? It is like if CRTC2 has
> > not enough memory bandwidth available, and so it displays stale data.
> 
> Can the CRTC high priority stuff affect this? Does matroxfb touch the
> priority registers?

Yes, matroxfb sets them to default values, recommended for low pixclock
rates. You must set them when you initialize hardware after poweron.
 
> > Only problem I can think of is that system VCO frequency is always set
> > to 133333 kHz (for G100/200/400) in matroxfb_DAC1064.c. Your PINS
> > suggest that 200MHz are correct system clocks for your chip.
> 
> What do you think about making matroxfb do clock setup accrding to PINS?
> XFree86 mga driver does it own clock setup but DirectFB matrox driver
> does not. I'm pretty sure increasing the clocks would provide some
> speed benefits since the BIOS default clocks are pretty low.

I'll not use other clocks than specified in the BIOS (BIOS uses value
specified in PINS). It is highest rate Matrox says to use. That Matrox 
windows drivers use higher frequency is another story: they have access 
to other information than I have, and so they can select highest system 
clock from chip revision, serial number and other values...

On G450/G550 I use frequency specified in BIOS PINS. G400 (and older) 
historically used hardwired values in matroxfb, and because of I do not 
use them regulary anymore, I try to not touch their initialization code 
(and as you can saw, even then I had mistake in G400 initialization... 
unfortunately testing powerup initialization requires plugging in another
videocard, unplugging powercord, and then trying again and again...).

If you'll cook and test patch which will set system clocks on G400
according to the value specified in the BIOS, or if you'll create
patch which will add ioctl() or some other operation to set system
PLL, I'll apply it without problem (if code is correct, changing
system PLL is not trivial operation).
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
