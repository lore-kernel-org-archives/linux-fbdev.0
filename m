From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Fri, 07 Mar 2003 18:00:59 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E68D04B.3090304@winischhofer.net>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80	 80506@winischhofer.net> <1047045694.1310.6.camel@localhost.localdomain> 	<3E68B895.2080500@winischhofer.net> <1047053804.1281.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rLGX-0000JA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 09:04:14 -0800
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
> Right, fbcon never dealt with margins greater than a character
> width/height before :-). I think your patch will do the Right Thing.

I hope so :) But please think it through, I have no idea about the 
possible impacts of this.

> As for the one you commented out as INCOMPLETE, my guess is it won't
> matter since that particular section of code is called only during
> initialization.  An fbcon_switch() will be called later on, I think.

No idea, but ... you're the expert!

>>Why you used info->var.yres_virtual (and not the adapted 
>>var.yres_virtual) in fbcon_resize() is beyond me, BTW.
> 
> Because info->var will _always_ contain the correct var, so we trust
> that above all.

Then I must have misunderstood the code. You submit var (and not 
info->var) to fb_set_var, so it is that var that will be treated by 
check_var and used for set_par. Since check_var() may (and does) change 
the yres_virtual according to the desired resolution/depth and so on, I 
thought it might be more correct to use it instead of info->var...

I have in the meantime submitted a new sisfb patch to James; it depends, 
however, on the changes to fbcon we are discussing now (especially the 
fbcon_resize thing which is too intolerant in James' current code base). 
Otherwise, mode switches using stty won't work.

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
