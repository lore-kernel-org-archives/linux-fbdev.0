From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb and 2.5.66
Date: 26 Mar 2003 09:52:43 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048668763.10474.27.camel@zion.wanadoo.fr>
References: <Pine.GSO.4.21.0303251607490.22126-100000@vervain.sonytel.be>
	 <1048633657.2513.5.camel@tiger>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-1-208.abo.wanadoo.fr ([193.252.38.208] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18y6dy-00066q-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 00:52:22 -0800
In-Reply-To: <1048633657.2513.5.camel@tiger>
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
To: Louis Garcia <louisg00@bellsouth.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-26 at 00:07, Louis Garcia wrote:
> When I use video=radeonfb:dfp my monitor just goes into power saving
> mode (shuts off). This is what I get in the logs: If someone needs more
> info let me know. By the way I'm on a Intel x86 box.

Try that: around line 2065, change:

	newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST |
					 ICHCSEL | TMDS_PLL_EN) &
					 ~(TMDS_PLLRST);

to:

	newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST | ICHCSEL) &
					 ~(TMDS_PLLRST);

And tell me if that helps

Ben.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
