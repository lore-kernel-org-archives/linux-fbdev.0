From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Another problem, seemingly coming f
Date: Wed, 16 Oct 2002 11:59:56 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021016115956.A8311@sci.fi>
References: <4BECCE234BB@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from kura.mail.jippii.net ([195.197.172.113])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181k24-0008Hn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 02:00:00 -0700
In-Reply-To: <4BECCE234BB@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Wed, Oct 16, 2002 at 09:00:27AM +0200
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
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, Oct 16, 2002 at 09:00:27AM +0200, Petr Vandrovec wrote:
> Ah, these ones... What pixclocks do you use? It is like if CRTC2 has
> not enough memory bandwidth available, and so it displays stale data.

Can the CRTC high priority stuff affect this? Does matroxfb touch the
priority registers?

> Only problem I can think of is that system VCO frequency is always set
> to 133333 kHz (for G100/200/400) in matroxfb_DAC1064.c. Your PINS
> suggest that 200MHz are correct system clocks for your chip.

What do you think about making matroxfb do clock setup accrding to PINS?
XFree86 mga driver does it own clock setup but DirectFB matrox driver
does not. I'm pretty sure increasing the clocks would provide some
speed benefits since the BIOS default clocks are pretty low.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
