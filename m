From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fbdev and PM patch.
Date: Sat, 13 Sep 2003 14:00:18 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063454417.674.11.camel@gaston>
References: <Pine.LNX.4.44.0309121858550.5017-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19y95g-0004CN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 05:01:24 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19y95f-0004KD-Es
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Sep 2003 05:01:23 -0700
In-Reply-To: <Pine.LNX.4.44.0309121858550.5017-100000@phoenix.infradead.org>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-09-12 at 20:08, James Simmons wrote:
> Hi!
> 
>     I looked at your PM patch and I have a few ideas. The first thing I 
> did was create a dummy struct fb_ops instead of dummy functions for each 
> function for fb_ops. Plus you only had dummy functions for the basic 
> functions. So in the style of dummycon.c I created a dummy struct fb_ops.
>     I like to seperate out the client management code out of fbmem.c into 
> a seperate file. Especially with the device handling stuff it is quite 
> ugly looking. Here is what I suggest:

I kept the fb_ops on purpose. If you look at my implementation in
radeonfb, you'll see for example that the check_var/set_par fully
works during sleep, except that the HW isn't touched, but on wakeup,
the mode that was set during sleep will be applied properly.

If you put dummy fb_ops, you'll either let var be changed without
control from the driver, or make any set_var fail, which is a policy
decision I didn't want to take (but acceptable).

>     struct fb_client_ops {
> 	struct module *owner;
> 	void (*state_manager)(struct fb_info *info, void *data, u32 state);
>     }
> 
> The idea is instead of a bunch of functions we have one function for 
> state management. In struct fb_info we keep track of the state flag to see
> what the states are. We have something like this:
> 
> int
> fb_change_state(struct fb_info *info, u32 state)
> {
> 	if (info->state & state)
> 		return;
> 
> 	Your fb_client_call_##name code except it is now only one 
> 	function.
> }			
> 
> What do you think?

Well... The mode change notification isn't a state per-se and would
benefit from beeing a separate function. For the Power Management
callbacks, I don't mind either way

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
