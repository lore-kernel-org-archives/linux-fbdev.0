From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 08 Mar 2003 01:42:54 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047058910.1390.65.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80
	 80506@winischhofer.net> <1047045694.1310.6.camel@localhost.localdomain>
	<3E68B895.2080500@winischhofer.net>
	<1047053804.1281.45.camel@localhost.localdomain> 
	<3E68D04B.3090304@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rLr9-0001Nq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 09:42:04 -0800
In-Reply-To: <3E68D04B.3090304@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-03-08 at 01:00, Thomas Winischhofer wrote:
> >>Why you used info->var.yres_virtual (and not the adapted 
> >>var.yres_virtual) in fbcon_resize() is beyond me, BTW.
> > 
> > Because info->var will _always_ contain the correct var, so we trust
> > that above all.
> 
> Then I must have misunderstood the code. You submit var (and not 
> info->var) to fb_set_var, so it is that var that will be treated by 
> check_var and used for set_par. Since check_var() may (and does) change 
> the yres_virtual according to the desired resolution/depth and so on, I 
> thought it might be more correct to use it instead of info->var...
> 

Note that fbcon_resize made a copy of info->var, then modified it
according to the requested width and height.  Then it goes through a
test if it needs an fb_set_var or not.  So info->var and the modified
var can be different if fb_set_var() wasn't called at all.  If it indeed
went through fb_set_var(), the var returned from check_var() will be
placed automatically to info->var before calling set_par().  So, yes, in
this case, info->var and the adjusted var will be the same.

Of course, in this particular code it is not important whichever var is
used because we're only interested in yres_virtual.  But using info->var
instead of the adjusted var is safer because it is guaranteed to be
always correct.

BTW: I'll check the patch against vesafb and let you know.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
