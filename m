From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Fri, 07 Mar 2003 18:49:37 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E68DBB1.9070306@winischhofer.net>
References: <Pine.LNX.4.33.0303071030590.1781-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rM1c-0006We-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 09:52:52 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:
>>Therefore, the calculation of vrows has to take the difference between
>>these two into account.
>>
>>The attached patch fixes this for me but I have no idea if I cought all
>>possible itches. It will no apply cleanly, because I had made changes to
>>fbcon.c before making a backup copy - but it sure illustrates the problem.
>>
>>Why you used info->var.yres_virtual (and not the adapted
>>var.yres_virtual) in fbcon_resize() is beyond me, BTW.
> 
> 
> My mistake. I applied your patch.

Reading first Toni's post (because it came one minute earlier) and now 
yours, what's true resp. correct now?

Thomas

PS: James, are you "entitled" to add maintainers to the MAINTAINERS 
file? I have actually been the maintainer of sisfb since a year back, so 
I think this should perhaps be mentioned..?

SIS FRAMEBUFFER DRIVER
P:	Thomas Winischhofer
M:	thomas@winischhofer.net
W:	http://www.winischhofer.net/linuxsisvga.shtml
S:	Maintained



-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
