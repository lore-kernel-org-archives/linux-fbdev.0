From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: [Fwd: Re: Some questions]
Date: Thu, 06 Mar 2003 10:31:42 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E67157E.3090607@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qrlx-0008PN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 01:34:41 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: adaplas@pol.net, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net



-------- Original Message --------
Subject: Re: [Linux-fbdev-devel] Some questions
Date: Thu, 06 Mar 2003 10:30:21 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <Pine.GSO.4.21.0303061006180.28248-100000@vervain.sonytel.be>

Geert Uytterhoeven wrote:
 > What if fbcon implements a text console _on top of_ fbdev? I.e. it
 > uses the current resolution?
 >
 > If you use stty to change the number of cols/rows, or change the font,
 > or use fbset, your text console may end up being smaller or larger
 > than the real screen size, in which case margins are cleared, or
 > columns/lines are lost. (Optionally, we can center the text console if
 >  it's smaller than the real  screen size.)
 >
 > IMHO this is the most orthogonal approach. Fbcon takes care of the
 > text console, fbdev takes care of the graphics hardware and the video
 > mode. Both parts do (try to) not influence each other.
 >
 > Optionally, fbset can call stty to change the number of cols/rows, if
 > the user wants that.
 >
 > What do you think?

I think that sounds like the best solution, and it also respects the
fact that fbcon and fbdev are two different pairs of shoes.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/






-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
