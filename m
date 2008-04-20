From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] [FB] Add the carmine FB driver.
Date: Sun, 20 Apr 2008 08:03:18 -0400
Message-ID: <45a44e480804200503m7e2d158j10a87dc510e195f5@mail.gmail.com>
References: <20080418172824.GB22342@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JnYGO-0007cQ-1p for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Apr 2008 05:03:20 -0700
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JnYGM-0000R7-Ok
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Apr 2008 05:03:19 -0700
Received: by wf-out-1314.google.com with SMTP id 28so1086481wff.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 20 Apr 2008 05:03:18 -0700 (PDT)
In-Reply-To: <20080418172824.GB22342@Chamillionaire.breakpoint.cc>
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
To: Sebastian Siewior <frame+buffer@ml.breakpoint.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, tglx@linutronix.de, Antonino Daplas <adaplas@gmail.com>

On Fri, Apr 18, 2008 at 1:28 PM, Sebastian Siewior
<frame+buffer@ml.breakpoint.cc> wrote:
>  +#ifndef MODULE
>  +static int __init carminefb_setup(void)
>  +{
>  +       char *options;
>  +
>  +       if (fb_get_options("carmine", &options))
>  +               return -ENXIO;

Hi Sebastian,

Interesting work. btw, I think there was some discussion of
deprecating the fb_get_options and associated manual parsing code in
favor of using module.option = value. Since this is a new driver, is
there an advantage in keeping the legacy option support?

>  +
>  +               if (!strncmp(this_opt, "mode:", 5))
>  +                       carminefb_mode = simple_strtoul(this_opt + 5, NULL, 0);

checkpatch suggests using strict_strtoul.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
