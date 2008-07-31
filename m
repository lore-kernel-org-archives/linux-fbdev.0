From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: Give i2c buses nicer	names
Date: Thu, 31 Jul 2008 19:00:37 +1000
Message-ID: <1217494837.11188.439.camel@pasglop>
References: <20080606111955.5583e81a@hyperion.delvare>
	<1212744097.12464.29.camel@pasglop>
	<20080608155056.4506f457@hyperion.delvare>
	<20080731015751.9d78e1af.akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOU1k-0001S0-CH for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 02:00:54 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19v3e6VpEqSbcLF0VKZSeifuZFxTHavfgo=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KOU1i-00051i-KR
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 02:00:52 -0700
In-Reply-To: <20080731015751.9d78e1af.akpm@linux-foundation.org>
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
Cc: Jean Delvare <khali@linux-fr.org>, linux-fbdev-devel@lists.sourceforge.net

On Thu, 2008-07-31 at 01:57 -0700, Andrew Morton wrote:
> On Sun, 8 Jun 2008 15:50:56 +0200 Jean Delvare <khali@linux-fr.org> wrote:
> 
> > On Fri, 06 Jun 2008 19:21:37 +1000, Benjamin Herrenschmidt wrote:
> > > On Fri, 2008-06-06 at 11:19 +0200, Jean Delvare wrote:
> > > > The name of the i2c buses shows in the output of "i2cdetect -l", so
> > > > it's important to give informative names.
> > > > 
> > > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > 
> > > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Hmm, does this mean that you won't take care of pushing the patch
> > upstream? Driver maintainers usually do that...
> 
> Tony hasn't been heard from in many months and I only very occasionally
> troll linux-fbdev-devel for lost things.
> 
> Is this patch still good?  If so, in which of
> 2.6.25/2.6.26/2.6.27/2.6.28 do you think it should be merged?

No objection here.

Ben.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
