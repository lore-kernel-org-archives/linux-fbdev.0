From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb and 2.5.66
Date: 25 Mar 2003 16:00:37 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048604437.582.37.camel@zion.wanadoo.fr>
References: <1048567152.2455.5.camel@tiger>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xpuq-0001jw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 07:00:40 -0800
In-Reply-To: <1048567152.2455.5.camel@tiger>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, 2003-03-25 at 05:39, Louis Garcia wrote:
> Does anyone know if the radeonfb in 2.5.66 supports the dvi port on my
> radeon 7500 QW? I've compiled the driver in and appended video=radeon to
> grub and I still get vga.

Tried video=radeon:dfp ?

Ben.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
