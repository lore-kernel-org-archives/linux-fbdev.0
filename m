From: James Simmons <jsimmons@infradead.org>
Subject: Fbdev and PM patch.
Date: Fri, 12 Sep 2003 19:08:22 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309121858550.5017-100000@phoenix.infradead.org>
References: <1063094455.676.15.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xsLK-0004q7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 11:08:26 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xsLK-0007Ki-02
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 11:08:26 -0700
In-Reply-To: <1063094455.676.15.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi!

    I looked at your PM patch and I have a few ideas. The first thing I 
did was create a dummy struct fb_ops instead of dummy functions for each 
function for fb_ops. Plus you only had dummy functions for the basic 
functions. So in the style of dummycon.c I created a dummy struct fb_ops.
    I like to seperate out the client management code out of fbmem.c into 
a seperate file. Especially with the device handling stuff it is quite 
ugly looking. Here is what I suggest:

    struct fb_client_ops {
	struct module *owner;
	void (*state_manager)(struct fb_info *info, void *data, u32 state);
    }

The idea is instead of a bunch of functions we have one function for 
state management. In struct fb_info we keep track of the state flag to see
what the states are. We have something like this:

int
fb_change_state(struct fb_info *info, u32 state)
{
	if (info->state & state)
		return;

	Your fb_client_call_##name code except it is now only one 
	function.
}			

What do you think?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
