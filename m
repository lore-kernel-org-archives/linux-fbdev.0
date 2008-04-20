From: Sebastian Siewior <frame+buffer@ml.breakpoint.cc>
Subject: Re: [PATCH] [FB] Add the carmine FB driver.
Date: Sun, 20 Apr 2008 21:27:34 +0200
Message-ID: <20080420192734.GB12136@Chamillionaire.breakpoint.cc>
References: <20080418172824.GB22342@Chamillionaire.breakpoint.cc>
	<45a44e480804200503m7e2d158j10a87dc510e195f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JnfCQ-00045J-Qv for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Apr 2008 12:27:43 -0700
Received: from chamillionaire.breakpoint.cc ([85.10.199.196]
	ident=G2wL6ZuayTZo\z0haXx|IP)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JnfCP-0005ZW-7k
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Apr 2008 12:27:42 -0700
Content-Disposition: inline
In-Reply-To: <45a44e480804200503m7e2d158j10a87dc510e195f5@mail.gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, tglx@linutronix.de, Antonino Daplas <adaplas@gmail.com>

* Jaya Kumar | 2008-04-20 08:03:18 [-0400]:

>On Fri, Apr 18, 2008 at 1:28 PM, Sebastian Siewior
><frame+buffer@ml.breakpoint.cc> wrote:
>>  +#ifndef MODULE
>>  +static int __init carminefb_setup(void)
>>  +{
>>  +       char *options;
>>  +
>>  +       if (fb_get_options("carmine", &options))
>>  +               return -ENXIO;
>
>Hi Sebastian,
Hi Jaya,

>Interesting work. btw, I think there was some discussion of
>deprecating the fb_get_options and associated manual parsing code in
>favor of using module.option = value. Since this is a new driver, is
>there an advantage in keeping the legacy option support?
I grabed a random driver as a template and the driver was using that
interface. I could get rid of this parsing code and use module options
only if this is prefered these days.
On a second look this is probably the better solution since I don't have
to care about to option interfaces.

>>  +
>>  +               if (!strncmp(this_opt, "mode:", 5))
>>  +                       carminefb_mode = simple_strtoul(this_opt + 5, NULL, 0);
>
>checkpatch suggests using strict_strtoul.
Indeed. I didn't notice this before. I get rid of this.

>Thanks,
>jaya
Thanks for review.

Sebastian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
