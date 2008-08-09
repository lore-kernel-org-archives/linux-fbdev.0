From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 0/3] matroxfb fixes and improvements
Date: Sat, 9 Aug 2008 10:57:56 +0200
Message-ID: <20080809105756.633b3658@hyperion.delvare>
References: <20080808164937.141a95e0@hyperion.delvare>
	<20080808140019.32d949f7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRkH9-0008QG-0K for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Aug 2008 01:58:15 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KRkH6-0003gz-4c
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Aug 2008 01:58:13 -0700
In-Reply-To: <20080808140019.32d949f7.akpm@linux-foundation.org>
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
Cc: vandrove@vc.cvut.cz, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

Hi Andrew,

On Fri, 8 Aug 2008 14:00:19 -0700, Andrew Morton wrote:
> On Fri, 8 Aug 2008 16:49:37 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > Not having heard of Petr in one month and a half, I am sending these 3
> > patches again. Patch 1/3 (matrox maven: Fix a broken error path) in
> > particular should be applied ASAP. Patch 2/3 (matroxfb: i2c structure
> > templates clean-up) would be good to have as well and I tested it.
> > Patch 3/3 (matrox maven: Convert to a new-style i2c driver) needs
> > testing before it can go upstream. I can't test it myself, but it has
> > been in linux-next for 6 weeks or so.
> 
> I'll put all three into 2.6.27.

Thank you.

> I suspect that #1 should be backported to 2.6.25.x and to 2.6.26.x but
> I am unsure about that due to its poor changelogging.
> 
> I _think_ that the machine will crash if the i2c_attach_client() or
> maven_init_client() calls fail.  But I don't know under what
> circumstances that can happen, nor whether the bug has been reported in
> the field, etc.

I found it while working on patch #3. I am not aware of it having been
reported in the field. The maven driver doesn't have that many users
(which is why I am struggling to get patch #3 tested.) And then the
errors in question are unlikely to happen. In fact, maven_init_client()
always returns 0, it simply cannot fail. So I'd say that the chances
that someone hits that bug are thin.

That would mean that we don't really need to backport the fix. But OTOH
it's a regression and the fix is pretty easy and not intrusive. So, I
think I would still backport it.

> And the -stable people also will be interested in such information when
> making their decisions.

I think I will let them decide.

-- 
Jean Delvare

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
