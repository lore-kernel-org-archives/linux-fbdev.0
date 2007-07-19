From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [git patches] two warning fixes
Date: Wed, 18 Jul 2007 18:41:01 -0700
Message-ID: <20070718184101.1d31db9c.akpm@linux-foundation.org>
References: <20070718235504.GA9601@havoc.gtf.org>
	<200707190159.22654.ak@suse.de> <469EAABD.4010504@garzik.org>
	<1184807945.25235.289.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBL16-0004Jv-Jz for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 18:41:24 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBL15-0003Da-BB
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 18:41:20 -0700
In-Reply-To: <1184807945.25235.289.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>, adaplas@gmail.com, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, 19 Jul 2007 11:19:05 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> In general, I share paulus point of view here that forcing us to test
> all those result code from sysfs file creation functions is just a major
> PITA and adds bloat all over the kernel. There are many many cases where
> the "obvious" thing of erroring out is actually not good policy. In many
> cases, the failure to create some random sysfs file shouldn't prevent
> the driver from operating, because the consequences of doing the later
> are worse than the consequences of not having that sysfs file in the
> first place. 

The only reason why the sysfs creation would fail is a kernel bug,
so the consequence of your proposal is in fact unfixed kernel bugs.

Plus, of course, a driver which doesn't offer the interfaces which
it is supposed to offer.

Now, we can talk about making those sysfs core functions generate warnings
themselves, and we can talk about generating new wrappers around them which
generate warnings and which return void, then migrating code over to use
those.

And we can also talk about blithely ignoring these errors and not telling
anyone about our bugs, but nobody should listen to such scandalous ideas.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
