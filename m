From: Antonino Daplas <adaplas@pol.net>
Subject: Re: new logo drawing code
Date: 03 Jan 2003 18:33:06 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041589394.1014.7.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0212292057180.17739-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UPLM-0003nH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 03 Jan 2003 02:46:24 -0800
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
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2002-12-30 at 04:07, Geert Uytterhoeven wrote:
> 
> Did anyone actually test fbcon_set_logo() on monochrome hardware?
> 
> I admit I haven't tried it myself yet (still fighting with amifb), but this
> looks more reasonable:
>   - Use index i*8+j instead of i*2
This part is fixed in linux-2.5.54.

>   - Replace conditionals by straight code without branches (bit 7 of needs_logo
>     is either 0 (normal) or 1 (reverse), and perhaps we should kill the default
>     case?).
This is cleaner, I believe.

Tony





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
