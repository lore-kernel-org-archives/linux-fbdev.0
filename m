From: John Zielinski <grim@undead.cc>
Subject: Re: Radeonfb hsync fudge factor?
Date: Wed, 24 Dec 2003 15:52:57 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE9FCA9.3070107@undead.cc>
References: <3FE8D315.1000904@undead.cc> <20031224091824.GB11706@master.mivlgu.local> <Pine.GSO.4.58.0312241310520.1638@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZG0I-00037e-N1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 12:53:14 -0800
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZG0I-0005Vs-6E
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 12:53:14 -0800
In-Reply-To: <Pine.GSO.4.58.0312241310520.1638@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>On Wed, 24 Dec 2003, Sergey Vlasov wrote:
>  
>
>>Probably this fudge factor was needed for some early chips?
>>    
>>
>
>Yep, Mach64 needs one (but atyfb doesn't take care of it yet). So if you switch
>between depths, the display may shift horizontally. I guess this is due to
>different lengths of the dataflow paths for different color depths.
>  
>

How many cards handled by radeonfb need it?   That way we can add a 
fudge or nofudge driver option.  Or put it in the card database if the 
numbers are roughly equal.

I need to see if that's what's causing the sync problems with my friends 
HDTV....

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
