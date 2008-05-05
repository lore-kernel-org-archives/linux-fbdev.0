From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/1 2.6.25] fbdev: bugfix for
	multiprocess defio
Date: Mon, 5 May 2008 00:23:09 -0700
Message-ID: <45a44e480805050023h68cffe15h5e309707ec6d8380@mail.gmail.com>
References: <20080428020140.8662.66707.sendpatchset@hit-nxdomain.opendns.com>
	<20080430133759.e39bf34c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jsv2V-0005g8-TT for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 00:23:11 -0700
Received: from wf-out-1314.google.com ([209.85.200.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jsv2U-0002yF-KB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 00:23:11 -0700
Received: by wf-out-1314.google.com with SMTP id 27so1025919wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 05 May 2008 00:23:10 -0700 (PDT)
In-Reply-To: <20080430133759.e39bf34c.akpm@linux-foundation.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bernard@largestprime.net, linux-fbdev-devel@lists.sourceforge.net

On Wed, Apr 30, 2008 at 1:37 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sun, 27 Apr 2008 22:01:40 -0400
>  Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>  > +     /* we loop through the pagelist before adding in order
>  > +     to keep the pagelist sorted */
>  > +     list_for_each_entry(cur, &fbdefio->pagelist, lru) {
>
>  Did you consider using !list_empty(&page->lru) to avoid the linear search?
>

Ah, no, I didn't think of that. I agree that checking list_empty would
be far better. I'll redo the patch using that.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
