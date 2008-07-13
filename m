From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] eink_apollofb: new driver for
	Apollo eInk controller.
Date: Sun, 13 Jul 2008 11:02:29 +0800
Message-ID: <45a44e480807122002uaf7e452n563c42e186c944a1@mail.gmail.com>
References: <1215787849-25580-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-2-git-send-email-jekhor@gmail.com>
	<20080712192013.1fb9519b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KHrr8-0004V0-UM for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jul 2008 20:02:35 -0700
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KHrr5-0007bY-9c
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jul 2008 20:02:34 -0700
Received: by nf-out-0910.google.com with SMTP id g16so1200452nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 12 Jul 2008 20:02:29 -0700 (PDT)
In-Reply-To: <20080712192013.1fb9519b.akpm@linux-foundation.org>
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
Cc: Ingo Molnar <mingo@redhat.com>, linux-fbdev-devel@lists.sourceforge.net

On Sun, Jul 13, 2008 at 10:20 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 11 Jul 2008 17:54:31 +0300 Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
>> This driver has been developed for the OpenInkpot
>> project (http://openinkpot.org/).

Hi Yauhen,

I'm excited to see openinkpot.org. Excellent efforts.

> + *
> + * This driver based on hecubafb driver code.
> + *

If possible, please also CC me, I'm the author of hecubafb, defio, and
am always interested to know if people are finding it useful.

> The eink_apollofb driver supports many features of
> Apollo chip, in difference with the hecubafb driver:
> 2-bit color depth, partial picture loading, flash
> read/write.

Yes, you've done good work here. I see the additions you've made as
support for 2-bit, partial updates and also suspend/resume.

However, I should point out that hecubafb is a driver for this same
apollo controller. There are several names for the Apollo controller
including PVI-1006A, Hecuba among others. Looking at the diff between
your work above and hecubafb, I think it should be feasible to add
your code to hecubafb rather than to create a new driver. Please let
me know if there's any problems achieving that, I'll be happy to help.

Thanks,
jaya

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
