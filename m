From: James Simmons <jsimmons@infradead.org>
Subject: Re: new logo drawing code
Date: Sun, 5 Jan 2003 20:46:33 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301052044530.24903-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0212292057180.17739-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18VHfo-00006C-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 05 Jan 2003 12:47:08 -0800
In-Reply-To: <Pine.GSO.4.21.0212292057180.17739-100000@vervain.sonytel.be>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 29 Dec 2002, Geert Uytterhoeven wrote:

>   - Replace conditionals by straight code without branches (bit 7 of needs_logo
>     is either 0 (normal) or 1 (reverse), and perhaps we should kill the default
>     case?).

Applied.

> BTW, most of the new fbdev code looks really ugly in vim with `let
> c_space_errors=1', due to the exorbitant use of superfluous whitespace
> characters.

??? I use indent -kr -i8 to handle indenting.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
