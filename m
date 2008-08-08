From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] matroxfb fixes and improvements
Date: Fri, 8 Aug 2008 14:00:19 -0700
Message-ID: <20080808140019.32d949f7.akpm@linux-foundation.org>
References: <20080808164937.141a95e0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRZ59-00086X-HB for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 14:01:07 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KRZ59-0002TZ-8A
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 14:01:07 -0700
In-Reply-To: <20080808164937.141a95e0@hyperion.delvare>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: vandrove@vc.cvut.cz, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Fri, 8 Aug 2008 16:49:37 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Not having heard of Petr in one month and a half, I am sending these 3
> patches again. Patch 1/3 (matrox maven: Fix a broken error path) in
> particular should be applied ASAP. Patch 2/3 (matroxfb: i2c structure
> templates clean-up) would be good to have as well and I tested it.
> Patch 3/3 (matrox maven: Convert to a new-style i2c driver) needs
> testing before it can go upstream. I can't test it myself, but it has
> been in linux-next for 6 weeks or so.

I'll put all three into 2.6.27.

I suspect that #1 should be backported to 2.6.25.x and to 2.6.26.x but
I am unsure about that due to its poor changelogging.

I _think_ that the machine will crash if the i2c_attach_client() or
maven_init_client() calls fail.  But I don't know under what
circumstances that can happen, nor whether the bug has been reported in
the field, etc.

And the -stable people also will be interested in such information when
making their decisions.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
