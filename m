From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] eink_apollofb: new driver for
	Apollo eInk controller.
Date: Mon, 14 Jul 2008 03:03:05 +0800
Message-ID: <45a44e480807131203s6f4ad6dfn507b6a1f22972b7@mail.gmail.com>
References: <1215787849-25580-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-2-git-send-email-jekhor@gmail.com>
	<20080712192013.1fb9519b.akpm@linux-foundation.org>
	<45a44e480807122002uaf7e452n563c42e186c944a1@mail.gmail.com>
	<87iqvaasc8.fsf@frontier.dottedmag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KI6qi-00040C-NM for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jul 2008 12:03:09 -0700
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KI6qh-0007pW-2K
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jul 2008 12:03:08 -0700
Received: by nf-out-0910.google.com with SMTP id g16so1250062nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 13 Jul 2008 12:03:05 -0700 (PDT)
In-Reply-To: <87iqvaasc8.fsf@frontier.dottedmag.net>
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
To: Mikhail Gusarov <dottedmag@dottedmag.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, linux-fbdev-devel@lists.sourceforge.net

On Sun, Jul 13, 2008 at 8:20 PM, Mikhail Gusarov
<dottedmag@dottedmag.net> wrote:
> Twas brillig at 11:02:29 13.07.2008 UTC+08 when jayakumar.lkml@gmail.com did gyre and gimble:
>
>  JK> However, I should point out that hecubafb is a driver for this same
>  JK> apollo controller.
>
> AFAICT from the diff, eink_apollofb already includes all the features of
> hecubafb, so that would be just renaming. Is it worth it?
>
> --
>

Hi Mikhail,

Looking at the posted code, it is the same code as hecubafb, renamed,
and with the 2-bit, partial update, and flash features added. The new
features are good but basically, its a fork of hecubafb. I'm
suggesting that rather than doing that, it would make more sense to
add those features to the existing hecubafb code. If any help is
needed in making that happen, please let me know, I'm happy to help.

Thanks,
jaya

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
