From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fbcon_redraw_clear()
Date: 24 Feb 2003 05:55:22 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046037261.1311.78.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0302231314540.28532-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18n45D-0002AW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Feb 2003 13:54:51 -0800
In-Reply-To: <Pine.GSO.4.21.0302231314540.28532-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-02-23 at 20:15, Geert Uytterhoeven wrote:
> 
> fbcon_redraw_clear() uses fbcon_putc() to clear characters one by one, which is
> slow.
> 

Largely unused.  James already removed this and fbcon_redraw_bmove() in
his newest patch.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
