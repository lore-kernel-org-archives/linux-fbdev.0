From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 21:12:39 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408F0507.3000201@undead.cc>
References: <Pine.LNX.4.44.0404280051480.23153-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdd1-0004Qn-Lw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 18:12:47 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BIdd0-00045A-I9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 18:12:46 -0700
In-Reply-To: <Pine.LNX.4.44.0404280051480.23153-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:

>If this is true then it would be better if we have the below logic.
>
>struct vc_data --> native driver layer --> fbdev.
>
>instead of save/restore the var for each VC.
>  
>

I don't mean save as in record the current hardware state.  I mean save 
as in remember the last mode the user had active on the console before a 
graphics app starts.  This only has to be done 1) on boot and 2) after 
running fbset or calling VT_RESIZE.

Once we get the users mode db into the kernel then we only need to 
remember the generic stuff (x, y, Hz, bpp) per vt as the user will have 
the ability to map:

(x, y, Hz, bpp) -> (exact timing options)

Either way, regardless if we remember a per vt var or (x, y, Hz, bpp), I 
still would like the vt/fbcon to reset the the last mode on switch from 
KD_GRAPHICS to KD_TEXT.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
