From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] two warning fixes
Date: Thu, 19 Jul 2007 11:00:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707191056010.27353@woody.linux-foundation.org>
References: <20070718235504.GA9601@havoc.gtf.org>
	<alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org>
	<m3vecgbjix.fsf@maximus.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBaJ2-0004dC-O1 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 11:00:54 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBaJ0-00045Y-BO
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 11:00:52 -0700
In-Reply-To: <m3vecgbjix.fsf@maximus.localdomain>
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
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>, adaplas@gmail.com, benh@kernel.crashing.org, LKML <linux-kernel@vger.kernel.org>, ak@suse.de, Andrew Morton <akpm@linux-foundation.org>



On Thu, 19 Jul 2007, Krzysztof Halasa wrote:
> >
> >   We absolutely NEVER add things like "must_check" unless not checking 
> >   causes a real and obvious SECURITY ISSUE.
> 
> Oh, come on, almost every kernel bug is a potential security issue.

Sure. And adding unnecessary checking that doesn't make sense makes bugs 
*more* likely rather than less.

> IMHO, if the function can only fail due to a kernel bug, it should
> return void and, in case of bug, explode with BUG_ON() or something
> like that. Sure, must_check doesn't apply too well to void.

There are absolutely tons of functions that can return errors (or other 
values), and where many users MAY SIMPLY NOT CARE.

I think "must_check" is an abomination. It makes the callee dictate what 
the caller has to do, but dammit, if the callee really "knows" its errors 
are that serious, it should damn well handle them itself.

The whole "sysfs_create_file()" thing is an example of that. If it fails, 
it fails. The caller can't do anythign about it anyway, except perhaps 
print a message.  Why the hell does such a function have the "right" to 
dictate what the user should do?

That doesn't mean that *all* callers migth not care. Maybe some internal 
sysfs routines really should care. But not a random driver.

			Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
