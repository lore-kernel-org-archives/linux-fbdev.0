From: Andrew Morton <akpm@osdl.org>
Subject: Re: FB accel capabilities patch
Date: Wed, 19 May 2004 03:03:19 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040519030319.1f0e6eec.akpm@osdl.org>
References: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQNvR-0002AO-D9
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 03:03:49 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BQNvQ-00034H-Sw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 03:03:48 -0700
In-Reply-To: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: David Eger <eger@theboonies.us>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

David Eger <eger@theboonies.us> wrote:
>
> A month or two ago I noticed that the framebuffer console driver doesn't
>  know to do proper framebuffer acceleration in Linux 2.6;

For what fbdev operations will acceleration be used?

> I've implemented
>  a solution Geert suggested where each framebuffer driver advertizes its 
>  hardware capabilities via fb_info->flags.  Please apply to -mm so I can 
>  get wider testing.

The larger patch gets a bunch of rejects against Linus's current tree. 
Please update and resend.

Please send the patches via email, too.  That way lots of people help to
check your code and it's considerably less fiddly at my end.

Canonical form is one patch per email, with the changelog at the top of the
email, with a useful Subject: which describes the patch.  Each patch email
will have a different subject, and that subject ain't the name of the file
which holds the patch!  The patch will be in the body of the email of your
MUA is halfway sane.  As an attachment if not.

Thanks.


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
