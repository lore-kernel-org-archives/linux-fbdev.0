From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Advice sought on approach.
Date: 05 Mar 2003 23:36:48 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046878559.1291.199.camel@localhost.localdomain>
References: <1046867855.2505.200.camel@cambridge.braddahead>
	<1046870757.1229.94.camel@localhost.localdomain> 
	<1046875200.10894.216.camel@cambridge.braddahead>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qavg-0000YP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 07:35:36 -0800
In-Reply-To: <1046875200.10894.216.camel@cambridge.braddahead>
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
To: Alex Bennee <kernel-hacker@bennee.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 22:40, Alex Bennee wrote:
> 
> I think I understand now. When the fb_set_disp function is called I fill
> in the display struction with the console display operations. I've got
> two choices now:
> 
> 1. Create a new fbcon_cfb16 file which notes the changed areas before
> calling the generic function.
> 
> 2. Patch the current fbcon_cfb16 (with a CONFIG option) to add the
> change tracking facility in a more generic way.
> 
> I guess the question is is it worth doing 2 as a potential upstream
> patch? Or is this sort of thing so specialised I should just keep it all
> packed in my own fb driver?
> 

Either do #1 (create your own set -- check the popular drivers which has
acceleration, they have their own set), or you can generically implement
#2, I think.  It may even become useful for devices without mappable
graphics memory.

Or as Geert suggested, just write a console driver if you don't need
GUI.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
