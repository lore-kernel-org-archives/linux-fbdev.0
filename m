From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Feature Freeze?
Date: 06 Mar 2003 09:18:07 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046913396.1227.176.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303051829450.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qk06-00076x-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 17:16:46 -0800
In-Reply-To: <Pine.LNX.4.44.0303051829450.27760-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 02:34, James Simmons wrote:
> 
> > > 1. Text mode support?
> > 
> > Required by at least davem and petr
> 
> Just Petr. I'm working to seperate the text code out into a matroxcon.c 
> file. Needs alot more work tho.
> 
> > > 2. console resizing using fbset (besides stty)?
> > 
> > Nice, if it's not too much work.
> 
> :-( I hope to improve fbcon to handle this.
>  

If you're really against using fbset to resize the console, then the
first step is to protect the console from the "dangers" of fbset. 
Secondly, we can have fbcon_resize() validate the mode instead of just
blindly calling fb_set_var().  If it's not valid, then it can also fetch
a working mode for it.  The user can then fine tune the timings using
fbset afterwards.


So, do we allow fbcon to handle mode validating and fetching, or do we
just leave all this to fbdev? At least let's bring out some ideas on how
to go about doing this.  Having a working idea, even if dumb, should
interest other developers in contributing. 

Tony  



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
