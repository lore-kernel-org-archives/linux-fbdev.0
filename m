From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 06 Mar 2003 17:58:06 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046944674.1332.68.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303061006180.28248-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qs7M-0002o1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 01:56:48 -0800
In-Reply-To: <Pine.GSO.4.21.0303061006180.28248-100000@vervain.sonytel.be>
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
Cc: Thomas Winischhofer <thomas@winischhofer.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 17:12, Geert Uytterhoeven wrote:
> 
> What if fbcon implements a text console _on top of_ fbdev? I.e. it uses the
> current resolution?
> 
> If you use stty to change the number of cols/rows, or change the font, or use
> fbset, your text console may end up being smaller or larger than the real
> screen size, in which case margins are cleared, or columns/lines are lost.
> (Optionally, we can center the text console if it's smaller than the real
>  screen size.)
> 

Which is basically what stty does for the standard console (except that
lines are not lost, but wrapped, and margins are not cleared).

So, we need to reimplement the clipping code.

> IMHO this is the most orthogonal approach. Fbcon takes care of the text
> console, fbdev takes care of the graphics hardware and the video mode. Both
> parts do (try to) not influence each other.
> 
> Optionally, fbset can call stty to change the number of cols/rows, if the user
> wants that.
> 

Or even a simple script that basically does "fbset 1024x768-60 && stty
cols 128 rows 48". Of course, adding this to fbset itself will make it
transparent to the user.

Sounds very logical to me :-)

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
